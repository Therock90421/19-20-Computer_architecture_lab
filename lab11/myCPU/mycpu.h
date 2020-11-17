`ifndef MYCPU_H
    `define MYCPU_H

    
	`define BR_BUS_WD       35
    `define FS_TO_DS_BUS_WD 98
    //`define DS_TO_ES_BUS_WD 136
    `define DS_TO_ES_BUS_WD 207 
    //修改原因：lab6添加andi指令时添加zimm信号;div信号；mf和mt信号;load;store; mfc0,mtc0;整数溢出;地址错
    `define ES_TO_MS_BUS_WD 159
    //原来是71，因引入load_choice修改; mfc0,mtc0
    `define MS_TO_WS_BUS_WD 149
    `define WS_TO_RF_BUS_WD 38
    `define CR_BADVADDR     8
    `define CR_COUNT        9
    `define CR_COMPARE      11
    `define CR_STATUS       12
    `define CR_CAUSE        13
    `define CR_EPC          14
    //`define CR_BADVADDR     8
   // `define CR_COUNT        9
    //`define CR_COMPARE      11
   // `define CR_STATUS       12
    //`define CR_CAUSE        13
   // `define CR_EPC          14
    
`endif
