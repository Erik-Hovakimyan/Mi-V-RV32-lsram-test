// Copyright (c) 2023, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2023, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
// 3.0.102 - development enhancement for MIV_WDT, HALTED top level o/p added (debug mode), to stall WDT when core halted during debug 
//
////////////////////////////////////////////////////////////////////////////////
//`define RVFI
`timescale 1ns/10ps
module MIV_RV32_CFG1_C0_MIV_RV32_CFG1_C0_0_MIV_RV32
//********************************************************************************
// Parameter description

   #(   
    parameter FAMILY                          = 26,
	
    parameter [15:0] RESET_VECTOR_ADDR_1      = 16'h8000,
    parameter [15:0] RESET_VECTOR_ADDR_0      = 16'h0000,
    parameter        DEBUGGER                 = 1'b1,
	parameter        I_TRACE                  = 1'b0,
    
	parameter        AXI_INITIATOR_TYPE       = 0,
	parameter        AXI_TARGET_MIRROR        = 0,
    parameter [15:0] AXI_START_ADDR_1         = 16'h6000,
    parameter [15:0] AXI_START_ADDR_0         = 16'h0000,
    parameter [15:0] AXI_END_ADDR_1           = 16'h6FFF,
    parameter [15:0] AXI_END_ADDR_0           = 16'hFFFF,
	                                         
    parameter        AHB_INITIATOR_TYPE      = 1,
    parameter        AHB_TARGET_MIRROR       = 0,
    parameter [15:0] AHB_START_ADDR_1        = 16'h8000,
    parameter [15:0] AHB_START_ADDR_0        = 16'h0000,
    parameter [15:0] AHB_END_ADDR_1          = 16'h8FFF,
    parameter [15:0] AHB_END_ADDR_0          = 16'hFFFF,
	
    parameter        APB_INITIATOR_TYPE      = 1,
    parameter        APB_TARGET_MIRROR       = 0,
    parameter [15:0] APB_START_ADDR_1        = 16'h7000,
    parameter [15:0] APB_START_ADDR_0        = 16'h0000,
    parameter [15:0] APB_END_ADDR_1          = 16'h7FFF,
    parameter [15:0] APB_END_ADDR_0          = 16'hFFFF,
	
    parameter        TCM_PRESENT          = 0,
    parameter [15:0] TCM_START_ADDR_1     = 16'h4000,
    parameter [15:0] TCM_START_ADDR_0     = 16'h0000,
    parameter [15:0] TCM_END_ADDR_1       = 16'h4000,
    parameter [15:0] TCM_END_ADDR_0       = 16'h3FFF,
	
    parameter        TCM_TAS_PRESENT      = 0,
    parameter [15:0] TAS_START_ADDR_1     = 16'h4000,
    parameter [15:0] TAS_START_ADDR_0     = 16'h0000,
    parameter [15:0] TAS_END_ADDR_1       = 16'h4000,
    parameter [15:0] TAS_END_ADDR_0       = 16'h3FFF,

   parameter C_EXT                        = 0,
   parameter F_EXT                        = 0,
   parameter M_EXT                        = 0,
   parameter GEN_MUL_TYPE                 = 0,
   
   parameter VECTORED_INTERRUPTS          = 0,
   parameter NUM_EXT_IRQS                 = 0,
   
   parameter FWD_REGS                     = 0,
   parameter ECC_ENABLE                   = 0, 
   parameter NO_MACC_BLK                  = 0,
   
   parameter INTERNAL_MTIME               = 1,
   parameter INTERNAL_MTIME_IRQ           = 1,
   parameter MTIME_PRESCALER              = 16'd100,
   
   parameter GPR_REGS                     = 0,
   
   parameter        BOOTROM_PRESENT              = 0,
   parameter		RECONFIG_BOOTROM			 = 0,
   parameter [15:0] BOOTROM_SRC_START_ADDR_UPPER = 16'h8000,
   parameter [15:0] BOOTROM_SRC_START_ADDR_LOWER = 16'h0000,
   parameter [15:0] BOOTROM_SRC_END_ADDR_UPPER   = 16'h8000,
   parameter [15:0] BOOTROM_SRC_END_ADDR_LOWER   = 16'h3FFF,
   parameter [15:0] BOOTROM_DEST_ADDR_UPPER      = 16'h4000,
   parameter [15:0] BOOTROM_DEST_ADDR_LOWER      = 16'h0000,
   
   parameter ICACHE_EN                           = 0,
   parameter MI_I_MEM                            = 0,
   parameter TCM_REGS							 = 0,
   parameter I_REGS                              = 0,
   parameter MIV_HART_ID                         = 0
    
   )

//********************************************************************************
// Port description

  (    
    
    input                                    CLK,
    input                                    RESETN,
    output                                   EXT_RESETN,

    output									 TRACE_VALID,
	output [31:0]                            TRACE_IADDR,
	output [31:0]                            TRACE_INSN,
    output [2:0]  	   	  				     TRACE_PRIV,
   	output      					  	     TRACE_EXCEPTION,
    output     						         TRACE_INTERRUPT,
	output [5:0]                             TRACE_CAUSE,
	output [31:0]							 TRACE_TVAL,
	
	
    // CPU controls
    input    [63:0]                          TIME_COUNT_IN,     
    input                                    TMR_IRQ,
    input                                    EXT_IRQ,
    input    [NUM_EXT_IRQS-1:0]              MSYS_EI,
    input                                    JTAG_TRSTN,
    input                                    JTAG_TCK,
    input                                    JTAG_TDI,
    input                                    JTAG_TMS,
	output   [63:0]                          TIME_COUNT_OUT,
    output                                   JTAG_TDO,
    output                                   JTAG_TDO_DR,

      
    // APB Initiator interface
    input                                    APB_PREADY, 
    input        [31:0]                      APB_PRDATA,
    input                                    APB_PSLVERR,
    output       [31:0]                      APB_PADDR, 
    output                                   APB_PSEL,
    output                                   APB_PENABLE, 
    output                                   APB_PWRITE, 
    output       [31:0]                      APB_PWDATA,
    
    // TCM ACCESS 
    input                                    TCM_CPU_ACCESS_DISABLE,  
    input                                    TCM_TAS_ACCESS_DISABLE, 
	
    // APB Target interface (TCM direct access port)
    input    [31:0]                          TAS_PADDR, 
    input                                    TAS_PSEL,
    input                                    TAS_PENABLE, 
    input                                    TAS_PWRITE, 
    input    [31:0]                          TAS_PWDATA,
    output                                   TAS_PREADY, 
    output   [31:0]                          TAS_PRDATA,
    output                                   TAS_PSLVERR,
    
    // AXI Initiator interface
    output                                   AXI_ARID,
    output  [31:0]                           AXI_ARADDR,
    output  [(AXI_INITIATOR_TYPE*4)-1:0]     AXI_ARLEN,
    output  [2:0]                            AXI_ARSIZE,
    output  [1:0]                            AXI_ARBURST,
    output  [2-AXI_INITIATOR_TYPE:0]         AXI_ARLOCK,
    output  [3:0]                            AXI_ARCACHE,
    output  [2:0]                            AXI_ARPROT,
    input                                    AXI_ARREADY,
    output                                   AXI_ARVALID,
    input   [1:0]                            AXI_RRESP,
    input   [31:0]                           AXI_RDATA,
    input                                    AXI_RLAST,
    input                                    AXI_RID,
    output                                   AXI_RREADY,
    input                                    AXI_RVALID,
    output                                   AXI_AWID,
    output  [31:0]                           AXI_AWADDR,
    output [(AXI_INITIATOR_TYPE*4)-1:0]      AXI_AWLEN,
    output  [2:0]                            AXI_AWSIZE,
    output  [1:0]                            AXI_AWBURST,
    output  [2-AXI_INITIATOR_TYPE:0]         AXI_AWLOCK,
    output  [3:0]                            AXI_AWCACHE,
    output  [2:0]                            AXI_AWPROT,
    input                                    AXI_AWREADY,
    output                                   AXI_AWVALID,
    output  [31:0]                           AXI_WDATA,
    output  [3:0]                            AXI_WSTRB,
    output                                   AXI_WLAST,
    output                                   AXI_WID,
    input                                    AXI_WREADY,
    output                                   AXI_WVALID,
    input    [1:0]                           AXI_BRESP,
    input                                    AXI_BID,
    output                                   AXI_BREADY,
    input                                    AXI_BVALID,
    
    // AHB Initiator interface
    output                                   AHB_HSEL,      // Only used in mirrored i/f
    output       [31:0]                      AHB_HADDR,     
    output       [2:0]                       AHB_HBURST,    
    output                                   AHB_HMASTLOCK, 
    output       [3:0]                       AHB_HPROT,     
    output       [2:0]                       AHB_HSIZE,     
    output       [1:0]                       AHB_HTRANS,    
    output       [31:0]                      AHB_HWDATA,    
    output                                   AHB_HWRITE,    
    input    [31:0]                          AHB_HRDATA,    
    input                                    AHB_HREADY,    
    input                                    AHB_HRESP       
    
    
  );
   
//********************************************************************************
// Declarations

//miv_rv32 verison
 localparam l_miv_rv32_version = 32'h030100C8;
 
//top level 
 localparam USE_BUS_PARITY                      = 0;
 localparam TCM0_UDMA_PRESENT                   = 0;
 localparam APB_REGISTER_IO                     = 1;
 localparam CPU_ADDR_WIDTH                      = 32;
 localparam AXI_ADDR_WIDTH                      = 32;
 localparam APB_ADDR_WIDTH                      = 32;
 localparam AHB_ADDR_WIDTH                      = 32;
 localparam UDMA_PRESENT                        = 0;
 localparam UDMA_CTRL_ADDR_WIDTH                = 32;    
 localparam SUBSYS_CFG_ADDR_WIDTH               = 32;    
 localparam TCM0_ADDR_WIDTH                     = 32;
 localparam TCM0_CPU_I_PRESENT                  = 1;
 localparam TCM0_CPU_D_PRESENT                  = 1;
 localparam TCM0_USE_RAM_PARITY_BITS            = 0;
 localparam TCM_TAS_ADDR_WIDTH             	    = 32;
 localparam MAX_EXT_IRQS                        = 8;
 
 localparam TCM1_ADDR_WIDTH                     = 32;
 localparam TCM1_CPU_I_PRESENT                  = 1; 
 localparam TCM1_CPU_D_PRESENT                  = 1; 
 localparam TCM1_USE_RAM_PARITY_BITS            = 0; 
 
//subsys_package
  localparam l_subsys_cfg_axi_present           = (AXI_INITIATOR_TYPE != 0) ? 1: 0;
  localparam l_subsys_cfg_ahb_present           = (AHB_INITIATOR_TYPE != 0) ? 1: 0;
  localparam l_subsys_cfg_apb_present           = (APB_INITIATOR_TYPE != 0) ? 1: 0; 
  localparam l_subsys_cfg_hart_debug            = DEBUGGER;
  localparam l_hart_cfg_hw_debug                = DEBUGGER;
  localparam l_hart_cfg_num_triggers            = (DEBUGGER) ? 2 : 0;
  localparam l_subsys_cfg_tcm_tas_present       = TCM_TAS_PRESENT;
  localparam l_subsys_cfg_tcm0_tas_present      = TCM_TAS_PRESENT;
  localparam l_apb_start_addr                   = (APB_INITIATOR_TYPE != 0) ? {APB_START_ADDR_1, APB_START_ADDR_0} : 32'h0FFF_FFE0;
  localparam l_apb_end_addr                     = (APB_INITIATOR_TYPE != 0) ? {APB_END_ADDR_1  , APB_END_ADDR_0  } : 32'h0FFF_FFE1;
  localparam l_tcm0_start_addr                  = (TCM_PRESENT)          ? {TCM_START_ADDR_1, TCM_START_ADDR_0} : 32'h0FFF_FFE2;
  localparam l_tcm0_end_addr                    = (TCM_PRESENT)          ? {TCM_END_ADDR_1  , TCM_END_ADDR_0  } : 32'h0FFF_FFE3;
  localparam l_tcm_tas_tcm0_start_addr          = (TCM_TAS_PRESENT)      ? {TAS_START_ADDR_1, TAS_START_ADDR_0} : 32'h0FFF_FFE4;
  localparam l_tcm_tas_tcm0_end_addr            = (TCM_TAS_PRESENT)      ? {TAS_END_ADDR_1  , TAS_END_ADDR_0}   : 32'h0FFF_FFE5;
  localparam l_axi_start_addr                   = (AXI_INITIATOR_TYPE != 0) ? {AXI_START_ADDR_1, AXI_START_ADDR_0} : 32'h0FFF_FFE6;
  localparam l_axi_end_addr                     = (AXI_INITIATOR_TYPE != 0) ? {AXI_END_ADDR_1  , AXI_END_ADDR_0  } : 32'h0FFF_FFE7;
  localparam l_ahb_start_addr                   = (AHB_INITIATOR_TYPE != 0) ? {AHB_START_ADDR_1, AHB_START_ADDR_0} : 32'h0FFF_FFE8;
  localparam l_ahb_end_addr                     = (AHB_INITIATOR_TYPE != 0) ? {AHB_END_ADDR_1  , AHB_END_ADDR_0  } : 32'h0FFF_FFE9;
  localparam l_tcm1_start_addr                  =                                                                    32'h0000_A000;
  localparam l_tcm1_end_addr                    =                                                                    32'h0000_A200;
  localparam l_tcm_tas_tcm1_start_addr          =                                                                    32'h0FFF_FFEC;
  localparam l_tcm_tas_tcm1_end_addr            =                                                                    32'h0FFF_FFED;    
  localparam l_tcm_tas_udma_ctrl_start_addr     =                                                                    32'h0FFF_FFEE;
  localparam l_tcm_tas_udma_ctrl_end_addr       =                                                                    32'h0FFF_FFEF; 
  localparam l_udma_ctrl_start_addr             =                                                                    32'h0FFF_FFE0;
  localparam l_udma_ctrl_end_addr               =                                                                    32'h0FFF_FFF1;
  localparam l_subsys_cfg_start_addr            = 32'h0000_6000;
  localparam l_subsys_cfg_end_addr              = 32'h0000_6FFF;
  localparam l_hart_cfg_time_count_width        = 64;

  localparam l_subsys_cfg_tcm0_present          = TCM_PRESENT;
  localparam l_subsys_cfg_tcm1_present          = BOOTROM_PRESENT;
  localparam BOOTROM_SRC_START_ADDR             = {BOOTROM_SRC_START_ADDR_UPPER[15:0], BOOTROM_SRC_START_ADDR_LOWER[15:0]};
  localparam BOOTROM_SRC_END_ADDR               = {BOOTROM_SRC_END_ADDR_UPPER[15:0], BOOTROM_SRC_END_ADDR_LOWER[15:0]};
  localparam BOOTROM_DEST_ADDR                  = {BOOTROM_DEST_ADDR_UPPER[15:0], BOOTROM_DEST_ADDR_LOWER[15:0]};
  
//core package
  localparam reg[31:0] l_hart_reset_vector           = (BOOTROM_PRESENT) ? l_tcm1_start_addr : {RESET_VECTOR_ADDR_1, RESET_VECTOR_ADDR_0};
  localparam reg[27:0] l_hart_mtvec_offset           = 28'h4;
  localparam reg[31:0] l_hart_static_mtvec_base      = (BOOTROM_PRESENT) ?  BOOTROM_DEST_ADDR + l_hart_mtvec_offset : l_hart_reset_vector + l_hart_mtvec_offset;
  localparam reg       l_hart_cfg_static_mtvec_base  = 1'b0;  // SAR_125515
  localparam reg       l_hart_cfg_static_mtvec_mode  = 1'b1;
  localparam reg[1:0]  l_hart_static_mtvec_mode      = (VECTORED_INTERRUPTS) ? 2'b1 : 2'b0;
  localparam           l_hart_cfg_hw_compressed      = C_EXT;
  localparam           l_hart_cfg_hw_sp_float        = F_EXT; 
  localparam           l_hart_cfg_hw_multiply_divide = M_EXT;
  localparam           l_hart_cfg_hw_macc_multiplier = (NO_MACC_BLK) ? 0 : GEN_MUL_TYPE;
  localparam 		   l_hart_num_sys_ext_irqs       = NUM_EXT_IRQS;
  localparam reg       l_hart_cfg_lsu_fwd            = FWD_REGS;
  localparam reg       l_hart_cfg_csr_fwd            = FWD_REGS;
  localparam reg       l_hart_cfg_exu_fwd            = FWD_REGS;
  localparam reg       l_hart_cfg_gpr_type           = GPR_REGS;
  
// Other
  
 localparam l_icache_en = ICACHE_EN & (l_subsys_cfg_axi_present | l_subsys_cfg_ahb_present);
 localparam l_mi_i_mem = MI_I_MEM & (l_subsys_cfg_axi_present + l_subsys_cfg_ahb_present + l_subsys_cfg_tcm0_present > 1);
// Signals 
   wire       debug_sys_reset;    
   wire [7:0] m_sys_ext_irq_int;
   
// Assignments
  assign AHB_HSEL = 1'b1;
  assign EXT_RESETN = RESETN & ~debug_sys_reset;
  
//Unused Signals
  wire       tcm_tas_udma_ctrl_irq;
  wire       APB_PADDR_P;
  wire [3:0] APB_PWDATA_P;
  wire [3:0] APB_PRDATA_P         = 4'b0; 
  wire [3:0] APB_PSTRB; 
  wire [2:0] APB_PPROT;
  wire       AXI_AWADDR_P;
  wire [3:0] AXI_WDATA_P; 
  wire       AHB_HADDR_P;   
  wire [3:0] AHB_HWDATA_P;  
  wire       AXI_ARADDR_P;
  wire [3:0] TAS_PRDATA_P; 
  wire [2:0] TAS_PPROT         = 3'b0;
  wire       tcm1_cpu_access_disable   = 1'b0; 
  wire       tcm1_dma_access_disable   = 1'b0;
  wire       tcm1_tas_access_disable   = 1'b0;
  wire       sys_parity_disable        = 1'b0;
  wire       TAS_PADDR_P       = 1'b0;
  wire [3:0] TAS_PWDATA_P      = 1'b0; 
  wire [3:0] AXI_RDATA_P          = 4'b0;
  wire [3:0] AHB_HRDATA_P         = 4'b0;  
  
  wire [3:0] axi_arlen_int;
  wire [3:0] axi_awlen_int;
  wire       axi_arlock_int;
  wire       axi_awlock_int;
  
  assign AXI_ARLEN  = (AXI_INITIATOR_TYPE == 2) ? {4'b0, axi_arlen_int}  : (AXI_INITIATOR_TYPE == 1) ?  axi_arlen_int  : 2'b0; // always 1 beat from CPU
  assign AXI_AWLEN  = (AXI_INITIATOR_TYPE == 2) ? {4'b0, axi_awlen_int}  : (AXI_INITIATOR_TYPE == 1) ?  axi_awlen_int  : 2'b0; // always 1 beat from CPU
  assign AXI_ARLOCK = (AXI_INITIATOR_TYPE == 1) ? {1'b0, axi_arlock_int} : (AXI_INITIATOR_TYPE == 2) ?  axi_arlock_int : 3'b0; // Always normal (no lock, no exclusive) for now
  assign AXI_AWLOCK = (AXI_INITIATOR_TYPE == 1) ? {1'b0, axi_awlock_int} : (AXI_INITIATOR_TYPE == 2) ?  axi_awlock_int : 3'b0; // Always normal (no lock, no exclusive) for now
  
  generate
  if(NUM_EXT_IRQS == MAX_EXT_IRQS) begin : gen_irq_8
    assign m_sys_ext_irq_int = MSYS_EI[NUM_EXT_IRQS-1:0];
  end else begin : ngen_gen_irq_8
    assign m_sys_ext_irq_int = {{((MAX_EXT_IRQS)-NUM_EXT_IRQS){1'b0}}, MSYS_EI[NUM_EXT_IRQS-1:0]};
  end
  endgenerate
miv_rv32_ipcore
   #(   
    .FAMILY                             (FAMILY                          ),
    .CPU_ADDR_WIDTH                     (CPU_ADDR_WIDTH                  ),    
    .APB_ADDR_WIDTH                     (APB_ADDR_WIDTH                  ),
    .APB_REGISTER_IO                    (APB_REGISTER_IO                 ),
    .AHB_ADDR_WIDTH                     (AHB_ADDR_WIDTH                  ),
    .UDMA_PRESENT                       (UDMA_PRESENT                    ),
    .UDMA_CTRL_ADDR_WIDTH               (UDMA_CTRL_ADDR_WIDTH            ),
    .SUBSYS_CFG_ADDR_WIDTH              (SUBSYS_CFG_ADDR_WIDTH           ),
    .TCM0_ADDR_WIDTH                    (TCM0_ADDR_WIDTH                 ),
    .TCM0_UDMA_PRESENT                  (TCM0_UDMA_PRESENT               ),
    .TCM0_CPU_I_PRESENT                 (TCM0_CPU_I_PRESENT              ),
    .TCM0_CPU_D_PRESENT                 (TCM0_CPU_D_PRESENT              ),
    .TCM0_USE_RAM_PARITY_BITS           (TCM0_USE_RAM_PARITY_BITS        ),
    .TCM_TAS_ADDR_WIDTH                 (TCM_TAS_ADDR_WIDTH              ),
    .TCM1_ADDR_WIDTH                    (TCM1_ADDR_WIDTH                 ),
    .TCM1_CPU_I_PRESENT                 (TCM1_CPU_I_PRESENT              ),
    .TCM1_CPU_D_PRESENT                 (TCM1_CPU_D_PRESENT              ),
    .TCM1_USE_RAM_PARITY_BITS           (TCM1_USE_RAM_PARITY_BITS        ),
    .USE_BUS_PARITY                     (USE_BUS_PARITY                  ),                                 
    .l_subsys_cfg_axi_present           (l_subsys_cfg_axi_present        ),
    .l_subsys_cfg_ahb_present           (l_subsys_cfg_ahb_present        ),
	.l_subsys_cfg_apb_present           (l_subsys_cfg_apb_present        ),
    .l_subsys_cfg_hart_debug            (l_subsys_cfg_hart_debug         ),
    .l_hart_cfg_hw_debug                (l_hart_cfg_hw_debug             ),
    .l_hart_cfg_num_triggers            (l_hart_cfg_num_triggers         ),
    .l_subsys_cfg_tcm0_present          (l_subsys_cfg_tcm0_present       ),
    .l_subsys_cfg_tcm1_present          (l_subsys_cfg_tcm1_present       ),
    .l_axi_start_addr                   (l_axi_start_addr                ), 
    .l_axi_end_addr                     (l_axi_end_addr                  ),
    .l_apb_start_addr                   (l_apb_start_addr                ),
    .l_apb_end_addr                     (l_apb_end_addr                  ),
    .l_ahb_start_addr                   (l_ahb_start_addr                ),
    .l_ahb_end_addr                     (l_ahb_end_addr                  ),
    .l_udma_ctrl_start_addr             (l_udma_ctrl_start_addr          ),
    .l_udma_ctrl_end_addr               (l_udma_ctrl_end_addr            ),
    .l_subsys_cfg_start_addr            (l_subsys_cfg_start_addr         ),
    .l_subsys_cfg_end_addr              (l_subsys_cfg_end_addr           ),
    .l_tcm0_start_addr                  (l_tcm0_start_addr               ),
    .l_tcm0_end_addr                    (l_tcm0_end_addr                 ),
    .l_tcm1_start_addr                  (l_tcm1_start_addr               ),
    .l_tcm1_end_addr                    (l_tcm1_end_addr                 ),
    .l_tcm_tas_udma_ctrl_start_addr     (l_tcm_tas_udma_ctrl_start_addr  ),
    .l_tcm_tas_udma_ctrl_end_addr       (l_tcm_tas_udma_ctrl_end_addr    ),
    .l_tcm_tas_tcm0_start_addr          (l_tcm_tas_tcm0_start_addr       ),
    .l_tcm_tas_tcm0_end_addr            (l_tcm_tas_tcm0_end_addr         ),
    .l_tcm_tas_tcm1_start_addr          (l_tcm_tas_tcm1_start_addr       ),
    .l_tcm_tas_tcm1_end_addr            (l_tcm_tas_tcm1_end_addr         ),
    .l_subsys_cfg_tcm_tas_present       (l_subsys_cfg_tcm_tas_present    ),
	.l_subsys_cfg_tcm0_tas_present      (l_subsys_cfg_tcm0_tas_present   ),
	.l_hart_reset_vector                (l_hart_reset_vector             ),
    .l_hart_cfg_hw_multiply_divide      (l_hart_cfg_hw_multiply_divide   ),
    .l_hart_cfg_hw_compressed           (l_hart_cfg_hw_compressed        ),
	.l_hart_cfg_hw_sp_float             (l_hart_cfg_hw_sp_float          ),
    .l_hart_static_mtvec_base           (l_hart_static_mtvec_base        ),
    .l_hart_cfg_static_mtvec_base       (l_hart_cfg_static_mtvec_base    ),
    .l_hart_cfg_static_mtvec_mode       (l_hart_cfg_static_mtvec_mode    ),
    .l_hart_static_mtvec_mode           (l_hart_static_mtvec_mode        ),
	.l_hart_num_sys_ext_irqs            (l_hart_num_sys_ext_irqs         ),
	.l_hart_cfg_hw_macc_multiplier      (l_hart_cfg_hw_macc_multiplier   ),
	.l_hart_cfg_time_count_width        (l_hart_cfg_time_count_width     ),
    .l_hart_cfg_lsu_fwd                 (l_hart_cfg_lsu_fwd              ),
    .l_hart_cfg_csr_fwd                 (l_hart_cfg_csr_fwd              ),
    .l_hart_cfg_exu_fwd                 (l_hart_cfg_exu_fwd              ),
    .l_hart_cfg_gpr_type                (l_hart_cfg_gpr_type             ),
    .RAM_SB_IN_WIDTH                    (4                               ),
    .RAM_SB_OUT_WIDTH                   (4                               ), 
    .ECC_ENABLE                         (ECC_ENABLE                      ),
	.NO_MACC_BLK                        (NO_MACC_BLK                     ),
    .INTERNAL_MTIME                     (INTERNAL_MTIME                  ),
    .INTERNAL_MTIME_IRQ                 (INTERNAL_MTIME_IRQ              ),
    .MTIME_PRESCALER                    (MTIME_PRESCALER                 ),
    .BOOTROM_SRC_START_ADDR             (BOOTROM_SRC_START_ADDR          ),
    .BOOTROM_SRC_END_ADDR               (BOOTROM_SRC_END_ADDR            ),
    .BOOTROM_DEST_ADDR                  (BOOTROM_DEST_ADDR               ),
	.RECONFIG_BOOTROM                   (RECONFIG_BOOTROM                ),
	.ICACHE_EN                          (l_icache_en                     ),
	.MI_I_MEM                           (MI_I_MEM                        ),
	.TCM_REGS							(TCM_REGS						 ),
	.I_REGS                             (I_REGS                          ),
	.l_miv_rv32_version                 (l_miv_rv32_version              )
   )                                    
   
u_ipcore_0

  ( .clk                                    (CLK),
    .resetn                                 (RESETN),
	
    .trace_valid							(TRACE_VALID),
	.trace_iaddr                            (TRACE_IADDR),
    .trace_insn                             (TRACE_INSN),
	.trace_priv								(TRACE_PRIV),
    .trace_exception	     				(TRACE_EXCEPTION),
    .trace_interrupt    					(TRACE_INTERRUPT),
	.trace_cause                            (TRACE_CAUSE),
    .trace_tval                             (TRACE_TVAL),
	
    .mtime_count                            (TIME_COUNT_IN),
    .m_timer_irq                            (TMR_IRQ),
    .m_external_irq                         (EXT_IRQ),
    .m_sys_ext_irq                          (m_sys_ext_irq_int),
	.debug_sys_reset                        (debug_sys_reset),
    .jtag_trst                              (JTAG_TRSTN),
    .jtag_tck                               (JTAG_TCK),
    .jtag_tdi                               (JTAG_TDI),
    .jtag_tms                               (JTAG_TMS),
    .jtag_tdo                               (JTAG_TDO),
    .jtag_tdo_dr                            (JTAG_TDO_DR),    
    .apb_paddr                              (APB_PADDR), 
    .apb_paddr_p                            (APB_PADDR_P),
    .apb_pprot                              (APB_PPROT),
    .apb_psel                               (APB_PSEL),
    .apb_penable                            (APB_PENABLE), 
    .apb_pwrite                             (APB_PWRITE), 
    .apb_pwdata                             (APB_PWDATA),
    .apb_pwdata_p                           (APB_PWDATA_P),
    .apb_pstrb                              (APB_PSTRB), 
    .apb_pready                             (APB_PREADY), 
    .apb_prdata                             (APB_PRDATA),
    .apb_prdata_p                           (APB_PRDATA_P), 
    .apb_pslverr                            (APB_PSLVERR),    
    .tcm0_cpu_access_disable                (TCM_CPU_ACCESS_DISABLE),  
    .tcm0_dma_access_disable                (1'b1), 
    .tcm0_tas_access_disable                (TCM_TAS_ACCESS_DISABLE), 
    .tcm1_cpu_access_disable                (tcm1_cpu_access_disable),  
    .tcm1_dma_access_disable                (tcm1_dma_access_disable), 
    .tcm1_tas_access_disable                (tcm1_tas_access_disable),
    .tcm_tas_paddr                          (TAS_PADDR), 
    .tcm_tas_paddr_p                        (TAS_PADDR_P),
    .tcm_tas_pprot                          (TAS_PPROT),
    .tcm_tas_psel                           (TAS_PSEL),
    .tcm_tas_penable                        (TAS_PENABLE), 
    .tcm_tas_pwrite                         (TAS_PWRITE), 
    .tcm_tas_pwdata                         (TAS_PWDATA),
    .tcm_tas_pwdata_p                       (TAS_PWDATA_P), 
    .tcm_tas_pready                         (TAS_PREADY), 
    .tcm_tas_prdata                         (TAS_PRDATA),
    .tcm_tas_prdata_p                       (TAS_PRDATA_P), 
    .tcm_tas_pslverr                        (TAS_PSLVERR),    
    .tcm_tas_udma_ctrl_irq                  (TCM_TAS_UDMA_CTRL_IRQ),
    .axi_aclk_en                            (1'b1),
    .axi_arid                               (AXI_ARID),
    .axi_araddr                             (AXI_ARADDR),
    .axi_arlen                              (axi_arlen_int),
    .axi_arsize                             (AXI_ARSIZE),
    .axi_arburst                            (AXI_ARBURST),
    .axi_arlock                             (axi_arlock_int),
    .axi_arcache                            (AXI_ARCACHE),
    .axi_arprot                             (AXI_ARPROT),
    .axi_arready                            (AXI_ARREADY),
    .axi_arvalid                            (AXI_ARVALID),
    .axi_ar_addr_p                          (AXI_ARADDR_P),
    .axi_rresp                              (AXI_RRESP),
    .axi_rdata                              (AXI_RDATA),
    .axi_rlast                              (AXI_RLAST),
    .axi_rid                                (AXI_RID),
    .axi_rready                             (AXI_RREADY),
    .axi_rvalid                             (AXI_RVALID),
    .axi_r_data_p                           (AXI_RDATA_P),
    .axi_awid                               (AXI_AWID),
    .axi_awaddr                             (AXI_AWADDR),
    .axi_awlen                              (axi_awlen_int),
    .axi_awsize                             (AXI_AWSIZE),
    .axi_awburst                            (AXI_AWBURST),
    .axi_awlock                             (axi_awlock_int),
    .axi_awcache                            (AXI_AWCACHE),
    .axi_awprot                             (AXI_AWPROT),
    .axi_aw_addr_p                          (AXI_AWADDR_P),
    .axi_awready                            (AXI_AWREADY),
    .axi_awvalid                            (AXI_AWVALID),
    .axi_wdata                              (AXI_WDATA),
    .axi_wstrb                              (AXI_WSTRB),
    .axi_wlast                              (AXI_WLAST),
    .axi_wid                                (AXI_WID),
    .axi_wready                             (AXI_WREADY),
    .axi_wvalid                             (AXI_WVALID),
    .axi_w_data_p                           (AXI_WDATA_P), 
    .axi_bresp                              (AXI_BRESP),
    .axi_bid                                (AXI_BID),
    .axi_bready                             (AXI_BREADY),
    .axi_bvalid                             (AXI_BVALID),     
    .ahb_haddr                              (AHB_HADDR),     
    .ahb_haddr_p                            (AHB_HADDR_P),   
    .ahb_hburst                             (AHB_HBURST),    
    .ahb_hmastlock                          (AHB_HMASTLOCK), 
    .ahb_hprot                              (AHB_HPROT),     
    .ahb_hsize                              (AHB_HSIZE),     
    .ahb_htrans                             (AHB_HTRANS),    
    .ahb_hwdata                             (AHB_HWDATA),    
    .ahb_hwdata_p                           (AHB_HWDATA_P),  
    .ahb_hwrite                             (AHB_HWRITE),    
    .ahb_hrdata                             (AHB_HRDATA),    
    .ahb_hrdata_p                           (AHB_HRDATA_P),  
    .ahb_hready                             (AHB_HREADY),    
    .ahb_hresp                              (AHB_HRESP),
    .tcm0_uncorrectable_ecc_error           (),
    .tcm1_uncorrectable_ecc_error           (),
    .gpr_uncorrectable_ecc_error            (),
    .hart_id                                (MIV_HART_ID),
	.sys_parity_disable                     (sys_parity_disable),
	.tcm0_ram_sb_out                        (),
    .tcm0_ram_sb_in                         (4'b0),
    .tcm1_ram_sb_out                        (),
    .tcm1_ram_sb_in                         (4'b0),
	.mtime_count_out                        (TIME_COUNT_OUT)
  );
    
endmodule
