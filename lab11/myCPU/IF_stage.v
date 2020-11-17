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
    output      inst_req   ,
    output [ 3:0] inst_sram_wen  ,
    output [31:0] inst_sram_addr ,
    output [31:0] inst_sram_wdata,
    input  [31:0] inst_sram_rdata,
    input  [33   :0]                ws_to_fs_bus,
    
    input  inst_data_ok,
    input  inst_addr_ok
);
/////////////////////////////////////取值级没有写例外处理
reg         fs_valid;
wire        fs_ready_go;
wire        fs_allowin;
wire        to_fs_valid;

wire inst_sram_en;

wire [31:0] seq_pc;
wire [31:0] nextpc;

wire         br_taken;                                          //从ID中传回来的pc是否跳转
wire [ 31:0] br_target;
wire         fs_bd;
reg FS_BD;
always@(posedge clk)begin
    if(reset)
        FS_BD <= 1'b0;
    else if(fs_bd)
        FS_BD <= 1'b1;
    else if(fs_to_ds_valid)
        FS_BD <= 1'b0;
        end
wire j_reg;
assign {j_reg,fs_bd,br_taken,br_target} = br_bus;

wire [31:0] fs_inst;                                            //取值寄存器
reg  [31:0] fs_pc;                                              //pc触发器
wire [31:0] badvaddr;
wire fs_ex;
assign fs_to_ds_bus = {
                       fs_ex,   //97
                       badvaddr,//96:65
                      // fs_bd,   //64
                       FS_BD,   //64
                       fs_inst ,//63:32
                       fs_pc   };   
wire ft_address_error;
wire wb_ex;
//assign ft_address_error = ~(nextpc[1:0] == 2'b00); //错误bug
assign ft_address_error = ~(fs_pc[1:0] == 2'b00); 
assign fs_ex = ft_address_error && fs_valid && ~wb_ex; //加wb_ex信号为了清空流水线
assign badvaddr = (fs_ex)? fs_pc
                   : 32'h0;
////////////////////////////////////

wire inst_eret;
wire [31:0] cp0_rdata;
assign {
        wb_ex,
        inst_eret,
        cp0_rdata
} = ws_to_fs_bus;  
/////////////////////////////////
wire [31:0] true_npc;
reg br_valid;
reg [31:0] buf_br;
reg [31:0] buf_npc;
reg  [1:0]buf_valid;
reg WB_EX;
reg J_REG;
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
//assign true_npc=wb_ex? 32'hbfc00380 :
assign true_npc=WB_EX? 32'hbfc00380 :
               // inst_eret? cp0_rdata :
                INST_ERET? cp0_rdata :
                buf_valid ?buf_npc:
                br_valid & (j_reg | ~br_taken)?buf_br:     //j_reg为0时存在前递相关
                nextpc;

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
    else if(to_fs_valid&& fs_allowin)//(true_npc==buf_br&&to_fs_valid&& fs_allowin)
        br_valid<=0;
    else if(br_taken)
        br_valid<=1;
        /////////
    else if(WB_EX | INST_ERET)
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
assign inst_req     =~reset && fs_allowin;
assign to_fs_valid  = ~reset && inst_addr_ok;                                    //pc可写入
assign seq_pc       = fs_pc + 3'h4;                             //pc+4

assign nextpc       =  wb_ex? 32'hbfc00380 :
                        inst_eret? cp0_rdata :
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
    else if(wb_ex)
        fs_pc = 32'hbfc00380;
    else if(inst_eret)
        fs_pc = cp0_rdata;
    else if (to_fs_valid && fs_allowin) begin                   //启动时，pc为32'hbfbffffc，uu为bfc00000，此时发起读ram请求。一拍过后，pc更新至bfc00000，此时inst_sram_rdata为bfc00000对应的指令
        fs_pc <= true_npc;
    end
end

assign inst_sram_en    = to_fs_valid && fs_allowin;
assign inst_sram_wen   = 4'h0;
assign inst_sram_addr  = true_npc;
assign inst_sram_wdata = 32'b0;


assign fs_inst         =  (~WB_EX & ~fs_ex & ~inst_eret )? inst_sram_rdata : 32'b0;   //可以作为bug
/////对于例外和eret的处理，不修改fs_pc的值，而是将fs_inst指令变为0，就可以起到清除的效果
endmodule
