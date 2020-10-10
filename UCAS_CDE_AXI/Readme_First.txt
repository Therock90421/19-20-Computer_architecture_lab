本目录提供CPU_AXI实验开发环境（UCAS_CDE_AXI）。


更新日志
--v0.01：20181206
         1.2018年第一次发布:
           (1) func、confreg、testbench、PLL调用对应于ucas_CDE_v0.02。
--v0.02：20181207
         1.2018年第二次发布:
           (1) 更新AXI 1X2的桥IP，0xbfafxxxx也路由至Confreg。
--v0.03：20181208
         1.2018年第三次发布:
           (1) 修复v0.02更新AXI 1X2的桥IP带来0xbfc00000不可访问的问题。
--v0.04：20181212
         1.2018年第四次发布:
           (1) 修复拨码开关控制随机种子颠倒的问题。
		   (2) axi桥与CPU对接部分再包一层，去掉rvalid后的数据保持，以使仿真模型贴近上板情况。
		   
目录结构：
   +--cpu132_gettrace/   : gs132生成golden_trace的环境，架构为SoC_SRAM_Lite，默认已生产golden_trace.txt
   |        
   |--mycpu_axi_verify/  : AXI接口的CPU运行环境，架构为SoC_AXI_Lite
   |        
   |--soft/              : 功能点测试程序和，默认已包含编译好的结果
   |        
   |--Readme_First.txt   : 本文档
