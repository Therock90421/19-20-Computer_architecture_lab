`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/24 18:29:58
// Design Name: 
// Module Name: CP0
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
    `include "mycpu.h"
    

module CP0(
    input clk,
    input reset,
    input mtc0_we,
    input [4:0]  c0_addr,
    input [31:0] c0_wdata,
    input wb_ex,    //写回级例外信号
    input eret_flush,
    input wb_bd,
    input [5:0]  ext_int_in,  //硬件中断信号
    input [4:0]  wb_excode,  //写回级例外编号
    input [31:0] wb_pc,
    input [31:0] wb_badvaddr,//虚地址
    output[31:0] rdata,
    output interrupt    
    );
    
    wire [31:0] c0_reg[31:0];
    //COUNT
    wire[31:0] c0_count;
    
    reg        tick;
    reg [31:0] c0_count_domain;
    assign c0_count = c0_count_domain;
    always @(posedge clk) begin
        if(reset) begin
                   tick <= 1'b0;
                   c0_count_domain <= 32'h0;
                   end
        else      tick <= ~tick;
        if(mtc0_we && c0_addr == `CR_COUNT)
            c0_count_domain <= c0_wdata;
        else if(tick)
            c0_count_domain <= c0_count_domain + 1'b1;
     end 
    //COMPARE
    wire [31:0]c0_compare;
    wire count_eq_compare;
    reg  [31:0]c0_compare_domain;
    
    assign c0_compare = c0_compare_domain;
    always @(posedge clk) begin
        if(reset) c0_compare_domain <= 32'h0;
        if(mtc0_we && c0_addr == `CR_COMPARE)
            c0_compare_domain <= c0_wdata;
    end 
     
    assign count_eq_compare = (c0_compare != 0) & (c0_count != 0) & (c0_compare == c0_count);   
    //STATUS
    wire [31:0]c0_status;
    
    wire [8:0] c0_status_31_23;
    wire       c0_status_bev;
    wire [5:0] c0_status_21_16;
    reg  [7:0] c0_status_im;
    wire [5:0] c0_status_7_2;
    reg        c0_status_exl;
    reg        c0_status_ie;  
    assign c0_status = {
                   c0_status_31_23,
                   c0_status_bev,
                   c0_status_21_16,
                   c0_status_im,
                   c0_status_7_2,
                   c0_status_exl,
                   c0_status_ie    
        };    
    assign c0_status_31_23 = 9'b0;
    assign c0_status_21_16 = 6'b0;
    assign c0_status_7_2   = 6'b0;
    assign c0_status_bev   = 1'b1;
    always @(posedge clk) begin
        if(mtc0_we && c0_addr == `CR_STATUS)
            c0_status_im <= c0_wdata[15:8];
    end
    always @(posedge clk) begin
        if(reset)
            c0_status_exl <= 1'b0;
        else if(wb_ex)
            c0_status_exl <= 1'b1;
        else if(eret_flush)
            c0_status_exl <= 1'b0;
        else if(mtc0_we && c0_addr == `CR_STATUS)
            c0_status_exl <= c0_wdata[1];
    end
    always @(posedge clk) begin
        if(reset)
            c0_status_ie <= 1'b0;
        else if(mtc0_we && c0_addr == `CR_STATUS)
            c0_status_ie <= c0_wdata[0];
    end
    
    //CAUSE
    wire [31:0] c0_cause;
    
    reg         c0_cause_bd;  
    reg         c0_cause_ti;
    wire [13:0] c0_cause_29_16;
    reg  [7 :0] c0_cause_ip;
    wire        c0_cause_7;
    reg  [4 :0] c0_cause_excode;
    wire [1 :0] c0_cause_1_0;
    assign c0_cause = {
                c0_cause_bd,
                c0_cause_ti,
                c0_cause_29_16,
                c0_cause_ip,
                c0_cause_7,
                c0_cause_excode,
                c0_cause_1_0
    };
    assign c0_cause_29_16 = 14'b0;
    assign c0_cause_7     = 1'b0;
    assign c0_cause_1_0   = 2'b0;
    always @(posedge clk) begin
        if(reset)
            c0_cause_bd <= 1'b0;
        else if(wb_ex && !c0_status_exl)
            c0_cause_bd <= wb_bd;
    end
    always @(posedge clk) begin
        if(reset)
            c0_cause_ti <= 1'b0;
        else if(mtc0_we && c0_addr == `CR_COMPARE)
            c0_cause_ti <= 1'b0;
        else if(count_eq_compare)   
            c0_cause_ti <= 1'b1;
    end
    always @(posedge clk) begin
        if(reset)
            c0_cause_ip[7:2] <= 6'b0;
        else begin
            c0_cause_ip[7]   <= ext_int_in[5] | c0_cause_ti;
            c0_cause_ip[6:2] <= ext_int_in[4:0];
        end
    end
    always @(posedge clk) begin
        if(reset)
            c0_cause_ip[1:0] <= 2'b0;
        else if(mtc0_we && c0_addr == `CR_CAUSE)
            c0_cause_ip[1:0] <= c0_wdata[9:8];
    end
    always @(posedge clk) begin
        if(reset)
            c0_cause_excode <= 1'b0;
        else if(wb_ex)
            c0_cause_excode <= wb_excode;
    end
    
    //EPC
    wire [31:0] c0_epc;
    
    reg  [31:0] c0_epc_domain;
    assign c0_epc = c0_epc_domain;
    always @(posedge clk) begin
        if(wb_ex && !c0_status_exl)
            c0_epc_domain <= wb_bd ? wb_pc - 3'h4 : wb_pc;
        else if (mtc0_we && c0_addr == `CR_EPC)
            c0_epc_domain <= c0_wdata;
    end
    
    //BADVADDR
    wire   [31:0] c0_badvaddr;
    
    reg    [31:0] c0_badvaddr_domain;
    assign c0_badvaddr = c0_badvaddr_domain;
    always @(posedge clk) begin
        if(wb_ex && (wb_excode == 5'h04 || wb_excode == 5'h05))  //疑问，store地址错不需要存储吗？
            c0_badvaddr_domain <= wb_badvaddr;
    end
    
    //read data
    assign rdata = (c0_addr == `CR_STATUS ) ? c0_status
                   :(c0_addr == `CR_CAUSE  ) ? c0_cause
                   :(c0_addr == `CR_EPC    ) ? c0_epc
                   :(c0_addr == `CR_BADVADDR)?c0_badvaddr
                   :(c0_addr == `CR_COUNT  )?  c0_count
                   :(c0_addr == `CR_COMPARE)? c0_compare
                   :32'b0;
    //INTERRUPT
    wire hw0,hw1,hw2,hw3,hw4,hw5;
    wire sw0,sw1;
    wire interrupt;
    assign hw5 = c0_cause_ip[7] & c0_status_im[7];
    assign hw4 = c0_cause_ip[6] & c0_status_im[6];
    assign hw3 = c0_cause_ip[5] & c0_status_im[5];
    assign hw2 = c0_cause_ip[4] & c0_status_im[4];
    assign hw1 = c0_cause_ip[3] & c0_status_im[3];
    assign hw0 = c0_cause_ip[2] & c0_status_im[2];
    assign sw1 = c0_cause_ip[1] & c0_status_im[1];
    assign sw0 = c0_cause_ip[0] & c0_status_im[0];
    
    assign interrupt = (hw0|hw1|hw2|hw3|hw4|hw5|sw0|sw1)&& (c0_status_ie == 1'b1) && (c0_status_exl == 1'b0);
    
    
    
endmodule
