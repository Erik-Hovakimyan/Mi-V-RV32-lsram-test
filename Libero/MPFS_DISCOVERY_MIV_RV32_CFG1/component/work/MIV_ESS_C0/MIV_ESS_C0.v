//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Jan 18 23:06:57 2026
// Version: 2025.2 2025.2.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of MIV_ESS_C0 to TCL
# Family: PolarFireSoC
# Part Number: MPFS095T-1FCSG325E
# Create and Configure the core component MIV_ESS_C0
create_and_configure_core -core_vlnv {Actel:SystemBuilder:MIV_ESS:2.0.200} -component_name {MIV_ESS_C0} -params {\
"APBSLOT11ENABLE:false" \
"APBSLOT12ENABLE:false" \
"APBSLOT13ENABLE:false" \
"APBSLOT14ENABLE:false" \
"APBSLOT15ENABLE:false" \
"APBSLOT3ENABLE:true" \
"APBSLOT4ENABLE:false" \
"APB_DST_ADDR_LOWER:0x0" \
"APB_DST_ADDR_UPPER:0x4000" \
"APB_DWIDTH:32" \
"APB_INITIATOR_0_MIRROR:true" \
"APB_WIDTH:32" \
"BAUD_VALUE:1" \
"BAUD_VAL_FRCTN:0" \
"BAUD_VAL_FRCTN_EN:false" \
"BOOTLOAD_EN:false" \
"BOOTLOAD_SOURCE:1" \
"BUSY_SIGNAL:true" \
"CFG_CLK:7" \
"CFG_FIFO_DEPTH:32" \
"CFG_FRAME_SIZE:8" \
"CFG_MODE:0" \
"CFG_MOT_MODE:0" \
"CFG_MOT_SSEL:false" \
"CFG_NSC_OPERATION:0" \
"CFG_TI_JMB_FRAMES:false" \
"CFG_TI_NSC_CUSTOM:0" \
"CFG_TI_NSC_FRC:false" \
"DATA_WORD_CNT:8192" \
"FAMILY_TARGET:26" \
"FIXEDMODE:0" \
"FIXED_CONFIG_0:true" \
"FIXED_CONFIG_1:true" \
"FIXED_CONFIG_10:false" \
"FIXED_CONFIG_11:false" \
"FIXED_CONFIG_12:false" \
"FIXED_CONFIG_13:false" \
"FIXED_CONFIG_14:false" \
"FIXED_CONFIG_15:false" \
"FIXED_CONFIG_16:false" \
"FIXED_CONFIG_17:false" \
"FIXED_CONFIG_18:false" \
"FIXED_CONFIG_19:false" \
"FIXED_CONFIG_2:true" \
"FIXED_CONFIG_20:false" \
"FIXED_CONFIG_21:false" \
"FIXED_CONFIG_22:false" \
"FIXED_CONFIG_23:false" \
"FIXED_CONFIG_24:false" \
"FIXED_CONFIG_25:false" \
"FIXED_CONFIG_26:false" \
"FIXED_CONFIG_27:false" \
"FIXED_CONFIG_28:false" \
"FIXED_CONFIG_29:false" \
"FIXED_CONFIG_3:true" \
"FIXED_CONFIG_30:false" \
"FIXED_CONFIG_31:false" \
"FIXED_CONFIG_4:true" \
"FIXED_CONFIG_5:true" \
"FIXED_CONFIG_6:true" \
"FIXED_CONFIG_7:true" \
"FIXED_CONFIG_8:false" \
"FIXED_CONFIG_9:false" \
"GPIO_EN:true" \
"GUI_ALIGN_0:true" \
"I2C_CLK_DIVISOR:99" \
"I2C_EN:false" \
"I2C_MULTI_ADDR_BYTES:1" \
"I2C_SLV_ADDR:0x50" \
"I2C_START_ADDR_LOWER:0x0" \
"I2C_START_ADDR_UPPER:0x0" \
"INTERNAL_MTIME_IRQ:true" \
"INT_BUS:1" \
"IO_INT_TYPE_0:7" \
"IO_INT_TYPE_1:7" \
"IO_INT_TYPE_10:7" \
"IO_INT_TYPE_11:7" \
"IO_INT_TYPE_12:7" \
"IO_INT_TYPE_13:7" \
"IO_INT_TYPE_14:7" \
"IO_INT_TYPE_15:7" \
"IO_INT_TYPE_16:7" \
"IO_INT_TYPE_17:7" \
"IO_INT_TYPE_18:7" \
"IO_INT_TYPE_19:7" \
"IO_INT_TYPE_2:3" \
"IO_INT_TYPE_20:7" \
"IO_INT_TYPE_21:7" \
"IO_INT_TYPE_22:7" \
"IO_INT_TYPE_23:7" \
"IO_INT_TYPE_24:7" \
"IO_INT_TYPE_25:7" \
"IO_INT_TYPE_26:7" \
"IO_INT_TYPE_27:7" \
"IO_INT_TYPE_28:7" \
"IO_INT_TYPE_29:7" \
"IO_INT_TYPE_3:2" \
"IO_INT_TYPE_30:7" \
"IO_INT_TYPE_31:7" \
"IO_INT_TYPE_4:7" \
"IO_INT_TYPE_5:7" \
"IO_INT_TYPE_6:7" \
"IO_INT_TYPE_7:7" \
"IO_INT_TYPE_8:7" \
"IO_INT_TYPE_9:7" \
"IO_NUM:8" \
"IO_TYPE_0:2" \
"IO_TYPE_1:2" \
"IO_TYPE_10:0" \
"IO_TYPE_11:0" \
"IO_TYPE_12:0" \
"IO_TYPE_13:0" \
"IO_TYPE_14:0" \
"IO_TYPE_15:0" \
"IO_TYPE_16:0" \
"IO_TYPE_17:0" \
"IO_TYPE_18:0" \
"IO_TYPE_19:0" \
"IO_TYPE_2:2" \
"IO_TYPE_20:0" \
"IO_TYPE_21:0" \
"IO_TYPE_22:0" \
"IO_TYPE_23:0" \
"IO_TYPE_24:0" \
"IO_TYPE_25:0" \
"IO_TYPE_26:0" \
"IO_TYPE_27:0" \
"IO_TYPE_28:0" \
"IO_TYPE_29:0" \
"IO_TYPE_3:2" \
"IO_TYPE_30:0" \
"IO_TYPE_31:0" \
"IO_TYPE_4:1" \
"IO_TYPE_5:1" \
"IO_TYPE_6:0" \
"IO_TYPE_7:0" \
"IO_TYPE_8:0" \
"IO_TYPE_9:0" \
"IO_VAL_0:0" \
"IO_VAL_1:0" \
"IO_VAL_10:0" \
"IO_VAL_11:0" \
"IO_VAL_12:0" \
"IO_VAL_13:0" \
"IO_VAL_14:0" \
"IO_VAL_15:0" \
"IO_VAL_16:0" \
"IO_VAL_17:0" \
"IO_VAL_18:0" \
"IO_VAL_19:0" \
"IO_VAL_2:0" \
"IO_VAL_20:0" \
"IO_VAL_21:0" \
"IO_VAL_22:0" \
"IO_VAL_23:0" \
"IO_VAL_24:0" \
"IO_VAL_25:0" \
"IO_VAL_26:0" \
"IO_VAL_27:0" \
"IO_VAL_28:0" \
"IO_VAL_29:0" \
"IO_VAL_3:0" \
"IO_VAL_30:0" \
"IO_VAL_31:0" \
"IO_VAL_4:0" \
"IO_VAL_5:0" \
"IO_VAL_6:0" \
"IO_VAL_7:0" \
"IO_VAL_8:0" \
"IO_VAL_9:0" \
"IRQ_EN_SIGNAL:true" \
"MTIME_PRESCALER:1000" \
"MTIME_RTC_CLOCK:false" \
"OE_TYPE:1" \
"PLIC_EN:true" \
"PLIC_IRQS:2" \
"PRG_BIT8:1" \
"PRG_PARITY:0" \
"READ_4BYTE_ADDR:0" \
"READ_MIRROR:false" \
"READ_STATUS_TYPE:false" \
"RST_EXTPROC_DURATION:1000" \
"RST_RECOVERY_DURATION:8" \
"RX_FIFO:0" \
"RX_LEGACY_MODE:0" \
"SPI_CLK_RATIO:8" \
"SPI_EN:false" \
"SPI_SRC_ADDR_LOWER:0x0" \
"SPI_SRC_ADDR_UPPER:0x0" \
"SS_DESELECT_DURATION:8" \
"SW_RESET_TYPE:0" \
"SYS_TIMER_EN:false" \
"TX_FIFO:0" \
"UART_EN:true" \
"UART_STATUS_FLAGS:false" \
"UPROM_SRC_ADDR_LOWER:0x0" \
"UPROM_SRC_ADDR_UPPER:0x0" \
"USE_SOFT_FIFO:0" \
"WDT_EN:false" \
"WRITE_MIRROR:false" \
"WRITE_PORT:1" \
"uDMA_EN:false" }
# Exporting Component Description of MIV_ESS_C0 to TCL done
*/

// MIV_ESS_C0
module MIV_ESS_C0(
    // Inputs
    APB_I3_PRDATA,
    APB_I3_PREADY,
    APB_I3_PSLVERR,
    APB_T0_PADDR,
    APB_T0_PENABLE,
    APB_T0_PSEL,
    APB_T0_PWDATA,
    APB_T0_PWRITE,
    GPIO_IN,
    PCLK,
    PLIC_SRC_IRQ,
    PRESETN,
    UART_RX,
    // Outputs
    APB_I3_PADDR,
    APB_I3_PENABLE,
    APB_I3_PSEL,
    APB_I3_PWDATA,
    APB_I3_PWRITE,
    APB_T0_PRDATA,
    APB_T0_PREADY,
    APB_T0_PSLVERR,
    GPIO_INT,
    GPIO_INT_OR,
    GPIO_OUT,
    PLIC_IRQ,
    UART_TX
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [31:0] APB_I3_PRDATA;
input         APB_I3_PREADY;
input         APB_I3_PSLVERR;
input  [31:0] APB_T0_PADDR;
input         APB_T0_PENABLE;
input         APB_T0_PSEL;
input  [31:0] APB_T0_PWDATA;
input         APB_T0_PWRITE;
input  [7:0]  GPIO_IN;
input         PCLK;
input  [1:0]  PLIC_SRC_IRQ;
input         PRESETN;
input         UART_RX;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] APB_I3_PADDR;
output        APB_I3_PENABLE;
output        APB_I3_PSEL;
output [31:0] APB_I3_PWDATA;
output        APB_I3_PWRITE;
output [31:0] APB_T0_PRDATA;
output        APB_T0_PREADY;
output        APB_T0_PSLVERR;
output [7:0]  GPIO_INT;
output        GPIO_INT_OR;
output [7:0]  GPIO_OUT;
output        PLIC_IRQ;
output        UART_TX;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [31:0] APB_T0_PADDR;
wire          APB_T0_PENABLE;
wire   [31:0] APB_0_mINITIATOR_PRDATA;
wire          APB_0_mINITIATOR_PREADY;
wire          APB_T0_PSEL;
wire          APB_0_mINITIATOR_PSLVERR;
wire   [31:0] APB_T0_PWDATA;
wire          APB_T0_PWRITE;
wire   [31:0] APB_3_mTARGET_PADDR;
wire          APB_3_mTARGET_PENABLE;
wire   [31:0] APB_I3_PRDATA;
wire          APB_I3_PREADY;
wire          APB_3_mTARGET_PSELx;
wire          APB_I3_PSLVERR;
wire   [31:0] APB_3_mTARGET_PWDATA;
wire          APB_3_mTARGET_PWRITE;
wire   [7:0]  GPIO_IN;
wire   [7:0]  GPIO_INT_net_0;
wire          GPIO_INT_OR_net_0;
wire   [7:0]  GPIO_OUT_net_0;
wire          MIV_APB3_0_APBmslave0_PENABLE;
wire   [31:0] MIV_APB3_0_APBmslave0_PRDATA;
wire          MIV_APB3_0_APBmslave0_PSELx;
wire          MIV_APB3_0_APBmslave0_PWRITE;
wire          MIV_APB3_0_APBmslave1_PREADY;
wire          MIV_APB3_0_APBmslave1_PSELx;
wire          MIV_APB3_0_APBmslave1_PSLVERR;
wire   [31:0] MIV_APB3_0_APBmslave3_PRDATA;
wire          MIV_APB3_0_APBmslave3_PREADY;
wire          MIV_APB3_0_APBmslave3_PSELx;
wire          MIV_APB3_0_APBmslave3_PSLVERR;
wire   [31:0] MIV_APB3_0_APBmslave5_PRDATA;
wire          MIV_APB3_0_APBmslave5_PREADY;
wire          MIV_APB3_0_APBmslave5_PSELx;
wire          MIV_APB3_0_APBmslave5_PSLVERR;
wire   [31:0] MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PADDR;
wire          MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PENABLE;
wire   [31:0] MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PRDATA;
wire          MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PREADY;
wire          MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PSELx;
wire          MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PSLVERR;
wire   [31:0] MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PWDATA;
wire          MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PWRITE;
wire          MIV_ESS_RESET_CTRL_0_ESS_SYS_RESETN;
wire          PCLK;
wire          PLIC_IRQ_net_0;
wire   [1:0]  PLIC_SRC_IRQ;
wire          PRESETN;
wire          UART_RX;
wire          UART_TX_net_0;
wire          PLIC_IRQ_net_1;
wire   [7:0]  GPIO_OUT_net_1;
wire   [7:0]  GPIO_INT_net_1;
wire          GPIO_INT_OR_net_1;
wire          UART_TX_net_1;
wire   [31:0] APB_0_mINITIATOR_PRDATA_net_0;
wire          APB_0_mINITIATOR_PREADY_net_0;
wire          APB_0_mINITIATOR_PSLVERR_net_0;
wire   [31:0] APB_3_mTARGET_PADDR_net_0;
wire          APB_3_mTARGET_PENABLE_net_0;
wire          APB_3_mTARGET_PWRITE_net_0;
wire   [31:0] APB_3_mTARGET_PWDATA_net_0;
wire          APB_3_mTARGET_PSELx_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
wire          VCC_net;
wire   [31:0] PRDATAS2_const_net_0;
wire   [31:0] PRDATAS4_const_net_0;
wire   [31:0] PRDATAS6_const_net_0;
wire   [31:0] PRDATAS7_const_net_0;
wire   [31:0] PRDATAS8_const_net_0;
wire   [31:0] PRDATAS9_const_net_0;
wire   [31:0] PRDATAS10_const_net_0;
wire   [31:0] PRDATAS11_const_net_0;
wire   [31:0] PRDATAS12_const_net_0;
wire   [31:0] PRDATAS13_const_net_0;
wire   [31:0] PRDATAS14_const_net_0;
wire   [31:0] PRDATAS15_const_net_0;
wire   [31:0] APB_I4_PRDATA_const_net_0;
wire   [31:0] APB_I11_PRDATA_const_net_0;
wire   [31:0] APB_I12_PRDATA_const_net_0;
wire   [31:0] APB_I13_PRDATA_const_net_0;
wire   [31:0] APB_I14_PRDATA_const_net_0;
wire   [31:0] APB_I15_PRDATA_const_net_0;
wire   [31:0] APB_T4_PADDR_const_net_0;
wire   [31:0] APB_T4_PWDATA_const_net_0;
wire   [31:0] APB_T11_PADDR_const_net_0;
wire   [31:0] APB_T11_PWDATA_const_net_0;
wire   [31:0] APB_T12_PADDR_const_net_0;
wire   [31:0] APB_T12_PWDATA_const_net_0;
wire   [31:0] APB_T13_PADDR_const_net_0;
wire   [31:0] APB_T13_PWDATA_const_net_0;
wire   [31:0] APB_T14_PADDR_const_net_0;
wire   [31:0] APB_T14_PWDATA_const_net_0;
wire   [31:0] APB_T15_PADDR_const_net_0;
wire   [31:0] APB_T15_PWDATA_const_net_0;
//--------------------------------------------------------------------
// Bus Interface Nets Declarations - Unequal Pin Widths
//--------------------------------------------------------------------
wire   [31:0] MIV_APB3_0_APBmslave0_PADDR;
wire   [4:0]  MIV_APB3_0_APBmslave0_PADDR_0;
wire   [4:0]  MIV_APB3_0_APBmslave0_PADDR_0_4to0;
wire   [7:0]  MIV_APB3_0_APBmslave0_PADDR_1;
wire   [7:0]  MIV_APB3_0_APBmslave0_PADDR_1_7to0;
wire   [31:0] MIV_APB3_0_APBmslave0_PWDATA;
wire   [7:0]  MIV_APB3_0_APBmslave0_PWDATA_0;
wire   [7:0]  MIV_APB3_0_APBmslave0_PWDATA_0_7to0;
wire   [7:0]  MIV_APB3_0_APBmslave1_PRDATA;
wire   [31:0] MIV_APB3_0_APBmslave1_PRDATA_0;
wire   [31:8] MIV_APB3_0_APBmslave1_PRDATA_0_31to8;
wire   [7:0]  MIV_APB3_0_APBmslave1_PRDATA_0_7to0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net                    = 1'b0;
assign VCC_net                    = 1'b1;
assign PRDATAS2_const_net_0       = 32'h00000000;
assign PRDATAS4_const_net_0       = 32'h00000000;
assign PRDATAS6_const_net_0       = 32'h00000000;
assign PRDATAS7_const_net_0       = 32'h00000000;
assign PRDATAS8_const_net_0       = 32'h00000000;
assign PRDATAS9_const_net_0       = 32'h00000000;
assign PRDATAS10_const_net_0      = 32'h00000000;
assign PRDATAS11_const_net_0      = 32'h00000000;
assign PRDATAS12_const_net_0      = 32'h00000000;
assign PRDATAS13_const_net_0      = 32'h00000000;
assign PRDATAS14_const_net_0      = 32'h00000000;
assign PRDATAS15_const_net_0      = 32'h00000000;
assign APB_I4_PRDATA_const_net_0  = 32'h00000000;
assign APB_I11_PRDATA_const_net_0 = 32'h00000000;
assign APB_I12_PRDATA_const_net_0 = 32'h00000000;
assign APB_I13_PRDATA_const_net_0 = 32'h00000000;
assign APB_I14_PRDATA_const_net_0 = 32'h00000000;
assign APB_I15_PRDATA_const_net_0 = 32'h00000000;
assign APB_T4_PADDR_const_net_0   = 32'h00000000;
assign APB_T4_PWDATA_const_net_0  = 32'h00000000;
assign APB_T11_PADDR_const_net_0  = 32'h00000000;
assign APB_T11_PWDATA_const_net_0 = 32'h00000000;
assign APB_T12_PADDR_const_net_0  = 32'h00000000;
assign APB_T12_PWDATA_const_net_0 = 32'h00000000;
assign APB_T13_PADDR_const_net_0  = 32'h00000000;
assign APB_T13_PWDATA_const_net_0 = 32'h00000000;
assign APB_T14_PADDR_const_net_0  = 32'h00000000;
assign APB_T14_PWDATA_const_net_0 = 32'h00000000;
assign APB_T15_PADDR_const_net_0  = 32'h00000000;
assign APB_T15_PWDATA_const_net_0 = 32'h00000000;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign PLIC_IRQ_net_1                 = PLIC_IRQ_net_0;
assign PLIC_IRQ                       = PLIC_IRQ_net_1;
assign GPIO_OUT_net_1                 = GPIO_OUT_net_0;
assign GPIO_OUT[7:0]                  = GPIO_OUT_net_1;
assign GPIO_INT_net_1                 = GPIO_INT_net_0;
assign GPIO_INT[7:0]                  = GPIO_INT_net_1;
assign GPIO_INT_OR_net_1              = GPIO_INT_OR_net_0;
assign GPIO_INT_OR                    = GPIO_INT_OR_net_1;
assign UART_TX_net_1                  = UART_TX_net_0;
assign UART_TX                        = UART_TX_net_1;
assign APB_0_mINITIATOR_PRDATA_net_0  = APB_0_mINITIATOR_PRDATA;
assign APB_T0_PRDATA[31:0]            = APB_0_mINITIATOR_PRDATA_net_0;
assign APB_0_mINITIATOR_PREADY_net_0  = APB_0_mINITIATOR_PREADY;
assign APB_T0_PREADY                  = APB_0_mINITIATOR_PREADY_net_0;
assign APB_0_mINITIATOR_PSLVERR_net_0 = APB_0_mINITIATOR_PSLVERR;
assign APB_T0_PSLVERR                 = APB_0_mINITIATOR_PSLVERR_net_0;
assign APB_3_mTARGET_PADDR_net_0      = APB_3_mTARGET_PADDR;
assign APB_I3_PADDR[31:0]             = APB_3_mTARGET_PADDR_net_0;
assign APB_3_mTARGET_PENABLE_net_0    = APB_3_mTARGET_PENABLE;
assign APB_I3_PENABLE                 = APB_3_mTARGET_PENABLE_net_0;
assign APB_3_mTARGET_PWRITE_net_0     = APB_3_mTARGET_PWRITE;
assign APB_I3_PWRITE                  = APB_3_mTARGET_PWRITE_net_0;
assign APB_3_mTARGET_PWDATA_net_0     = APB_3_mTARGET_PWDATA;
assign APB_I3_PWDATA[31:0]            = APB_3_mTARGET_PWDATA_net_0;
assign APB_3_mTARGET_PSELx_net_0      = APB_3_mTARGET_PSELx;
assign APB_I3_PSEL                    = APB_3_mTARGET_PSELx_net_0;
//--------------------------------------------------------------------
// Bus Interface Nets Assignments - Unequal Pin Widths
//--------------------------------------------------------------------
assign MIV_APB3_0_APBmslave0_PADDR_0 = { MIV_APB3_0_APBmslave0_PADDR_0_4to0 };
assign MIV_APB3_0_APBmslave0_PADDR_0_4to0 = MIV_APB3_0_APBmslave0_PADDR[4:0];
assign MIV_APB3_0_APBmslave0_PADDR_1 = { MIV_APB3_0_APBmslave0_PADDR_1_7to0 };
assign MIV_APB3_0_APBmslave0_PADDR_1_7to0 = MIV_APB3_0_APBmslave0_PADDR[7:0];

assign MIV_APB3_0_APBmslave0_PWDATA_0 = { MIV_APB3_0_APBmslave0_PWDATA_0_7to0 };
assign MIV_APB3_0_APBmslave0_PWDATA_0_7to0 = MIV_APB3_0_APBmslave0_PWDATA[7:0];

assign MIV_APB3_0_APBmslave1_PRDATA_0 = { MIV_APB3_0_APBmslave1_PRDATA_0_31to8, MIV_APB3_0_APBmslave1_PRDATA_0_7to0 };
assign MIV_APB3_0_APBmslave1_PRDATA_0_31to8 = 24'h0;
assign MIV_APB3_0_APBmslave1_PRDATA_0_7to0 = MIV_APB3_0_APBmslave1_PRDATA[7:0];

//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------MIV_ESS_C0_CoreGPIO_0_CoreGPIO   -   Actel:DirectCore:CoreGPIO:3.2.102
MIV_ESS_C0_CoreGPIO_0_CoreGPIO #( 
        .APB_WIDTH       ( 32 ),
        .FIXED_CONFIG_0  ( 1 ),
        .FIXED_CONFIG_1  ( 1 ),
        .FIXED_CONFIG_2  ( 1 ),
        .FIXED_CONFIG_3  ( 1 ),
        .FIXED_CONFIG_4  ( 1 ),
        .FIXED_CONFIG_5  ( 1 ),
        .FIXED_CONFIG_6  ( 1 ),
        .FIXED_CONFIG_7  ( 1 ),
        .FIXED_CONFIG_8  ( 0 ),
        .FIXED_CONFIG_9  ( 0 ),
        .FIXED_CONFIG_10 ( 0 ),
        .FIXED_CONFIG_11 ( 0 ),
        .FIXED_CONFIG_12 ( 0 ),
        .FIXED_CONFIG_13 ( 0 ),
        .FIXED_CONFIG_14 ( 0 ),
        .FIXED_CONFIG_15 ( 0 ),
        .FIXED_CONFIG_16 ( 0 ),
        .FIXED_CONFIG_17 ( 0 ),
        .FIXED_CONFIG_18 ( 0 ),
        .FIXED_CONFIG_19 ( 0 ),
        .FIXED_CONFIG_20 ( 0 ),
        .FIXED_CONFIG_21 ( 0 ),
        .FIXED_CONFIG_22 ( 0 ),
        .FIXED_CONFIG_23 ( 0 ),
        .FIXED_CONFIG_24 ( 0 ),
        .FIXED_CONFIG_25 ( 0 ),
        .FIXED_CONFIG_26 ( 0 ),
        .FIXED_CONFIG_27 ( 0 ),
        .FIXED_CONFIG_28 ( 0 ),
        .FIXED_CONFIG_29 ( 0 ),
        .FIXED_CONFIG_30 ( 0 ),
        .FIXED_CONFIG_31 ( 0 ),
        .INT_BUS         ( 1 ),
        .IO_INT_TYPE_0   ( 7 ),
        .IO_INT_TYPE_1   ( 7 ),
        .IO_INT_TYPE_2   ( 3 ),
        .IO_INT_TYPE_3   ( 2 ),
        .IO_INT_TYPE_4   ( 7 ),
        .IO_INT_TYPE_5   ( 7 ),
        .IO_INT_TYPE_6   ( 7 ),
        .IO_INT_TYPE_7   ( 7 ),
        .IO_INT_TYPE_8   ( 7 ),
        .IO_INT_TYPE_9   ( 7 ),
        .IO_INT_TYPE_10  ( 7 ),
        .IO_INT_TYPE_11  ( 7 ),
        .IO_INT_TYPE_12  ( 7 ),
        .IO_INT_TYPE_13  ( 7 ),
        .IO_INT_TYPE_14  ( 7 ),
        .IO_INT_TYPE_15  ( 7 ),
        .IO_INT_TYPE_16  ( 7 ),
        .IO_INT_TYPE_17  ( 7 ),
        .IO_INT_TYPE_18  ( 7 ),
        .IO_INT_TYPE_19  ( 7 ),
        .IO_INT_TYPE_20  ( 7 ),
        .IO_INT_TYPE_21  ( 7 ),
        .IO_INT_TYPE_22  ( 7 ),
        .IO_INT_TYPE_23  ( 7 ),
        .IO_INT_TYPE_24  ( 7 ),
        .IO_INT_TYPE_25  ( 7 ),
        .IO_INT_TYPE_26  ( 7 ),
        .IO_INT_TYPE_27  ( 7 ),
        .IO_INT_TYPE_28  ( 7 ),
        .IO_INT_TYPE_29  ( 7 ),
        .IO_INT_TYPE_30  ( 7 ),
        .IO_INT_TYPE_31  ( 7 ),
        .IO_NUM          ( 8 ),
        .IO_TYPE_0       ( 2 ),
        .IO_TYPE_1       ( 2 ),
        .IO_TYPE_2       ( 2 ),
        .IO_TYPE_3       ( 2 ),
        .IO_TYPE_4       ( 1 ),
        .IO_TYPE_5       ( 1 ),
        .IO_TYPE_6       ( 0 ),
        .IO_TYPE_7       ( 0 ),
        .IO_TYPE_8       ( 0 ),
        .IO_TYPE_9       ( 0 ),
        .IO_TYPE_10      ( 0 ),
        .IO_TYPE_11      ( 0 ),
        .IO_TYPE_12      ( 0 ),
        .IO_TYPE_13      ( 0 ),
        .IO_TYPE_14      ( 0 ),
        .IO_TYPE_15      ( 0 ),
        .IO_TYPE_16      ( 0 ),
        .IO_TYPE_17      ( 0 ),
        .IO_TYPE_18      ( 0 ),
        .IO_TYPE_19      ( 0 ),
        .IO_TYPE_20      ( 0 ),
        .IO_TYPE_21      ( 0 ),
        .IO_TYPE_22      ( 0 ),
        .IO_TYPE_23      ( 0 ),
        .IO_TYPE_24      ( 0 ),
        .IO_TYPE_25      ( 0 ),
        .IO_TYPE_26      ( 0 ),
        .IO_TYPE_27      ( 0 ),
        .IO_TYPE_28      ( 0 ),
        .IO_TYPE_29      ( 0 ),
        .IO_TYPE_30      ( 0 ),
        .IO_TYPE_31      ( 0 ),
        .IO_VAL_0        ( 0 ),
        .IO_VAL_1        ( 0 ),
        .IO_VAL_2        ( 0 ),
        .IO_VAL_3        ( 0 ),
        .IO_VAL_4        ( 0 ),
        .IO_VAL_5        ( 0 ),
        .IO_VAL_6        ( 0 ),
        .IO_VAL_7        ( 0 ),
        .IO_VAL_8        ( 0 ),
        .IO_VAL_9        ( 0 ),
        .IO_VAL_10       ( 0 ),
        .IO_VAL_11       ( 0 ),
        .IO_VAL_12       ( 0 ),
        .IO_VAL_13       ( 0 ),
        .IO_VAL_14       ( 0 ),
        .IO_VAL_15       ( 0 ),
        .IO_VAL_16       ( 0 ),
        .IO_VAL_17       ( 0 ),
        .IO_VAL_18       ( 0 ),
        .IO_VAL_19       ( 0 ),
        .IO_VAL_20       ( 0 ),
        .IO_VAL_21       ( 0 ),
        .IO_VAL_22       ( 0 ),
        .IO_VAL_23       ( 0 ),
        .IO_VAL_24       ( 0 ),
        .IO_VAL_25       ( 0 ),
        .IO_VAL_26       ( 0 ),
        .IO_VAL_27       ( 0 ),
        .IO_VAL_28       ( 0 ),
        .IO_VAL_29       ( 0 ),
        .IO_VAL_30       ( 0 ),
        .IO_VAL_31       ( 0 ),
        .OE_TYPE         ( 1 ) )
CoreGPIO_0(
        // Inputs
        .PRESETN  ( MIV_ESS_RESET_CTRL_0_ESS_SYS_RESETN ),
        .PCLK     ( PCLK ),
        .PSEL     ( MIV_APB3_0_APBmslave5_PSELx ),
        .PENABLE  ( MIV_APB3_0_APBmslave0_PENABLE ),
        .PWRITE   ( MIV_APB3_0_APBmslave0_PWRITE ),
        .PADDR    ( MIV_APB3_0_APBmslave0_PADDR_1 ),
        .PWDATA   ( MIV_APB3_0_APBmslave0_PWDATA ),
        .GPIO_IN  ( GPIO_IN ),
        // Outputs
        .PSLVERR  ( MIV_APB3_0_APBmslave5_PSLVERR ),
        .PREADY   ( MIV_APB3_0_APBmslave5_PREADY ),
        .PRDATA   ( MIV_APB3_0_APBmslave5_PRDATA ),
        .INT      ( GPIO_INT_net_0 ),
        .INT_OR   ( GPIO_INT_OR_net_0 ),
        .GPIO_OUT ( GPIO_OUT_net_0 ),
        .GPIO_OE  (  ) 
        );

//--------MIV_ESS_C0_CoreUARTapb_0_CoreUARTapb   -   Actel:DirectCore:CoreUARTapb:5.7.100
MIV_ESS_C0_CoreUARTapb_0_CoreUARTapb #( 
        .BAUD_VAL_FRCTN    ( 0 ),
        .BAUD_VAL_FRCTN_EN ( 0 ),
        .BAUD_VALUE        ( 1 ),
        .FAMILY            ( 26 ),
        .FIXEDMODE         ( 0 ),
        .PRG_BIT8          ( 1 ),
        .PRG_PARITY        ( 0 ),
        .RX_FIFO           ( 0 ),
        .RX_LEGACY_MODE    ( 0 ),
        .TX_FIFO           ( 0 ) )
CoreUARTapb_0(
        // Inputs
        .PCLK        ( PCLK ),
        .PRESETN     ( MIV_ESS_RESET_CTRL_0_ESS_SYS_RESETN ),
        .PADDR       ( MIV_APB3_0_APBmslave0_PADDR_0 ),
        .PSEL        ( MIV_APB3_0_APBmslave1_PSELx ),
        .PENABLE     ( MIV_APB3_0_APBmslave0_PENABLE ),
        .PWRITE      ( MIV_APB3_0_APBmslave0_PWRITE ),
        .PWDATA      ( MIV_APB3_0_APBmslave0_PWDATA_0 ),
        .RX          ( UART_RX ),
        // Outputs
        .PRDATA      ( MIV_APB3_0_APBmslave1_PRDATA ),
        .TXRDY       (  ),
        .RXRDY       (  ),
        .PARITY_ERR  (  ),
        .OVERFLOW    (  ),
        .TX          ( UART_TX_net_0 ),
        .PREADY      ( MIV_APB3_0_APBmslave1_PREADY ),
        .PSLVERR     ( MIV_APB3_0_APBmslave1_PSLVERR ),
        .FRAMING_ERR (  ) 
        );

//--------MIV_APB3   -   Microchip:MiV:MIV_APB3:2.0.100
MIV_APB3 #( 
        .APBSLOT0ENABLE  ( 1 ),
        .APBSLOT1ENABLE  ( 1 ),
        .APBSLOT2ENABLE  ( 1 ),
        .APBSLOT3ENABLE  ( 1 ),
        .APBSLOT4ENABLE  ( 0 ),
        .APBSLOT5ENABLE  ( 1 ),
        .APBSLOT6ENABLE  ( 1 ),
        .APBSLOT7ENABLE  ( 0 ),
        .APBSLOT8ENABLE  ( 1 ),
        .APBSLOT9ENABLE  ( 1 ),
        .APBSLOT10ENABLE ( 1 ),
        .APBSLOT11ENABLE ( 0 ),
        .APBSLOT12ENABLE ( 0 ),
        .APBSLOT13ENABLE ( 0 ),
        .APBSLOT14ENABLE ( 0 ),
        .APBSLOT15ENABLE ( 0 ),
        .FAMILY          ( 26 ) )
MIV_APB3_0(
        // Inputs
        .PADDR      ( MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PADDR ),
        .PWRITE     ( MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PWRITE ),
        .PENABLE    ( MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PENABLE ),
        .PWDATA     ( MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PWDATA ),
        .PSEL       ( MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PSELx ),
        .PRDATAS0   ( MIV_APB3_0_APBmslave0_PRDATA ),
        .PREADYS0   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS0  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS1   ( MIV_APB3_0_APBmslave1_PRDATA_0 ),
        .PREADYS1   ( MIV_APB3_0_APBmslave1_PREADY ),
        .PSLVERRS1  ( MIV_APB3_0_APBmslave1_PSLVERR ),
        .PRDATAS2   ( PRDATAS2_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS2   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS2  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS3   ( MIV_APB3_0_APBmslave3_PRDATA ),
        .PREADYS3   ( MIV_APB3_0_APBmslave3_PREADY ),
        .PSLVERRS3  ( MIV_APB3_0_APBmslave3_PSLVERR ),
        .PRDATAS4   ( PRDATAS4_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS4   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS4  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS5   ( MIV_APB3_0_APBmslave5_PRDATA ),
        .PREADYS5   ( MIV_APB3_0_APBmslave5_PREADY ),
        .PSLVERRS5  ( MIV_APB3_0_APBmslave5_PSLVERR ),
        .PRDATAS6   ( PRDATAS6_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS6   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS6  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS7   ( PRDATAS7_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS7   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS7  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS8   ( PRDATAS8_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS8   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS8  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS9   ( PRDATAS9_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS9   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS9  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS10  ( PRDATAS10_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS10  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS10 ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS11  ( PRDATAS11_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS11  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS11 ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS12  ( PRDATAS12_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS12  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS12 ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS13  ( PRDATAS13_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS13  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS13 ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS14  ( PRDATAS14_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS14  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS14 ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS15  ( PRDATAS15_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS15  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS15 ( GND_net ), // tied to 1'b0 from definition
        // Outputs
        .PRDATA     ( MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PRDATA ),
        .PREADY     ( MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PREADY ),
        .PSLVERR    ( MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PSLVERR ),
        .PADDRS     ( MIV_APB3_0_APBmslave0_PADDR ),
        .PWRITES    ( MIV_APB3_0_APBmslave0_PWRITE ),
        .PENABLES   ( MIV_APB3_0_APBmslave0_PENABLE ),
        .PWDATAS    ( MIV_APB3_0_APBmslave0_PWDATA ),
        .PSELS0     ( MIV_APB3_0_APBmslave0_PSELx ),
        .PSELS1     ( MIV_APB3_0_APBmslave1_PSELx ),
        .PSELS2     (  ),
        .PSELS3     ( MIV_APB3_0_APBmslave3_PSELx ),
        .PSELS4     (  ),
        .PSELS5     ( MIV_APB3_0_APBmslave5_PSELx ),
        .PSELS6     (  ),
        .PSELS7     (  ),
        .PSELS8     (  ),
        .PSELS9     (  ),
        .PSELS10    (  ),
        .PSELS11    (  ),
        .PSELS12    (  ),
        .PSELS13    (  ),
        .PSELS14    (  ),
        .PSELS15    (  ) 
        );

//--------MIV_ESS_APB_TO_APB   -   Microchip:MiV:MIV_ESS_APB_TO_APB:2.0.100
MIV_ESS_APB_TO_APB #( 
        .APB_INITIATOR_0_MIRROR  ( 1 ),
        .APB_INITIATOR_3_MIRROR  ( 0 ),
        .APB_INITIATOR_4_MIRROR  ( 0 ),
        .APB_INITIATOR_11_MIRROR ( 0 ),
        .APB_INITIATOR_12_MIRROR ( 0 ),
        .APB_INITIATOR_13_MIRROR ( 0 ),
        .APB_INITIATOR_14_MIRROR ( 0 ),
        .APB_INITIATOR_15_MIRROR ( 0 ),
        .APB_TARGET_0_MIRROR     ( 0 ),
        .APB_TARGET_3_MIRROR     ( 1 ),
        .APB_TARGET_4_MIRROR     ( 1 ),
        .APB_TARGET_11_MIRROR    ( 1 ),
        .APB_TARGET_12_MIRROR    ( 1 ),
        .APB_TARGET_13_MIRROR    ( 1 ),
        .APB_TARGET_14_MIRROR    ( 1 ),
        .APB_TARGET_15_MIRROR    ( 1 ) )
MIV_ESS_APB_TO_APB_0(
        // Inputs
        .APB_I0_PRDATA   ( MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PRDATA ),
        .APB_I3_PRDATA   ( APB_I3_PRDATA ),
        .APB_I4_PRDATA   ( APB_I4_PRDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_I11_PRDATA  ( APB_I11_PRDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_I12_PRDATA  ( APB_I12_PRDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_I13_PRDATA  ( APB_I13_PRDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_I15_PRDATA  ( APB_I15_PRDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_I0_PREADY   ( MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PREADY ),
        .APB_I3_PREADY   ( APB_I3_PREADY ),
        .APB_I4_PREADY   ( VCC_net ), // tied to 1'b1 from definition
        .APB_I11_PREADY  ( VCC_net ), // tied to 1'b1 from definition
        .APB_I12_PREADY  ( VCC_net ), // tied to 1'b1 from definition
        .APB_I13_PREADY  ( VCC_net ), // tied to 1'b1 from definition
        .APB_I15_PREADY  ( VCC_net ), // tied to 1'b1 from definition
        .APB_I0_PSLVERR  ( MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PSLVERR ),
        .APB_I3_PSLVERR  ( APB_I3_PSLVERR ),
        .APB_I4_PSLVERR  ( GND_net ), // tied to 1'b0 from definition
        .APB_I11_PSLVERR ( GND_net ), // tied to 1'b0 from definition
        .APB_I12_PSLVERR ( GND_net ), // tied to 1'b0 from definition
        .APB_I13_PSLVERR ( GND_net ), // tied to 1'b0 from definition
        .APB_I15_PSLVERR ( GND_net ), // tied to 1'b0 from definition
        .APB_T0_PADDR    ( APB_T0_PADDR ),
        .APB_T3_PADDR    ( MIV_APB3_0_APBmslave0_PADDR ),
        .APB_T4_PADDR    ( APB_T4_PADDR_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_T11_PADDR   ( APB_T11_PADDR_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_T14_PADDR   ( APB_T14_PADDR_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_T13_PADDR   ( APB_T13_PADDR_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_T15_PADDR   ( APB_T15_PADDR_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_T0_PWRITE   ( APB_T0_PWRITE ),
        .APB_T3_PWRITE   ( MIV_APB3_0_APBmslave0_PWRITE ),
        .APB_T4_PWRITE   ( GND_net ), // tied to 1'b0 from definition
        .APB_T11_PWRITE  ( GND_net ), // tied to 1'b0 from definition
        .APB_T14_PWRITE  ( GND_net ), // tied to 1'b0 from definition
        .APB_T13_PWRITE  ( GND_net ), // tied to 1'b0 from definition
        .APB_T15_PWRITE  ( GND_net ), // tied to 1'b0 from definition
        .APB_T0_PENABLE  ( APB_T0_PENABLE ),
        .APB_T3_PENABLE  ( MIV_APB3_0_APBmslave0_PENABLE ),
        .APB_T4_PENABLE  ( GND_net ), // tied to 1'b0 from definition
        .APB_T11_PENABLE ( GND_net ), // tied to 1'b0 from definition
        .APB_T14_PENABLE ( GND_net ), // tied to 1'b0 from definition
        .APB_T13_PENABLE ( GND_net ), // tied to 1'b0 from definition
        .APB_T15_PENABLE ( GND_net ), // tied to 1'b0 from definition
        .APB_T0_PWDATA   ( APB_T0_PWDATA ),
        .APB_T3_PWDATA   ( MIV_APB3_0_APBmslave0_PWDATA ),
        .APB_T4_PWDATA   ( APB_T4_PWDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_T11_PWDATA  ( APB_T11_PWDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_T14_PWDATA  ( APB_T14_PWDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_T13_PWDATA  ( APB_T13_PWDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_T15_PWDATA  ( APB_T15_PWDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_T0_PSEL     ( APB_T0_PSEL ),
        .APB_T3_PSEL     ( MIV_APB3_0_APBmslave3_PSELx ),
        .APB_T4_PSEL     ( GND_net ), // tied to 1'b0 from definition
        .APB_T11_PSEL    ( GND_net ), // tied to 1'b0 from definition
        .APB_T14_PSEL    ( GND_net ), // tied to 1'b0 from definition
        .APB_T13_PSEL    ( GND_net ), // tied to 1'b0 from definition
        .APB_T15_PSEL    ( GND_net ), // tied to 1'b0 from definition
        .APB_I14_PRDATA  ( APB_I14_PRDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_I14_PREADY  ( VCC_net ), // tied to 1'b1 from definition
        .APB_I14_PSLVERR ( GND_net ), // tied to 1'b0 from definition
        .APB_T12_PADDR   ( APB_T12_PADDR_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_T12_PWRITE  ( GND_net ), // tied to 1'b0 from definition
        .APB_T12_PENABLE ( GND_net ), // tied to 1'b0 from definition
        .APB_T12_PWDATA  ( APB_T12_PWDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .APB_T12_PSEL    ( GND_net ), // tied to 1'b0 from definition
        // Outputs
        .APB_I0_PADDR    ( MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PADDR ),
        .APB_I3_PADDR    ( APB_3_mTARGET_PADDR ),
        .APB_I4_PADDR    (  ),
        .APB_I11_PADDR   (  ),
        .APB_I12_PADDR   (  ),
        .APB_I13_PADDR   (  ),
        .APB_I15_PADDR   (  ),
        .APB_I0_PWRITE   ( MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PWRITE ),
        .APB_I3_PWRITE   ( APB_3_mTARGET_PWRITE ),
        .APB_I4_PWRITE   (  ),
        .APB_I11_PWRITE  (  ),
        .APB_I12_PWRITE  (  ),
        .APB_I13_PWRITE  (  ),
        .APB_I15_PWRITE  (  ),
        .APB_I0_PENABLE  ( MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PENABLE ),
        .APB_I3_PENABLE  ( APB_3_mTARGET_PENABLE ),
        .APB_I4_PENABLE  (  ),
        .APB_I11_PENABLE (  ),
        .APB_I12_PENABLE (  ),
        .APB_I13_PENABLE (  ),
        .APB_I15_PENABLE (  ),
        .APB_I0_PSEL     ( MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PSELx ),
        .APB_I3_PSEL     ( APB_3_mTARGET_PSELx ),
        .APB_I4_PSEL     (  ),
        .APB_I11_PSEL    (  ),
        .APB_I12_PSEL    (  ),
        .APB_I13_PSEL    (  ),
        .APB_I15_PSEL    (  ),
        .APB_I0_PWDATA   ( MIV_ESS_APB_TO_APB_0_APB_0_INITIATOR_PWDATA ),
        .APB_I3_PWDATA   ( APB_3_mTARGET_PWDATA ),
        .APB_I4_PWDATA   (  ),
        .APB_I11_PWDATA  (  ),
        .APB_I12_PWDATA  (  ),
        .APB_I13_PWDATA  (  ),
        .APB_I15_PWDATA  (  ),
        .APB_T0_PRDATA   ( APB_0_mINITIATOR_PRDATA ),
        .APB_T3_PRDATA   ( MIV_APB3_0_APBmslave3_PRDATA ),
        .APB_T4_PRDATA   (  ),
        .APB_T11_PRDATA  (  ),
        .APB_T14_PRDATA  (  ),
        .APB_T13_PRDATA  (  ),
        .APB_T15_PRDATA  (  ),
        .APB_T0_PREADY   ( APB_0_mINITIATOR_PREADY ),
        .APB_T3_PREADY   ( MIV_APB3_0_APBmslave3_PREADY ),
        .APB_T4_PREADY   (  ),
        .APB_T11_PREADY  (  ),
        .APB_T14_PREADY  (  ),
        .APB_T13_PREADY  (  ),
        .APB_T15_PREADY  (  ),
        .APB_T0_PSLVERR  ( APB_0_mINITIATOR_PSLVERR ),
        .APB_T3_PSLVERR  ( MIV_APB3_0_APBmslave3_PSLVERR ),
        .APB_T4_PSLVERR  (  ),
        .APB_T11_PSLVERR (  ),
        .APB_T14_PSLVERR (  ),
        .APB_T13_PSLVERR (  ),
        .APB_T15_PSLVERR (  ),
        .APB_I14_PADDR   (  ),
        .APB_I14_PWRITE  (  ),
        .APB_I14_PENABLE (  ),
        .APB_I14_PSEL    (  ),
        .APB_I14_PWDATA  (  ),
        .APB_T12_PRDATA  (  ),
        .APB_T12_PREADY  (  ),
        .APB_T12_PSLVERR (  ) 
        );

//--------MIV_ESS_RESET_CTRL   -   Microchip:MiV:MIV_ESS_RESET_CTRL:2.0.101
MIV_ESS_RESET_CTRL #( 
        .FAMILY           ( 26 ),
        .RST_POR_DURATION ( 32768 ) )
MIV_ESS_RESET_CTRL_0(
        // Inputs
        .PCLK            ( PCLK ),
        .ESS_RESETN      ( PRESETN ),
        .ESS_RESET_REQ_0 ( GND_net ),
        .ESS_RESET_REQ_1 ( GND_net ),
        // Outputs
        .ESS_GEN_RESETN  (  ),
        .ESS_SYS_RESETN  ( MIV_ESS_RESET_CTRL_0_ESS_SYS_RESETN ) 
        );

//--------MIV_PLIC   -   Microchip:MiV:MIV_PLIC:2.0.100
MIV_PLIC #( 
        .FAMILY      ( 26 ),
        .NUM_OF_INTS ( 2 ) )
MIV_PLIC_0(
        // Inputs
        .SRC_IRQ        ( PLIC_SRC_IRQ ),
        .TARGET_PCLK    ( PCLK ),
        .TARGET_PRESETn ( MIV_ESS_RESET_CTRL_0_ESS_SYS_RESETN ),
        .TARGET_PENABLE ( MIV_APB3_0_APBmslave0_PENABLE ),
        .TARGET_PSEL    ( MIV_APB3_0_APBmslave0_PSELx ),
        .TARGET_PADDR   ( MIV_APB3_0_APBmslave0_PADDR ),
        .TARGET_PWRITE  ( MIV_APB3_0_APBmslave0_PWRITE ),
        .TARGET_PWDATA  ( MIV_APB3_0_APBmslave0_PWDATA ),
        // Outputs
        .PLIC_IRQ       ( PLIC_IRQ_net_0 ),
        .TARGET_PRDATA  ( MIV_APB3_0_APBmslave0_PRDATA ) 
        );


endmodule
