//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Jan 19 02:45:18 2026
// Version: 2025.2 2025.2.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// BaseDesign
module BaseDesign(
    // Inputs
    INT_2,
    REF_CLK,
    RX,
    TCK,
    TDI,
    TMS,
    TRSTB,
    USER_RST,
    // Outputs
    LED_1,
    LED_2,
    LED_3,
    LED_4,
    TDO,
    TX
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  INT_2;
input  REF_CLK;
input  RX;
input  TCK;
input  TDI;
input  TMS;
input  TRSTB;
input  USER_RST;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output LED_1;
output LED_2;
output LED_3;
output LED_4;
output TDO;
output TX;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          CLKBUF_0_Y;
wire          CoreJTAGDebug_TRSTN_C0_0_TGT_TCK_0;
wire          CoreJTAGDebug_TRSTN_C0_0_TGT_TDI_0;
wire          CoreJTAGDebug_TRSTN_C0_0_TGT_TMS_0;
wire          CoreJTAGDebug_TRSTN_C0_0_TGT_TRSTN_0;
wire          CORERESET_PF_C0_0_FABRIC_RESET_N_0;
wire          CoreTimer_C0_0_TIMINT;
wire          INT_2;
wire   [0:0]  LED_1_net_0;
wire   [1:1]  LED_2_net_0;
wire   [2:2]  LED_3_net_0;
wire   [3:3]  LED_4_net_0;
wire          MIV_ESS_C0_0_APB_3_mTARGET_1_PENABLE;
wire   [31:0] MIV_ESS_C0_0_APB_3_mTARGET_1_PRDATA;
wire          MIV_ESS_C0_0_APB_3_mTARGET_1_PSELx;
wire   [31:0] MIV_ESS_C0_0_APB_3_mTARGET_1_PWDATA;
wire          MIV_ESS_C0_0_APB_3_mTARGET_1_PWRITE;
wire   [2:2]  MIV_ESS_C0_0_GPIO_INT2to2;
wire   [3:3]  MIV_ESS_C0_0_GPIO_INT3to3;
wire   [4:4]  MIV_ESS_C0_0_GPIO_OUT4to4;
wire   [5:5]  MIV_ESS_C0_0_GPIO_OUT5to5;
wire          MIV_ESS_C0_0_PLIC_IRQ;
wire   [31:0] MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HADDR;
wire   [2:0]  MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HBURST;
wire          MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HMASTLOCK;
wire   [3:0]  MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HPROT;
wire   [31:0] MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HRDATA;
wire          MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HREADYOUT;
wire          MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HSELx;
wire   [2:0]  MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HSIZE;
wire   [1:0]  MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HTRANS;
wire   [31:0] MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HWDATA;
wire          MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HWRITE;
wire   [31:0] MIV_RV32_CFG1_C0_0_APB_INITIATOR_PADDR;
wire          MIV_RV32_CFG1_C0_0_APB_INITIATOR_PENABLE;
wire   [31:0] MIV_RV32_CFG1_C0_0_APB_INITIATOR_PRDATA;
wire          MIV_RV32_CFG1_C0_0_APB_INITIATOR_PREADY;
wire          MIV_RV32_CFG1_C0_0_APB_INITIATOR_PSELx;
wire          MIV_RV32_CFG1_C0_0_APB_INITIATOR_PSLVERR;
wire   [31:0] MIV_RV32_CFG1_C0_0_APB_INITIATOR_PWDATA;
wire          MIV_RV32_CFG1_C0_0_APB_INITIATOR_PWRITE;
wire          MIV_RV32_CFG1_C0_0_JTAG_TDO;
wire          PF_CCC_C0_0_OUT0_FABCLK_0_1;
wire          PF_CCC_C0_0_PLL_LOCK_0;
wire   [19:0] PF_DPSRAM_C0_0_A_DOUT;
wire          PF_INIT_MONITOR_C0_0_DEVICE_INIT_DONE;
wire          PF_INIT_MONITOR_C0_0_FABRIC_POR_N;
wire          REF_CLK;
wire          RX;
wire   [9:0]  sram_test_module_0_addr_portA;
wire   [19:0] sram_test_module_0_data_write_portA;
wire          sram_test_module_0_done_irq;
wire          sram_test_module_0_done_latch;
wire          sram_test_module_0_error_latch;
wire          sram_test_module_0_wen_portA;
wire          TCK;
wire          TDI;
wire          TDO_net_0;
wire          TMS;
wire          TRSTB;
wire          TX_net_0;
wire          USER_RST;
wire          LED_1_net_1;
wire          LED_2_net_1;
wire          LED_3_net_1;
wire          LED_4_net_1;
wire          TDO_net_1;
wire          TX_net_1;
wire   [0:0]  GPIO_INT_slice_0;
wire   [1:1]  GPIO_INT_slice_1;
wire   [4:4]  GPIO_INT_slice_2;
wire   [5:5]  GPIO_INT_slice_3;
wire   [1:0]  PLIC_SRC_IRQ_net_0;
wire   [7:0]  GPIO_IN_net_0;
wire   [7:0]  GPIO_OUT_net_0;
wire   [7:0]  GPIO_INT_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          VCC_net;
wire          GND_net;
wire   [19:0] B_DIN_const_net_0;
wire   [9:0]  B_ADDR_const_net_0;
//--------------------------------------------------------------------
// Bus Interface Nets Declarations - Unequal Pin Widths
//--------------------------------------------------------------------
wire   [31:0] MIV_ESS_C0_0_APB_3_mTARGET_1_PADDR;
wire   [4:2]  MIV_ESS_C0_0_APB_3_mTARGET_1_PADDR_0;
wire   [4:2]  MIV_ESS_C0_0_APB_3_mTARGET_1_PADDR_0_4to2;
wire   [1:0]  MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HRESP;
wire          MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HRESP_0;
wire   [0:0]  MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HRESP_0_0to0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net            = 1'b1;
assign GND_net            = 1'b0;
assign B_DIN_const_net_0  = 20'h00000;
assign B_ADDR_const_net_0 = 10'h000;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign LED_1_net_1 = LED_1_net_0[0];
assign LED_1       = LED_1_net_1;
assign LED_2_net_1 = LED_2_net_0[1];
assign LED_2       = LED_2_net_1;
assign LED_3_net_1 = LED_3_net_0[2];
assign LED_3       = LED_3_net_1;
assign LED_4_net_1 = LED_4_net_0[3];
assign LED_4       = LED_4_net_1;
assign TDO_net_1   = TDO_net_0;
assign TDO         = TDO_net_1;
assign TX_net_1    = TX_net_0;
assign TX          = TX_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign LED_1_net_0[0]               = GPIO_OUT_net_0[0:0];
assign LED_2_net_0[1]               = GPIO_OUT_net_0[1:1];
assign LED_3_net_0[2]               = GPIO_OUT_net_0[2:2];
assign LED_4_net_0[3]               = GPIO_OUT_net_0[3:3];
assign MIV_ESS_C0_0_GPIO_INT2to2[2] = GPIO_INT_net_0[2:2];
assign MIV_ESS_C0_0_GPIO_INT3to3[3] = GPIO_INT_net_0[3:3];
assign MIV_ESS_C0_0_GPIO_OUT4to4[4] = GPIO_OUT_net_0[4:4];
assign MIV_ESS_C0_0_GPIO_OUT5to5[5] = GPIO_OUT_net_0[5:5];
assign GPIO_INT_slice_0[0]          = GPIO_INT_net_0[0:0];
assign GPIO_INT_slice_1[1]          = GPIO_INT_net_0[1:1];
assign GPIO_INT_slice_2[4]          = GPIO_INT_net_0[4:4];
assign GPIO_INT_slice_3[5]          = GPIO_INT_net_0[5:5];
//--------------------------------------------------------------------
// Concatenation assignments
//--------------------------------------------------------------------
assign PLIC_SRC_IRQ_net_0 = { MIV_ESS_C0_0_GPIO_INT3to3[3] , MIV_ESS_C0_0_GPIO_INT2to2[2] };
assign GPIO_IN_net_0      = { sram_test_module_0_done_latch , sram_test_module_0_error_latch , 1'b0 , 1'b0 , sram_test_module_0_done_irq , INT_2 , 1'b0 , 1'b0 };
//--------------------------------------------------------------------
// Bus Interface Nets Assignments - Unequal Pin Widths
//--------------------------------------------------------------------
assign MIV_ESS_C0_0_APB_3_mTARGET_1_PADDR_0 = { MIV_ESS_C0_0_APB_3_mTARGET_1_PADDR_0_4to2 };
assign MIV_ESS_C0_0_APB_3_mTARGET_1_PADDR_0_4to2 = MIV_ESS_C0_0_APB_3_mTARGET_1_PADDR[4:2];

assign MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HRESP_0 = { MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HRESP_0_0to0 };
assign MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HRESP_0_0to0 = MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HRESP[0:0];

//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CLKBUF
CLKBUF CLKBUF_0(
        // Inputs
        .PAD ( REF_CLK ),
        // Outputs
        .Y   ( CLKBUF_0_Y ) 
        );

//--------CoreJTAGDebug_TRSTN_C0
CoreJTAGDebug_TRSTN_C0 CoreJTAGDebug_TRSTN_C0_0(
        // Inputs
        .TRSTB       ( TRSTB ),
        .TCK         ( TCK ),
        .TMS         ( TMS ),
        .TDI         ( TDI ),
        .TGT_TDO_0   ( MIV_RV32_CFG1_C0_0_JTAG_TDO ),
        // Outputs
        .TDO         ( TDO_net_0 ),
        .TGT_TCK_0   ( CoreJTAGDebug_TRSTN_C0_0_TGT_TCK_0 ),
        .TGT_TMS_0   ( CoreJTAGDebug_TRSTN_C0_0_TGT_TMS_0 ),
        .TGT_TDI_0   ( CoreJTAGDebug_TRSTN_C0_0_TGT_TDI_0 ),
        .TGT_TRSTN_0 ( CoreJTAGDebug_TRSTN_C0_0_TGT_TRSTN_0 ) 
        );

//--------CORERESET_PF_C0
CORERESET_PF_C0 CORERESET_PF_C0_0(
        // Inputs
        .CLK                ( PF_CCC_C0_0_OUT0_FABCLK_0_1 ),
        .EXT_RST_N          ( USER_RST ),
        .BANK_x_VDDI_STATUS ( VCC_net ),
        .BANK_y_VDDI_STATUS ( VCC_net ),
        .PLL_LOCK           ( PF_CCC_C0_0_PLL_LOCK_0 ),
        .SS_BUSY            ( GND_net ),
        .INIT_DONE          ( PF_INIT_MONITOR_C0_0_DEVICE_INIT_DONE ),
        .FF_US_RESTORE      ( GND_net ),
        .FPGA_POR_N         ( PF_INIT_MONITOR_C0_0_FABRIC_POR_N ),
        // Outputs
        .PLL_POWERDOWN_B    (  ),
        .FABRIC_RESET_N     ( CORERESET_PF_C0_0_FABRIC_RESET_N_0 ) 
        );

//--------CoreTimer_C0
CoreTimer_C0 CoreTimer_C0_0(
        // Inputs
        .PCLK    ( PF_CCC_C0_0_OUT0_FABCLK_0_1 ),
        .PRESETn ( CORERESET_PF_C0_0_FABRIC_RESET_N_0 ),
        .PSEL    ( MIV_ESS_C0_0_APB_3_mTARGET_1_PSELx ),
        .PENABLE ( MIV_ESS_C0_0_APB_3_mTARGET_1_PENABLE ),
        .PADDR   ( MIV_ESS_C0_0_APB_3_mTARGET_1_PADDR_0 ),
        .PWRITE  ( MIV_ESS_C0_0_APB_3_mTARGET_1_PWRITE ),
        .PWDATA  ( MIV_ESS_C0_0_APB_3_mTARGET_1_PWDATA ),
        // Outputs
        .TIMINT  ( CoreTimer_C0_0_TIMINT ),
        .PRDATA  ( MIV_ESS_C0_0_APB_3_mTARGET_1_PRDATA ) 
        );

//--------MIV_ESS_C0
MIV_ESS_C0 MIV_ESS_C0_0(
        // Inputs
        .PCLK           ( PF_CCC_C0_0_OUT0_FABCLK_0_1 ),
        .PRESETN        ( CORERESET_PF_C0_0_FABRIC_RESET_N_0 ),
        .PLIC_SRC_IRQ   ( PLIC_SRC_IRQ_net_0 ),
        .GPIO_IN        ( GPIO_IN_net_0 ),
        .UART_RX        ( RX ),
        .APB_T0_PADDR   ( MIV_RV32_CFG1_C0_0_APB_INITIATOR_PADDR ),
        .APB_T0_PENABLE ( MIV_RV32_CFG1_C0_0_APB_INITIATOR_PENABLE ),
        .APB_T0_PWRITE  ( MIV_RV32_CFG1_C0_0_APB_INITIATOR_PWRITE ),
        .APB_T0_PWDATA  ( MIV_RV32_CFG1_C0_0_APB_INITIATOR_PWDATA ),
        .APB_T0_PSEL    ( MIV_RV32_CFG1_C0_0_APB_INITIATOR_PSELx ),
        .APB_I3_PRDATA  ( MIV_ESS_C0_0_APB_3_mTARGET_1_PRDATA ),
        .APB_I3_PREADY  ( VCC_net ), // tied to 1'b1 from definition
        .APB_I3_PSLVERR ( GND_net ), // tied to 1'b0 from definition
        // Outputs
        .PLIC_IRQ       ( MIV_ESS_C0_0_PLIC_IRQ ),
        .GPIO_OUT       ( GPIO_OUT_net_0 ),
        .GPIO_INT       ( GPIO_INT_net_0 ),
        .GPIO_INT_OR    (  ),
        .UART_TX        ( TX_net_0 ),
        .APB_T0_PRDATA  ( MIV_RV32_CFG1_C0_0_APB_INITIATOR_PRDATA ),
        .APB_T0_PREADY  ( MIV_RV32_CFG1_C0_0_APB_INITIATOR_PREADY ),
        .APB_T0_PSLVERR ( MIV_RV32_CFG1_C0_0_APB_INITIATOR_PSLVERR ),
        .APB_I3_PADDR   ( MIV_ESS_C0_0_APB_3_mTARGET_1_PADDR ),
        .APB_I3_PENABLE ( MIV_ESS_C0_0_APB_3_mTARGET_1_PENABLE ),
        .APB_I3_PWRITE  ( MIV_ESS_C0_0_APB_3_mTARGET_1_PWRITE ),
        .APB_I3_PWDATA  ( MIV_ESS_C0_0_APB_3_mTARGET_1_PWDATA ),
        .APB_I3_PSEL    ( MIV_ESS_C0_0_APB_3_mTARGET_1_PSELx ) 
        );

//--------MIV_RV32_CFG1_C0
MIV_RV32_CFG1_C0 MIV_RV32_CFG1_C0_0(
        // Inputs
        .CLK            ( PF_CCC_C0_0_OUT0_FABCLK_0_1 ),
        .RESETN         ( CORERESET_PF_C0_0_FABRIC_RESET_N_0 ),
        .APB_PRDATA     ( MIV_RV32_CFG1_C0_0_APB_INITIATOR_PRDATA ),
        .APB_PREADY     ( MIV_RV32_CFG1_C0_0_APB_INITIATOR_PREADY ),
        .APB_PSLVERR    ( MIV_RV32_CFG1_C0_0_APB_INITIATOR_PSLVERR ),
        .AHB_HRDATA     ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HRDATA ),
        .AHB_HRESP      ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HRESP_0 ),
        .AHB_HREADY     ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HREADYOUT ),
        .JTAG_TRSTN     ( CoreJTAGDebug_TRSTN_C0_0_TGT_TRSTN_0 ),
        .JTAG_TCK       ( CoreJTAGDebug_TRSTN_C0_0_TGT_TCK_0 ),
        .JTAG_TDI       ( CoreJTAGDebug_TRSTN_C0_0_TGT_TDI_0 ),
        .JTAG_TMS       ( CoreJTAGDebug_TRSTN_C0_0_TGT_TMS_0 ),
        .EXT_IRQ        ( MIV_ESS_C0_0_PLIC_IRQ ),
        .MSYS_EI        ( CoreTimer_C0_0_TIMINT ),
        // Outputs
        .EXT_RESETN     (  ),
        .TIME_COUNT_OUT (  ),
        .APB_PADDR      ( MIV_RV32_CFG1_C0_0_APB_INITIATOR_PADDR ),
        .APB_PENABLE    ( MIV_RV32_CFG1_C0_0_APB_INITIATOR_PENABLE ),
        .APB_PWRITE     ( MIV_RV32_CFG1_C0_0_APB_INITIATOR_PWRITE ),
        .APB_PWDATA     ( MIV_RV32_CFG1_C0_0_APB_INITIATOR_PWDATA ),
        .APB_PSEL       ( MIV_RV32_CFG1_C0_0_APB_INITIATOR_PSELx ),
        .AHB_HADDR      ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HADDR ),
        .AHB_HTRANS     ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HTRANS ),
        .AHB_HWRITE     ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HWRITE ),
        .AHB_HSIZE      ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HSIZE ),
        .AHB_HBURST     ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HBURST ),
        .AHB_HPROT      ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HPROT ),
        .AHB_HWDATA     ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HWDATA ),
        .AHB_HMASTLOCK  ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HMASTLOCK ),
        .AHB_HSEL       ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HSELx ),
        .JTAG_TDO       ( MIV_RV32_CFG1_C0_0_JTAG_TDO ),
        .JTAG_TDO_DR    (  ) 
        );

//--------PF_CCC_C0
PF_CCC_C0 PF_CCC_C0_0(
        // Inputs
        .REF_CLK_0     ( CLKBUF_0_Y ),
        // Outputs
        .OUT0_FABCLK_0 ( PF_CCC_C0_0_OUT0_FABCLK_0_1 ),
        .PLL_LOCK_0    ( PF_CCC_C0_0_PLL_LOCK_0 ) 
        );

//--------PF_DPSRAM_C0
PF_DPSRAM_C0 PF_DPSRAM_C0_0(
        // Inputs
        .A_DIN  ( sram_test_module_0_data_write_portA ),
        .A_ADDR ( sram_test_module_0_addr_portA ),
        .B_DIN  ( B_DIN_const_net_0 ),
        .B_ADDR ( B_ADDR_const_net_0 ),
        .A_WEN  ( sram_test_module_0_wen_portA ),
        .B_WEN  ( GND_net ),
        .CLK    ( PF_CCC_C0_0_OUT0_FABCLK_0_1 ),
        // Outputs
        .A_DOUT ( PF_DPSRAM_C0_0_A_DOUT ),
        .B_DOUT (  ) 
        );

//--------PF_INIT_MONITOR_C0
PF_INIT_MONITOR_C0 PF_INIT_MONITOR_C0_0(
        // Outputs
        .FABRIC_POR_N               ( PF_INIT_MONITOR_C0_0_FABRIC_POR_N ),
        .PCIE_INIT_DONE             (  ),
        .USRAM_INIT_DONE            (  ),
        .SRAM_INIT_DONE             (  ),
        .DEVICE_INIT_DONE           ( PF_INIT_MONITOR_C0_0_DEVICE_INIT_DONE ),
        .XCVR_INIT_DONE             (  ),
        .USRAM_INIT_FROM_SNVM_DONE  (  ),
        .USRAM_INIT_FROM_UPROM_DONE (  ),
        .USRAM_INIT_FROM_SPI_DONE   (  ),
        .SRAM_INIT_FROM_SNVM_DONE   (  ),
        .SRAM_INIT_FROM_UPROM_DONE  (  ),
        .SRAM_INIT_FROM_SPI_DONE    (  ),
        .AUTOCALIB_DONE             (  ) 
        );

//--------PF_SRAM_AHB_C0
PF_SRAM_AHB_C0 PF_SRAM_AHB_C0_0(
        // Inputs
        .HCLK      ( PF_CCC_C0_0_OUT0_FABCLK_0_1 ),
        .HRESETN   ( CORERESET_PF_C0_0_FABRIC_RESET_N_0 ),
        .HWRITE    ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HWRITE ),
        .HSEL      ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HSELx ),
        .HREADYIN  ( VCC_net ), // tied to 1'b1 from definition
        .HADDR     ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HADDR ),
        .HTRANS    ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HTRANS ),
        .HSIZE     ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HSIZE ),
        .HBURST    ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HBURST ),
        .HWDATA    ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HWDATA ),
        // Outputs
        .HREADYOUT ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HREADYOUT ),
        .HRDATA    ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HRDATA ),
        .HRESP     ( MIV_RV32_CFG1_C0_0_AHBL_M_TARGET_HRESP ) 
        );

//--------sram_test_module
sram_test_module sram_test_module_0(
        // Inputs
        .clk              ( PF_CCC_C0_0_OUT0_FABCLK_0_1 ),
        .rst_n            ( CORERESET_PF_C0_0_FABRIC_RESET_N_0 ),
        .start_test       ( MIV_ESS_C0_0_GPIO_OUT4to4 ),
        .clr_status       ( MIV_ESS_C0_0_GPIO_OUT5to5 ),
        .data_read_portA  ( PF_DPSRAM_C0_0_A_DOUT ),
        // Outputs
        .wen_portA        ( sram_test_module_0_wen_portA ),
        .addr_portA       ( sram_test_module_0_addr_portA ),
        .data_write_portA ( sram_test_module_0_data_write_portA ),
        .error_latch      ( sram_test_module_0_error_latch ),
        .done_latch       ( sram_test_module_0_done_latch ),
        .done_irq         ( sram_test_module_0_done_irq ) 
        );


endmodule
