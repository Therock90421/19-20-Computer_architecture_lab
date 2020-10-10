/*------------------------------------------------------------------------------
--------------------------------------------------------------------------------
Copyright (c) 2016, Loongson Technology Corporation Limited.

All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this 
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, 
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

3. Neither the name of Loongson Technology Corporation Limited nor the names of 
its contributors may be used to endorse or promote products derived from this 
software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
DISCLAIMED. IN NO EVENT SHALL LOONGSON TECHNOLOGY CORPORATION LIMITED BE LIABLE
TO ANY PARTY FOR DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE 
GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--------------------------------------------------------------------------------
------------------------------------------------------------------------------*/
`timescale 1ns / 1ps

`define V_C_I_DATA_CNT    axi_ifc_top.u_virtual_cpu.inst_data_cnt
`define V_C_I_ADDR_CNT    axi_ifc_top.u_virtual_cpu.inst_addr_cnt
`define V_C_I_WAIT_DEP    axi_ifc_top.u_virtual_cpu.inst_wait_dep
`define V_C_I_RDATA_REF_V axi_ifc_top.u_virtual_cpu.inst_rdata_ref_v
`define V_C_I_RDATA       axi_ifc_top.u_virtual_cpu.inst_rdata
`define V_C_I_DATA_OK     axi_ifc_top.u_virtual_cpu.inst_data_ok

`define V_C_D_DATA_CNT    axi_ifc_top.u_virtual_cpu.data_data_cnt
`define V_C_D_ADDR_CNT    axi_ifc_top.u_virtual_cpu.data_data_cnt
`define V_C_D_WAIT_DEP    axi_ifc_top.u_virtual_cpu.data_wait_dep
`define V_C_D_RDATA_REF_V axi_ifc_top.u_virtual_cpu.data_rdata_ref_v
`define V_C_D_RDATA_REF_M_V axi_ifc_top.u_virtual_cpu.data_rdata_ref_m_v
`define V_C_D_RDATA       axi_ifc_top.u_virtual_cpu.data_rdata
`define V_C_D_DATA_OK     axi_ifc_top.u_virtual_cpu.data_data_ok

module axi_ifc_tb( );
reg resetn;
reg clk;

//goio
wire [15:0] led;
wire [1 :0] led_rg0;
wire [1 :0] led_rg1;
wire [7 :0] num_csn;
wire [6 :0] num_a_g;
reg  [7 :0] switch;
wire [3 :0] btn_key_col;
wire [3 :0] btn_key_row;
reg  [1 :0] btn_step;
//assign switch      = 8'd0;
assign btn_key_row = 4'd0;
//assign btn_step    = 2'b11;
initial
begin
   btn_step = 2'b11;
   switch   = 8'd0;
   #5000;
   btn_step = 2'b10;
   switch   = 8'd3;
   #100;
   btn_step = 2'b11;
end
initial
begin
    clk = 1'b0;
    resetn = 1'b0;
    #2000;
    resetn = 1'b1;
end
always #5 clk=~clk;
axi_ifc_top #(
    .SIMULATION(1'b1)
) axi_ifc_top (
    .resetn      (resetn     ), 
    .clk         (clk        ),
    
    //------gpio-------
    .num_csn    (num_csn    ),
    .num_a_g    (num_a_g    ),
    .led        (led        ),
    .led_rg0    (led_rg0    ),
    .led_rg1    (led_rg1    ),
    .switch     (switch     ),
    .btn_key_col(btn_key_col),
    .btn_key_row(btn_key_row),
    .btn_step   (btn_step   )
);   

initial
begin
    $timeformat(-9,0," ns",10);
end
integer global_err;
initial
begin
    global_err = 0;
end
//moniter inst sram_like
always @(posedge clk)
begin
    if (`V_C_I_DATA_CNT==4'd0&&`V_C_I_WAIT_DEP!=2'd0&&`V_C_I_DATA_OK)
    begin
        if (`V_C_I_RDATA!==32'h6666_6666)
        begin
            $display("[%t] Fail!!!read inst 0, ref_data=32'h66666666, my_data=%8h", $time, `V_C_I_RDATA);
            global_err = global_err +1;
        end
        else
        begin
            $display("[%t] OK!!!read inst 0", $time);
        end
    end
    
    if (`V_C_I_DATA_CNT==4'd1&&`V_C_I_WAIT_DEP!=2'd0&&`V_C_I_DATA_OK)
    begin
        if (`V_C_I_RDATA!==32'h7777_7777)
        begin
            $display("[%t] Fail!!!read from inst 1, ref_data=32'h77777777, my_data=%8h", $time, `V_C_I_RDATA);
            global_err = global_err +1;
        end
        else
        begin
            $display("[%t] OK!!!read inst 1", $time);
        end
    end

    if (`V_C_I_DATA_CNT==4'd2&&`V_C_I_WAIT_DEP!=2'd0&&`V_C_I_DATA_OK)
    begin
        if (`V_C_I_RDATA!==32'h8888_8888)
        begin
            $display("[%t] Fail!!!read from inst sram-like, ref_data=32'h88888888, my_data=%8h", $time, `V_C_I_RDATA);
            global_err = global_err +1;
        end
        else
        begin
            $display("[%t] OK!!!read inst 2", $time);
        end
    end

    if (`V_C_I_DATA_CNT==4'd3&&`V_C_I_WAIT_DEP!=2'd0&&`V_C_I_DATA_OK)
    begin
        if (`V_C_I_RDATA!==32'h9999_9999)
        begin
            $display("[%t] Fail!!!read from inst sram-like, ref_data=32'h99999999, my_data=%8h", $time, `V_C_I_RDATA);
            global_err = global_err +1;
        end
        else
        begin
            $display("[%t] OK!!!read inst 3", $time);
        end
    end

    if (`V_C_I_DATA_CNT==4'd4&&`V_C_I_WAIT_DEP!=2'd0&&`V_C_I_DATA_OK)
    begin
        if (`V_C_I_RDATA!==32'haaaa_aaaa)
        begin
            $display("[%t] Fail!!!read from inst sram-like, ref_data=32'haaaaaaaa, my_data=%8h", $time, `V_C_I_RDATA);
            global_err = global_err +1;
        end
        else
        begin
            $display("[%t] OK!!!read inst 4", $time);
        end
    end
end

//moniter data sram-like
always @(posedge clk)
begin
    if (`V_C_D_DATA_CNT==4'd2&&`V_C_D_WAIT_DEP!=2'd0&&`V_C_D_DATA_OK)
    begin
        if (((`V_C_D_RDATA^32'h2222_0000)&32'hffff_ffff)!==32'd0)
        begin
            $display("[%t] Fail!!!read from data sram-like, ref_data[31: 0]=32'h22220000, my_data[31: 0]=%8h", $time, `V_C_D_RDATA);
            global_err = global_err +1;
        end
        else
        begin
            $display("[%t] OK!!read data 0", $time);
        end
    end
    
    if (`V_C_D_DATA_CNT==4'd4&&`V_C_D_WAIT_DEP!=2'd0&&`V_C_D_DATA_OK)
    begin
        if (((`V_C_D_RDATA^32'h0011_0000)&32'h00ff_0000)!==32'd0)
        begin
            $display("[%t] Fail!!!read from data sram-like, ref_data[23:16]=8'h11, my_data[23:16]=%2h", $time, `V_C_D_RDATA[23:16]);
            global_err = global_err +1;
        end
        else
        begin
            $display("[%t] OK!!!read data 1", $time);
        end
    end

    if (`V_C_D_DATA_CNT==4'd5&&`V_C_D_WAIT_DEP!=2'd0&&`V_C_D_DATA_OK)
    begin
        if (((`V_C_D_RDATA^32'h0000_0000)&32'h0000_ffff)!==32'd0)
        begin
            $display("[%t] Fail!!!read from data sram-like, ref_data[15: 0]=16'h0000, my_data[15: 0]=%4h", $time, `V_C_D_RDATA[15:0]);
            global_err = global_err +1;
        end
        else
        begin
            $display("[%t] OK!!!read data 2", $time);
        end
    end

    if (`V_C_D_DATA_CNT==4'd6&&`V_C_D_WAIT_DEP!=2'd0&&`V_C_D_DATA_OK)
    begin
        if (((`V_C_D_RDATA^32'h1111_3311)&32'hffff_ffff)!==32'd0)
        begin
            $display("[%t] Fail!!!read from data sram-like, ref_data[31: 0]=32'h11113311, my_data[31: 0]=%8h", $time, `V_C_D_RDATA);
            global_err = global_err +1;
        end
        else
        begin
            $display("[%t] OK!!!read data 3", $time);
        end
    end

    if (`V_C_D_DATA_CNT==4'd9&&`V_C_D_WAIT_DEP!=2'd0&&`V_C_D_DATA_OK)
    begin
        if (((`V_C_D_RDATA^32'h5500_4444)&32'hffff_ffff)!==32'd0)
        begin
            $display("[%t] Fail!!!read from data sram-like, ref_data[31: 0]=32'h55004444, my_data[31: 0]=%8h", $time, `V_C_D_RDATA);
            global_err = global_err +1;
        end
        else
        begin
            $display("[%t] OK!!!read data 4", $time);
        end
    end
end
//test end
reg inst_end;
reg data_end;
always @(posedge clk)
begin
    if(!resetn)
    begin
        inst_end <= 1'b0;
    end
    else if (`V_C_I_DATA_CNT==4'd4&&`V_C_I_WAIT_DEP!=2'd0&&`V_C_I_DATA_OK)
    begin
        inst_end <= 1'b1;
    end

    if(!resetn)
    begin
        data_end <= 1'b0;
    end
    else if (`V_C_D_DATA_CNT==4'd9&&`V_C_D_WAIT_DEP!=2'd0&&`V_C_D_DATA_OK)
    begin
        data_end <= 1'b1;
    end
end

always @(posedge clk)
begin
    if(inst_end&&data_end)
	begin
	    $display("=========================================================");
	    $display("Test end!");
	     #700;
        if (global_err!=0)
        begin
            $display("Fail!!!Total %d errors!",global_err);
        end
        else
        begin
            $display("----PASS!!!");
        end
	    $finish;
	end
end

endmodule
