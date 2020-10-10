本目录提供CPU实验开发环境（UCAS_CDE）。


更新日志
--v0.01：20180906
         1.2018年第一次发布。

         
目录结构：
   +--cpu132_gettrace/   : gs132生成golden_trace的环境，架构为SoC_SRAM_Lite，默认已生产golden_trace.txt
   |        
   |--mycpu_verify/      : SRAM接口的CPU运行环境，架构为SoC_SRAM_Lite
   |        
   |--soft/              : 功能点测试程序和，默认已包含编译好的结果
   |        
   |--Readme_First.txt   : 本文档