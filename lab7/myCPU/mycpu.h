`ifndef MYCPU_H
    `define MYCPU_H

    //`define BR_BUS_WD       32  错误1？
	`define BR_BUS_WD       33
    `define FS_TO_DS_BUS_WD 64
    //`define DS_TO_ES_BUS_WD 136
    `define DS_TO_ES_BUS_WD 157 
    //修改原因：lab6添加andi指令时添加zimm信号;div信号；mf和mt信号;load;store
    `define ES_TO_MS_BUS_WD 111
    //原来是71，因引入load_choice修改
    `define MS_TO_WS_BUS_WD 70
    `define WS_TO_RF_BUS_WD 38
`endif
