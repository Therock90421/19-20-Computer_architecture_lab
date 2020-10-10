module cache( 
    //global
    input         clk,
    input         resetn, 
    //CPU<->CACHE
    input         valid,
    input         op,//1 write 0 read
    input [ 7:0]  index, //addr[11:4]
    input [19:0]  tlb_tag, //pfn + addr[12]
    input [ 3:0]  offset, //addr[3:0]
    input [ 3:0]  wstrb,
    input [31:0]  wdata,
    output        addr_ok,
    output        data_ok,
    output[31:0]  rdata,
    //CACHE<->AXI-BRIDGE
    //read
    output        rd_req,
    output[ 2:0]  rd_type,//3'b000-BYTE  3'b001-HALFWORD 3'b010-WORD 3'b100-cache-row
    output[31:0]  rd_addr,
    input         rd_rdy,//read_req can be accepted
    input         ret_valid,
    input [ 1:0]  ret_last,
    input [31:0]  ret_data,
    //write
    output        wr_req,
    output[ 2:0]  wr_type,
    output[31:0]  wr_addr,
    output[ 3:0]  wr_wstrb,
    output[127:0] wr_data,       
    input         wr_rdy//write_req can be accepted, actually nonsense in inst_cache
    
);  
    //state machine
    reg [2:0] curstate;
    reg [2:0] nxtstate;
    parameter IDLE    = 3'd0;
    parameter LOOKUP  = 3'd1;
    parameter MISS  = 3'd2;
    parameter REPLACE = 3'd3;
    parameter REFILL   = 3'd4;
    
    always@(posedge clk) begin
        if(~resetn) begin
            curstate <= IDLE;
        end 
        else begin
            curstate <= nxtstate;
        end
    end
    //Request buffer
    reg           op_r;//1 write 0 read
    reg   [ 7:0]  index_r; //addr[11:4]
    reg   [19:0]  tlb_tag_r; //pfn + addr[12]
    reg   [ 3:0]  offset_r; //addr[3:0]
    reg   [ 3:0]  wstrb_r;
    reg   [31:0]  wdata_r;
    reg           busy;
    reg   [127:0] replace_data_r;
    always@(posedge clk)begin
        if(!resetn) begin
            op_r <= 0;
            index_r <= 0;
            tlb_tag_r <= 0;
            offset_r <= 0;
            wstrb_r <= 0;
            wdata_r <= 0;
            busy <= 0;
        end
        if(busy & data_ok) begin
            op_r <= 0;
            index_r <= 0;
            tlb_tag_r <= 0;
            offset_r <= 0;
            wstrb_r <= 0;
            wdata_r <= 0;
            busy <= 0;
        end
        if(curstate == IDLE & valid) begin
            op_r <= op;
            index_r <= index;
            tlb_tag_r <= tlb_tag;
            offset_r <= offset;
            wstrb_r <= wstrb;
            wdata_r <= wdata;
            busy <= 1;
        end
    end
    
    reg          replace_way;
    //assign       replace_way = 0;
   
    wire [127:0]  replace_data;  
    reg  [ 22:0]  pseudo_random_23;
    //LSFR
    always @ (posedge clk)
    begin
           if (!resetn) begin
               pseudo_random_23 <= {7'b1010101,16'h00FF};
               replace_way <= 0;
           end
           else
               pseudo_random_23 <= {pseudo_random_23[21:0],pseudo_random_23[22] ^ pseudo_random_23[17]};
               
           if(curstate == REFILL & ret_last)
               replace_way <= pseudo_random_23[0];
    end
    //assign       replace_way = pseudo_random_23[0];
    
    always@(posedge clk)begin
        if(!resetn) begin
            replace_data_r <= 0;
        end
        if(curstate == LOOKUP) begin
            replace_data_r <= replace_data;
        end
        else if(curstate == REFILL) begin
            replace_data_r <= 0;
        end
    end
    wire [19:0]    replace_addr;
    reg  [19:0]    replace_addr_r;
    always@(posedge clk)begin
        if(!resetn) begin
            replace_addr_r <= 0;
        end
        if(curstate == LOOKUP) begin
            replace_addr_r <= replace_addr;
        end
        else if(curstate == REFILL) begin
            replace_addr_r <= 0;
        end
    end
    
                  
    //tag_v_ram_0
    wire [2:0] tag_v_ram_0_we;
    wire [7:0] tag_v_ram_0_addr;
    wire [23:0]tag_v_ram_0_wdata;
    wire [23:0]tag_v_ram_0_rdata;
    
    tag_v_ram_0 my_tag_v_ram_0(
  .clka(clk),    // input wire clka
  .wea(tag_v_ram_0_we),      // input wire [2 : 0] wea
  .addra(tag_v_ram_0_addr),  // input wire [7 : 0] addra
  .dina(tag_v_ram_0_wdata),    // input wire [23 : 0] dina
  .douta(tag_v_ram_0_rdata)  // output wire [23 : 0] douta
);

    //tag_v_ram_1
    wire [2:0] tag_v_ram_1_we;
    wire [7:0] tag_v_ram_1_addr;
    wire [23:0]tag_v_ram_1_wdata;
    wire [23:0]tag_v_ram_1_rdata;
    
    tag_v_ram_1 my_tag_v_ram_1(
  .clka(clk),    // input wire clka
  .wea(tag_v_ram_1_we),      // input wire [2 : 0] wea
  .addra(tag_v_ram_1_addr),  // input wire [7 : 0] addra
  .dina(tag_v_ram_1_wdata),    // input wire [23 : 0] dina
  .douta(tag_v_ram_1_rdata)  // output wire [23 : 0] douta
);
    wire         way0_hit;
    wire         way1_hit;
    wire         cache_hit;
    
    assign tag_v_ram_0_addr = busy? index_r : valid? index :0;//bug !!!! assign tag_v_ram_0_addr = busy? index_r :0;
    assign tag_v_ram_1_addr = busy? index_r : valid? index :0;
    assign tag_v_ram_0_wdata = {tlb_tag_r,4'b0001};
    assign tag_v_ram_1_wdata = {tlb_tag_r,4'b0001};
    assign tag_v_ram_0_we = (curstate == REFILL & replace_way == 0)? 3'b111:0;
    assign tag_v_ram_1_we = (curstate == REFILL & replace_way == 1)? 3'b111:0;
    
 
    wire         way0_v;
    wire         way1_v;
    wire [19:0]  way0_tag;
    wire [19:0]  way1_tag;
    assign way0_tag = tag_v_ram_0_rdata[23:4];
    assign way1_tag = tag_v_ram_1_rdata[23:4];
    assign way0_v   = tag_v_ram_0_rdata[0];
    assign way1_v   = tag_v_ram_1_rdata[0];
    /////////////////bug!
    /*
    assign way0_hit = way0_v && (way0_tag == tlb_tag);
    assign way1_hit = way1_v && (way1_tag == tlb_tag);*/
    //assign way0_hit = way0_v && ((way0_tag == tlb_tag & curstate == IDLE) | (way0_tag == tlb_tag_r & curstate != IDLE));
    //assign way1_hit = way1_v && ((way1_tag == tlb_tag & curstate == IDLE) | (way1_tag == tlb_tag_r & curstate != IDLE));
    assign way0_hit = way0_v && (way0_tag == tlb_tag_r & curstate != IDLE);
    assign way1_hit = way1_v && (way1_tag == tlb_tag_r & curstate != IDLE);
    
    assign cache_hit = way0_hit || way1_hit;
    assign replace_addr = replace_way? way1_tag : way0_tag;
    
    //dirty_ram_0
    wire [7:0]   dirty_ram_0_raddr;
    wire         dirty_ram_0_rd;
    wire         dirty_ram_0_we;
    wire [7:0]   dirty_ram_0_waddr;
    wire         dirty_ram_0_wd;
    
    dirty_ram dirty_ram_0(
    .clk(clk),
    .resetn(resetn),
    // READ PORT 
    .raddr(dirty_ram_0_raddr),
    .rdata(dirty_ram_0_rd),
    // WRITE PORT
    .we(dirty_ram_0_we),       //write enable, HIGH valid
    .waddr(dirty_ram_0_waddr),
    .wdata(dirty_ram_0_wd)
);
    //dirty_ram_1
    wire [7:0]   dirty_ram_1_raddr;
    wire         dirty_ram_1_rd;
    wire         dirty_ram_1_we;
    wire [7:0]   dirty_ram_1_waddr;
    wire         dirty_ram_1_wd;
    
    dirty_ram dirty_ram_1(
    .clk(clk),
    .resetn(resetn),
    // READ PORT 
    .raddr(dirty_ram_1_raddr),
    .rdata(dirty_ram_1_rd),
    // WRITE PORT
    .we(dirty_ram_1_we),       //write enable, HIGH valid
    .waddr(dirty_ram_1_waddr),
    .wdata(dirty_ram_1_wd)
);
    assign dirty_ram_0_raddr = busy?index_r: valid? index: 0;
    assign dirty_ram_1_raddr = busy?index_r: valid? index: 0;
    assign dirty_ram_0_waddr = busy?index_r: valid? index: 0;
    assign dirty_ram_1_waddr = busy?index_r: valid? index: 0;
    assign dirty_ram_0_wd = (op_r == 1);
    assign dirty_ram_1_wd = (op_r == 1);
    assign dirty_ram_0_we = (curstate == LOOKUP & way0_hit & op_r == 1) | (curstate == REFILL & replace_way == 0 & op_r == 1);
    assign dirty_ram_1_we = (curstate == LOOKUP & way1_hit & op_r == 1) | (curstate == REFILL & replace_way == 1 & op_r == 1);
                             
    
    //data_ram_bank_0//////////////////////////////////////////////////
    wire [3:0] data_ram_bank0_0_we;
    wire [7:0] data_ram_bank0_0_addr;
    wire [31:0]data_ram_bank0_0_wdata;
    wire [31:0]data_ram_bank0_0_rdata;
    data_ram_bank0_0 my_data_ram_bank0_0(
  .clka(clk),    // input wire clka
  .wea(data_ram_bank0_0_we),      // input wire [3 : 0] wea
  .addra(data_ram_bank0_0_addr),  // input wire [7 : 0] addra
  .dina(data_ram_bank0_0_wdata),    // input wire [31 : 0] dina
  .douta(data_ram_bank0_0_rdata)  // output wire [31 : 0] douta
);
    wire [3:0] data_ram_bank1_0_we;
    wire [7:0] data_ram_bank1_0_addr;
    wire [31:0]data_ram_bank1_0_wdata;
    wire [31:0]data_ram_bank1_0_rdata;
    data_ram_bank1_0 my_data_ram_bank1_0(
  .clka(clk),    // input wire clka
  .wea(data_ram_bank1_0_we),      // input wire [3 : 0] wea
  .addra(data_ram_bank1_0_addr),  // input wire [7 : 0] addra
  .dina(data_ram_bank1_0_wdata),    // input wire [31 : 0] dina
  .douta(data_ram_bank1_0_rdata)  // output wire [31 : 0] douta
);
    wire [3:0] data_ram_bank2_0_we;
    wire [7:0] data_ram_bank2_0_addr;
    wire [31:0]data_ram_bank2_0_wdata;
    wire [31:0]data_ram_bank2_0_rdata;
    data_ram_bank2_0 my_data_ram_bank2_0(
  .clka(clk),    // input wire clka
  .wea(data_ram_bank2_0_we),      // input wire [3 : 0] wea
  .addra(data_ram_bank2_0_addr),  // input wire [7 : 0] addra
  .dina(data_ram_bank2_0_wdata),    // input wire [31 : 0] dina
  .douta(data_ram_bank2_0_rdata)  // output wire [31 : 0] douta
);
    wire [3:0] data_ram_bank3_0_we;
    wire [7:0] data_ram_bank3_0_addr;
    wire [31:0]data_ram_bank3_0_wdata;
    wire [31:0]data_ram_bank3_0_rdata;
    data_ram_bank3_0 my_data_ram_bank3_0(
  .clka(clk),    // input wire clka
  .wea(data_ram_bank3_0_we),      // input wire [3 : 0] wea
  .addra(data_ram_bank3_0_addr),  // input wire [7 : 0] addra
  .dina(data_ram_bank3_0_wdata),    // input wire [31 : 0] dina
  .douta(data_ram_bank3_0_rdata)  // output wire [31 : 0] douta
);
    //data_ram_bank_0//////////////////////////////////////////
    wire [3:0] data_ram_bank0_1_we;
    wire [7:0] data_ram_bank0_1_addr;
    wire [31:0]data_ram_bank0_1_wdata;
    wire [31:0]data_ram_bank0_1_rdata;
    data_ram_bank0_1 my_data_ram_bank0_1(
  .clka(clk),    // input wire clka
  .wea(data_ram_bank0_1_we),      // input wire [3 : 0] wea
  .addra(data_ram_bank0_1_addr),  // input wire [7 : 0] addra
  .dina(data_ram_bank0_1_wdata),    // input wire [31 : 0] dina
  .douta(data_ram_bank0_1_rdata)  // output wire [31 : 0] douta
);
    wire [3:0] data_ram_bank1_1_we;
    wire [7:0] data_ram_bank1_1_addr;
    wire [31:0]data_ram_bank1_1_wdata;
    wire [31:0]data_ram_bank1_1_rdata;
    data_ram_bank1_1 my_data_ram_bank1_1(
  .clka(clk),    // input wire clka
  .wea(data_ram_bank1_1_we),      // input wire [3 : 0] wea
  .addra(data_ram_bank1_1_addr),  // input wire [7 : 0] addra
  .dina(data_ram_bank1_1_wdata),    // input wire [31 : 0] dina
  .douta(data_ram_bank1_1_rdata)  // output wire [31 : 0] douta
);
    wire [3:0] data_ram_bank2_1_we;
    wire [7:0] data_ram_bank2_1_addr;
    wire [31:0]data_ram_bank2_1_wdata;
    wire [31:0]data_ram_bank2_1_rdata;
    data_ram_bank2_1 my_data_ram_bank2_1(
  .clka(clk),    // input wire clka
  .wea(data_ram_bank2_1_we),      // input wire [3 : 0] wea
  .addra(data_ram_bank2_1_addr),  // input wire [7 : 0] addra
  .dina(data_ram_bank2_1_wdata),    // input wire [31 : 0] dina
  .douta(data_ram_bank2_1_rdata)  // output wire [31 : 0] douta
);
    wire [3:0] data_ram_bank3_1_we;
    wire [7:0] data_ram_bank3_1_addr;
    wire [31:0]data_ram_bank3_1_wdata;
    wire [31:0]data_ram_bank3_1_rdata;
    data_ram_bank3_1 my_data_ram_bank3_1(
  .clka(clk),    // input wire clka
  .wea(data_ram_bank3_1_we),      // input wire [3 : 0] wea
  .addra(data_ram_bank3_1_addr),  // input wire [7 : 0] addra
  .dina(data_ram_bank3_1_wdata),    // input wire [31 : 0] dina
  .douta(data_ram_bank3_1_rdata)  // output wire [31 : 0] douta
);
    //wire [127:0]  way0_data;
    //wire [127:0]  way1_data;
    wire [31:0]   way0_load_word;
    wire [31:0]   way1_load_word;
    wire [31:0]   load_res;
   
    assign way0_load_word = (offset_r[3:2] == 2'd0)?data_ram_bank0_0_rdata:
                             (offset_r[3:2] == 2'd1)?data_ram_bank1_0_rdata:
                             (offset_r[3:2] == 2'd2)?data_ram_bank2_0_rdata:
                             data_ram_bank3_0_rdata;
    assign way1_load_word = (offset_r[3:2] == 2'd0)?data_ram_bank0_1_rdata:
                             (offset_r[3:2] == 2'd1)?data_ram_bank1_1_rdata:
                             (offset_r[3:2] == 2'd2)?data_ram_bank2_1_rdata:
                             data_ram_bank3_1_rdata;
    assign load_res = {32{way0_hit}} & way0_load_word
                     | {32{way1_hit}} & way1_load_word;
    assign replace_data = replace_way? {data_ram_bank3_1_rdata,data_ram_bank2_1_rdata,data_ram_bank1_1_rdata,data_ram_bank0_1_rdata}:
                                        {data_ram_bank3_0_rdata,data_ram_bank2_0_rdata,data_ram_bank1_0_rdata,data_ram_bank0_0_rdata};
    
    
     assign addr_ok = curstate == LOOKUP;//this may be different from pdf
     
    //assign data_ok = curstate == IDLE;//this may be different from pdf  bug!�ᵼ�·���ʱ�����һ��
   // assign data_ok = (curstate == REFILL & nxtstate == IDLE) | (curstate == LOOKUP & nxtstate == IDLE);//this may be different from pdf
    reg start;
    always@(posedge clk) begin
        if(!resetn)
            start <= 0;
        else if(valid)
            start <= 1;
        else if(data_ok)
            start <= 0;
    end
    assign data_ok = curstate == IDLE & start;
    
    assign rd_req = curstate == REPLACE;
    assign rd_type = 3'b100;  //REPLACE CACHE-ROW ONLY 
    assign rd_addr = {tlb_tag_r,index_r,4'b00};
    
    reg [1:0] rd_cnt;
    always @(posedge clk) begin
        if(!resetn) begin
            rd_cnt <= 2'b00;
        end
        else if(ret_valid) begin
            rd_cnt <= rd_cnt + 2'b01;
        end
    end
    reg write_req;
    always@(posedge clk) begin
        if(!resetn)
            write_req <= 0;
        else if(curstate == LOOKUP & nxtstate == MISS & ((dirty_ram_1_rd == 1)&replace_way | (dirty_ram_0_rd == 1)&~replace_way))
            write_req <= 1;
        else if(wr_rdy)
            write_req <= 0;
    end
    assign wr_req = write_req;
    assign wr_type = 3'b100;//REPLACE CACHE-ROW ONLY
    //assign wr_addr = {tlb_tag_r,index_r,4'b00};   bug! �����Ľ����replace����cache�б����͵���Ҫ���ʵ��ڴ��ַ��
    assign wr_addr = {replace_addr_r,index_r,4'b00};
    assign wr_wstrb = 4'b1111;//nonsense
    assign wr_data = replace_data_r;
    reg [31:0] rdata_r;
    always@(posedge clk) begin
        if(!resetn) begin
            rdata_r <= 0;
        end
        /////////////////
        else if(curstate == LOOKUP & cache_hit)
            rdata_r <= load_res;
        ///////////////////////
        else if(offset_r[3:2] == 2'b00 & rd_cnt == 2'b00 & ret_valid)
            rdata_r <= ret_data;
        else if(offset_r[3:2] == 2'b01 & rd_cnt == 2'b01 & ret_valid)
            rdata_r <= ret_data;
        else if(offset_r[3:2] == 2'b10 & rd_cnt == 2'b10 & ret_valid)
            rdata_r <= ret_data;
        else if(offset_r[3:2] == 2'b11 & rd_cnt == 2'b11 & ret_valid)
            rdata_r <= ret_data;
    end
    reg [31:0] readdata;
    always@(posedge clk) begin
        if(!resetn) begin
            readdata <= 0;
        end
        else if(curstate == LOOKUP & cache_hit)
            readdata <= load_res;
    end
    assign rdata = rdata_r;
    /*
    assign rdata = (cache_hit)?load_res:
                    //(offset[3:2] == 2'b11 & ret_last)? ret_data
                    rdata_r;*/
 
    
    /*
    assign data_ram_bank0_0_we =(op_r == 0 & curstate == REFILL & rd_cnt == 2'b00 & ret_valid & replace_way == 0)?4'b1111://read,cache miss and be refilled
                                 (op_r == 1 & cache_hit & offset_r[3:2] == 2'b00)?wstrb://write,cache hit
                                 (op_r == 1 & ~cache_hit & curstate == LOOKUP)? (offset_r[3:2] == 2'b00)?wstrb://write,cache miss,write position is 2'b00
                                                                                                         4'b1111://write,cache miss,write position is not 2'b00
                                 (op_r == 1 & curstate == REFILL & rd_cnt == 2'b00 & ret_valid)?~wstrb://write,cache miss and be refilled
                                  0;*/
    assign data_ram_bank0_0_we =  (curstate == LOOKUP & cache_hit & way0_hit &offset_r[3:2] == 2'b00 & op_r == 1)?wstrb_r://hit store
                                   (curstate == REFILL & rd_cnt == 2'b00 & ret_valid & replace_way == 0)?4'b1111://refill
                                   0;
    assign data_ram_bank0_0_addr = (curstate == IDLE)?index:index_r;
    assign data_ram_bank0_0_wdata = (curstate == LOOKUP & cache_hit & offset_r[3:2] == 2'b00)?wdata_r://hit store
                                     (curstate == REFILL)? (offset_r[3:2] == 2'b00)? (wstrb_r == 4'b1111)?wdata_r:
                                                                                     (wstrb_r == 4'b1110)?{wdata_r[31:8],ret_data[7:0]}:
                                                                                     (wstrb_r == 4'b1100)?{wdata_r[31:16],ret_data[15:0]}:
                                                                                     (wstrb_r == 4'b1000)?{wdata_r[31:24],ret_data[23:0]}:
                                                                                     (wstrb_r == 4'b0000)?ret_data:
                                                                                     (wstrb_r == 4'b0001)?{ret_data[31:24],wdata_r[7:0]}:
                                                                                     (wstrb_r == 4'b0011)?{ret_data[31:16],wdata_r[15:0]}:
                                                                                     (wstrb_r == 4'b0111)?{ret_data[31:24],wdata_r[23:0]}:
                                                                                     wdata_r:
                                                           ret_data:
                                     0;
    assign data_ram_bank1_0_we =  (curstate == LOOKUP & cache_hit & way0_hit &offset_r[3:2] == 2'b01 & op_r == 1)?wstrb_r://hit store
                                   (curstate == REFILL & rd_cnt == 2'b01 & ret_valid & replace_way == 0)?4'b1111://refill
                                   0;
    assign data_ram_bank1_0_addr = (curstate == IDLE)?index:index_r;
    assign data_ram_bank1_0_wdata = (curstate == LOOKUP & cache_hit & offset_r[3:2] == 2'b01)?wdata_r://hit store
                                     (curstate == REFILL)? (offset_r[3:2] == 2'b01)? (wstrb_r == 4'b1111)?wdata_r:
                                                                                     (wstrb_r == 4'b1110)?{wdata_r[31:8],ret_data[7:0]}:
                                                                                     (wstrb_r == 4'b1100)?{wdata_r[31:16],ret_data[15:0]}:
                                                                                     (wstrb_r == 4'b1000)?{wdata_r[31:24],ret_data[23:0]}:
                                                                                     (wstrb_r == 4'b0000)?ret_data:
                                                                                     (wstrb_r == 4'b0001)?{ret_data[31:24],wdata_r[7:0]}:
                                                                                     (wstrb_r == 4'b0011)?{ret_data[31:16],wdata_r[15:0]}:
                                                                                     (wstrb_r == 4'b0111)?{ret_data[31:24],wdata_r[23:0]}:
                                                                                     wdata_r:
                                                           ret_data:
                                     0;
    assign data_ram_bank2_0_we =  (curstate == LOOKUP & cache_hit & way0_hit &offset_r[3:2] == 2'b10 & op_r == 1)?wstrb_r://hit store
                                   (curstate == REFILL & rd_cnt == 2'b10 & ret_valid & replace_way == 0)?4'b1111://refill
                                   0;
    assign data_ram_bank2_0_addr = (curstate == IDLE)?index:index_r;
    assign data_ram_bank2_0_wdata = (curstate == LOOKUP & cache_hit & offset_r[3:2] == 2'b10)?wdata_r://hit store
                                     (curstate == REFILL)? (offset_r[3:2] == 2'b10)? (wstrb_r == 4'b1111)?wdata_r:
                                                                                     (wstrb_r == 4'b1110)?{wdata_r[31:8],ret_data[7:0]}:
                                                                                     (wstrb_r == 4'b1100)?{wdata_r[31:16],ret_data[15:0]}:
                                                                                     (wstrb_r == 4'b1000)?{wdata_r[31:24],ret_data[23:0]}:
                                                                                     (wstrb_r == 4'b0000)?ret_data:
                                                                                     (wstrb_r == 4'b0001)?{ret_data[31:24],wdata_r[7:0]}:
                                                                                     (wstrb_r == 4'b0011)?{ret_data[31:16],wdata_r[15:0]}:
                                                                                     (wstrb_r == 4'b0111)?{ret_data[31:24],wdata_r[23:0]}:
                                                                                     wdata_r:
                                                           ret_data:
                                     0;
    assign data_ram_bank3_0_we =  (curstate == LOOKUP & cache_hit & way0_hit &offset_r[3:2] == 2'b11 & op_r == 1)?wstrb_r://hit store
                                   (curstate == REFILL & rd_cnt == 2'b11 & ret_valid & replace_way == 0)?4'b1111://refill
                                   0;
    assign data_ram_bank3_0_addr = (curstate == IDLE)?index:index_r;
    assign data_ram_bank3_0_wdata = (curstate == LOOKUP & cache_hit & offset_r[3:2] == 2'b11)?wdata_r://hit store
                                     (curstate == REFILL)? (offset_r[3:2] == 2'b11)? (wstrb_r == 4'b1111)?wdata_r:
                                                                                     (wstrb_r == 4'b1110)?{wdata_r[31:8],ret_data[7:0]}:
                                                                                     (wstrb_r == 4'b1100)?{wdata_r[31:16],ret_data[15:0]}:
                                                                                     (wstrb_r == 4'b1000)?{wdata_r[31:24],ret_data[23:0]}:
                                                                                     (wstrb_r == 4'b0000)?ret_data:
                                                                                     (wstrb_r == 4'b0001)?{ret_data[31:24],wdata_r[7:0]}:
                                                                                     (wstrb_r == 4'b0011)?{ret_data[31:16],wdata_r[15:0]}:
                                                                                     (wstrb_r == 4'b0111)?{ret_data[31:24],wdata_r[23:0]}:
                                                                                     wdata_r:
                                                           ret_data:
                                     0;
    assign data_ram_bank0_1_we =  (curstate == LOOKUP & cache_hit & way1_hit &offset_r[3:2] == 2'b00 & op_r == 1)?wstrb_r://hit store
                                   (curstate == REFILL & rd_cnt == 2'b00 & ret_valid & replace_way == 1)?4'b1111://refill
                                   0;
    assign data_ram_bank0_1_addr = (curstate == IDLE)?index:index_r;
    assign data_ram_bank0_1_wdata = (curstate == LOOKUP & cache_hit & offset_r[3:2] == 2'b00)?wdata_r://hit store
                                     (curstate == REFILL)? (offset_r[3:2] == 2'b00)? (wstrb_r == 4'b1111)?wdata_r:
                                                                                     (wstrb_r == 4'b1110)?{wdata_r[31:8],ret_data[7:0]}:
                                                                                     (wstrb_r == 4'b1100)?{wdata_r[31:16],ret_data[15:0]}:
                                                                                     (wstrb_r == 4'b1000)?{wdata_r[31:24],ret_data[23:0]}:
                                                                                     (wstrb_r == 4'b0000)?ret_data:
                                                                                     (wstrb_r == 4'b0001)?{ret_data[31:24],wdata_r[7:0]}:
                                                                                     (wstrb_r == 4'b0011)?{ret_data[31:16],wdata_r[15:0]}:
                                                                                     (wstrb_r == 4'b0111)?{ret_data[31:24],wdata_r[23:0]}:
                                                                                     wdata_r:
                                                           ret_data:
                                     0;
    assign data_ram_bank1_1_we =  (curstate == LOOKUP & cache_hit & way1_hit &offset_r[3:2] == 2'b01 & op_r == 1)?wstrb_r://hit store
                                   (curstate == REFILL & rd_cnt == 2'b01 & ret_valid & replace_way == 1)?4'b1111://refill
                                   0;
    assign data_ram_bank1_1_addr = (curstate == IDLE)?index:index_r;
    assign data_ram_bank1_1_wdata = (curstate == LOOKUP & cache_hit & offset_r[3:2] == 2'b01)?wdata_r://hit store
                                     (curstate == REFILL)? (offset_r[3:2] == 2'b01)? (wstrb_r == 4'b1111)?wdata_r:
                                                                                     (wstrb_r == 4'b1110)?{wdata_r[31:8],ret_data[7:0]}:
                                                                                     (wstrb_r == 4'b1100)?{wdata_r[31:16],ret_data[15:0]}:
                                                                                     (wstrb_r == 4'b1000)?{wdata_r[31:24],ret_data[23:0]}:
                                                                                     (wstrb_r == 4'b0000)?ret_data:
                                                                                     (wstrb_r == 4'b0001)?{ret_data[31:24],wdata_r[7:0]}:
                                                                                     (wstrb_r == 4'b0011)?{ret_data[31:16],wdata_r[15:0]}:
                                                                                     (wstrb_r == 4'b0111)?{ret_data[31:24],wdata_r[23:0]}:
                                                                                     wdata_r:
                                                           ret_data:
                                     0;
    assign data_ram_bank2_1_we =  (curstate == LOOKUP & cache_hit & way1_hit &offset_r[3:2] == 2'b10 & op_r == 1)?wstrb_r://hit store
                                   (curstate == REFILL & rd_cnt == 2'b10 & ret_valid & replace_way == 1)?4'b1111://refill
                                   0;
    assign data_ram_bank2_1_addr = (curstate == IDLE)?index:index_r;
    assign data_ram_bank2_1_wdata = (curstate == LOOKUP & cache_hit & offset_r[3:2] == 2'b10)?wdata_r://hit store
                                     (curstate == REFILL)? (offset_r[3:2] == 2'b10)? (wstrb_r == 4'b1111)?wdata_r:
                                                                                     (wstrb_r == 4'b1110)?{wdata_r[31:8],ret_data[7:0]}:
                                                                                     (wstrb_r == 4'b1100)?{wdata_r[31:16],ret_data[15:0]}:
                                                                                     (wstrb_r == 4'b1000)?{wdata_r[31:24],ret_data[23:0]}:
                                                                                     (wstrb_r == 4'b0000)?ret_data:
                                                                                     (wstrb_r == 4'b0001)?{ret_data[31:24],wdata_r[7:0]}:
                                                                                     (wstrb_r == 4'b0011)?{ret_data[31:16],wdata_r[15:0]}:
                                                                                     (wstrb_r == 4'b0111)?{ret_data[31:24],wdata_r[23:0]}:
                                                                                     wdata_r:
                                                           ret_data:
                                     0;
    assign data_ram_bank3_1_we =  (curstate == LOOKUP & cache_hit & way1_hit &offset_r[3:2] == 2'b11 & op_r == 1)?wstrb_r://hit store
                                   (curstate == REFILL & rd_cnt == 2'b11 & ret_valid & replace_way == 1)?4'b1111://refill
                                   0;
    assign data_ram_bank3_1_addr = (curstate == IDLE)?index:index_r;
    assign data_ram_bank3_1_wdata = (curstate == LOOKUP & cache_hit & offset_r[3:2] == 2'b11)?wdata_r://hit store
                                     (curstate == REFILL)? (offset_r[3:2] == 2'b11)? (wstrb_r == 4'b1111)?wdata_r:
                                                                                     (wstrb_r == 4'b1110)?{wdata_r[31:8],ret_data[7:0]}:
                                                                                     (wstrb_r == 4'b1100)?{wdata_r[31:16],ret_data[15:0]}:
                                                                                     (wstrb_r == 4'b1000)?{wdata_r[31:24],ret_data[23:0]}:
                                                                                     (wstrb_r == 4'b0000)?ret_data:
                                                                                     (wstrb_r == 4'b0001)?{ret_data[31:24],wdata_r[7:0]}:
                                                                                     (wstrb_r == 4'b0011)?{ret_data[31:16],wdata_r[15:0]}:
                                                                                     (wstrb_r == 4'b0111)?{ret_data[31:24],wdata_r[23:0]}:
                                                                                     wdata_r:
                                                           ret_data:
                                     0;
    
    //STATE TRANSFORMATION
    always@(*)
begin
    case(curstate)
        IDLE:
        begin
            if(valid)
                nxtstate = LOOKUP;        
            else
                nxtstate = curstate;
        end 
        LOOKUP:
        begin
            if(cache_hit)
                nxtstate = IDLE;
            else
                nxtstate = MISS;
        end
        MISS:
        begin
            if(wr_rdy)
                nxtstate = REPLACE;
            else
                nxtstate = curstate;
        end
        REPLACE:
        begin
            if(rd_rdy)
                nxtstate = REFILL;
            else
                nxtstate = curstate;
        end
        REFILL:
        begin
           if(ret_last)
                nxtstate = IDLE;        
            else
                nxtstate = REFILL;
        end
        default:
            nxtstate = IDLE;
    endcase
end 
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module dirty_ram(
    input         clk,
    input         resetn,
    // READ PORT 
    input  [ 7:0] raddr,
    output        rdata,
    // WRITE PORT
    input         we,       //write enable, HIGH valid
    input  [ 7:0] waddr,
    input         wdata
);
reg [255:0] rf;
                 

//WRITE
always @(posedge clk) begin
    if(!resetn)
        rf <= 0;
    else if (we) rf[waddr]<= wdata;
end
//READ OUT 1
assign rdata = rf[raddr];
endmodule