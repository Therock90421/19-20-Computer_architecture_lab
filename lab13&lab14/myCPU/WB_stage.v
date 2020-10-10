`include "mycpu.h"

module wb_stage(
    input                           clk           ,
    input                           reset         ,
    //allowin
    output                          ws_allowin    ,
    //from ms
    input                           ms_to_ws_valid,
    input  [`MS_TO_WS_BUS_WD -1:0]  ms_to_ws_bus  ,
    //to rf: for write back
    output [`WS_TO_RF_BUS_WD -1:0]  ws_to_rf_bus  ,
    
    output [36:0] ws_to_fs_bus,
    output [1:0]  ws_to_ds_bus,
    output        ws_to_es_bus,
    output        ws_to_ms_bus,
    //trace debug interface
    output [31:0] debug_wb_pc     ,
    output [ 3:0] debug_wb_rf_wen ,
    output [ 4:0] debug_wb_rf_wnum,
    output [31:0] debug_wb_rf_wdata,
    
   // output  [5   :0]                ws_dest_withvalid
   output  [37   :0]                ws_dest_withvalid,
   input    [5:0]  int,
   
   //tlb
   // search port 0
        input  [              18:0] s0_vpn2,
        input                       s0_odd_page,     
       // input  [               7:0] s0_asid,     
        output                      s0_found,     
        output [               3:0] s0_index,     
        output [              19:0] s0_pfn,     
        output [               2:0] s0_c,     
        output                      s0_d,     
        output                      s0_v, 
    
       // search port 1     
        input  [              18:0] s1_vpn2,     
        input                       s1_odd_page,     
      //  input  [               7:0] s1_asid,     
        output                      s1_found,     
        output [               3:0] s1_index,     
        output [              19:0] s1_pfn,     
        output [               2:0] s1_c,     
        output                      s1_d,     
        output                      s1_v,
        
        output [31:0] c0_entryhi,
        output ws_to_es_tlbp
);

reg         ws_valid;
wire        ws_ready_go;
wire tlb_miss_ms;
reg [`MS_TO_WS_BUS_WD -1:0] ms_to_ws_bus_r;
wire        ws_gr_we;
wire [ 4:0] ws_dest;
wire [31:0] ws_final_result;
wire [31:0] ws_pc;
wire        inst_mfc0,inst_mtc0;
wire [31:0] ws_rt_value;
wire [ 4:0] rt;
wire ex;
wire inst_eret;
wire wb_bd;
wire [ 4:0] wb_excode;
wire [31:0] wb_badvaddr;
wire tlbp,tlbr,tlbwi;
wire tlbp_found;
wire [3:0] index;
wire ws_refetch;
assign {
        tlb_miss_ms,
        ws_refetch,          //157
        index,               //156:153
        tlbp_found,          //152
        tlbp,                //151
        tlbr,                //150
        tlbwi,               //149
        wb_badvaddr    ,  //148:117   
        ex             ,  //116
        inst_eret      ,  //115
        wb_bd          ,  //114
        wb_excode      ,  //113:109
        rt             ,  //108:104
        inst_mfc0      ,  //103
        inst_mtc0      ,  //102
        ws_rt_value    ,  //101:70
        ws_gr_we       ,  //69:69
        ws_dest        ,  //68:64
        ws_final_result,  //63:32
        ws_pc             //31:0
       } = ms_to_ws_bus_r;
assign ws_to_es_tlbp = inst_mtc0;
wire        rf_we;
wire [4 :0] rf_waddr;
wire [31:0] rf_wdata;
assign ws_to_rf_bus = {rf_we   ,  //37:37
                       rf_waddr,  //36:32
                       rf_wdata   //31:0
                      };


    wire    block_valid,block;//属于阻塞有意义（目的操作数存在,即需要写回）
    assign block = (ws_dest == 5'd0)?0:ws_gr_we;
    assign block_valid = block&ws_valid;
    //assign ws_dest_withvalid = {ws_final_result,block_valid,ws_dest};
    assign ws_dest_withvalid = {rf_wdata,block_valid,rf_waddr};
   // assign ws_dest_withvalid = {block_valid,ws_dest};






assign ws_ready_go = 1'b1;
assign ws_allowin  = !ws_valid || ws_ready_go;
always @(posedge clk) begin
    if (reset) begin
        ws_valid <= 1'b0;
    end
    else if (ws_allowin) begin
        ws_valid <= ms_to_ws_valid;
    end

    if (ms_to_ws_valid && ws_allowin) begin
        ms_to_ws_bus_r <= ms_to_ws_bus;
    end
end

///////////////////////////
wire [5:0] ext_int_in;
assign ext_int_in = int;
wire [31:0] cp0_rdata;
wire wb_ex;
assign wb_ex = ex & ws_valid;
wire eret_flush;
assign eret_flush = inst_eret;

wire mtc0_we;
//assign mtc0_we = ws_valid && inst_mtc0 && !wb_ex ; //wb_ex是写回级报例外的信号
assign mtc0_we = ws_valid && inst_mtc0 && !wb_ex && !ws_refetch; //wb_ex是写回级报例外的信号  ws_refetch是写回级报重取指令的信号
wire interrupt;
wire [31:0] c0_entrylo0,c0_entrylo1,c0_index;
////////////////////////////////
//tlb
  // write port     
   wire                       we;     //w(rite) e(nable)     
   wire  [               3:0] w_index;     
   wire  [              18:0] w_vpn2;     
   wire  [               7:0] w_asid;     
   wire                       w_g;     
   wire  [              19:0] w_pfn0;     
   wire  [               2:0] w_c0;     
   wire                       w_d0; 
   wire                       w_v0;     
   wire  [              19:0] w_pfn1;     
   wire  [               2:0] w_c1;     
   wire                       w_d1;     
   wire                       w_v1; 
   
   // read port     
   wire  [              3:0] r_index;     
   wire [              18:0] r_vpn2;     
   wire [               7:0] r_asid;     
   wire                      r_g;     
   wire [              19:0] r_pfn0;     
   wire [               2:0] r_c0;     
   wire                      r_d0;     
   wire                      r_v0;     
   wire [              19:0] r_pfn1;     
   wire [               2:0] r_c1;     
   wire                      r_d1;     
   wire                      r_v1; 
   ///////////////////////////////////////
CP0 cp0_reg(
    .clk           (clk),
    .reset         (reset),
    .mtc0_we       (inst_mtc0),
    .c0_addr       (ws_dest),  //dest 当mfc0时为rd
    .c0_wdata      (ws_rt_value),
    .wb_ex         (wb_ex),    //写回级例外信号
    .eret_flush    (eret_flush),//清中断，清流水线
    .wb_bd         (wb_bd),     //延迟槽信号
    .ext_int_in    (ext_int_in),  //硬件中断信号
    .wb_excode     (wb_excode),  //写回级例外编号
    .wb_pc         (ws_pc),
    .wb_badvaddr   (wb_badvaddr),//虚地址
    .rdata         (cp0_rdata),
    .interrupt     (interrupt),
    .c0_entryhi    (c0_entryhi),
    .c0_entrylo0   (c0_entrylo0),
    .c0_entrylo1   (c0_entrylo1),
    .c0_index      (c0_index),
    .tlbp          (tlbp),
    .tlbp_found    (tlbp_found),
    .index         (index),
    .tlbr          (tlbr),
    .r_vpn2        (r_vpn2),     
    .r_asid        (r_asid),     
    .r_g           (r_g),     
    .r_pfn0        (r_pfn0),     
    .r_c0          (r_c0),     
    .r_d0          (r_d0),     
    .r_v0          (r_v0),     
    .r_pfn1        (r_pfn1),     
    .r_c1          (r_c1),     
    .r_d1          (r_d1),     
    .r_v1          (r_v1)
    );

wire eret;
wire [31:0] cp0_rdata_or_refetch_pc;
//////////////
wire refetch;
assign refetch = ws_refetch & ws_valid;
assign cp0_rdata_or_refetch_pc = (ws_refetch)?ws_pc:cp0_rdata;
/////////////
assign eret = inst_eret & ws_valid;

assign ws_to_fs_bus = {
        tlb_miss_ms,               // 这个bug 在lab13中，会导致指令为全x
        refetch,
        wb_ex,
        eret,
        cp0_rdata_or_refetch_pc
};

assign ws_to_ds_bus = {
                       //(interrupt & ws_valid),
                       (interrupt ),
                       (wb_ex | eret |refetch)
                       };
//assign ws_to_es_bus = wb_ex | eret ;
//assign ws_to_ms_bus = wb_ex | eret ;
assign ws_to_es_bus = wb_ex | eret |refetch;
assign ws_to_ms_bus = wb_ex | eret |refetch;




 
  

     
tlb TLB
(
     .clk     (clk), 
    // search port 0
     .s0_vpn2        (s0_vpn2),
     .s0_odd_page    (s0_odd_page),
     .s0_asid        (c0_entryhi[7:0]),     
     .s0_found       (s0_found),
     .s0_index       (s0_index),
     .s0_pfn         (s0_pfn),
     .s0_c           (s0_c),
     .s0_d           (s0_d),
     .s0_v           (s0_v),
     
    // search port 1     
     .s1_vpn2        (s1_vpn2),
     .s1_odd_page    (s1_odd_page),
     .s1_asid        (c0_entryhi[7:0]),     
     .s1_found       (s1_found),
     .s1_index       (s1_index),
     .s1_pfn         (s1_pfn),
     .s1_c           (s1_c),
     .s1_d           (s1_d),
     .s1_v           (s1_v),
 
    // write port     
     .we              (tlbwi),     //w(rite) e(nable)     
     .w_index         (c0_index[3:0]),     
     .w_vpn2          (c0_entryhi[31:13]),     
     .w_asid          (c0_entryhi[7:0]),     
     .w_g             (c0_entrylo0[0] & c0_entrylo1[0]),     
     .w_pfn0          (c0_entrylo0[25:6]),     
     .w_c0            (c0_entrylo0[5:3]),     
     .w_d0            (c0_entrylo0[2]), 
     .w_v0            (c0_entrylo0[1]),     
     .w_pfn1          (c0_entrylo1[25:6]),     
     .w_c1            (c0_entrylo1[5:3]),     
     .w_d1            (c0_entrylo1[2]),     
     .w_v1            (c0_entrylo0[1]), 
     
     // read port   
     .r_index       (c0_index[3:0]),   
     .r_vpn2        (r_vpn2),     
     .r_asid        (r_asid),     
     .r_g           (r_g),     
     .r_pfn0        (r_pfn0),     
     .r_c0          (r_c0),     
     .r_d0          (r_d0),     
     .r_v0          (r_v0),     
     .r_pfn1        (r_pfn1),     
     .r_c1          (r_c1),     
     .r_d1          (r_d1),     
     .r_v1          (r_v1) 
   

     );








//assign rf_we    = ws_gr_we&&ws_valid;   原来的写错误！
assign rf_we    = ws_gr_we && ws_valid && ~wb_ex; 
assign rf_waddr = (inst_mfc0)?rt
                   :ws_dest;
assign rf_wdata = (inst_mfc0)?cp0_rdata
                   :ws_final_result;

// debug info generate
assign debug_wb_pc       = ws_pc;
assign debug_wb_rf_wen   = {4{rf_we}};
//assign debug_wb_rf_wnum  = ws_dest;
//assign debug_wb_rf_wdata = ws_final_result;
assign debug_wb_rf_wnum  = rf_waddr;
assign debug_wb_rf_wdata = rf_wdata;


endmodule
