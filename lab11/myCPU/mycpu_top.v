module mycpu_top(
    input  [5:0]  int,
    input         aclk,
    input         aresetn,
    //AXI interface
    //ar
    output [ 3:0] arid,
    output [31:0] araddr,
    output [ 7:0] arlen,
    output [ 2:0] arsize,
    output [ 1:0] arburst,
    output [ 1:0] arlock,
    output [ 3:0] arcache,
    output [ 2:0] arprot,
    output        arvalid,
    input         arready,
    //r
    input  [ 3:0] rid,
    input  [31:0] rdata,
    input  [ 1:0] rresp,
    input         rlast,
    input         rvalid,
    output        rready,
    //aw
    output [ 3:0] awid,
    output [31:0] awaddr,
    output [ 7:0] awlen,
    output [ 2:0] awsize,
    output [ 1:0] awburst,
    output [ 1:0] awlock,
    output [ 3:0] awcache,
    output [ 2:0] awprot,
    output        awvalid,
    input         awready,
    //w
    output [ 3:0] wid,
    output [31:0] wdata,
    output [ 3:0] wstrb,
    output        wlast,
    output        wvalid,
    input         wready,
    //b
    input  [ 3:0] bid,
    input  [ 1:0] bresp,
    input         bvalid,
    output        bready,

    // trace debug interface
    output [31:0] debug_wb_pc,
    output [ 3:0] debug_wb_rf_wen,
    output [ 4:0] debug_wb_rf_wnum,
    output [31:0] debug_wb_rf_wdata
);
wire clk;
assign clk=aclk;
wire resetn;
assign resetn=aresetn;
reg         reset;
always @(posedge clk) reset <= ~aresetn;

// inst sram interface
wire        inst_sram_en;
wire [ 3:0] inst_sram_wen;
wire [31:0] inst_sram_addr;
wire [31:0] inst_sram_wdata;
wire [31:0] inst_sram_rdata;
// data sram interface
wire        data_sram_en;
wire [ 3:0] data_sram_wen;
wire [31:0] data_sram_addr;
wire [31:0] data_sram_wdata;
wire [31:0] data_sram_rdata;

wire inst_req;
wire inst_wr;
assign inst_wr=1'b0;
wire [1:0] inst_size;
assign inst_size=2'b10;
wire inst_addr_ok;
wire inst_data_ok;

wire data_req;
wire data_wr;
wire [2:0] data_size;
wire data_addr_ok;
wire data_data_ok;


cpu_axi_interface cpu_axi_interface(
    .clk          (clk        ),
    .resetn       (resetn     ),
        
    .inst_req     (inst_req   ),
    .inst_wr      (inst_wr     ),
    .inst_size    (inst_size   ),
    .inst_addr    (inst_sram_addr   ),
    .inst_wdata   (inst_sram_wdata  ),
    .inst_rdata   (inst_sram_rdata  ),
    .inst_addr_ok (inst_addr_ok),
    .inst_data_ok (inst_data_ok),

    .data_req     (data_req    ),
    .data_wr      (data_wr     ),
    .data_size    (data_size   ),
    .data_addr    (data_sram_addr   ),
    .data_wdata   (data_sram_wdata  ),
    .data_rdata   (data_sram_rdata  ),
    .data_addr_ok (data_addr_ok),
    .data_data_ok (data_data_ok),

    .arid         (arid        ),
    .araddr       (araddr      ),
    .arlen        (arlen       ),
    .arsize       (arsize      ),
    .arburst      (arburst     ),
    .arlock       (arlock      ),
    .arcache      (arcache     ),
    .arprot       (arprot      ),
    .arvalid      (arvalid     ),
    .arready      (arready     ),
        
    .rid          (rid         ),
    .rdata        (rdata       ),
    .rresp        (rresp       ),
    .rlast        (rlast       ),
    .rvalid       (rvalid      ),
    .rready       (rready      ),
        
    .awid         (awid        ),
    .awaddr       (awaddr      ),
    .awlen        (awlen       ),
    .awsize       (awsize      ),
    .awburst      (awburst     ),
    .awlock       (awlock      ),
    .awcache      (awcache     ),
    .awprot       (awprot      ),
    .awvalid      (awvalid     ),
    .awready      (awready     ),
        
    .wid          (wid         ),
    .wdata        (wdata       ),
    .wstrb        (wstrb       ),
    .wlast        (wlast       ),
    .wvalid       (wvalid      ),
    .wready       (wready      ),
        
    .bid          (bid         ),
    .bresp        (bresp       ),
    .bvalid       (bvalid      ),
    .bready       (bready      )
    );

wire         ds_allowin;
wire         es_allowin;
wire         ms_allowin;
wire         ws_allowin;
wire         fs_to_ds_valid;
wire         ds_to_es_valid;
wire         es_to_ms_valid;
wire         ms_to_ws_valid;
wire [`FS_TO_DS_BUS_WD -1:0] fs_to_ds_bus;
wire [`DS_TO_ES_BUS_WD -1:0] ds_to_es_bus;
wire [`ES_TO_MS_BUS_WD -1:0] es_to_ms_bus;
wire [`MS_TO_WS_BUS_WD -1:0] ms_to_ws_bus;
wire [`WS_TO_RF_BUS_WD -1:0] ws_to_rf_bus;
wire [`BR_BUS_WD       -1:0] br_bus;
wire [                   33:0 ] ws_to_fs_bus;
wire [                    1:0 ] ws_to_ds_bus;
wire                            ws_to_es_bus;
wire                            ws_to_ms_bus;
wire                            ms_to_es_bus;
wire [3:0]                    div_or_mul;
/*wire [5   :0]                es_dest_withvalid;
    //es_dest_withvalid  第5位表示有没有必要阻断，后五位表示寄存器号
wire [5   :0]                ms_dest_withvalid;
    
wire [5   :0]                ws_dest_withvalid;*/
wire [38   :0]                es_dest_withvalid;
    //es_dest_withvalid  第5位表示有没有必要阻断，后五位表示寄存器号
wire [38   :0]                ms_dest_withvalid;
    
wire [37   :0]                ws_dest_withvalid;
// IF stage
if_stage if_stage(
    .clk            (clk            ),
    .reset          (reset          ),
    //allowin
    .ds_allowin     (ds_allowin     ),
    //brbus
    .br_bus         (br_bus         ),
    //outputs
    .fs_to_ds_valid (fs_to_ds_valid ),
    .fs_to_ds_bus   (fs_to_ds_bus   ),
    // inst sram interface
    .inst_req   (inst_req   ),
    .inst_sram_wen  (inst_sram_wen  ),
    .inst_sram_addr (inst_sram_addr ),
    .inst_sram_wdata(inst_sram_wdata),
    .inst_sram_rdata(inst_sram_rdata),
    .ws_to_fs_bus   (ws_to_fs_bus   ),

    .inst_addr_ok   (inst_addr_ok),
    .inst_data_ok   (inst_data_ok)
);
// ID stage
id_stage id_stage(
    .clk            (clk            ),
    .reset          (reset          ),
    //allowin
    .es_allowin     (es_allowin     ),
    .ds_allowin     (ds_allowin     ),
    //from fs
    .fs_to_ds_valid (fs_to_ds_valid ),
    .fs_to_ds_bus   (fs_to_ds_bus   ),
    //to es
    .ds_to_es_valid (ds_to_es_valid ),
    .ds_to_es_bus   (ds_to_es_bus   ),
    //to fs
    .br_bus         (br_bus         ),
    //to rf: for write back
    .ws_to_rf_bus   (ws_to_rf_bus   ),
    .es_dest_withvalid  (es_dest_withvalid),
    .ms_dest_withvalid  (ms_dest_withvalid),
    .ws_dest_withvalid  (ws_dest_withvalid),
    .ws_to_ds_bus   (ws_to_ds_bus   )
    
);
// EXE stage
exe_stage exe_stage(
    .clk            (clk            ),
    .reset          (reset          ),
    //allowin
    .ms_allowin     (ms_allowin     ),
    .es_allowin     (es_allowin     ),
    //from ds
    .ds_to_es_valid (ds_to_es_valid ),
    .ds_to_es_bus   (ds_to_es_bus   ),
    //to ms
    .es_to_ms_valid (es_to_ms_valid ),
    .es_to_ms_bus   (es_to_ms_bus   ),
    // data sram interface
    .data_sram_en   (data_sram_en   ),
    .data_sram_wen  (data_sram_wen  ),
    .data_sram_addr (data_sram_addr ),
    .data_sram_wdata(data_sram_wdata),
    
    .es_dest_withvalid  (es_dest_withvalid),
    .ws_to_es_bus   (ws_to_es_bus   ),
    .ms_to_es_bus   (ms_to_es_bus),

    .data_req(data_req),
    .data_wr(data_wr),
    .data_size(data_size),
    .data_addr_ok(data_addr_ok)
);

// MEM stage
mem_stage mem_stage(
    .clk            (clk            ),
    .reset          (reset          ),
    //allowin
    .ws_allowin     (ws_allowin     ),
    .ms_allowin     (ms_allowin     ),
    //from es
    .es_to_ms_valid (es_to_ms_valid ),
    .es_to_ms_bus   (es_to_ms_bus   ),
    //to ws
    .ms_to_ws_valid (ms_to_ws_valid ),
    .ms_to_ws_bus   (ms_to_ws_bus   ),
    //from data-sram
    .data_sram_rdata(data_sram_rdata),
    
    .ms_dest_withvalid  (ms_dest_withvalid),
    .ws_to_ms_bus   (ws_to_ms_bus   ),
    .ms_to_es_bus   (ms_to_es_bus),

    .data_data_ok(data_data_ok)
);
// WB stage
wb_stage wb_stage(
    .clk            (clk            ),
    .reset          (reset          ),
    //allowin
    .ws_allowin     (ws_allowin     ),
    //from ms
    .ms_to_ws_valid (ms_to_ws_valid ),
    .ms_to_ws_bus   (ms_to_ws_bus   ),
    //to rf: for write back
    .ws_to_rf_bus   (ws_to_rf_bus   ),
    .ws_to_fs_bus   (ws_to_fs_bus   ),
    .ws_to_ds_bus   (ws_to_ds_bus   ),
    .ws_to_es_bus   (ws_to_es_bus   ),
    .ws_to_ms_bus   (ws_to_ms_bus   ),
    //trace debug interface
    .debug_wb_pc      (debug_wb_pc      ),
    .debug_wb_rf_wen  (debug_wb_rf_wen  ),
    .debug_wb_rf_wnum (debug_wb_rf_wnum ),
    .debug_wb_rf_wdata(debug_wb_rf_wdata),
    .int                (int),
    .ws_dest_withvalid  (ws_dest_withvalid)
);

endmodule
