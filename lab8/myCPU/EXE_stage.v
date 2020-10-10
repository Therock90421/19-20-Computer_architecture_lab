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
    input                           ms_to_es_bus
   
);
    



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

wire inst_lb,inst_lbu,inst_lh,inst_lhu;
wire [1:0] load_choice;

wire    inst_lwl,inst_lwr;
wire    inst_sb,inst_sh,inst_swl,inst_swr;
wire    inst_mfc0,inst_mtc0;
wire [4:0] rt;

///////////////////
wire es_ex;
wire ex;
wire inst_eret;
wire es_bd;
wire [ 4:0] es_excode;
/////////////////////
assign {
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
        es_gr_we       ,  //118:118     //写回寄存器
        es_mem_we      ,  //117:117
        es_dest        ,  //116:112     //对于mfc0，dest是rd
        es_imm         ,  //111:96
        es_rs_value    ,  //95 :64
        es_rt_value    ,  //63 :32
        es_pc             //31 :0
       } = (!ws_to_es_bus & !ms_to_es_bus ) ? ds_to_es_bus_r : 0;   //这里对于执行级，只要访存和写回有例外或eret，都清零

wire [31:0] es_alu_src1   ;
wire [31:0] es_alu_src2   ;
wire [31:0] es_alu_result ;

wire        es_res_from_mem;

wire   [31:0]  ES_result;
////////////////////////////////////////////////////////////////////////
    wire    block_valid,block;//属于阻塞有意义（目的操作数存在,即需要写回）
    assign block= (es_dest == 5'd0)?0:es_gr_we;
    assign block_valid = block&es_valid;
    //assign es_dest_withvalid = {block_valid,es_dest};
    assign es_dest_withvalid = {(es_load_op | inst_mfc0)&es_valid,ES_result ,block_valid,es_dest};  //10.3前递
///////////////////////////////////////////////////////////////////////




assign es_res_from_mem = es_load_op;



assign es_ready_go    = (div_or_mul[3])?m_axis_dout_tvalid:
                         (div_or_mul[2])?um_axis_dout_tvalid:
                         1'b1; ///bug! assign es_ready_go    = (div_or_mul[3])?m_axis_dout_tvalid:1'b1;

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
    .alu_src1   (es_alu_src1  ),    //错误6   es_alu_src2
    .alu_src2   (es_alu_src2  ),
    .alu_result (es_alu_result)
    );
//////////////////////////////////////////

always @(posedge clk) begin
    if (reset) begin
        s_axis_divisor_tvalid <= 1'b0;
        s_axis_dividend_tvalid <= 1'b0;
        us_axis_divisor_tvalid <= 1'b0;
        us_axis_dividend_tvalid <= 1'b0;
        last <= 1'b0;
    end
    else if(s_axis_divisor_tready & s_axis_dividend_tready )begin //s_axis_divisor_tready & s_axis_dividend_tready
        s_axis_divisor_tvalid <= 1'b0;
        s_axis_dividend_tvalid <= 1'b0;
    end
    else if(us_axis_divisor_tready & us_axis_dividend_tready  )begin //s_axis_divisor_tready & s_axis_dividend_tready
        us_axis_divisor_tvalid <= 1'b0;
        us_axis_dividend_tvalid <= 1'b0;
    end    
    else if (div_or_mul[3] & ~last) begin
        s_axis_divisor_tvalid <= 1'b1;
        s_axis_dividend_tvalid <= 1'b1;
        last <= 1'b1;
    end
    else if (div_or_mul[2] & ~last) begin
        us_axis_divisor_tvalid <= 1'b1;
        us_axis_dividend_tvalid <= 1'b1;
        last <= 1'b1;
    end
    if(m_axis_dout_tvalid)
    last <= 1'b0;
    else if(um_axis_dout_tvalid)
    last <= 1'b0;
   
end

assign s_axis_divisor_tdata = es_rt_value;       //除数
assign s_axis_dividend_tdata = es_rs_value;      //被除数

assign us_axis_divisor_tdata = es_rt_value;       //除数
assign us_axis_dividend_tdata = es_rs_value;      //被除数

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
                       
                       es_alu_result;        //9.30还没写前递
                       
                       
                       
assign es_ex = ex & es_valid;
//////////////////////////////////////////////    
assign es_to_ms_bus = {
                       es_ex,               //125
                       inst_eret,        //124
                       es_bd,            //123
                       es_excode,        //122:118
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
                       es_gr_we       ,  //69:69                 这个信号干什么用？
                       es_dest        ,  //68:64  //mfc0时传递的是rd
                       ES_result  ,  //63:32
                       es_pc             //31:0
                      } ;


assign data_sram_en    = 1'b1;
//////////////////////////////////////////////////////////
//assign data_sram_wen   = es_mem_we&&es_valid ? 4'hf : 4'h0;
assign data_sram_addr  = es_alu_result;
//assign data_sram_wdata = es_rt_value;
assign data_sram_wen    = es_mem_we&&es_valid?  (ms_to_es_bus)? 4'b0000
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
