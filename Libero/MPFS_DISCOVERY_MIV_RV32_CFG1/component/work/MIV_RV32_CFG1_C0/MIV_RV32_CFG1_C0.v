//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Fri Jan 16 18:22:43 2026
// Version: 2025.2 2025.2.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of MIV_RV32_CFG1_C0 to TCL
# Family: PolarFireSoC
# Part Number: MPFS095T-1FCSG325E
# Create and Configure the core component MIV_RV32_CFG1_C0
create_and_configure_core -core_vlnv {Microsemi:MiV:MIV_RV32:3.1.200} -component_name {MIV_RV32_CFG1_C0} -params {\
"AHB_END_ADDR_0:0xffff"  \
"AHB_END_ADDR_1:0x8fff"  \
"AHB_INITIATOR_TYPE:1"  \
"AHB_START_ADDR_0:0x0"  \
"AHB_START_ADDR_1:0x8000"  \
"AHB_TARGET_MIRROR:true"  \
"APB_END_ADDR_0:0xffff"  \
"APB_END_ADDR_1:0x7fff"  \
"APB_INITIATOR_TYPE:1"  \
"APB_START_ADDR_0:0x0"  \
"APB_START_ADDR_1:0x7000"  \
"APB_TARGET_MIRROR:false"  \
"AXI_END_ADDR_0:0xffff"  \
"AXI_END_ADDR_1:0x6fff"  \
"AXI_INITIATOR_TYPE:0"  \
"AXI_START_ADDR_0:0x0"  \
"AXI_START_ADDR_1:0x6000"  \
"AXI_TARGET_MIRROR:false"  \
"BOOTROM_DEST_ADDR_LOWER:0x0"  \
"BOOTROM_DEST_ADDR_UPPER:0x4000"  \
"BOOTROM_PRESENT:false"  \
"BOOTROM_SRC_END_ADDR_LOWER:0x3fff"  \
"BOOTROM_SRC_END_ADDR_UPPER:0x8000"  \
"BOOTROM_SRC_START_ADDR_LOWER:0x0"  \
"BOOTROM_SRC_START_ADDR_UPPER:0x8000"  \
"C_EXT:true"  \
"DEBUGGER:true"  \
"ECC_ENABLE:false"  \
"F_EXT:false"  \
"FWD_REGS:false"  \
"GEN_MUL_TYPE:2"  \
"GPR_REGS:false"  \
"I_REGS:false"  \
"I_TRACE:false"  \
"ICACHE_EN:false"  \
"INTERNAL_MTIME:true"  \
"INTERNAL_MTIME_IRQ:true"  \
"M_EXT:true"  \
"MI_I_MEM:false"  \
"MIV_HART_ID:0x0"  \
"MTIME_PRESCALER:100"  \
"NO_MACC_BLK:false"  \
"NUM_EXT_IRQS:1"  \
"RECONFIG_BOOTROM:false"  \
"RESET_VECTOR_ADDR_0:0x0"  \
"RESET_VECTOR_ADDR_1:0x8000"  \
"TAS_END_ADDR_0:0x3fff"  \
"TAS_END_ADDR_1:0x4000"  \
"TAS_START_ADDR_0:0x0"  \
"TAS_START_ADDR_1:0x4000"  \
"TCM_END_ADDR_0:0x7fff"  \
"TCM_END_ADDR_1:0x4000"  \
"TCM_PRESENT:true"  \
"TCM_REGS:false"  \
"TCM_START_ADDR_0:0x0"  \
"TCM_START_ADDR_1:0x4000"  \
"TCM_TAS_PRESENT:false"  \
"VECTORED_INTERRUPTS:false"   }
# Exporting Component Description of MIV_RV32_CFG1_C0 to TCL done
*/

// MIV_RV32_CFG1_C0
module MIV_RV32_CFG1_C0(
    // Inputs
    AHB_HRDATA,
    AHB_HREADY,
    AHB_HRESP,
    APB_PRDATA,
    APB_PREADY,
    APB_PSLVERR,
    CLK,
    EXT_IRQ,
    JTAG_TCK,
    JTAG_TDI,
    JTAG_TMS,
    JTAG_TRSTN,
    MSYS_EI,
    RESETN,
    // Outputs
    AHB_HADDR,
    AHB_HBURST,
    AHB_HMASTLOCK,
    AHB_HPROT,
    AHB_HSEL,
    AHB_HSIZE,
    AHB_HTRANS,
    AHB_HWDATA,
    AHB_HWRITE,
    APB_PADDR,
    APB_PENABLE,
    APB_PSEL,
    APB_PWDATA,
    APB_PWRITE,
    EXT_RESETN,
    JTAG_TDO,
    JTAG_TDO_DR,
    TIME_COUNT_OUT
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [31:0] AHB_HRDATA;
input         AHB_HREADY;
input         AHB_HRESP;
input  [31:0] APB_PRDATA;
input         APB_PREADY;
input         APB_PSLVERR;
input         CLK;
input         EXT_IRQ;
input         JTAG_TCK;
input         JTAG_TDI;
input         JTAG_TMS;
input         JTAG_TRSTN;
input  [0:0]  MSYS_EI;
input         RESETN;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] AHB_HADDR;
output [2:0]  AHB_HBURST;
output        AHB_HMASTLOCK;
output [3:0]  AHB_HPROT;
output        AHB_HSEL;
output [2:0]  AHB_HSIZE;
output [1:0]  AHB_HTRANS;
output [31:0] AHB_HWDATA;
output        AHB_HWRITE;
output [31:0] APB_PADDR;
output        APB_PENABLE;
output        APB_PSEL;
output [31:0] APB_PWDATA;
output        APB_PWRITE;
output        EXT_RESETN;
output        JTAG_TDO;
output        JTAG_TDO_DR;
output [63:0] TIME_COUNT_OUT;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [31:0] AHBL_M_TARGET_HADDR;
wire   [2:0]  AHBL_M_TARGET_HBURST;
wire          AHBL_M_TARGET_HMASTLOCK;
wire   [3:0]  AHBL_M_TARGET_HPROT;
wire   [31:0] AHB_HRDATA;
wire          AHB_HREADY;
wire          AHB_HRESP;
wire          AHBL_M_TARGET_HSELx;
wire   [2:0]  AHBL_M_TARGET_HSIZE;
wire   [1:0]  AHBL_M_TARGET_HTRANS;
wire   [31:0] AHBL_M_TARGET_HWDATA;
wire          AHBL_M_TARGET_HWRITE;
wire   [31:0] APB_INITIATOR_PADDR;
wire          APB_INITIATOR_PENABLE;
wire   [31:0] APB_PRDATA;
wire          APB_PREADY;
wire          APB_INITIATOR_PSELx;
wire          APB_PSLVERR;
wire   [31:0] APB_INITIATOR_PWDATA;
wire          APB_INITIATOR_PWRITE;
wire          CLK;
wire          EXT_IRQ;
wire          EXT_RESETN_net_0;
wire          JTAG_TCK;
wire          JTAG_TDI;
wire          JTAG_TDO_net_0;
wire          JTAG_TDO_DR_net_0;
wire          JTAG_TMS;
wire          JTAG_TRSTN;
wire   [0:0]  MSYS_EI;
wire          RESETN;
wire   [63:0] TIME_COUNT_OUT_net_0;
wire          EXT_RESETN_net_1;
wire   [63:0] TIME_COUNT_OUT_net_1;
wire   [31:0] APB_INITIATOR_PADDR_net_0;
wire          APB_INITIATOR_PENABLE_net_0;
wire          APB_INITIATOR_PWRITE_net_0;
wire   [31:0] APB_INITIATOR_PWDATA_net_0;
wire          APB_INITIATOR_PSELx_net_0;
wire   [31:0] AHBL_M_TARGET_HADDR_net_0;
wire   [1:0]  AHBL_M_TARGET_HTRANS_net_0;
wire          AHBL_M_TARGET_HWRITE_net_0;
wire   [2:0]  AHBL_M_TARGET_HSIZE_net_0;
wire   [2:0]  AHBL_M_TARGET_HBURST_net_0;
wire   [3:0]  AHBL_M_TARGET_HPROT_net_0;
wire   [31:0] AHBL_M_TARGET_HWDATA_net_0;
wire          AHBL_M_TARGET_HMASTLOCK_net_0;
wire          AHBL_M_TARGET_HSELx_net_0;
wire          JTAG_TDO_net_1;
wire          JTAG_TDO_DR_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
wire          VCC_net;
wire   [63:0] TIME_COUNT_IN_const_net_0;
wire   [1:0]  AXI_BRESP_const_net_0;
wire   [31:0] AXI_RDATA_const_net_0;
wire   [1:0]  AXI_RRESP_const_net_0;
wire   [31:0] TAS_PADDR_const_net_0;
wire   [31:0] TAS_PWDATA_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net                   = 1'b0;
assign VCC_net                   = 1'b1;
assign TIME_COUNT_IN_const_net_0 = 64'h0000000000000000;
assign AXI_BRESP_const_net_0     = 2'h0;
assign AXI_RDATA_const_net_0     = 32'h00000000;
assign AXI_RRESP_const_net_0     = 2'h0;
assign TAS_PADDR_const_net_0     = 32'h00000000;
assign TAS_PWDATA_const_net_0    = 32'h00000000;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign EXT_RESETN_net_1              = EXT_RESETN_net_0;
assign EXT_RESETN                    = EXT_RESETN_net_1;
assign TIME_COUNT_OUT_net_1          = TIME_COUNT_OUT_net_0;
assign TIME_COUNT_OUT[63:0]          = TIME_COUNT_OUT_net_1;
assign APB_INITIATOR_PADDR_net_0     = APB_INITIATOR_PADDR;
assign APB_PADDR[31:0]               = APB_INITIATOR_PADDR_net_0;
assign APB_INITIATOR_PENABLE_net_0   = APB_INITIATOR_PENABLE;
assign APB_PENABLE                   = APB_INITIATOR_PENABLE_net_0;
assign APB_INITIATOR_PWRITE_net_0    = APB_INITIATOR_PWRITE;
assign APB_PWRITE                    = APB_INITIATOR_PWRITE_net_0;
assign APB_INITIATOR_PWDATA_net_0    = APB_INITIATOR_PWDATA;
assign APB_PWDATA[31:0]              = APB_INITIATOR_PWDATA_net_0;
assign APB_INITIATOR_PSELx_net_0     = APB_INITIATOR_PSELx;
assign APB_PSEL                      = APB_INITIATOR_PSELx_net_0;
assign AHBL_M_TARGET_HADDR_net_0     = AHBL_M_TARGET_HADDR;
assign AHB_HADDR[31:0]               = AHBL_M_TARGET_HADDR_net_0;
assign AHBL_M_TARGET_HTRANS_net_0    = AHBL_M_TARGET_HTRANS;
assign AHB_HTRANS[1:0]               = AHBL_M_TARGET_HTRANS_net_0;
assign AHBL_M_TARGET_HWRITE_net_0    = AHBL_M_TARGET_HWRITE;
assign AHB_HWRITE                    = AHBL_M_TARGET_HWRITE_net_0;
assign AHBL_M_TARGET_HSIZE_net_0     = AHBL_M_TARGET_HSIZE;
assign AHB_HSIZE[2:0]                = AHBL_M_TARGET_HSIZE_net_0;
assign AHBL_M_TARGET_HBURST_net_0    = AHBL_M_TARGET_HBURST;
assign AHB_HBURST[2:0]               = AHBL_M_TARGET_HBURST_net_0;
assign AHBL_M_TARGET_HPROT_net_0     = AHBL_M_TARGET_HPROT;
assign AHB_HPROT[3:0]                = AHBL_M_TARGET_HPROT_net_0;
assign AHBL_M_TARGET_HWDATA_net_0    = AHBL_M_TARGET_HWDATA;
assign AHB_HWDATA[31:0]              = AHBL_M_TARGET_HWDATA_net_0;
assign AHBL_M_TARGET_HMASTLOCK_net_0 = AHBL_M_TARGET_HMASTLOCK;
assign AHB_HMASTLOCK                 = AHBL_M_TARGET_HMASTLOCK_net_0;
assign AHBL_M_TARGET_HSELx_net_0     = AHBL_M_TARGET_HSELx;
assign AHB_HSEL                      = AHBL_M_TARGET_HSELx_net_0;
assign JTAG_TDO_net_1                = JTAG_TDO_net_0;
assign JTAG_TDO                      = JTAG_TDO_net_1;
assign JTAG_TDO_DR_net_1             = JTAG_TDO_DR_net_0;
assign JTAG_TDO_DR                   = JTAG_TDO_DR_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------MIV_RV32_CFG1_C0_MIV_RV32_CFG1_C0_0_MIV_RV32   -   Microsemi:MiV:MIV_RV32:3.1.200
MIV_RV32_CFG1_C0_MIV_RV32_CFG1_C0_0_MIV_RV32 #( 
        .AHB_END_ADDR_0               ( 'hffff ),
        .AHB_END_ADDR_1               ( 'h8fff ),
        .AHB_INITIATOR_TYPE           ( 1 ),
        .AHB_START_ADDR_0             ( 'h0 ),
        .AHB_START_ADDR_1             ( 'h8000 ),
        .AHB_TARGET_MIRROR            ( 1 ),
        .APB_END_ADDR_0               ( 'hffff ),
        .APB_END_ADDR_1               ( 'h7fff ),
        .APB_INITIATOR_TYPE           ( 1 ),
        .APB_START_ADDR_0             ( 'h0 ),
        .APB_START_ADDR_1             ( 'h7000 ),
        .APB_TARGET_MIRROR            ( 0 ),
        .AXI_END_ADDR_0               ( 'hffff ),
        .AXI_END_ADDR_1               ( 'h6fff ),
        .AXI_INITIATOR_TYPE           ( 0 ),
        .AXI_START_ADDR_0             ( 'h0 ),
        .AXI_START_ADDR_1             ( 'h6000 ),
        .AXI_TARGET_MIRROR            ( 0 ),
        .BOOTROM_DEST_ADDR_LOWER      ( 'h0 ),
        .BOOTROM_DEST_ADDR_UPPER      ( 'h4000 ),
        .BOOTROM_PRESENT              ( 0 ),
        .BOOTROM_SRC_END_ADDR_LOWER   ( 'h3fff ),
        .BOOTROM_SRC_END_ADDR_UPPER   ( 'h8000 ),
        .BOOTROM_SRC_START_ADDR_LOWER ( 'h0 ),
        .BOOTROM_SRC_START_ADDR_UPPER ( 'h8000 ),
        .C_EXT                        ( 1 ),
        .DEBUGGER                     ( 1 ),
        .ECC_ENABLE                   ( 0 ),
        .F_EXT                        ( 0 ),
        .FAMILY                       ( 26 ),
        .FWD_REGS                     ( 0 ),
        .GEN_MUL_TYPE                 ( 2 ),
        .GPR_REGS                     ( 0 ),
        .I_REGS                       ( 0 ),
        .I_TRACE                      ( 0 ),
        .ICACHE_EN                    ( 0 ),
        .INTERNAL_MTIME               ( 1 ),
        .INTERNAL_MTIME_IRQ           ( 1 ),
        .M_EXT                        ( 1 ),
        .MI_I_MEM                     ( 0 ),
        .MIV_HART_ID                  ( 'h0 ),
        .MTIME_PRESCALER              ( 100 ),
        .NO_MACC_BLK                  ( 0 ),
        .NUM_EXT_IRQS                 ( 1 ),
        .RECONFIG_BOOTROM             ( 0 ),
        .RESET_VECTOR_ADDR_0          ( 'h0 ),
        .RESET_VECTOR_ADDR_1          ( 'h8000 ),
        .TAS_END_ADDR_0               ( 'h3fff ),
        .TAS_END_ADDR_1               ( 'h4000 ),
        .TAS_START_ADDR_0             ( 'h0 ),
        .TAS_START_ADDR_1             ( 'h4000 ),
        .TCM_END_ADDR_0               ( 'h7fff ),
        .TCM_END_ADDR_1               ( 'h4000 ),
        .TCM_PRESENT                  ( 1 ),
        .TCM_REGS                     ( 0 ),
        .TCM_START_ADDR_0             ( 'h0 ),
        .TCM_START_ADDR_1             ( 'h4000 ),
        .TCM_TAS_PRESENT              ( 0 ),
        .VECTORED_INTERRUPTS          ( 0 ) )
MIV_RV32_CFG1_C0_0(
        // Inputs
        .TMR_IRQ                ( GND_net ), // tied to 1'b0 from definition
        .EXT_IRQ                ( EXT_IRQ ),
        .JTAG_TRSTN             ( JTAG_TRSTN ),
        .JTAG_TCK               ( JTAG_TCK ),
        .JTAG_TDI               ( JTAG_TDI ),
        .JTAG_TMS               ( JTAG_TMS ),
        .APB_PREADY             ( APB_PREADY ),
        .APB_PSLVERR            ( APB_PSLVERR ),
        .TCM_CPU_ACCESS_DISABLE ( GND_net ), // tied to 1'b0 from definition
        .TCM_TAS_ACCESS_DISABLE ( VCC_net ), // tied to 1'b1 from definition
        .TAS_PSEL               ( GND_net ), // tied to 1'b0 from definition
        .TAS_PENABLE            ( GND_net ), // tied to 1'b0 from definition
        .TAS_PWRITE             ( GND_net ), // tied to 1'b0 from definition
        .AXI_ARREADY            ( GND_net ), // tied to 1'b0 from definition
        .AXI_RLAST              ( GND_net ), // tied to 1'b0 from definition
        .AXI_RID                ( GND_net ), // tied to 1'b0 from definition
        .AXI_RVALID             ( GND_net ), // tied to 1'b0 from definition
        .AXI_AWREADY            ( GND_net ), // tied to 1'b0 from definition
        .AXI_WREADY             ( GND_net ), // tied to 1'b0 from definition
        .AXI_BID                ( GND_net ), // tied to 1'b0 from definition
        .AXI_BVALID             ( GND_net ), // tied to 1'b0 from definition
        .AHB_HREADY             ( AHB_HREADY ),
        .AHB_HRESP              ( AHB_HRESP ),
        .CLK                    ( CLK ),
        .RESETN                 ( RESETN ),
        .TIME_COUNT_IN          ( TIME_COUNT_IN_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .APB_PRDATA             ( APB_PRDATA ),
        .TAS_PADDR              ( TAS_PADDR_const_net_0 ), // tied to 32'h00000000 from definition
        .TAS_PWDATA             ( TAS_PWDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .AXI_RRESP              ( AXI_RRESP_const_net_0 ), // tied to 2'h0 from definition
        .AXI_RDATA              ( AXI_RDATA_const_net_0 ), // tied to 32'h00000000 from definition
        .AXI_BRESP              ( AXI_BRESP_const_net_0 ), // tied to 2'h0 from definition
        .AHB_HRDATA             ( AHB_HRDATA ),
        .MSYS_EI                ( MSYS_EI ),
        // Outputs
        .JTAG_TDO               ( JTAG_TDO_net_0 ),
        .JTAG_TDO_DR            ( JTAG_TDO_DR_net_0 ),
        .APB_PSEL               ( APB_INITIATOR_PSELx ),
        .APB_PENABLE            ( APB_INITIATOR_PENABLE ),
        .APB_PWRITE             ( APB_INITIATOR_PWRITE ),
        .TAS_PREADY             (  ),
        .TAS_PSLVERR            (  ),
        .AXI_ARID               (  ),
        .AXI_ARVALID            (  ),
        .AXI_RREADY             (  ),
        .AXI_AWID               (  ),
        .AXI_AWVALID            (  ),
        .AXI_WLAST              (  ),
        .AXI_WID                (  ),
        .AXI_WVALID             (  ),
        .AXI_BREADY             (  ),
        .AHB_HMASTLOCK          ( AHBL_M_TARGET_HMASTLOCK ),
        .AHB_HWRITE             ( AHBL_M_TARGET_HWRITE ),
        .AHB_HSEL               ( AHBL_M_TARGET_HSELx ),
        .EXT_RESETN             ( EXT_RESETN_net_0 ),
        .TRACE_VALID            (  ),
        .TRACE_EXCEPTION        (  ),
        .TRACE_INTERRUPT        (  ),
        .APB_PADDR              ( APB_INITIATOR_PADDR ),
        .APB_PWDATA             ( APB_INITIATOR_PWDATA ),
        .TAS_PRDATA             (  ),
        .AXI_ARADDR             (  ),
        .AXI_ARLEN              (  ),
        .AXI_ARSIZE             (  ),
        .AXI_ARBURST            (  ),
        .AXI_ARLOCK             (  ),
        .AXI_ARCACHE            (  ),
        .AXI_AWADDR             (  ),
        .AXI_AWLEN              (  ),
        .AXI_AWSIZE             (  ),
        .AXI_AWBURST            (  ),
        .AXI_AWLOCK             (  ),
        .AXI_AWCACHE            (  ),
        .AXI_AWPROT             (  ),
        .AXI_WDATA              (  ),
        .AXI_WSTRB              (  ),
        .AHB_HADDR              ( AHBL_M_TARGET_HADDR ),
        .AHB_HBURST             ( AHBL_M_TARGET_HBURST ),
        .AHB_HPROT              ( AHBL_M_TARGET_HPROT ),
        .AHB_HSIZE              ( AHBL_M_TARGET_HSIZE ),
        .AHB_HTRANS             ( AHBL_M_TARGET_HTRANS ),
        .AHB_HWDATA             ( AHBL_M_TARGET_HWDATA ),
        .AXI_ARPROT             (  ),
        .TIME_COUNT_OUT         ( TIME_COUNT_OUT_net_0 ),
        .TRACE_IADDR            (  ),
        .TRACE_INSN             (  ),
        .TRACE_PRIV             (  ),
        .TRACE_CAUSE            (  ),
        .TRACE_TVAL             (  ) 
        );


endmodule
