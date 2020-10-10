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
    output        inst_sram_en   ,
    output [ 3:0] inst_sram_wen  ,
    output [31:0] inst_sram_addr ,
    output [31:0] inst_sram_wdata,
    input  [31:0] inst_sram_rdata,
    input  [33   :0]                ws_to_fs_bus
);
/////////////////////////////////////取值级没有写例外处理
reg         fs_valid;
wire        fs_ready_go;
wire        fs_allowin;
wire        to_fs_valid;

wire [31:0] seq_pc;
wire [31:0] nextpc;

wire         br_taken;                                          //从ID中传回来的pc是否跳转
wire [ 31:0] br_target;
wire         fs_bd;
assign {fs_bd,br_taken,br_target} = br_bus;

wire [31:0] fs_inst;                                            //取值寄存器
reg  [31:0] fs_pc;                                              //pc触发器
assign fs_to_ds_bus = {
                       fs_bd,
                       fs_inst ,
                       fs_pc   };   
////////////////////////////////////
wire wb_ex;
wire inst_eret;
wire [31:0] cp0_rdata;
assign {
        wb_ex,
        inst_eret,
        cp0_rdata
} = ws_to_fs_bus;                            
//////////////////////////////////
// pre-IF stage
assign to_fs_valid  = ~reset;                                    //pc可写入
assign seq_pc       = fs_pc + 3'h4;                             //pc+4
///////////////////////////////////
assign nextpc       =  wb_ex? 32'hbfc00380 :
                        inst_eret? cp0_rdata :
                        br_taken ? br_target : seq_pc; 
///////////////////////////////////                        
// IF stage
assign fs_ready_go    = 1'b1;
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
    else if (to_fs_valid && fs_allowin) begin                   //启动时，pc为32'hbfbffffc，nextpc为bfc00000，此时发起读ram请求。一拍过后，pc更新至bfc00000，此时inst_sram_rdata为bfc00000对应的指令
        fs_pc <= nextpc;
    end
end

assign inst_sram_en    = to_fs_valid && fs_allowin;
assign inst_sram_wen   = 4'h0;
assign inst_sram_addr  = nextpc;
assign inst_sram_wdata = 32'b0;


assign fs_inst         =  (~wb_ex & ~inst_eret )? inst_sram_rdata : 32'b0;
/////对于例外和eret的处理，不修改fs_pc的值，而是将fs_inst指令变为0，就可以起到清除的效果
endmodule
