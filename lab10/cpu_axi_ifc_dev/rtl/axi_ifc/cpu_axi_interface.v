module cpu_axi_interface(
    input         clk,
    input         resetn,

    // inst sram-like (master: cpu, slave: interface)
    input         inst_req,      // master -> slave
    input         inst_wr,       // master -> slave
    input  [ 1:0] inst_size,     // master -> slave
    input  [31:0] inst_addr,     // master -> slave
//  input  [ 3:0] inst_wstrb,    // master -> slave
    input  [31:0] inst_wdata,    // master -> slave
    output [31:0] inst_rdata,    // slave  -> master
    output        inst_addr_ok,  // slave  -> master
    output        inst_data_ok,  // slave  -> master
    
    // data sram-like (master: cpu, slave: interface) 
    input         data_req,      // master -> slave
    input         data_wr,       // master -> slave
    input  [ 1:0] data_size,     // master -> slave
    input  [31:0] data_addr,     // master -> slave
//  input  [ 3:0] data_wstrb,    // master -> slave
    input  [31:0] data_wdata,    // master -> slave
    output [31:0] data_rdata,    // slave  -> master
    output        data_addr_ok,  // slave  -> master
    output        data_data_ok,  // slave  -> master

    // axi (master: interface, slave: axi)
    // ar: acquire reading channels
    output [ 3:0] arid,          // master -> slave
    output [31:0] araddr,        // master -> slave
    output [ 7:0] arlen,         // master -> slave, fixed at 8'b0
    output [ 2:0] arsize,        // master -> slave
    output [ 1:0] arburst,       // master -> slave, fixed at 2'b1
    output [ 1:0] arlock,        // master -> slave, fixed at 2'b0
    output [ 3:0] arcache,       // master -> slave, fixed at 4'b0
    output [ 2:0] arprot,        // master -> slave, fixed at 3'b0
    output        arvalid,       // master -> slave
    input         arready,       // slave  -> master
    // r: reading response channels             
    input  [ 3:0] rid,           // slave  -> master
    input  [31:0] rdata,         // slave  -> master
    input  [ 1:0] rresp,         // slave  -> master, ignored
    input         rlast,         // slave  -> master, ignored
    input         rvalid,        // slave  -> master
    output        rready,        // master -> slave
    // aw: acquire writing channels           
    output [ 3:0] awid,          // master -> slave, fixed at 4'b1
    output [31:0] awaddr,        // master -> slave
    output [ 7:0] awlen,         // master -> slave, fixed at 8'b0
    output [ 2:0] awsize,        // master -> slave
    output [ 1:0] awburst,       // master -> slave, fixed at 2'b1
    output [ 1:0] awlock,        // master -> slave, fixed at 2'b0
    output [ 3:0] awcache,       // master -> slave, fixed at 4'b0
    output [ 2:0] awprot,        // master -> slave, fixed at 3'b0
    output        awvalid,       // master -> slave
    input         awready,       // slave  -> master
    // w: write data channels       
    output [ 3:0] wid,           // master -> slave, fixed at 4'b1
    output [31:0] wdata,         // master -> slave
    output [ 3:0] wstrb,         // master -> slave
    output        wlast,         // master -> slave, fixed at 1'b1
    output        wvalid,        // master -> slave
    input         wready,        // slave  -> master
    // b: writing response channels              
    input  [ 3:0] bid,           // slave  -> master, ignored
    input  [ 1:0] bresp,         // slave  -> master, ignored
    input         bvalid,        // slave  -> master
    output        bready         // master -> slave
);

	// control signals
    wire        inst_read;
    wire        inst_write;
    wire        data_read;
    wire        data_write;
    
    wire        raw_collide;

    // wire        inst_addr_read;
    // wire        inst_addr_write;
    // wire        inst_data_read;
    // wire        inst_data_write;
    
    // wire        data_addr_read;
    // wire        data_addr_write;
    // wire        data_data_read;
    // wire        data_data_write;

	reg			inst_raddr_arrived;
	reg			inst_waddr_arrived;
	reg			inst_wdata_arrived;
	
	reg			data_raddr_arrived;
	reg			data_waddr_arrived;
	reg			data_wdata_arrived;
	
	wire		inst_read_complete;
	wire		data_read_complete;		
	wire		inst_write_complete;
	wire		data_write_complete;

    // inst sram-like (master: cpu, slave: interface)
    reg  [31:0] inst_rdata_r;
    
    // data sram-like (master: cpu, slave: interface)
    reg  [31:0] data_rdata_r;   

    // axi (master: interface, slave: axi)
    // ar: acquire reading channels
    reg  [ 3:0] arid_r;
    reg  [31:0] araddr_r;
    reg  [ 2:0] arsize_r;
    reg         arvalid_r;
    // r: reading response channels             
    reg         rready_r;
    // aw: acquire writing channels           
    reg  [31:0] awaddr_r;
    reg  [ 2:0] awsize_r;
    reg         awvalid_r;
    // w: write data channels       
    reg  [31:0] wdata_r;
    reg  [ 3:0] wstrb_r;
    reg         wvalid_r;
    // b: writing response channels              
    reg         bready_r;


	// control signals
    assign inst_read    = inst_req && !inst_wr;
    assign inst_write   = inst_req &&  inst_wr;
    assign data_read    = data_req && !data_wr;
    assign data_write   = data_req &&  data_wr;

    assign raw_collide  = inst_read && data_write && inst_addr == data_addr;

    // assign inst_addr_read  = inst_read  && !data_read  && arvalid && arready && rid == 4'b00 && inst_req;
    // assign inst_addr_write = inst_write && !data_write && awvalid && awready && wid == 4'b01 && wvalid && wready && inst_req;
    // assign inst_data_read  = inst_read  && !data_read  &&  rvalid &&  rready && rid == 4'b00 ;
    // assign inst_data_write = inst_write && !data_write &&  bvalid &&  bready && bid == 4'b01 ;

    // assign data_addr_read  = data_read  && arvalid && arready && rid == 4'b01 && data_req;
    // assign data_addr_write = data_write && awvalid && awready && wid == 4'b01 && wvalid && wready && data_req;
    // assign data_data_read  = data_read  &&  rvalid &&  rready && rid == 4'b01 ; 
    // assign data_data_write = data_write &&  bvalid &&  bready && bid == 4'b01 ;

	assign inst_read_complete  = inst_raddr_arrived && rvalid && rready && rid == 4'b0 && !data_read;
	assign data_read_complete  = data_raddr_arrived && rvalid && rready && rid == 4'b1;	
	
	assign inst_write_complete = inst_waddr_arrived && inst_wdata_arrived && bvalid && bready && bid == 4'b1 && !data_write;
	assign data_write_complete = data_waddr_arrived && data_wdata_arrived && bvalid && bready && bid == 4'b1;

	always @(posedge clk) begin
		if(!resetn) begin
			inst_raddr_arrived <= 1'b0;
		end
		else if(inst_read_complete) begin
			inst_raddr_arrived <= 1'b0;
		end
		else if(inst_read && !data_read && arvalid && arready && rid == 4'b0) begin
			inst_raddr_arrived <= 1'b1;
		end
	end
	
	always @(posedge clk) begin
		if(!resetn) begin
			inst_waddr_arrived <= 1'b0;
		end
		else if(inst_write_complete) begin
			inst_waddr_arrived <= 1'b0;
		end
		else if(inst_write && !data_write && awvalid && awready && wid == 4'b0) begin
			inst_waddr_arrived <= 1'b1;
		end
	end

	always @(posedge clk) begin
		if(!resetn) begin
			inst_wdata_arrived <= 1'b0;
		end
		else if(inst_write_complete) begin
			inst_wdata_arrived <= 1'b0;
		end
		else if(inst_write && !data_write &&  wvalid &&  wready && wid == 4'b0) begin
			inst_wdata_arrived <= 1'b1;
		end
	end

	always @(posedge clk) begin
		if(!resetn) begin
			data_raddr_arrived <= 1'b0;
		end
		else if(data_read_complete) begin
			data_raddr_arrived <= 1'b0;
		end
		else if(data_read  && arvalid && arready && rid == 4'b1) begin
			data_raddr_arrived <= 1'b1;
		end
	end
	
	always @(posedge clk) begin
		if(!resetn) begin
			data_waddr_arrived <= 1'b0;
		end
		else if(data_write_complete) begin
			data_waddr_arrived <= 1'b0;
		end
		else if(data_write && awvalid && awready && awid == 4'b1) begin
			data_waddr_arrived <= 1'b1;
		end
	end

	always @(posedge clk) begin
		if(!resetn) begin
			data_wdata_arrived <= 1'b0;
		end
		else if(data_write_complete) begin
			data_wdata_arrived <= 1'b0;
		end
		else if(data_write &&  wvalid &&  wready &&  wid == 4'b1) begin
			data_wdata_arrived <= 1'b1;
		end
	end

    // inst sram-like (master: cpu, slave: interface)
    assign inst_rdata   = inst_rdata_r;
    assign inst_addr_ok = inst_raddr_arrived || inst_waddr_arrived && inst_wdata_arrived;
    assign inst_data_ok = inst_read_complete || inst_write_complete;
    
    always @(posedge clk) begin
        if(inst_read && !data_read) begin
            inst_rdata_r <= rdata;
        end
    end

    
    // data sram-like (master: cpu, slave: interface) 
    assign data_rdata   = data_rdata_r;
    assign data_addr_ok = data_raddr_arrived || data_waddr_arrived && data_wdata_arrived;
    assign data_data_ok = data_read_complete || data_write_complete;

    always @(posedge clk) begin
        if(data_read) begin  // load has higher priority
            data_rdata_r <= rdata;
        end
    end

    
    // axi-ar: acquire reading channels
    assign arid    = arid_r;
    assign araddr  = araddr_r;
    assign arlen   = 8'b0;
    assign arsize  = arsize_r;
    assign arburst = 2'b01;
    assign arlock  = 2'b0;
    assign arcache = 4'b0;
    assign arprot  = 3'b0;
    assign arvalid = arvalid_r;
    
    always @(posedge clk) begin
        if(arvalid && !arready) begin
            ;
        end
        else begin
            arid_r   <= (data_read) ? 4'b01:  // load data
                        (inst_read) ? 4'b00:  // IF
                                      4'b11;
        end
    end
    
    always @(posedge clk) begin
        if(arvalid && !arready) begin
            ;
        end
        else begin
			araddr_r <= (data_read) ? data_addr:
						(inst_read) ? inst_addr:
									  32'b0;
        end                       
    end

    always @(posedge clk) begin
        if(arvalid && !arready) begin
            ;
        end
        else begin
			arsize_r <= (data_read) ? data_size:
						(inst_read) ? inst_size:
									  3'b0;
        end                       
    end

    always @(posedge clk) begin
        if(!resetn) begin
            arvalid_r <= 1'b0;      
        end
        else begin
            arvalid_r <= data_read || inst_read;
        end
    end

    
    // axi-r: reading response channels             
    assign rready  = rready_r;
    
    always @(posedge clk) begin
        if(!resetn) begin
            rready_r <= 1'b0;
        end
        else begin
            if(data_read) begin
                rready_r <= 1'b1;
            end
            else if(inst_read) begin
                rready_r <= !raw_collide;
            end
        end
    end
    

    // axi-aw: acquire writing channels           
    assign awid    = 4'b1;
    assign awaddr  = awaddr_r;
    assign awlen   = 8'b0;
    assign awsize  = awsize_r;
    assign awburst = 2'b01;
    assign awlock  = 2'b0;
    assign awcache = 4'b0;
    assign awprot  = 3'b0;
    assign awvalid = awvalid_r;
    
    always @(posedge clk) begin
        if(awvalid && !awready) begin
            ;
        end
        else begin
            awaddr_r <= {32{data_write}} & data_addr;
        end
    end
    
    always @(posedge clk) begin
        if(awvalid && !awready) begin
            ;
        end
        else begin
            awsize_r <= { 3{data_write}} & data_size;
        end
    end
    
    always @(posedge clk) begin
        if(!resetn) begin
            awvalid_r <= 1'b0;
        end
        else begin
            awvalid_r <= data_write;
        end
    end

    
    // axi-w: write data channels       
    assign wid     = 4'b1;
    assign wdata   = wdata_r;
    assign wstrb   = wstrb_r;
    assign wlast   = 1'b1;
    assign wvalid  = wvalid_r;

    always @(posedge clk) begin
        if(wvalid && !wready) begin
            ;
        end
        else begin
            wdata_r <= {32{data_write}} & data_wdata;
        end
    end

    always @(posedge clk) begin
        if(wvalid && !wready) begin
            ;
        end
        else begin
            wstrb_r <= (data_write && data_addr[1:0] == 2'b00 && data_size == 2'b00) ? 4'b0001:
                       (data_write && data_addr[1:0] == 2'b01 && data_size == 2'b00) ? 4'b0010:
                       (data_write && data_addr[1:0] == 2'b10 && data_size == 2'b00) ? 4'b0100:
                       (data_write && data_addr[1:0] == 2'b11 && data_size == 2'b00) ? 4'b1000:
                       (data_write && data_addr[1:0] == 2'b00 && data_size == 2'b01) ? 4'b0011:
                       (data_write && data_addr[1:0] == 2'b10 && data_size == 2'b01) ? 4'b1100:
                       (data_write && data_addr[1:0] == 2'b00 && data_size == 2'b10) ? 4'b1111:
                                                                                       4'b0000;
        end                                                                        
    end

    always @(posedge clk) begin
        if(!resetn) begin
            wvalid_r <= 1'b0;
        end
        else begin
            wvalid_r <= data_write;
        end
    end
 
 
    // axi-b: writing response channels              
    assign bready  = bready_r;

    always @(posedge clk) begin
        if(!resetn) begin
            bready_r <= 1'b0;
        end
        else begin
            bready_r <= 1'b1;  // In Lab10, master(interface) is always ready for wdata
        end
    end


endmodule