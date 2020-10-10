module cpu_axi_interface(
    input     clk,
    input     resetn,

    //inst sram-like (master: cpu, slave: interface)
    input             inst_req     ,// master -> slave
    input             inst_wr      ,// master -> slave
    input      [ 1:0] inst_size    ,// master -> slave
    input      [31:0] inst_addr    ,// master -> slave
    input      [31:0] inst_wdata   ,// master -> slave
    output reg [31:0] inst_rdata   ,// slave  -> master
    output            inst_addr_ok ,// slave  -> master
    //output reg        inst_data_ok ,
    output            inst_data_ok ,// slave  -> master
    //data sram-like (master: cpu, slave: interface)
    input             data_req     ,// master -> slave
    input             data_wr      ,// master -> slave
    input      [ 2:0] data_size    ,// master -> slave
    input      [31:0] data_addr    ,// master -> slave
    input      [31:0] data_wdata   ,// master -> slave
    output reg [31:0] data_rdata   ,// slave  -> master
    output            data_addr_ok ,// slave  -> master
    output            data_data_ok ,// slave  -> master

    //axi (master: interface, slave: axi)
    //ar: acquire reading channels
    output reg [ 3:0] arid    ,// master -> slave
    output reg [31:0] araddr  ,// master -> slave
    output     [ 7:0] arlen   ,// master -> slave, fixed at 8'b0
    output reg [ 2:0] arsize  ,// master -> slave
    output     [ 1:0] arburst ,// master -> slave, fixed at 2'b1
    output     [ 1:0] arlock  ,// master -> slave, fixed at 2'b0
    output     [ 3:0] arcache ,// master -> slave, fixed at 4'b0
    output     [ 2:0] arprot  ,// master -> slave, fixed at 3'b0
    output reg        arvalid ,// master -> slave
    input             arready ,// slave  -> master
    //r: reading response channels               
    input      [ 3:0] rid     ,// slave  -> master
    input      [31:0] rdata   ,// slave  -> master
    input      [ 1:0] rresp   ,// slave  -> master, ignore
    input             rlast   ,// slave  -> master, ignore
    input             rvalid  ,// slave  -> master
    output reg        rready  ,// master -> slave
    //aw: acquire writing channels                  
    output     [ 3:0] awid    ,// master -> slave, fixed at 4'b1
    output reg [31:0] awaddr  ,// master -> slave
    output     [ 7:0] awlen   ,// master -> slave, fixed at 8'b0
    output reg [ 2:0] awsize  ,// master -> slave
    output     [ 1:0] awburst ,// master -> slave, fixed at 2'b1
    output     [ 1:0] awlock  ,// master -> slave, fixed at 2'b0
    output     [ 3:0] awcache ,// master -> slave, fixed at 4'b0
    output     [ 2:0] awprot  ,// master -> slave, fixed at 3'b0
    output reg        awvalid ,// master -> slave
    input             awready ,// slave  -> master
    //w: write data channels                    
    output     [ 3:0] wid     ,// master -> slave, fixed at 4'b1
    output reg [31:0] wdata   ,// master -> slave
    output reg [ 3:0] wstrb   ,// master -> slave
    output            wlast   ,// master -> slave, fixed at 1'b1
    output reg        wvalid  ,// master -> slave
    input             wready  ,// slave  -> master
    //b: writing response channels               
    input      [ 3:0] bid     ,// slave  -> master, ignore
    input      [ 1:0] bresp   ,// slave  -> master, ignore
    input             bvalid  ,// slave  -> master
    output reg        bready  // master -> slave
);

reg [2:0] r_curstate;
reg [2:0] r_nxtstate;
reg [2:0] w_curstate;
reg [2:0] w_nxtstate;
parameter ReadStart    = 3'd0;
parameter Readinst  = 3'd1;
parameter Read_data_check  = 3'd2;
parameter Readdata = 3'd5;
parameter ReadEnd   = 3'd4;
parameter WriteStart   = 3'd4;
parameter Writeinst = 3'd5;
parameter Writedata = 3'd6;
parameter WriteEnd  = 3'd7;

always@(posedge clk)
begin
    if(~resetn) begin
        r_curstate <= ReadStart;
        w_curstate <= WriteStart;
    end else begin
        r_curstate <= r_nxtstate;
        w_curstate <= w_nxtstate;
    end
end

reg [31:0] awaddr_t;
always@(posedge clk)
begin
    if(~resetn) begin
        awaddr_t   <= 32'd0;
    end else if(data_req && data_wr && w_curstate == WriteStart) begin
        awaddr_t   <= data_addr;
    end else if(bvalid) begin
        awaddr_t   <= 32'd0;
    end
end

reg read_wait_write;
reg write_wait_read;
always@(posedge clk)
begin
    if(~resetn) 
        read_wait_write <= 1'b0;
    else if(r_curstate == ReadStart && r_nxtstate == Read_data_check && bready && ~bvalid)    //��ʾ�ڸ��ź�֮ǰ��дָ�����ڹ���,����ok�ź�ͬʱ����д�Ͷ������ͬʱ��д�Ͷ����ڽ��У���Ҫ�����н�����?
        read_wait_write <= 1'b1;                                                          //һ���Ľ���״̬���ӳ�����һ���������Ӷ���֤��������ok�ź�
    else if(bvalid)
        read_wait_write <= 1'b0;
end
always@(posedge clk)
begin
    if(~resetn)
        write_wait_read <= 1'b0;
    else if(w_curstate == WriteStart && w_nxtstate == Writedata && rready && ~rvalid) //��ʾ��дָ��ǰ�ж�ָ�����ڹ���
        write_wait_read <= 1'b1;
    else if(rvalid)
        write_wait_read <= 1'b0;
end


always@(*)
begin
    case(r_curstate)
        ReadStart:
        begin
            if(inst_req && ~inst_wr)
                r_nxtstate = Readinst;
            else if(data_req && ~data_wr)
                r_nxtstate = Read_data_check;
            else
                r_nxtstate = r_curstate;
        end 
        Readinst, Readdata:
        begin
            if(rvalid)
                r_nxtstate = ReadEnd;
            else
                r_nxtstate = r_curstate;
        end
        Read_data_check:
        begin
            if(bready && awaddr_t[31:2] == araddr[31:2])
                r_nxtstate = r_curstate;
            else
                r_nxtstate = Readdata;
        end
        ReadEnd:
        begin
            if(read_wait_write)
                r_nxtstate = r_curstate;
            else
                r_nxtstate = ReadStart;
        end
        default:
            r_nxtstate = ReadStart;
    endcase
end

always@(*)
begin
    case (w_curstate)
        WriteStart:
        begin
            if(inst_req && inst_wr)
                w_nxtstate = Writeinst;
            else if(data_req && data_wr)
                w_nxtstate = Writedata;
            else
                w_nxtstate = w_curstate;
        end 
        Writeinst, Writedata:
        begin
            if(bvalid)
                w_nxtstate = WriteEnd;
            else
                w_nxtstate = w_curstate;
        end
        WriteEnd:
        begin
            if(write_wait_read)
                w_nxtstate = w_curstate;
            else
                w_nxtstate = WriteStart;
        end
        default:
            w_nxtstate = WriteStart;
    endcase
end

assign inst_addr_ok = r_curstate == ReadStart && r_nxtstate == Readinst || w_curstate == WriteStart && w_nxtstate == Writeinst;
assign data_addr_ok = r_curstate == ReadStart && r_nxtstate == Read_data_check || w_curstate == WriteStart && w_nxtstate == Writedata;

reg rvalid_t;
always@(posedge clk)
begin
    if(~resetn)
        rvalid_t <= 1'b0;
    else if(r_curstate == ReadEnd && r_nxtstate == ReadStart && arid == 4'd1 
                 && w_curstate == WriteEnd && w_nxtstate == WriteStart)
        rvalid_t <= 1'b1;
    else
        rvalid_t <= 1'b0;
end

always@(posedge clk)
begin
    if(rvalid && arid == 4'd0)
        inst_rdata <= rdata;
    
    if(rvalid && arid == 4'd1)
        data_rdata <= rdata;

 //   inst_data_ok <= rvalid && arid == 4'd0;
    
end
assign inst_data_ok = r_curstate == ReadEnd && arid == 4'd0;
//data_data_ok chage from reg to wire
assign data_data_ok = r_curstate == ReadEnd && r_nxtstate == ReadStart && arid == 4'd1 
                 || w_curstate == WriteEnd && w_nxtstate == WriteStart || rvalid_t;   //rvalid_t�źž��ǵ�����дͬʱ����ʱ������д/������ok���ٵ���һ�ķ�����/дok
always@(posedge clk)
begin
    if(r_curstate == ReadStart && r_nxtstate == Readinst) begin
        arid   <= 4'd0;
        araddr <= inst_addr;
        arsize <= !inst_size ? 3'd1 : {inst_size, 1'b0};
    end else if(r_curstate == ReadStart && r_nxtstate == Read_data_check) begin
        arid   <= 4'd1;
        araddr <= {data_addr[31:2], 2'd0};
        arsize <= !data_size[1:0] ? 3'd1 : {data_size[1:0], 1'b0};
    end else if(r_curstate == ReadEnd) begin
        araddr <= 32'd0;
    end
end

always@(posedge clk)
begin
    if(~resetn)
        arvalid <= 1'b0;
    else if(r_curstate == ReadStart && r_nxtstate == Readinst || r_curstate == Read_data_check && r_nxtstate == Readdata)
        arvalid <= 1'b1;
    else if(arready)
        arvalid <= 1'b0;
end

always@(posedge clk)
begin
    if(~resetn)
        rready <= 1'b1;
    else if(r_nxtstate == Readinst || r_nxtstate == Read_data_check)
        rready <= 1'b1;
    else if(rvalid)
        rready <= 1'b0;
end

always@(posedge clk)
begin
    if(w_curstate == WriteStart && w_nxtstate == Writeinst) begin
        awaddr <= inst_addr;
        awsize <= !inst_size ? 3'd1 : {inst_size, 1'b0};
    end else if(w_curstate == WriteStart && w_nxtstate == Writedata) begin
        awaddr <= {data_addr[31:2], 2'd0};
        awsize <= !data_size[1:0] ? 3'd1 : {data_size[1:0], 1'b0};
    end
end

always@(posedge clk)
begin
    if(~resetn)
        awvalid <= 1'b0;
    else if(w_curstate == WriteStart && (w_nxtstate == Writeinst || w_nxtstate == Writedata))
        awvalid <= 1'b1;
    else if(awready)
        awvalid <= 1'b0;
end

always@(posedge clk)
begin
    if(w_curstate == WriteStart && w_nxtstate == Writeinst) begin
        wdata <= inst_wdata;
       
        wstrb <= (~data_size[2])?
                    (data_addr[1:0] == 2'b00 && data_size[1:0] == 2'b00) ? 4'b0001
                    :(data_addr[1:0] == 2'b01 && data_size[1:0] == 2'b00) ? 4'b0010
                    :(data_addr[1:0] == 2'b10 && data_size[1:0] == 2'b00) ? 4'b0100
                    :(data_addr[1:0] == 2'b11 && data_size[1:0] == 2'b00) ? 4'b1000
                    :(data_addr[1:0] == 2'b00 && data_size[1:0] == 2'b01) ? 4'b0011
                    :(data_addr[1:0] == 2'b10 && data_size[1:0] == 2'b01) ? 4'b1100
                    :(data_addr[1:0] == 2'b00 && data_size[1:0] == 2'b10) ? 4'b1111
                :   (data_size[0])?
                        (data_addr[1:0]==2'b00)?4'b1111:
                        (data_addr[1:0]==2'b01)?4'b1110:
                        (data_addr[1:0]==2'b10)?4'b1100:
                                                4'b1000
                       :(data_addr[1:0]==2'b00)?4'b0001:
                        (data_addr[1:0]==2'b01)?4'b0011:
                        (data_addr[1:0]==2'b10)?4'b0111:
                                                4'b1111:
                   4'b1111;
                        
                    
    end else if(w_curstate == WriteStart && w_nxtstate == Writedata) begin
        wdata <= data_wdata;
       
        wstrb <= (~data_size[2])?
                    (data_addr[1:0] == 2'b00 && data_size[1:0] == 2'b00) ? 4'b0001
                    :(data_addr[1:0] == 2'b01 && data_size[1:0] == 2'b00) ? 4'b0010
                    :(data_addr[1:0] == 2'b10 && data_size[1:0] == 2'b00) ? 4'b0100
                    :(data_addr[1:0] == 2'b11 && data_size[1:0] == 2'b00) ? 4'b1000
                    :(data_addr[1:0] == 2'b00 && data_size[1:0] == 2'b01) ? 4'b0011
                    :(data_addr[1:0] == 2'b10 && data_size[1:0] == 2'b01) ? 4'b1100
                    :(data_addr[1:0] == 2'b00 && data_size[1:0] == 2'b10) ? 4'b1111
                :   (data_size[0])?
                        (data_addr[1:0]==2'b00)?4'b1111:
                        (data_addr[1:0]==2'b01)?4'b1110:
                        (data_addr[1:0]==2'b10)?4'b1100:
                                                4'b1000
                       :(data_addr[1:0]==2'b00)?4'b0001:
                        (data_addr[1:0]==2'b01)?4'b0011:
                        (data_addr[1:0]==2'b10)?4'b0111:
                                                4'b1111
               :4'b1111;
    end
end

always@(posedge clk)
begin
    if(~resetn)
        wvalid <= 1'b0;
    else if(w_curstate == WriteStart && (w_nxtstate == Writeinst || w_nxtstate == Writedata))
        wvalid <= 1'b1;
    else if(wready)
        wvalid <= 1'b0;
end

always@(posedge clk)
begin
    if(~resetn)
        bready <= 1'b0;
    else if(w_nxtstate == Writeinst || w_nxtstate == Writedata)
        bready <= 1'b1;
    else if(bvalid)
        bready <= 1'b0;
end

// ar
assign arlen   = 8'd0;
assign arburst = 2'b01;
assign arlock  = 2'd0;
assign arcache = 4'd0;
assign arprot  = 3'd0;

//aw
assign awid    = 4'd1;
assign awlen   = 8'd0;
assign awburst = 2'b01;
assign awlock  = 2'd0;
assign awcache = 4'd0;
assign awprot  = 3'd0;

//w
assign wid   = 4'd1;
assign wlast = 1'b1;

endmodule