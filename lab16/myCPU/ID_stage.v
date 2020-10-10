`include "mycpu.h"

module id_stage(
    input                          clk           ,
    input                          reset         ,
    //allowin
    input                          es_allowin    ,
    output                         ds_allowin    ,
    //from fs
    input                          fs_to_ds_valid,
    input  [`FS_TO_DS_BUS_WD -1:0] fs_to_ds_bus  ,
    //to es
    output                         ds_to_es_valid,
    output [`DS_TO_ES_BUS_WD -1:0] ds_to_es_bus  ,
    //to fs
    output [`BR_BUS_WD       -1:0] br_bus        ,
    //to rf: for write back
    input  [`WS_TO_RF_BUS_WD -1:0] ws_to_rf_bus,

    
    
    input  [38   :0]                es_dest_withvalid,
        //es_dest_withvalid
    input  [38   :0]                ms_dest_withvalid,
        
    input  [37   :0]                ws_dest_withvalid,
    
    input  [1:0]                    ws_to_ds_bus
    
    
  
);

reg         ds_valid   ;
wire        ds_ready_go;

wire [31                 :0] fs_pc;
reg  [`FS_TO_DS_BUS_WD -1:0] fs_to_ds_bus_r;
assign fs_pc = fs_to_ds_bus[31:0];

wire [31:0] ds_inst;
wire [31:0] ds_pc  ;
wire ds_bd;
wire fs_ex;
wire [31:0] fs_badvaddr;
wire ds_refetch;
wire tlb_miss;
wire tlb_invalid;
///////////////////

reg WB_EX;
always@(posedge clk)begin
    if(reset)
        WB_EX<=1'b0;
    else if(ws_to_ds_bus[0])
        WB_EX<=1'b1;
    else if(fs_to_ds_valid && ds_allowin)
        WB_EX<=1'b0;
        end
        
/////////////////////////////      
assign {
        tlb_invalid,
        tlb_miss,//99
        ds_refetch,//98
        fs_ex,   //97
        fs_badvaddr,//96:65
        ds_bd,   //64
        ds_inst ,//63:32,
        ds_pc  } = (~WB_EX & !ws_to_ds_bus[0]) ? fs_to_ds_bus_r : 0;//(!ws_to_ds_bus[0]) ? fs_to_ds_bus_r : 0;  //!ȡ�������?

wire        rf_we   ;
wire [ 4:0] rf_waddr;
wire [31:0] rf_wdata;

assign {rf_we   ,  //37:37
        rf_waddr,  //36:32
        rf_wdata   //31:0
       } = ws_to_rf_bus;

wire        br_taken;
wire [31:0] br_target;

wire [11:0] alu_op;
wire        load_op;
wire        src1_is_sa;
wire        src1_is_pc;
wire        src2_is_imm;
wire        src2_is_8;
wire        res_from_mem;
wire        gr_we;
wire        mem_we;
wire [ 4:0] dest;
wire [15:0] imm;
wire [31:0] rs_value;
wire [31:0] rt_value;

wire [ 5:0] op;
wire [ 4:0] rs;
wire [ 4:0] rt;
wire [ 4:0] rd;
wire [ 4:0] sa;
wire [ 5:0] func;
wire [25:0] jidx;
wire [63:0] op_d;
wire [31:0] rs_d;
wire [31:0] rt_d;
wire [31:0] rd_d;
wire [31:0] sa_d;
wire [63:0] func_d;
/////////////////////
wire [19:0] code;  //syscall
///////////////////

wire        inst_addu;
wire        inst_subu;
wire        inst_slt;
wire        inst_sltu;
wire        inst_and;
wire        inst_or;
wire        inst_xor;
wire        inst_nor;
wire        inst_sll;
wire        inst_srl;
wire        inst_sra;
wire        inst_addiu;
wire        inst_lui;
wire        inst_lw;
wire        inst_sw;
wire        inst_beq;
wire        inst_bne;
wire        inst_jal;
wire        inst_jr;

wire        inst_add;
wire        inst_addi;
wire        inst_sub;
wire        inst_slti;
wire        inst_sltiu;
wire        inst_andi;
wire        inst_ori;
wire        inst_xori;
wire        inst_sllv;
wire        inst_srav;
wire        inst_srlv;
wire        inst_mult;
wire        inst_multu;
wire        inst_div;
wire        inst_divu;
wire        inst_mfhi;
wire        inst_mflo;
wire        inst_mthi;
wire        inst_mtlo;

wire        src2_is_zimm;

wire        inst_bgez;
wire        inst_bgtz;
wire        inst_blez;
wire        inst_bltz;
wire        inst_j;
wire        inst_bltzal;
wire        inst_bgezal;
wire        inst_jalr;
wire        inst_lb;
wire        inst_lbu;
wire        inst_lh;
wire        inst_lhu;
wire        inst_lwl;
wire        inst_lwr;
wire        inst_sb;
wire        inst_sh;
wire        inst_swl;
wire        inst_swr;
////////////////////////////////////////////////
wire        inst_mfc0;  
wire        inst_mtc0; 
wire        syscall;
wire        inst_eret;
wire        break;

wire        tlbp;
wire        tlbr;
wire        tlbwi;
////////////////////////////////////////////////
wire        no_inst;
assign     no_inst = ~inst_addu & ~inst_subu & ~inst_slt & ~inst_sltu & ~inst_and
                    & ~inst_or   & ~inst_xor  & ~inst_nor & ~inst_sll  & ~inst_srl
                    & ~inst_sra  & ~inst_addiu& ~inst_lui & ~inst_lw   & ~inst_sw 
                    & ~inst_beq  & ~inst_bne  & ~inst_jal & ~inst_jr   & ~inst_add
                    & ~inst_addi & ~inst_sub  & ~inst_slti& ~inst_sltiu& ~inst_andi
                    & ~inst_ori  & ~inst_xori & ~inst_sllv& ~inst_srav & ~inst_srlv
                    & ~inst_mult & ~inst_multu& ~inst_div & ~inst_divu & ~inst_mfhi
                    & ~inst_mflo & ~inst_mthi & ~inst_mtlo& ~inst_bgez & ~inst_bgtz
                    & ~inst_blez & ~inst_bltz & ~inst_j   & ~inst_bltzal& ~inst_bgezal
                    & ~inst_jalr & ~inst_lb   & ~inst_lbu & ~inst_lh   & ~inst_lhu
                    & ~inst_lwl  & ~inst_lwr  & ~inst_sb  & ~inst_sh   & ~inst_swl
                    & ~inst_swr  & ~inst_mfc0 & ~inst_mtc0& ~syscall   & ~inst_eret & ~break
                    & ~tlbp      & ~tlbr      & ~tlbwi;


wire        dst_is_r31;  
wire        dst_is_rt;   

wire [ 4:0] rf_raddr1;
wire [31:0] rf_rdata1;
wire [ 4:0] rf_raddr2;
wire [31:0] rf_rdata2;

wire        rs_eq_rt;
wire [3:0 ] div_or_mul;
wire fs_bd;
assign fs_bd        = (inst_beq|| inst_bne  || inst_jal
                   || inst_jr|| inst_bgez|| inst_bgtz
                   || inst_blez|| inst_bltz|| inst_j
                   || inst_bltzal|| inst_bgezal|| inst_jalr) & ds_valid;
wire fs_refetch;
assign fs_refetch = tlbwi | tlbr;

//////////////////////////////////////
wire        inst_overflow;//////�����������ָ��?
assign      inst_overflow = (inst_add || inst_addi || inst_sub) & ds_valid;


wire ds_ex;
assign ds_ex = (syscall || break || fs_ex || no_inst || ws_to_ds_bus[1])? 1'b1 : 1'b0;    //[1]Ϊ�жϱ��?


wire [4:0] ds_excode;
assign ds_excode = (ws_to_ds_bus[1])? 5'h00
                   :(fs_ex&&!(tlb_miss|tlb_invalid))  ? 5'h04    
                   :(fs_ex&&(tlb_miss|tlb_invalid))? 5'h02
                   :(no_inst)? 5'h0a
                   :(syscall)? 5'h08 
                   :(break)  ? 5'h09
                   :           5'h0;
wire          [1:0]  load_choice;
assign load_choice  = ds_inst[1:0];

assign ds_to_es_bus = {
                        tlb_invalid,      //212
                       tlb_miss,
                       //tlb_miss,             //211
                       ds_refetch,          //210
                       tlbp,                //209
                       tlbr,                //208
                       tlbwi,               //207
                       fs_badvaddr,         //206:175
                       inst_sw,             //174
                       inst_lw,             //173
                       inst_overflow,       //172
                       ds_ex,               //171
                       inst_eret,        //170
                       ds_bd,            //169
                       ds_excode,        //168:164
                       rt,            //163:159
                       inst_mfc0,     //158
                       inst_mtc0,     //157
                       inst_sb,       //156
                       inst_sh,       //155
                       inst_swl,      //154
                       inst_swr,      //153
                       inst_lwl,      //152
                       inst_lwr,      //151
                       load_choice,   //150:149
                       inst_lb,       //148
                       inst_lbu,      //147
                       inst_lh,       //146
                       inst_lhu,      //145
                       inst_mflo,     //144
                       inst_mfhi,     //143
                       inst_mthi,     //142
                       inst_mtlo,     //141
                       div_or_mul,    //140:137
                       src2_is_zimm,  //136
                       alu_op      ,  //135:124
                       load_op     ,  //123:123
                       src1_is_sa  ,  //122:122
                       src1_is_pc  ,  //121:121
                       src2_is_imm ,  //120:120
                       src2_is_8   ,  //119:119
                       gr_we       ,  //118:118
                       mem_we      ,  //117:117
                       dest        ,  //116:112
                       imm         ,  //111:96
                       rs_value    ,  //95 :64
                       rt_value    ,  //63 :32
                       ds_pc          //31 :0
                      };
//����4  ȱ�ٶ�load_op�ĸ�ֵ load_opΪ1ʱ��ʾ���ݴ��ڴ���ȡ��Ϊ0ʱ��ʾ��alu��������ȡ
assign load_op = res_from_mem;


////////////////////////////////////////////
 wire             do_not_block; 
////////////////////////////////////////////

//assign ds_ready_go    = 1'b1;
assign ds_ready_go = do_not_block;
assign ds_allowin     = !ds_valid || ds_ready_go && es_allowin;
assign ds_to_es_valid = ds_valid && ds_ready_go;
always @(posedge clk) begin                       //����5  ȱ��ds_valid�ĸ�ֵ
    if (reset) begin
        ds_valid <= 1'b0;
    end
    else if (ds_allowin) begin
        ds_valid <= fs_to_ds_valid;
    end
    if (fs_to_ds_valid && ds_allowin) begin
        fs_to_ds_bus_r <= fs_to_ds_bus;
    end
end

assign op   = ds_inst[31:26];
assign rs   = ds_inst[25:21];
assign rt   = ds_inst[20:16];
assign rd   = ds_inst[15:11];
assign sa   = ds_inst[10: 6];
assign func = ds_inst[ 5: 0];
assign imm  = ds_inst[15: 0];
assign jidx = ds_inst[25: 0];

decoder_6_64 u_dec0(.in(op  ), .out(op_d  ));
decoder_6_64 u_dec1(.in(func), .out(func_d));
decoder_5_32 u_dec2(.in(rs  ), .out(rs_d  ));
decoder_5_32 u_dec3(.in(rt  ), .out(rt_d  ));
decoder_5_32 u_dec4(.in(rd  ), .out(rd_d  ));
decoder_5_32 u_dec5(.in(sa  ), .out(sa_d  ));

assign inst_addu   = op_d[6'h00] & func_d[6'h21] & sa_d[5'h00];
assign inst_subu   = op_d[6'h00] & func_d[6'h23] & sa_d[5'h00];
assign inst_slt    = op_d[6'h00] & func_d[6'h2a] & sa_d[5'h00];
assign inst_sltu   = op_d[6'h00] & func_d[6'h2b] & sa_d[5'h00];
assign inst_and    = op_d[6'h00] & func_d[6'h24] & sa_d[5'h00];
assign inst_or     = op_d[6'h00] & func_d[6'h25] & sa_d[5'h00];
assign inst_xor    = op_d[6'h00] & func_d[6'h26] & sa_d[5'h00];
assign inst_nor    = op_d[6'h00] & func_d[6'h27] & sa_d[5'h00];
assign inst_sll    = op_d[6'h00] & func_d[6'h00] & rs_d[5'h00];
assign inst_srl    = op_d[6'h00] & func_d[6'h02] & rs_d[5'h00];
assign inst_sra    = op_d[6'h00] & func_d[6'h03] & rs_d[5'h00];
assign inst_addiu  = op_d[6'h09];
assign inst_lui    = op_d[6'h0f] & rs_d[5'h00];
assign inst_lw     = op_d[6'h23];
assign inst_sw     = op_d[6'h2b];
assign inst_beq    = op_d[6'h04];
assign inst_bne    = op_d[6'h05];
assign inst_jal    = op_d[6'h03];
assign inst_jr     = op_d[6'h00] & func_d[6'h08] & rt_d[5'h00] & rd_d[5'h00] & sa_d[5'h00];

assign inst_add    = op_d[6'h00] & func_d[6'h20] & sa_d[5'h00];
assign inst_addi   = op_d[6'h08];
assign inst_sub    = op_d[6'h00] & func_d[6'h22] & sa_d[5'h00];
assign inst_slti   = op_d[6'h0a];
assign inst_sltiu  = op_d[6'h0b];
assign inst_andi   = op_d[6'h0c];
assign inst_ori    = op_d[6'h0d];
assign inst_xori   = op_d[6'h0e];
assign inst_sllv   = op_d[6'h00] & func_d[6'h04] & sa_d[5'h00];
assign inst_srav   = op_d[6'h00] & func_d[6'h07] & sa_d[5'h00];  
assign inst_srlv   = op_d[6'h00] & func_d[6'h06] & sa_d[5'h00];
assign inst_mult   = op_d[6'h00] & func_d[6'h18] & sa_d[5'h00] & rd_d[5'h00];
assign inst_multu  = op_d[6'h00] & func_d[6'h19] & sa_d[5'h00] & rd_d[5'h00];
assign inst_div    = op_d[6'h00] & func_d[6'h1a] & sa_d[5'h00] & rd_d[5'h00];
assign inst_divu   = op_d[6'h00] & func_d[6'h1b] & sa_d[5'h00] & rd_d[5'h00];
assign inst_mfhi   = op_d[6'h00] & func_d[6'h10] & sa_d[5'h00] & rt_d[5'h00] & rs_d[5'h00];
assign inst_mflo   = op_d[6'h00] & func_d[6'h12] & sa_d[5'h00] & rt_d[5'h00] & rs_d[5'h00];
assign inst_mthi   = op_d[6'h00] & func_d[6'h11] & sa_d[5'h00] & rt_d[5'h00] & rd_d[5'h00];   //bug  rs_d
assign inst_mtlo   = op_d[6'h00] & func_d[6'h13] & sa_d[5'h00] & rt_d[5'h00] & rd_d[5'h00];

assign inst_bgez   = op_d[6'h01] & rt_d[5'h01];
assign inst_bgtz   = op_d[6'h07] & rt_d[5'h00];
assign inst_blez   = op_d[6'h06] & rt_d[5'h00];
assign inst_bltz   = op_d[6'h01] & rt_d[5'h00];
assign inst_j      = op_d[6'h02];
assign inst_bltzal = op_d[6'h01] & rt_d[5'h10];
assign inst_bgezal = op_d[6'h01] & rt_d[5'h11];
assign inst_jalr   = op_d[6'h00] & func_d[6'h09] & sa_d[5'h00] & rt_d[5'h00];
assign inst_lb     = op_d[6'h20];
assign inst_lbu    = op_d[6'h24];
assign inst_lh     = op_d[6'h21];
assign inst_lhu    = op_d[6'h25];
assign inst_lwl    = op_d[6'h22];
assign inst_lwr    = op_d[6'h26];
assign inst_sb     = op_d[6'h28];
assign inst_sh     = op_d[6'h29];
assign inst_swl    = op_d[6'h2a];
assign inst_swr    = op_d[6'h2e];

///////////////////////////////////////////////////////
assign inst_mfc0   = op_d[6'h10] & rs_d[5'h00] & (ds_inst[10:3] == 8'h00);
assign inst_mtc0   = op_d[6'h10] & rs_d[5'h04] & (ds_inst[10:3] == 8'h00);
assign syscall     = op_d[6'h00] & func_d[6'h0c];
assign inst_eret   = op_d[6'h10] & (ds_inst[25] == 1'b1) & (ds_inst[24:6] == 19'b0) &func_d[6'h18];
assign break       = op_d[6'h00] & func_d[6'h0d];

assign tlbp        = op_d[6'h10] & ds_inst[25] & (ds_inst[24:6] == 0) & func_d[6'h08];
assign tlbr        = op_d[6'h10] & ds_inst[25] & (ds_inst[24:6] == 0) & func_d[6'h01];
assign tlbwi       = op_d[6'h10] & ds_inst[25] & (ds_inst[24:6] == 0) & func_d[6'h02];

//////////////////////////////////////////////////////
assign alu_op[ 0] = inst_addu | inst_addiu | inst_lw | inst_sw | inst_jal | inst_add | inst_addi | inst_bltzal | inst_bgezal | inst_jalr
                   | inst_lb   | inst_lbu   | inst_lh | inst_lhu| inst_lwl | inst_lwr | inst_sb   | inst_sh     | inst_swl    | inst_swr;
assign alu_op[ 1] = inst_subu | inst_sub ;
assign alu_op[ 2] = inst_slt | inst_slti ;   
assign alu_op[ 3] = inst_sltu | inst_sltiu;
assign alu_op[ 4] = inst_and | inst_andi;
assign alu_op[ 5] = inst_nor;
assign alu_op[ 6] = inst_or | inst_ori;
assign alu_op[ 7] = inst_xor | inst_xori;
assign alu_op[ 8] = inst_sll | inst_sllv;
assign alu_op[ 9] = inst_srl | inst_srlv;
assign alu_op[10] = inst_sra | inst_srav;
assign alu_op[11] = inst_lui;

assign src1_is_sa   = inst_sll   | inst_srl | inst_sra;
assign src1_is_pc   = inst_jal   | inst_bltzal  | inst_bgezal   | inst_jalr ;
assign src2_is_imm  = inst_addiu | inst_lui | inst_lw | inst_sw | inst_addi | inst_slti | inst_sltiu
                     | inst_lb    | inst_lbu | inst_lh | inst_lhu| inst_lwl  | inst_lwr  | inst_sb
                     | inst_sh    | inst_swl | inst_swr;
///////////////////////////////////////////////////////

assign div_or_mul = {
                       inst_div,
                       inst_divu,
                       inst_mult,
                       inst_multu
};
assign src2_is_zimm = inst_andi | inst_ori | inst_xori;
///////////////////////////////////////////////////////
assign src2_is_8    = inst_jal  | inst_bltzal  | inst_bgezal | inst_jalr;
assign res_from_mem = inst_lw   | inst_lb      | inst_lbu    | inst_lh  | inst_lhu | inst_lwl |inst_lwr;
assign dst_is_r31   = inst_jal  | inst_bltzal  | inst_bgezal;
assign dst_is_rt    = inst_addiu | inst_lui | inst_lw | inst_addi | inst_slti | inst_sltiu | inst_andi
                       | inst_ori | inst_xori| inst_lb | inst_lbu  | inst_lh   | inst_lhu   | inst_lwl  | inst_lwr
                       ; //���ﲻ��inst_mfc0����ΪΪ����dest��rd����ȥ
assign gr_we        = ~inst_sw & ~inst_beq & ~inst_bne & ~inst_jr & ~inst_div & ~inst_divu & ~inst_mult & ~inst_multu & ~inst_mtlo &~inst_mthi
                       & ~inst_bgez & ~inst_bgtz & ~inst_blez & ~inst_bltz & ~inst_j & ~inst_sb & ~inst_sh & ~inst_swl & ~inst_swr & ~inst_mtc0
                       & ~inst_eret & ~syscall & ~break & ~no_inst &~tlbp &~tlbr &~tlbwi;   //����д��
assign mem_we       = inst_sw | inst_sb | inst_sh | inst_swl | inst_swr;

assign dest         = inst_eret ? `CR_EPC :
                      dst_is_r31 ? 5'd31 :
                      dst_is_rt  ? rt    : 
                                   rd;

assign rf_raddr1 = rs;
assign rf_raddr2 = rt;


   
    wire             rs_es, rs_ms, rs_ws, rt_es, rt_ms, rt_ws;
    assign          rs_es = (es_dest_withvalid[5] == 0)?1                        //û��д�ز�������Ŀ��Ĵ����?0��������д�ز�������Ŀ��Ĵ�������IDԴ�Ĵ���ʱΪ1
                             :(rs == es_dest_withvalid[4:0])?0
                             :1;
    assign          rs_ms = (ms_dest_withvalid[5] == 0)?1                        
                             :(rs == ms_dest_withvalid[4:0])?0
                             :1;          
    assign          rs_ws = (ws_dest_withvalid[5] == 0)?1                        
                             :(rs == ws_dest_withvalid[4:0])?0
                             :1;
    assign          rt_es = (es_dest_withvalid[5] == 0)?1                        //û��д�ز�������Ŀ��Ĵ����?0��������д�ز�������Ŀ��Ĵ�������IDԴ�Ĵ���ʱΪ1
                             :(rt == es_dest_withvalid[4:0])?0
                             :1;
    assign          rt_ms = (ms_dest_withvalid[5] == 0)?1                        
                             :(rt == ms_dest_withvalid[4:0])?0
                             :1;          
    assign          rt_ws = (ws_dest_withvalid[5] == 0)?1                        
                             :(rt == ws_dest_withvalid[4:0])?0
                             :1;

    assign          do_not_block = es_dest_withvalid[38]?0://���exe�׶ε���loadָ���ô������һ�ģ�����Ͳ�����?
                                    ms_dest_withvalid[38]?0:
                                    1;              
   


regfile u_regfile(
    .clk    (clk      ),
    .raddr1 (rf_raddr1),
    .rdata1 (rf_rdata1),
    .raddr2 (rf_raddr2),
    .rdata2 (rf_rdata2),
    .we     (rf_we    ),
    .waddr  (rf_waddr ),
    .wdata  (rf_wdata )
    );
//wire   j_reg = rs_es & rs_ms & rs_ws;//1Ϊ��ǰ��
wire   j_reg = rs_es & rs_ms & rs_ws & rt_es & rt_ms & rt_ws;//1Ϊ��ǰ��

assign  rs_value = (~rs_es)?es_dest_withvalid[37:6]
                   :(~rs_ms)?ms_dest_withvalid[37:6]
                   :(~rs_ws)?ws_dest_withvalid[37:6]
                   :rf_rdata1;
assign  rt_value = (~rt_es)?es_dest_withvalid[37:6]
                   :(~rt_ms)?ms_dest_withvalid[37:6]
                   :(~rt_ws)?ws_dest_withvalid[37:6]
                   :rf_rdata2;

////////////////////////////////////////////
wire rs_ge_zero, rs_gt_zero;
assign rs_ge_zero = (!rs_value[31]);
assign rs_gt_zero = (!rs_value[31] && !(rs_value == 0));

assign rs_eq_rt = (rs_value == rt_value);
reg valid;
always@(posedge clk) begin
    if(reset)
        valid <= 0;
    else if(ds_to_es_valid)
        valid <= 1;
    else if(fs_to_ds_valid && ds_allowin)
        valid <= 0;
    end
assign br_taken = (   inst_beq  &&  rs_eq_rt
                   || inst_bne  && !rs_eq_rt
                   || inst_jal
                   || inst_jr
                   || inst_bgez && rs_ge_zero
                   || inst_bgtz && rs_gt_zero
                   || inst_blez && !rs_gt_zero
                   || inst_bltz && !rs_ge_zero
                   || inst_j
                   || inst_bltzal && !rs_ge_zero
                   || inst_bgezal && rs_ge_zero
                   || inst_jalr
                  )&&(ds_to_es_valid );//&& ds_to_es_valid;//bug &ds_valid
                  
assign br_target = (inst_beq || inst_bne || inst_bgez || inst_bgtz
                     || inst_blez || inst_bltz || inst_bltzal || inst_bgezal) ? (ds_pc+32'd4 + {{14{imm[15]}}, imm[15:0], 2'b0}) :
                   (inst_jr || inst_jalr)              ? rs_value :
                  /*inst_jal || inst_j*/              {fs_pc[31:28], jidx[25:0], 2'b0};
assign br_bus       = {fs_refetch,j_reg,fs_bd,br_taken,br_target};
endmodule
