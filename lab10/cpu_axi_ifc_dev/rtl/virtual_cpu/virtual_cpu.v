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

module virtual_cpu
(
    input         clk,
    input         resetn, 

    //------inst sram-like-------
    output reg    inst_req    ,
    output        inst_wr     ,
    output [1 :0] inst_size   ,
    output [31:0] inst_addr   ,
    output [31:0] inst_wdata  ,
    input  [31:0] inst_rdata  ,
    input         inst_addr_ok,
    input         inst_data_ok,
    
    //------data sram-like-------
    output reg    data_req    ,
    output        data_wr     ,
    output [1 :0] data_size   ,
    output [31:0] data_addr   ,
    output [31:0] data_wdata  ,
    input  [31:0] data_rdata  ,
    input         data_addr_ok,
    input         data_data_ok,

    //from confreg
    input         cpu_simu_flag,
    output        display_num_valid,
    output [31:0] display_num_data

);
//inst/data request complete
reg        inst_5_ok;   //inst req 5 times finished
reg        data_10_ok;  //data req 10 times finished
wire       both_ok;     //now ,is displaying data  
reg [3:0] inst_addr_cnt;
reg [3:0] inst_data_cnt;
reg [1:0] inst_wait_dep;
reg [3:0] data_addr_cnt;
reg [3:0] data_data_cnt;    
reg [1:0] data_wait_dep;
reg [3 :0] display_cnt;
wire       wait_1s;
reg [31:0] display_data_v[9:0];

assign both_ok = inst_5_ok&&data_10_ok;
always @(posedge clk)
begin
    inst_5_ok    <= !resetn                    ? 1'd0 :
                    display_cnt==4'd9&&wait_1s ? 1'd0 :
                    inst_data_cnt==4'd4&&inst_wait_dep!=2'd0&&inst_data_ok ? 1'b1 : inst_5_ok;
    data_10_ok   <= !resetn                    ? 1'd0 :
                    display_cnt==4'd9&&wait_1s ? 1'd0 :
                    data_data_cnt==4'd9&&data_wait_dep!=2'd0&&data_data_ok ? 1'b1 : data_10_ok;
end


//display data
//0~4: read data from data sram 
//5~9: read data from inst sram 
always @(posedge clk)
begin
    if (!resetn || !both_ok)
    begin
        display_cnt <= 4'd0;
    end
    else
    begin
        display_cnt <= display_cnt + wait_1s;
    end
end
//wait_1s
reg [26:0] wait_cnt;
assign wait_1s = wait_cnt==27'd0;
always @(posedge clk)
begin
    if (!resetn || !both_ok || wait_1s)
    begin
        wait_cnt <= cpu_simu_flag ? 27'd5 : 27'd60_000_000;
    end
    else
    begin
        wait_cnt <= wait_cnt - 1'b1;
    end
end

assign display_num_valid = cpu_simu_flag ? (wait_cnt==(27'd5-1)) : (wait_cnt==(27'd60_000_000-1));
assign display_num_data  = display_data_v[display_cnt];

//-----inst access----- 
reg       do_inst_req;

always @(posedge clk)
begin
    do_inst_req  <= !resetn     ? 1'b1 :
                    inst_addr_cnt==4'd4&&inst_req&&inst_addr_ok ? 1'b0 :
                    do_inst_req;
    if (!resetn)
    begin
        inst_wait_dep <= 2'd0;
    end
    else
    begin
        inst_wait_dep <= inst_wait_dep + (inst_req&&inst_addr_ok)
                       - ((inst_wait_dep!=2'd0)&&inst_data_ok);
    end
    
    //inst_req
    if (!resetn || !do_inst_req || inst_addr_cnt==4'd4&&inst_req&&inst_addr_ok)
    begin
        inst_req <= 1'b0;
    end
    else if (inst_wait_dep==2'd2)
    begin
        inst_req <= 1'b0;
    end
    else
    begin
        inst_req <= 1'b1;
    end

    //inst_addr
    if (!resetn)
    begin
        inst_addr_cnt <= 4'd0;
    end
    else if (inst_req&&inst_addr_ok)
    begin
        inst_addr_cnt <= inst_addr_cnt==4'd4 ? 4'd0 : inst_addr_cnt + 1'b1;
    end

    //inst_data
    if (!resetn)
    begin
        inst_data_cnt <= 4'd0;
    end
    else if ((inst_wait_dep!=2'd0)&&inst_data_ok)
    begin
        inst_data_cnt <= inst_data_cnt==4'd4 ? 4'd0 : inst_data_cnt + 1'b1;
    end
end

//0~9 inst req
wire [31:0] inst_addr_v [4:0];
wire [31:0] inst_rdata_ref_v[4:0];

//inst sram-like
assign inst_wr    = 1'd0;
assign inst_size  = 2'd2;
assign inst_addr  = inst_req&&inst_addr_ok ? inst_addr_v [inst_addr_cnt] : 32'hxxxxxxxx;
assign inst_wdata = 32'd0;

//0 :read 4 bytes
assign inst_addr_v       [0] = 32'h0000_0000;
assign inst_rdata_ref_v  [0] = 32'h6666_6666; //mem[8'h00][31:0]
//1 :read 4 bytes
assign inst_addr_v       [1] = 32'h0000_0004;
assign inst_rdata_ref_v  [1] = 32'h7777_7777; //mem[8'h04][31:0]
//0 :read 4 bytes
assign inst_addr_v       [2] = 32'h0000_0008;
assign inst_rdata_ref_v  [2] = 32'h8888_8888; //mem[8'h08][31:0]
//0 :read 4 bytes
assign inst_addr_v       [3] = 32'h0000_000c;
assign inst_rdata_ref_v  [3] = 32'h9999_9999; //mem[8'h0c][31:0]
//0 :read 4 bytes
assign inst_addr_v       [4] = 32'h0000_0010;
assign inst_rdata_ref_v  [4] = 32'haaaa_aaaa; //mem[8'h10][31:0]

//-----data access----- 
reg       do_data_req;

always @(posedge clk)
begin
    do_data_req  <= !resetn     ? 1'b1 :
                    data_addr_cnt==4'd9&&data_req&&data_addr_ok ? 1'b0 :
                    do_data_req;
    if (!resetn)
    begin
        data_wait_dep <= 2'd0;
    end
    else
    begin
        data_wait_dep <= data_wait_dep + (data_req&&data_addr_ok)
                       - ((data_wait_dep!=2'd0)&&data_data_ok);
    end
    
    //data_req
    if (!resetn || !do_data_req || data_addr_cnt==4'd9&&data_req&&data_addr_ok)
    begin
        data_req <= 1'b0;
    end
    else if (data_wait_dep==2'd2)
    begin
        data_req <= 1'b0;
    end
    else
    begin
        data_req <= 1'b1;
    end

    //data_addr
    if (!resetn)
    begin
        data_addr_cnt <= 4'd0;
    end
    else if (data_req&&data_addr_ok)
    begin
        data_addr_cnt <= data_addr_cnt==4'd9 ? 4'd0 : data_addr_cnt + 1'b1;
    end

    //data_data
    if (!resetn)
    begin
        data_data_cnt <= 4'd0;
    end
    else if ((data_wait_dep!=2'd0)&&data_data_ok)
    begin
        data_data_cnt <= data_data_cnt==4'd9 ? 4'd0 : data_data_cnt + 1'b1;
    end
end

//0~9 data req
wire        data_wr_v   [9:0];
wire [1 :0] data_size_v [9:0];
wire [31:0] data_addr_v [9:0];
wire [31:0] data_wdata_v[9:0];
wire [31:0] data_rdata_ref_v[9:0];
wire [31:0] data_rdata_ref_m_v[9:0];

//data sram-like
assign data_wr    = data_wr_v   [data_addr_cnt];
assign data_size  = data_size_v [data_addr_cnt];
assign data_addr  = data_req&&data_addr_ok ? data_addr_v [data_addr_cnt] : 32'hxxxx_xxxx;
assign data_wdata = data_req&&data_addr_ok ? data_wdata_v[data_addr_cnt] : 32'hxxxx_xxxx;

//0 :write 4 bytes
assign data_wr_v         [0] = 1'b1; 
assign data_size_v       [0] = 2'd2;
assign data_addr_v       [0] = 32'h0000_8000;
assign data_wdata_v      [0] = 32'h1111_1111; //mem[8'h00] = 32'h1111_1111
//1 :write 2 bytes
assign data_wr_v         [1] = 1'b1; 
assign data_size_v       [1] = 2'd1;
assign data_addr_v       [1] = 32'h0000_8042;
assign data_wdata_v      [1] = 32'h2222_2222; //mem[8'h40] = 32'h2222_0000
//2 :read 4 bytes
assign data_wr_v         [2] = 1'b0; 
assign data_size_v       [2] = 2'd2;
assign data_addr_v       [2] = 32'h0000_8040;
assign data_rdata_ref_v  [2] = 32'h2222_0000; //mem[8'h40][31:0]
assign data_rdata_ref_m_v[2] = 32'hffff_ffff;
//3 :write 1 bytes
assign data_wr_v         [3] = 1'b1; 
assign data_size_v       [3] = 2'd0;
assign data_addr_v       [3] = 32'h0000_8001;
assign data_wdata_v      [3] = 32'h3333_3333; //mem[8'h00] = 32'h1111_3311
//4 :read 1 bytes
assign data_wr_v         [4] = 1'b0; 
assign data_size_v       [4] = 2'd0;
assign data_addr_v       [4] = 32'h0000_8002;
assign data_rdata_ref_v  [4] = 32'h0011_0000; //mem[8'h00][23:16]
assign data_rdata_ref_m_v[4] = 32'h00ff_0000;
//5 :read 2 bytes
assign data_wr_v         [5] = 1'b0; 
assign data_size_v       [5] = 2'd1;
assign data_addr_v       [5] = 32'h0000_8040;
assign data_rdata_ref_v  [5] = 32'h0000_0000; //mem[8'h40][15: 0]
assign data_rdata_ref_m_v[5] = 32'h0000_ffff;
//6 :read 4 bytes
assign data_wr_v         [6] = 1'b0; 
assign data_size_v       [6] = 2'd2;
assign data_addr_v       [6] = 32'h0000_8000;
assign data_rdata_ref_v  [6] = 32'h1111_3311; //mem[8'h00][31: 0]
assign data_rdata_ref_m_v[6] = 32'hffff_ffff;
//7 :write 2 bytes
assign data_wr_v         [7] = 1'b1; 
assign data_size_v       [7] = 2'd1;
assign data_addr_v       [7] = 32'h0000_8080;
assign data_wdata_v      [7] = 32'h4444_4444; //mem[8'h80] = 32'h0000_4444
//8 :write 1 bytes
assign data_wr_v         [8] = 1'b1; 
assign data_size_v       [8] = 2'd0;
assign data_addr_v       [8] = 32'h0000_8083;
assign data_wdata_v      [8] = 32'h5555_5555; //mem[8'h00] = 32'h5500_4444
//9 :read 4 bytes
assign data_wr_v         [9] = 1'b0; 
assign data_size_v       [9] = 2'd2;
assign data_addr_v       [9] = 32'h0000_8080;
assign data_rdata_ref_v  [9] = 32'h5500_4444; //mem[8'h80][31: 0]
assign data_rdata_ref_m_v[9] = 32'hffff_ffff;

//register display data
always @(posedge clk)
begin
    display_data_v[0] <= !resetn ? 32'd0 :
                        data_data_cnt==4'd2 && data_wait_dep!=2'd0 && data_data_ok ? 
                        (data_rdata&data_rdata_ref_m_v[2]) -32'h1111_0000+32'h0000_1111 : display_data_v[0];
    display_data_v[1] <= !resetn ? 32'd0 :
                        data_data_cnt==4'd4 && data_wait_dep!=2'd0 && data_data_ok ?
                        (data_rdata&data_rdata_ref_m_v[4]) +32'h2211_2222               : display_data_v[1];
    display_data_v[2] <= !resetn ? 32'd0 :
                        data_data_cnt==4'd5 && data_wait_dep!=2'd0 && data_data_ok ?
                        (data_rdata&data_rdata_ref_m_v[5]) +32'h3333_3333               : display_data_v[2];
    display_data_v[3] <= !resetn ? 32'd0 :
                        data_data_cnt==4'd6 && data_wait_dep!=2'd0 && data_data_ok ?
                        (data_rdata&data_rdata_ref_m_v[6]) +32'h3333_1133               : display_data_v[3];
    display_data_v[4] <= !resetn ? 32'd0 :
                        data_data_cnt==4'd9 && data_wait_dep!=2'd0 && data_data_ok ?
                        (data_rdata&data_rdata_ref_m_v[9]) +32'h0055_1111               : display_data_v[4];
    display_data_v[5] <= !resetn ? 32'd0 :
                        inst_data_cnt==4'd0 && inst_wait_dep!=2'd0 && inst_data_ok ?
                        inst_rdata : display_data_v[5];
    display_data_v[6] <= !resetn ? 32'd0 :
                        inst_data_cnt==4'd1 && inst_wait_dep!=2'd0 && inst_data_ok ?
                        inst_rdata : display_data_v[6];
    display_data_v[7] <= !resetn ? 32'd0 :
                        inst_data_cnt==4'd2 && inst_wait_dep!=2'd0 && inst_data_ok ?
                        inst_rdata : display_data_v[7];
    display_data_v[8] <= !resetn ? 32'd0 :
                        inst_data_cnt==4'd3 && inst_wait_dep!=2'd0 && inst_data_ok ?
                        inst_rdata : display_data_v[8];
    display_data_v[9] <= !resetn ? 32'd0 :
                        inst_data_cnt==4'd4 && inst_wait_dep!=2'd0 && inst_data_ok ?
                        inst_rdata : display_data_v[9];
end

endmodule
