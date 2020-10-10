`include "mycpu.h"

module mem_stage(
    input                          clk           ,
    input                          reset         ,
    //allowin
    input                          ws_allowin    ,
    output                         ms_allowin    ,
    //from es
    input                          es_to_ms_valid,
    input  [`ES_TO_MS_BUS_WD -1:0] es_to_ms_bus  ,
    //to ws
    output                         ms_to_ws_valid,
    output [`MS_TO_WS_BUS_WD -1:0] ms_to_ws_bus  ,
    //from data-sram
    input  [31                 :0] data_sram_rdata,
    
    //output  [5   :0]                ms_dest_withvalid
    output  [38   :0]                ms_dest_withvalid,
    input                           ws_to_ms_bus,
    output                          ms_to_es_bus,

    input data_data_ok
);

reg         ms_valid;
wire        ms_ready_go;

reg [`ES_TO_MS_BUS_WD -1:0] es_to_ms_bus_r;
wire        ms_res_from_mem;
wire        ms_gr_we;
wire [ 4:0] ms_dest;
wire [31:0] ms_alu_result;
wire [31:0] ms_pc;
////////////////////////////////////
wire inst_lb,inst_lbu,inst_lh,inst_lhu;
wire inst_lwl,inst_lwr;
wire inst_mfc0,inst_mtc0;
wire [31:0] ms_rt_value;
wire [1:0] load_choice;
wire [4:0] rt;

wire ms_ex;
wire ex;
wire inst_eret;
wire ms_bd;
wire [ 4:0] ms_excode;
wire [31:0] ms_badvaddr;
///////////////////////////////////
assign {
       ms_badvaddr,      //157:126
       ex,               //125
       inst_eret,        //124
       ms_bd,            //123
       ms_excode,        //122:118
       rt,               //117:113
       inst_mfc0,        //112
       inst_mtc0,        //111
       ms_rt_value,      //110:79
       inst_lwl,         //78
       inst_lwr,         //77
       load_choice,      //76:75
       inst_lb,          //74
       inst_lbu,         //73
       inst_lh,          //72
       inst_lhu,         //71
        ms_res_from_mem,  //70:70
        ms_gr_we       ,  //69:69                         //����źŸ�ʲô�ã�
        ms_dest        ,  //68:64          //mfc0ʱΪrd
        ms_alu_result  ,  //63:32
        ms_pc             //31:0
       } = (!ws_to_ms_bus ) ? es_to_ms_bus_r : 0;

wire [31:0] mem_result;
wire [31:0] ms_final_result;
////////////////////////////////////////////////////////////////////////
    wire    block_valid,block;//�������������壨Ŀ�Ĳ���������,����Ҫд�أ�
    assign block = (ms_dest == 5'd0)?0:ms_gr_we;
    assign block_valid = block&ms_to_ws_valid;
    assign ms_dest_withvalid = {inst_mfc0&ms_to_ws_valid,ms_final_result,block_valid,ms_dest};
   // assign ms_dest_withvalid = {block_valid,ms_dest};
///////////////////////////////////////////////////////////////////////


assign ms_ex = ex & ms_to_ws_valid;

assign ms_to_es_bus = ms_ex | inst_eret &ms_to_ws_valid;

assign ms_to_ws_bus = {
                       ms_badvaddr    ,  //148:117
                       ms_ex          ,  //116
                       inst_eret      ,  //115
                       ms_bd          ,  //114
                       ms_excode      ,  //113:109
                       rt             ,  //108:104
                       inst_mfc0      ,  //103
                       inst_mtc0      ,  //102
                       ms_rt_value    ,  //101:70
                       ms_gr_we       ,  //69:69
                       ms_dest        ,  //68:64     //mfc0ʱΪrd
                       ms_final_result,  //63:32
                       ms_pc             //31:0
                      };

assign ms_ready_go    = !ms_res_from_mem||data_data_ok;
assign ms_allowin     = !ms_valid || ms_ready_go && ws_allowin;
assign ms_to_ws_valid = ms_valid && ms_ready_go;
always @(posedge clk) begin
    if (reset) begin
        ms_valid <= 1'b0;
    end
    else if (ms_allowin) begin
        ms_valid <= es_to_ms_valid;
    end

    if (es_to_ms_valid && ms_allowin) begin
        es_to_ms_bus_r  <= es_to_ms_bus;            //����7   ������ֵ
    end
end

assign mem_result = data_sram_rdata;
////////////////////////////////////
wire   [31:0] MEM_result;
assign MEM_result =  (inst_lb)?  (load_choice == 2'b00)?{{24{mem_result[7]}},mem_result[7:0]}
                                 :(load_choice == 2'b01)?{{24{mem_result[15]}},mem_result[15:8]}
                                 :(load_choice == 2'b10)?{{24{mem_result[23]}},mem_result[23:16]}
                                 :{{24{mem_result[31]}},mem_result[31:24]}
                     :(inst_lbu)? (load_choice == 2'b00)?{24'b0,mem_result[7:0]}
                                 :(load_choice == 2'b01)?{24'b0,mem_result[15:8]}
                                 :(load_choice == 2'b10)?{24'b0,mem_result[23:16]}
                                 :{24'b0,mem_result[31:24]}
                     :(inst_lh)?  (load_choice == 2'b00)?{{16{mem_result[15]}},mem_result[15:0]}
                                 :{{16{mem_result[31]}},mem_result[31:16]}
                     :(inst_lhu)? (load_choice == 2'b00)?{16'b0,mem_result[15:0]}
                                 :{16'b0,mem_result[31:16]}
                     :(inst_lwl)? (load_choice == 2'b00)?{mem_result[7:0],ms_rt_value[23:0]}
                                 :(load_choice == 2'b01)?{mem_result[15:0],ms_rt_value[15:0]}
                                 :(load_choice == 2'b10)?{mem_result[23:0],ms_rt_value[7:0]}
                                 :mem_result
                     :(inst_lwr)? (load_choice == 2'b00)?mem_result
                                 :(load_choice == 2'b01)?{ms_rt_value[31:24],mem_result[31:8]}
                                 :(load_choice == 2'b10)?{ms_rt_value[31:16],mem_result[31:16]}
                                 :{ms_rt_value[31:8],mem_result[31:24]}
                     :mem_result;
                     
                     
assign ms_final_result = ms_res_from_mem ? MEM_result
                                         : ms_alu_result;

endmodule
