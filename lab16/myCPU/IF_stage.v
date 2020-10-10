`include "mycpu.h"

module if_stage(
    input                          clk            ,
    input                          reset          ,
    //allwoin
    input                          ds_allowin     ,            //ds_allowin是允许传输数据至ID
    //brbus
    input  [`BR_BUS_WD       -1:0] br_bus         ,
    //to ds
    output                         fs_to_ds_valid ,            //从IF传数据至ID有效
    output [`FS_TO_DS_BUS_WD -1:0] fs_to_ds_bus   ,            //IF到ID总线
    // inst sram interface
  
    input  [36   :0]                ws_to_fs_bus,

    
    // search port 0
            output  [              18:0] s0_vpn2,
            output                       s0_odd_page,     
           // input  [               7:0] s0_asid,     
            input                      s0_found,     
            input [               3:0] s0_index,     
            input [              19:0] s0_pfn,     
            input [               2:0] s0_c,     
            input                      s0_d,     
            input                      s0_v,
     /////////////////////////////////////////////////
    output        rd_req,
    output[ 2:0]  rd_type,//3'b000-BYTE  3'b001-HALFWORD 3'b010-WORD 3'b100-cache-row
    output[31:0]  rd_addr,
    input         rd_rdy,//read_req can be accepted
    input         ret_valid,
    input [ 1:0]  ret_last,
    input [31:0]  ret_data
);
/////////////////////////////////////取值级没有写例外处理
   wire     inst_req   ;
   wire [ 3:0] inst_sram_wen  ;
   wire [31:0] inst_sram_addr ;
   wire [31:0] inst_sram_wdata;
   wire  [31:0] inst_sram_rdata;     
   wire  inst_data_ok;
   wire  inst_addr_ok;


reg         fs_valid;
wire        fs_ready_go;
wire        fs_allowin;
wire        to_fs_valid;
wire        mapped;
wire inst_sram_en;

wire [31:0] seq_pc;
wire [31:0] nextpc;

wire         br_taken;                                          //从ID中传回来的pc是否跳转
wire [ 31:0] br_target;
wire         fs_bd;
wire         fs_refetch;
reg FS_BD;
wire [31:0] true_npc;
always@(posedge clk)begin
    if(reset)
        FS_BD <= 1'b0;
    else if(fs_bd)
        FS_BD <= 1'b1;
    else if(fs_to_ds_valid)
        FS_BD <= 1'b0;
        end
reg FS_REFETCH;
always@(posedge clk)begin
    if(reset)
        FS_REFETCH <= 1'b0;
    else if(fs_refetch)
        FS_REFETCH <= 1'b1;
    else if(fs_to_ds_valid)
        FS_REFETCH <= 1'b0;
        end
wire j_reg;
assign {fs_refetch,j_reg,fs_bd,br_taken,br_target} = br_bus;

wire [31:0] fs_inst;                                            //取值寄存器
reg  [31:0] fs_pc;                                              //pc触发器
wire [31:0] badvaddr;
wire fs_ex;
wire tlb_miss;
wire tlb_invalid;
wire tlb_ex;
reg tlb_miss_reg;
reg tlb_invalid_reg;
reg WB_EX;
assign fs_to_ds_bus = {
                       tlb_invalid_reg,//100
                       tlb_miss_reg,//99
                       FS_REFETCH,//98
                       fs_ex,   //97
                       badvaddr,//96:65
                      // fs_bd,   //64
                       FS_BD,   //64
                       fs_inst ,//63:32
                       fs_pc   };   
wire ft_address_error;
wire wb_ex;
reg [31:0] BAD_VADDR;
assign tlb_miss=!s0_found&&mapped;
assign tlb_invalid=s0_found&&!s0_v&&mapped;

always @(posedge clk)begin
    /*if(reset)
        tlb_miss_reg<=0;
    else if(tlb_miss && to_fs_valid && fs_allowin)
        tlb_miss_reg<=1;
    else if(tlb_miss_reg&&fs_to_ds_valid && ds_allowin)
        tlb_miss_reg<=0;
    
    if(reset)
        tlb_invalid_reg<=0;
    else if(tlb_invalid && to_fs_valid && fs_allowin)
        tlb_invalid_reg<=1;
    else if(tlb_invalid_reg&&fs_to_ds_valid && ds_allowin)
        tlb_invalid_reg<=0;*/
    
    if(reset)
        tlb_miss_reg<=0;
    else if(to_fs_valid && fs_allowin)
        tlb_miss_reg<=tlb_miss;
    
    if(reset)
        tlb_invalid_reg<=0;
    else if( to_fs_valid && fs_allowin)
        tlb_invalid_reg<=tlb_invalid;
        
    if(reset)
         BAD_VADDR<=0;
    else if(to_fs_valid && fs_allowin)
         BAD_VADDR<=true_npc;
       
    /*if(reset)
        BAD_VADDR<=0;
    else
        BAD_VADDR<=true_npc;
     
     //////////  
    if(reset)
        tlb_miss<=0;
    else if(!s0_found&&mapped)
        tlb_miss<=1;
    else if(fs_to_ds_valid&&ds_allowin)
        tlb_miss<=0; 
        
    if(reset)
        tlb_invalid<=0;
    else if(s0_found&&!s0_v&&mapped)
        tlb_invalid<=1;
    else if(fs_to_ds_valid&&ds_allowin)
        tlb_invalid<=0;  */
end
//assign ft_address_error = ~(nextpc[1:0] == 2'b00); //错误bug
assign ft_address_error = ~(fs_pc[1:0] == 2'b00); 


assign fs_ex = (ft_address_error|tlb_miss_reg|tlb_invalid_reg) && fs_valid && ~wb_ex&&~WB_EX; //加wb_ex信号为了清空流水线
assign badvaddr = (ft_address_error)? fs_pc:
                   (tlb_miss_reg|tlb_invalid_reg)?BAD_VADDR
                   : 32'h0;
////////////////////////////////////

wire inst_eret;
wire [31:0] cp0_rdata;
wire ws_refetch;
assign {
        tlb_ex,
        ws_refetch,
        wb_ex,
        inst_eret,
        cp0_rdata
} = ws_to_fs_bus;  
/////////////////////////////////

reg br_valid;
reg [31:0] buf_br;
reg [31:0] buf_npc;
reg  [1:0]buf_valid;

reg J_REG;
reg TLB_EX;
always@(posedge clk)begin
    if(reset)
        TLB_EX<=1'b0;
    else if(tlb_ex)
        TLB_EX<=1'b1;
    else if(inst_addr_ok)
        TLB_EX<=1'b0;
        end
always@(posedge clk)begin
    if(reset)
        WB_EX<=1'b0;
    else if(wb_ex)
        WB_EX<=1'b1;
    else if(inst_addr_ok)
        WB_EX<=1'b0;
        end
reg INST_ERET;
always@(posedge clk)begin
    if(reset)
        INST_ERET<=1'b0;
    else if(inst_eret)
        INST_ERET<=1'b1;
    else if(inst_addr_ok)
        INST_ERET<=1'b0;
        end
reg [31:0] CP0_RDATA;
always@(posedge clk)begin
    if(reset)
        CP0_RDATA<=0;
    else if(inst_eret||ws_refetch)
        CP0_RDATA<=cp0_rdata;
    else if(inst_addr_ok)
        CP0_RDATA<=0;
        end
reg WS_REFETCH;
always@(posedge clk)begin
    if(reset)
        WS_REFETCH<=1'b0;
    else if(ws_refetch)
        WS_REFETCH<=1'b1;
    else if(inst_addr_ok)
        WS_REFETCH<=1'b0;
        end
//assign true_npc=wb_ex? 32'hbfc00380 :
assign true_npc= ((WB_EX||wb_ex )&&(tlb_ex||TLB_EX))?32'hbfc00200:
                 ((WB_EX||wb_ex )&&~TLB_EX&&~tlb_ex)?32'hbfc00380:
               // inst_eret? cp0_rdata :
                (INST_ERET||WS_REFETCH)? CP0_RDATA :
                (inst_eret||ws_refetch)?cp0_rdata:
                buf_valid ?buf_npc:
                br_valid & (j_reg | ~br_taken)?buf_br:     //j_reg为0时存在前递相关
                nextpc;
//tlb search
wire [31:0]TRUE_NPC;
assign s0_vpn2 = true_npc[31:13];
assign s0_odd_page = true_npc[12];
assign TRUE_NPC = (true_npc[31:28] < 4'h8 || true_npc[31:28] >= 4'hc)? {s0_pfn,{true_npc[11:0]}}
                 :true_npc;//mapped and unmapped
assign mapped= (true_npc[31:28] < 4'h8 || true_npc[31:28] >= 4'hc);            
/////////////                 
always @(posedge clk)begin
    if(reset)
        buf_valid<=2'b00;
    else if(to_fs_valid&& fs_allowin)
        buf_valid<=1'b0;
    else if(!buf_valid&&!br_valid)
        buf_valid<=1'b1;
        
    if(!buf_valid)
        buf_npc<=nextpc;
end

always @(posedge clk)begin
    if(reset) begin
        br_valid<=0;
        J_REG <= 1;
        end
      else if(br_taken)
                br_valid<=1;
       else if(to_fs_valid&& fs_allowin)
                br_valid<=0;         
      //lab11 -> lab13的改动，注意！
   /* else if(to_fs_valid&& fs_allowin)
        br_valid<=0;
    else if(br_taken)
        br_valid<=1;*/
        /////////
    else if(WB_EX | INST_ERET | WS_REFETCH)
        br_valid<=0;
    ///////////
    if(br_taken)
        buf_br<=br_target;
        
    if(j_reg)
        J_REG <= 0;
    else if(to_fs_valid&& fs_allowin)
        J_REG <= 1;
end

//////////////////////////////////
// pre-IF stage
//assign inst_req     =~reset && fs_allowin;
assign inst_req     =~reset && fs_allowin;
assign to_fs_valid  = ~reset && (inst_addr_ok);
//assign to_fs_valid  = ~reset && inst_addr_ok;                                    //pc可写入
assign seq_pc       = fs_pc + 3'h4;                             //pc+4

assign nextpc       =  (wb_ex&&!tlb_ex)? 32'hbfc00380 :
                        (wb_ex&&tlb_ex)?32'hbfc00200:
                        inst_eret | ws_refetch ? cp0_rdata :
                        br_taken ? br_target : seq_pc; 
///////////////////////////////////                        
// IF stage
reg inst_data_arrived;
always @(posedge clk) begin
    if(reset)
        inst_data_arrived<=0;
    else if(fs_to_ds_valid && ds_allowin)
        inst_data_arrived<=0;
    else if(inst_data_ok)
        inst_data_arrived<=1;
end
       
//assign fs_ready_go    = inst_data_ok||inst_data_arrived;
//assign fs_ready_go    = inst_data_arrived;
assign fs_ready_go    = inst_data_arrived;
assign fs_allowin     = !fs_valid || fs_ready_go && ds_allowin; //fs可以发出，ds允许进入，即下一拍fs中数据就将导出  或  fs中数据无效
assign fs_to_ds_valid =  fs_valid && fs_ready_go;               //fs中数据有效且fs可以发出
always @(posedge clk) begin
    if (reset) begin                                           //
        fs_valid <= 1'b0;                                     //reset期间fs_valid赋值为0
    end
    else if (fs_allowin) begin
        fs_valid <= to_fs_valid;                              //如果fs允许进入
    end

    if (reset) begin
        fs_pc <= 32'hbfbffffc;  //trick: to make nextpc be 0xbfc00000 during reset 
    end
    else if(wb_ex&&!tlb_ex)
        fs_pc <= 32'hbfc00380;
     else if(wb_ex&&tlb_ex)
        fs_pc <= 32'hbfc00200;
    else if(inst_eret | ws_refetch)
        fs_pc <= cp0_rdata;
    else if (to_fs_valid && fs_allowin) begin                   //启动时，pc为32'hbfbffffc，uu为bfc00000，此时发起读ram请求。一拍过后，pc更新至bfc00000，此时inst_sram_rdata为bfc00000对应的指令
        //fs_pc <= true_npc;
        //if(tlb_miss_reg||tlb_invalid_reg)
        if(tlb_miss||tlb_invalid||ft_address_error)
            fs_pc<=true_npc;
        else
            fs_pc <= TRUE_NPC;
    end
end

assign inst_sram_en    = to_fs_valid && fs_allowin;
assign inst_sram_wen   = 4'h0;
//assign inst_sram_addr  = true_npc;
assign inst_sram_addr  = (tlb_miss||tlb_invalid||ft_address_error)?32'hbfc00380:TRUE_NPC;
assign inst_sram_wdata = 32'b0;


//assign fs_inst         =  (~WB_EX & ~fs_ex & ~inst_eret )? inst_sram_rdata : 32'b0;   //可以作为bug
assign fs_inst         =  (~WB_EX & ~fs_ex & ~inst_eret&~INST_ERET & ~ws_refetch &~WS_REFETCH &~tlb_miss_reg &~tlb_invalid_reg)? inst_sram_rdata : 32'b0;
/////对于例外和eret的处理，不修改fs_pc的值，而是将fs_inst指令变为0，就可以起到清除的效果


cache icache( 
    //global
    .clk(clk),
    .resetn(~reset), 
    //CPU<->CACHE
    .valid(inst_req),
    .op(0),//1 write 0 read
    .index(inst_sram_addr[11:4]), //addr[11:4]
    .tlb_tag(inst_sram_addr[31:12]), //pfn + addr[12]
    .offset(inst_sram_addr[3:0]), //addr[3:0]
    .wstrb(0),
    .wdata(0),
    .addr_ok(inst_addr_ok),
    .data_ok(inst_data_ok),
    .rdata(inst_sram_rdata),
    //CACHE<->AXI-BRIDGE
    //read
    .rd_req(rd_req),
    .rd_type(),//3'b000-BYTE  3'b001-HALFWORD 3'b010-WORD 3'b100-cache-row
    .rd_addr(rd_addr),
    .rd_rdy(rd_rdy),//read_req can be accepted
    .ret_valid(ret_valid),
    .ret_last(ret_last),
    .ret_data(ret_data),
    //write
    .wr_rdy(1)//write_req can be accepted, actually nonsense in inst_cache
);
endmodule
