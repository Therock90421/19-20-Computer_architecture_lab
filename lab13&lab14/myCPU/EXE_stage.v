`include "mycpu.h"

module exe_stage(
    input                          clk           ,
    input                          reset         ,
    //allowin
    input                          ms_allowin    ,
    output                         es_allowin    ,
    //from ds
    input                          ds_to_es_valid,
    input  [`DS_TO_ES_BUS_WD -1:0] ds_to_es_bus  ,
    //to ms
    output                         es_to_ms_valid,
    output [`ES_TO_MS_BUS_WD -1:0] es_to_ms_bus  ,
    // data sram interface
    output        data_sram_en   ,
    output [ 3:0] data_sram_wen  ,
    output [31:0] data_sram_addr ,
    output [31:0] data_sram_wdata,
    
  //  output  [5   :0]                es_dest_withvalid
    output  [38   :0]                es_dest_withvalid,
    input                           ws_to_es_bus,
    input                           ms_to_es_bus,
    output data_req,
    output data_wr,
    output [2:0] data_size,
    input data_addr_ok,
    input data_data_ok,
    
    //tlb
         output  [              18:0] s1_vpn2,     
         output                       s1_odd_page,     
         //output  [               7:0] s1_asid,     
         input                      s1_found,     
         input [               3:0] s1_index,     
         input [              19:0] s1_pfn,     
         input [               2:0] s1_c,     
         input                      s1_d,     
         input                      s1_v,
         
         input [31:0] c0_entryhi,
         input ws_to_es_tlbp,
         input ms_to_es_tlbp  
);
    


reg data_addr_arrived;
reg         es_valid      ;
wire        es_ready_go   ;

reg  [`DS_TO_ES_BUS_WD -1:0] ds_to_es_bus_r;
wire [11:0] es_alu_op     ;
wire        es_load_op    ;
wire        es_src1_is_sa ;  
wire        es_src1_is_pc ;
wire        es_src2_is_imm; 
wire  [3:0] div_or_mul    ;
//////////////////////////////////////////
wire        es_src2_is_zimm;
wire mapped;
reg s_axis_divisor_tvalid;
wire s_axis_divisor_tready;
wire [31:0] s_axis_divisor_tdata;
reg s_axis_dividend_tvalid;
wire s_axis_dividend_tready;
wire [31:0] s_axis_dividend_tdata;
wire m_axis_dout_tvalid;
wire [63:0] m_axis_dout_tdata;

reg us_axis_divisor_tvalid;
wire us_axis_divisor_tready;
wire [31:0] us_axis_divisor_tdata;
reg us_axis_dividend_tvalid;
wire us_axis_dividend_tready;
wire [31:0] us_axis_dividend_tdata;
wire um_axis_dout_tvalid;
wire [63:0] um_axis_dout_tdata;

wire tlb_miss_ds;
reg  last;
/////////////////////////////////////////
wire        es_src2_is_8  ;
wire        es_gr_we      ;
wire        es_mem_we     ;
///////////////////////////////////////////////////
wire        inst_mflo,  inst_mfhi, inst_mthi,inst_mtlo;
//////////////////////////////////////////////////////
wire [ 4:0] es_dest       ;
wire [15:0] es_imm        ;
wire [31:0] es_rs_value   ;
wire [31:0] es_rt_value   ;
wire [31:0] es_pc         ;
wire tlb_miss;
wire tlb_invalid;
wire tlb_modify;
wire inst_lb,inst_lbu,inst_lh,inst_lhu;
wire [1:0] load_choice;

wire    inst_lwl,inst_lwr;
wire    inst_lw;
wire    inst_sw,inst_sb,inst_sh,inst_swl,inst_swr;
wire    inst_mfc0,inst_mtc0;
wire [4:0] rt;
reg [31:0] BAD_ADDR;
///////////////////
wire inst_overflow;
wire es_ex;
wire ex;
wire inst_eret;
wire es_bd;
wire [ 4:0] es_excode;
wire [31:0] fs_badvaddr;

wire load_store;
wire store;
wire tlbp,tlbr,tlbwi;
/////////////////////
wire es_refetch;
////////////////////////
reg EX;
always@(posedge clk)begin
    if(reset)
        EX<=1'b0;
    else if(ws_to_es_bus | ms_to_es_bus)
        EX<=1'b1;
    else if(ds_to_es_valid && es_allowin)
        EX<=1'b0;
        end
//////////////////////////////
wire tlb_invalid_ds;
assign {
        tlb_invalid_ds,      //212
        tlb_miss_ds,         //211
        es_refetch,          //210
        tlbp,                //209
        tlbr,                //208
        tlbwi,               //207
        fs_badvaddr,      //206:175
        inst_sw,          //174
        inst_lw,          //173
        inst_overflow,    //172
        ex,               //171
        inst_eret,        //170
        es_bd,            //169
        es_excode,        //168:164
        rt,            //163:159
        inst_mfc0,     //158
        inst_mtc0,     //157
        inst_sb,       //156
        inst_sh,       //155
        inst_swl,      //154
        inst_swr,      //153
        inst_lwl,      //152
        inst_lwr,      //151
        load_choice,   //150:149
        inst_lb,       //148
        inst_lbu,      //147
        inst_lh,       //146
        inst_lhu,      //145  
        inst_mflo,     //144
        inst_mfhi,     //143
        inst_mthi,     //142
        inst_mtlo,     //141
        div_or_mul    , //140:137
        es_src2_is_zimm, //136
        es_alu_op      ,  //135:124
        es_load_op     ,  //123:123
        es_src1_is_sa  ,  //122:122
        es_src1_is_pc  ,  //121:121
        es_src2_is_imm ,  //120:120
        es_src2_is_8   ,  //119:119
        es_gr_we       ,  //118:118     
        es_mem_we      ,  //117:117
        es_dest        ,  //116:112     
        es_imm         ,  //111:96
        es_rs_value    ,  //95 :64
        es_rt_value    ,  //63 :32
        es_pc             //31 :0
       } = (~EX & !ws_to_es_bus & !ms_to_es_bus) ? ds_to_es_bus_r : 0;//(!ws_to_es_bus & !ms_to_es_bus ) ? ds_to_es_bus_r : 0;   //ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ö´ï¿½Ð¼ï¿½ï¿½ï¿½Ö»Òªï¿½Ã´ï¿½ï¿½Ð´ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½eretï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½

wire [31:0] es_alu_src1   ;
wire [31:0] es_alu_src2   ;
wire [31:0] es_alu_result ;

wire        es_res_from_mem;

wire   [31:0]  ES_result;
////////////////////////////////////////////////////////////////////////
    wire    block_valid,block;//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½å£¨Ä¿ï¿½Ä²ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½,ï¿½ï¿½ï¿½ï¿½ÒªÐ´ï¿½Ø£ï¿½
    assign block= (es_dest == 5'd0)?0:es_gr_we;
    assign block_valid = block&es_valid;
   
    //assign es_dest_withvalid = {es_load_op&es_valid | inst_mfc0&es_valid,ES_result ,block_valid,es_dest};  //10.3Ç°ï¿½ï¿½
    assign es_dest_withvalid = {es_load_op&es_valid&&~es_ex | inst_mfc0&es_valid&&~es_ex,ES_result ,block_valid,es_dest};  
///////////////////////////////////////////////////////////////////////




assign es_res_from_mem = es_load_op;

always @(posedge clk) begin
    if(reset)
        data_addr_arrived<=0;
    else if(es_to_ms_valid&&ms_allowin)
        data_addr_arrived<=0;
    else if(data_addr_ok)
        data_addr_arrived<=1;       
end

assign data_wr=~es_res_from_mem;
assign load_store=inst_sb|inst_sh|inst_swl|inst_swr|inst_sw|inst_lb|inst_lbu|inst_lh|inst_lhu
                |inst_lw|inst_lwl|inst_lwr;
assign store=inst_sb|inst_sh|inst_swl|inst_swr|inst_sw;
//assign data_req=load_store&&ms_allowin&&es_valid&&~es_ex; 

//assign data_req=load_store&&ms_allowin&&es_valid
assign data_req=load_store&&ms_allowin&&es_valid&&~es_ex&&~EX;//±ØÐëEXE²»ÊÇÀýÍâ£¬MEMÒ²²»ÊÇÀýÍâ²ÅÄÜ·¢ÇëÇó
/*assign data_size=(inst_sb|inst_lb|inst_lbu)?3'b000:         //bug!
                (inst_sh|inst_lh|inst_lhu)?3'b001:
                (inst_lw|inst_sw)?          3'b010:
                (inst_swl)?                 3'b100:
                                            3'b101;*/
assign data_size=(inst_sb|inst_lb|inst_lbu)?3'b000:     
                  (inst_sh|inst_lh|inst_lhu)?3'b001:
                  (inst_lw|inst_sw)?          3'b010:
                  (inst_swl|inst_lwl)?  (es_alu_result[1:0] == 2'b00)?  3'b100:
                                        (es_alu_result[1:0] == 2'b01)?  3'b101:       
                                        3'b110:
                  (inst_swr|inst_lwr)?  (es_alu_result[1:0] == 2'b11)?  3'b100:
                                        (es_alu_result[1:0] == 2'b10)?  3'b101:       
                                        3'b110:
								3'b000;
///////////////////////////////////////////////////////////////////////////////
reg done_div;								
assign es_ready_go    =  tlbp & ms_to_es_tlbp?1'b0:
                          //tlbp & ws_to_es_tlbp?1'b0: 
                         (div_or_mul[3])?m_axis_dout_tvalid || done_div:
                         (div_or_mul[2])?um_axis_dout_tvalid || done_div:
                        (load_store && !data_addr_ok&&!data_addr_arrived && ~es_ex &&~EX)?1'b0:
                         1'b1;
						 ///bug! assign es_ready_go    = (div_or_mul[3])?m_axis_dout_tvalid:1'b1;

assign es_allowin     = !es_valid || es_ready_go && ms_allowin;
assign es_to_ms_valid =  es_valid && es_ready_go;
always @(posedge clk) begin
    if (reset) begin
        es_valid <= 1'b0;
    end
    else if (es_allowin) begin
        es_valid <= ds_to_es_valid;
    end

    if (ds_to_es_valid && es_allowin) begin
        ds_to_es_bus_r <= ds_to_es_bus;
    end
end

assign es_alu_src1 = es_src1_is_sa  ? {27'b0, es_imm[10:6]} : 
                     es_src1_is_pc  ? es_pc[31:0] :
                                      es_rs_value;
assign es_alu_src2 = es_src2_is_zimm?{16'd0,es_imm[15:0]}:
                     es_src2_is_imm ? {{16{es_imm[15]}}, es_imm[15:0]} : 
                     es_src2_is_8   ? 32'd8 :
                                      es_rt_value;

alu u_alu(
    .alu_op     (es_alu_op    ),
    .alu_src1   (es_alu_src1  ),    //ï¿½ï¿½ï¿½ï¿½6   es_alu_src2
    .alu_src2   (es_alu_src2  ),
    .alu_result (es_alu_result)
    );
    //////////////////////////////////////////

    wire overflow;
    assign overflow = (inst_overflow)? (es_alu_op[0])? ( (~es_alu_src1[31] & ~es_alu_src2[31] &  es_alu_result[31])
                                                        ||( es_alu_src1[31] &  es_alu_src2[31] & ~es_alu_result[31]) )
                                       :(es_alu_op[1])? ( (~es_alu_src1[31] &  es_alu_src2[31] &  es_alu_result[31])
                                                        ||( es_alu_src1[31] & ~es_alu_src2[31] & ~es_alu_result[31]) ) 
                                       :0
                       :0;  
    wire load_address_error;
    assign load_address_error = (inst_lw)? ~(es_alu_result[1:0] == 2'b00)
                                :(inst_lh || inst_lhu)? ~(es_alu_result[0] == 1'b0)
                                :0;
    wire store_address_error;
    assign store_address_error = (inst_sw)? ~(es_alu_result[1:0] == 2'b00)
                                    :(inst_sh)? ~(es_alu_result[0] == 1'b0)
                                    :0;          
    wire [31:0] badvaddr;
    assign badvaddr = (ex&&(tlb_miss_ds||tlb_invalid_ds))? fs_badvaddr
                      :es_alu_result;                                
//////////////////////////////////////////

always @(posedge clk) begin
    if (reset) begin
        s_axis_divisor_tvalid <= 1'b0;
        s_axis_dividend_tvalid <= 1'b0;
        us_axis_divisor_tvalid <= 1'b0;
        us_axis_dividend_tvalid <= 1'b0;
        last <= 1'b0;
        done_div <= 1'b0;
    end
    else if(s_axis_divisor_tready & s_axis_dividend_tready )begin //s_axis_divisor_tready & s_axis_dividend_tready
        s_axis_divisor_tvalid <= 1'b0;
        s_axis_dividend_tvalid <= 1'b0;
    end
    else if(us_axis_divisor_tready & us_axis_dividend_tready  )begin //s_axis_divisor_tready & s_axis_dividend_tready
        us_axis_divisor_tvalid <= 1'b0;
        us_axis_dividend_tvalid <= 1'b0;
    end    
    //else if (div_or_mul[3] & ~last ) begin
    else if (div_or_mul[3] & ~last & ~done_div) begin
        s_axis_divisor_tvalid <= 1'b1;
        s_axis_dividend_tvalid <= 1'b1;
        last <= 1'b1;
    end
    //else if (div_or_mul[2] & ~last) begin
    else if (div_or_mul[2] & ~last & ~done_div) begin
        us_axis_divisor_tvalid <= 1'b1;
        us_axis_dividend_tvalid <= 1'b1;
        last <= 1'b1;
    end
    if(m_axis_dout_tvalid) begin
    last <= 1'b0;
    done_div <= 1'b1;
    end
    else if(um_axis_dout_tvalid) begin
    last <= 1'b0;
    done_div <= 1'b1;
    end
    if (ds_to_es_valid && es_allowin) begin
            done_div <= 1'b0;
        end
   
end

assign s_axis_divisor_tdata = es_rt_value;       //ï¿½ï¿½ï¿½ï¿½
assign s_axis_dividend_tdata = es_rs_value;      //ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½

assign us_axis_divisor_tdata = es_rt_value;       //ï¿½ï¿½ï¿½ï¿½
assign us_axis_dividend_tdata = es_rs_value;      //ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½

mydiv div(
    .aclk         (clk),
    .s_axis_divisor_tvalid   (s_axis_divisor_tvalid),
    .s_axis_divisor_tready   (s_axis_divisor_tready),
    .s_axis_divisor_tdata    (s_axis_divisor_tdata),
    .s_axis_dividend_tvalid  (s_axis_dividend_tvalid),
    .s_axis_dividend_tready  (s_axis_dividend_tready),
    .s_axis_dividend_tdata   (s_axis_dividend_tdata),
    .m_axis_dout_tvalid      (m_axis_dout_tvalid),
    .m_axis_dout_tdata       (m_axis_dout_tdata)
    );
    
 mydivu divu(
        .aclk         (clk),
        .s_axis_divisor_tvalid   (us_axis_divisor_tvalid),
        .s_axis_divisor_tready   (us_axis_divisor_tready),
        .s_axis_divisor_tdata    (us_axis_divisor_tdata),
        .s_axis_dividend_tvalid  (us_axis_dividend_tvalid),
        .s_axis_dividend_tready  (us_axis_dividend_tready),
        .s_axis_dividend_tdata   (us_axis_dividend_tdata),
        .m_axis_dout_tvalid      (um_axis_dout_tvalid),
        .m_axis_dout_tdata       (um_axis_dout_tdata)
        );   
        
        
        
        
wire [31:0] src1, src2;
wire [63:0] unsigned_prod; 
wire [63:0] signed_prod; 

assign src1 = es_rt_value;       
assign src2 = es_rs_value;
                                
assign unsigned_prod = src1 * src2; 
                                
assign signed_prod   = $signed(src1) * $signed(src2); 

reg [31:0] LO;
reg [31:0] HI;


always@(posedge clk)
begin
    if(reset)begin
    LO <= 32'd0;
    HI <= 32'd0;
    end
    else if(m_axis_dout_tvalid)
    begin
    LO <=  m_axis_dout_tdata[63:32];
    HI <=  m_axis_dout_tdata[31:0]; 
    end
    else if(um_axis_dout_tvalid)
    begin
    LO <=  um_axis_dout_tdata[63:32];
    HI <=  um_axis_dout_tdata[31:0]; 
    end
    else if(div_or_mul[1])
    begin
    HI <=  signed_prod[63:32];
    LO <=  signed_prod[31:0]; 
    end
    else if(div_or_mul[0])
    begin
    HI <=  unsigned_prod[63:32];
    LO <=  unsigned_prod[31:0]; 
    end
    if(inst_mthi)
    HI <=  es_rs_value;
    if(inst_mtlo)
    LO <=  es_rs_value;
end


assign    ES_result = (inst_mflo)?LO:
                       (inst_mfhi)?HI:
                       
                       es_alu_result;        //9.30ï¿½ï¿½Ã»Ð´Ç°ï¿½ï¿½
                       
                       
                  
//assign es_ex = (ex || overflow || load_address_error || store_address_error) & es_valid;
assign es_ex = (ex || overflow || load_address_error || store_address_error||tlb_miss||tlb_invalid||tlb_modify);
wire [4:0]ES_excode;
assign ES_excode = (ex & (es_excode == 5'h00))? 5'h00
                  :(ex & (es_excode == 5'h02))? 5'h02
                  :tlb_modify?                  5'h01
                  :((tlb_miss||tlb_invalid)&&es_gr_we)?5'h02
                  :((tlb_miss||tlb_invalid)&&!es_gr_we)?5'h03
                  : (overflow)? 5'h0c
                  : (load_address_error)? 5'h04
                  : (store_address_error)? 5'h05
                  : es_excode;
//////////////////////////////////////////////    
//tlb
wire [31:0] true_addr;
wire tlbp_found;
wire [3:0] index;
assign s1_vpn2 = (~tlbp)?es_alu_result[31:13]:c0_entryhi[31:13];
assign s1_odd_page = (~tlbp)?es_alu_result[12]:0;
assign tlbp_found = tlbp & s1_found;
assign true_addr = (es_alu_result[31:28] < 4'h8 | es_alu_result[31:28] >= 4'hc)? {s1_pfn,{es_alu_result[11:0]}}
                 :es_alu_result;
assign index = s1_index; 
assign mapped=(es_alu_result[31:28] < 4'h8 | es_alu_result[31:28] >= 4'hc);
assign tlb_miss=!s1_found&&mapped&&load_store;
assign tlb_invalid=s1_found&&!s1_v&&mapped&&load_store;
assign tlb_modify=s1_found&&s1_v&&!s1_d&&mapped&&store;
/*always @(posedge clk)begin
    if(reset)
        tlb_miss<=0;
    else if(!s1_found&&mapped&&load_store)
        tlb_miss<=1;
    else if(es_to_ms_valid&&ms_allowin)
        tlb_miss<=0; 
        
    if(load_store)
        BAD_ADDR<=es_alu_result;
    else if(es_to_ms_valid&&ms_allowin)
        BAD_ADDR<=0;
    
    if(reset)
        tlb_invalid<=0;
    else if(s1_found&&!s1_v&&mapped&&load_store)
        tlb_invalid<=1;
    else if(es_to_ms_valid&&ms_allowin)
        tlb_invalid<=0; 
    
    if(reset)
        tlb_modify<=0;
    else if(s1_found&&s1_v&&!s1_d&&mapped&&store)
        tlb_invalid<=1;
    else if(es_to_ms_valid&&ms_allowin)
        tlb_invalid<=0; 
end*/
//////////////////////////////////////////////////

assign es_to_ms_bus = {
                       tlb_miss_ds|tlb_miss,
                       es_refetch,          //167
                       index,               //166:163
                       tlbp_found,          //162
                       tlbp,                //161
                       tlbr,                //160
                       tlbwi,               //159
                       load_store,       //158
                       badvaddr,         //157:126
                       es_ex,            //125
                       inst_eret,        //124
                       es_bd,            //123
                       ES_excode,        //122:118
                       rt,               //117:113
                       inst_mfc0,        //112
                       inst_mtc0,        //111
                       es_rt_value,      //110:79
                       inst_lwl,         //78
                       inst_lwr,         //77
                       load_choice,      //76:75
                       inst_lb,          //74
                       inst_lbu,         //73
                       inst_lh,          //72
                       inst_lhu,         //71  
                       es_res_from_mem,  //70:70
                       es_gr_we       ,  //69:69                 ï¿½ï¿½ï¿½ï¿½ÅºÅ¸ï¿½Ê²Ã´ï¿½Ã£ï¿?
                       es_dest        ,  //68:64  //mfc0Ê±ï¿½ï¿½ï¿½Ýµï¿½ï¿½ï¿½rd
                       ES_result  ,  //63:32
                       es_pc             //31:0
                      } ;
  


//////////////////////////////////////////////////////////////////
assign data_sram_en    = 1'b1;
//////////////////////////////////////////////////////////
                
                 
                 
//assign data_sram_addr  = es_alu_result;
assign data_sram_addr  = true_addr;

assign data_sram_wen    = ~es_ex && es_mem_we && es_valid?  (ms_to_es_bus)? 4'b0000
                                                :(inst_sb)?  (load_choice == 2'b00)? 4'b0001
                                                            :(load_choice == 2'b01)? 4'b0010
                                                            :(load_choice == 2'b10)? 4'b0100
                                                            :4'b1000
                                                :(inst_sh)?  (load_choice == 2'b00)? 4'b0011
                                                            :4'b1100
                                                :(inst_swl)?(load_choice == 2'b00)? 4'b0001
                                                            :(load_choice == 2'b01)? 4'b0011
                                                            :(load_choice == 2'b10)? 4'b0111
                                                            :4'b1111
                                                :(inst_swr)?(load_choice == 2'b00)? 4'b1111
                                                            :(load_choice == 2'b01)? 4'b1110
                                                            :(load_choice == 2'b10)? 4'b1100
                                                            :4'b1000
                                                 :4'b1111
                             :4'b0000;
                                                            


assign data_sram_wdata  = inst_sb? {4{es_rt_value[7:0]}}
                          :inst_sh? {2{es_rt_value[15:0]}}
                          :inst_swl? (load_choice == 2'b00)? {24'b0,es_rt_value[31:24]}
                                    :(load_choice == 2'b01)? {16'b0,es_rt_value[31:16]}
                                    :(load_choice == 2'b10)? {8'b0, es_rt_value[31:8]}
                                    :es_rt_value
                          :inst_swr? (load_choice == 2'b00)? es_rt_value
                                    :(load_choice == 2'b01)? {es_rt_value[23:0],8'b0}
                                    :(load_choice == 2'b10)? {es_rt_value[16:0],16'b0}
                                    :{es_rt_value[8:0],24'b0}
                          :es_rt_value;
//////////////////////////////////////////////
endmodule
