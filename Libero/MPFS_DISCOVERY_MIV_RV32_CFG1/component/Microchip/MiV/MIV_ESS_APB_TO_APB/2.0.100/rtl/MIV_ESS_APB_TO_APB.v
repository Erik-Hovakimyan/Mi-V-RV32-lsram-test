// Copyright (c) 2021, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary form, with or without
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
// ANY EXPRESS OR IMPLIED WARRANTIE, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// Description: 
//
// SVN Revision Information:
// SVN $Revision: 39703 $
// SVN $Date: 2021-12-16 16:57:01 +0000 (Thu, 16 Dec 2021) $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
// ****************************************************************************/
`timescale 1ns/1ps
module MIV_ESS_APB_TO_APB( 

// APB3 INITIATOR interface

output	wire	[31:0]				APB_I0_PADDR,
output	wire	[31:0]				APB_I3_PADDR,
output	wire	[31:0]				APB_I4_PADDR,
output	wire	[31:0]				APB_I11_PADDR,
output	wire	[31:0]				APB_I12_PADDR,
output	wire	[31:0]				APB_I13_PADDR,
output	wire	[31:0]				APB_I14_PADDR,
output	wire	[31:0]				APB_I15_PADDR,
output	wire						APB_I0_PWRITE,
output	wire						APB_I3_PWRITE,
output	wire						APB_I4_PWRITE,
output	wire						APB_I11_PWRITE,
output	wire						APB_I12_PWRITE,
output	wire						APB_I13_PWRITE,
output	wire						APB_I14_PWRITE,
output	wire						APB_I15_PWRITE,
output	wire						APB_I0_PENABLE,
output	wire						APB_I3_PENABLE,
output	wire						APB_I4_PENABLE,
output	wire						APB_I11_PENABLE,
output	wire						APB_I12_PENABLE,
output	wire						APB_I13_PENABLE,
output	wire						APB_I14_PENABLE,
output	wire						APB_I15_PENABLE,
output	wire						APB_I0_PSEL,
output	wire						APB_I3_PSEL,
output	wire						APB_I4_PSEL,
output	wire						APB_I11_PSEL,
output	wire						APB_I12_PSEL,
output	wire						APB_I13_PSEL,
output	wire						APB_I14_PSEL,
output	wire						APB_I15_PSEL,
output	wire	[31:0]				APB_I0_PWDATA,
output	wire	[31:0]				APB_I3_PWDATA,
output	wire	[31:0]				APB_I4_PWDATA,
output	wire	[31:0]				APB_I11_PWDATA,
output	wire	[31:0]				APB_I12_PWDATA,
output	wire	[31:0]				APB_I13_PWDATA,
output	wire	[31:0]				APB_I14_PWDATA,
output	wire	[31:0]				APB_I15_PWDATA,
input     		[31:0]				APB_I0_PRDATA,
input     		[31:0]				APB_I3_PRDATA,
input     		[31:0]				APB_I4_PRDATA,
input     		[31:0]				APB_I11_PRDATA,
input     		[31:0]				APB_I12_PRDATA,
input     		[31:0]				APB_I13_PRDATA,
input     		[31:0]				APB_I14_PRDATA,
input     		[31:0]				APB_I15_PRDATA,
input	    						APB_I0_PREADY,
input	    						APB_I3_PREADY,
input	    						APB_I4_PREADY,
input	    						APB_I11_PREADY,
input	    						APB_I12_PREADY,
input	    						APB_I13_PREADY,
input	    						APB_I14_PREADY,
input	    						APB_I15_PREADY,
input	    						APB_I0_PSLVERR,
input	    						APB_I3_PSLVERR,
input	    						APB_I4_PSLVERR,
input	    						APB_I11_PSLVERR,
input	    						APB_I12_PSLVERR,
input	    						APB_I13_PSLVERR,
input	    						APB_I14_PSLVERR,
input	    						APB_I15_PSLVERR,

// APB3 TARGET interface
input	wire 	[31:0]				APB_T0_PADDR,
input	wire 	[31:0]				APB_T3_PADDR,
input	wire 	[31:0]				APB_T4_PADDR,
input	wire 	[31:0]				APB_T11_PADDR,
input	wire 	[31:0]				APB_T12_PADDR,
input	wire 	[31:0]				APB_T13_PADDR,
input	wire 	[31:0]				APB_T14_PADDR,
input	wire 	[31:0]				APB_T15_PADDR,
input	wire						APB_T0_PWRITE,
input	wire						APB_T3_PWRITE,
input	wire						APB_T4_PWRITE,
input	wire						APB_T11_PWRITE,
input	wire						APB_T12_PWRITE,
input	wire						APB_T13_PWRITE,
input	wire						APB_T14_PWRITE,
input	wire						APB_T15_PWRITE,
input	wire						APB_T0_PENABLE,
input	wire						APB_T3_PENABLE,
input	wire						APB_T4_PENABLE,
input	wire						APB_T11_PENABLE,
input	wire						APB_T12_PENABLE,
input	wire						APB_T13_PENABLE,
input	wire						APB_T14_PENABLE,
input	wire						APB_T15_PENABLE,
input	wire	[31:0]				APB_T0_PWDATA,
input	wire	[31:0]				APB_T3_PWDATA,
input	wire	[31:0]				APB_T4_PWDATA,
input	wire	[31:0]				APB_T11_PWDATA,
input	wire	[31:0]				APB_T12_PWDATA,
input	wire	[31:0]				APB_T13_PWDATA,
input	wire	[31:0]				APB_T14_PWDATA,
input	wire	[31:0]				APB_T15_PWDATA,

input	    						APB_T0_PSEL,
input	    						APB_T3_PSEL,
input	    						APB_T4_PSEL,
input	    						APB_T11_PSEL,
input	    						APB_T12_PSEL,
input	    						APB_T13_PSEL,
input	    						APB_T14_PSEL,
input	    						APB_T15_PSEL,
output	wire    [31:0]				APB_T0_PRDATA,
output	wire    [31:0]				APB_T3_PRDATA,
output	wire    [31:0]				APB_T4_PRDATA,
output	wire    [31:0]				APB_T11_PRDATA,
output	wire    [31:0]				APB_T12_PRDATA,
output	wire    [31:0]				APB_T13_PRDATA,
output	wire    [31:0]				APB_T14_PRDATA,
output	wire    [31:0]				APB_T15_PRDATA,
output	wire    					APB_T0_PREADY,
output	wire    					APB_T3_PREADY,
output	wire    					APB_T4_PREADY,
output	wire    					APB_T11_PREADY,
output	wire    					APB_T12_PREADY,
output	wire    					APB_T13_PREADY,
output	wire    					APB_T14_PREADY,
output	wire    					APB_T15_PREADY,
output	wire    					APB_T0_PSLVERR,
output	wire    					APB_T3_PSLVERR,
output	wire    					APB_T4_PSLVERR,
output	wire    					APB_T11_PSLVERR,
output	wire    					APB_T12_PSLVERR,
output	wire    					APB_T13_PSLVERR,
output	wire    					APB_T14_PSLVERR,
output	wire    					APB_T15_PSLVERR
);
parameter APB_INITIATOR_0_MIRROR = 1;
parameter APB_INITIATOR_3_MIRROR = 0;
parameter APB_INITIATOR_4_MIRROR = 0;
parameter APB_INITIATOR_11_MIRROR = 0;
parameter APB_INITIATOR_12_MIRROR = 0;
parameter APB_INITIATOR_13_MIRROR = 0;
parameter APB_INITIATOR_14_MIRROR = 0;
parameter APB_INITIATOR_15_MIRROR = 0;

parameter APB_TARGET_0_MIRROR = 0;
parameter APB_TARGET_3_MIRROR = 1;
parameter APB_TARGET_4_MIRROR = 1;
parameter APB_TARGET_11_MIRROR = 1;
parameter APB_TARGET_12_MIRROR = 1;
parameter APB_TARGET_13_MIRROR = 1;
parameter APB_TARGET_14_MIRROR = 1;
parameter APB_TARGET_15_MIRROR = 1;

assign APB_T0_PRDATA   = APB_I0_PRDATA  ;
assign APB_T3_PRDATA   = APB_I3_PRDATA  ;
assign APB_T4_PRDATA   = APB_I4_PRDATA  ;
assign APB_T11_PRDATA   = APB_I11_PRDATA  ;
assign APB_T12_PRDATA   = APB_I12_PRDATA  ;
assign APB_T13_PRDATA   = APB_I13_PRDATA  ;
assign APB_T14_PRDATA   = APB_I14_PRDATA  ;
assign APB_T15_PRDATA   = APB_I15_PRDATA  ;
assign APB_T0_PREADY   = APB_I0_PREADY  ;
assign APB_T3_PREADY   = APB_I3_PREADY  ;
assign APB_T4_PREADY   = APB_I4_PREADY  ;
assign APB_T11_PREADY   = APB_I11_PREADY  ;
assign APB_T12_PREADY   = APB_I12_PREADY  ;
assign APB_T13_PREADY   = APB_I13_PREADY  ;
assign APB_T14_PREADY   = APB_I14_PREADY  ;
assign APB_T15_PREADY   = APB_I15_PREADY  ;
assign APB_T0_PSLVERR  = APB_I0_PSLVERR ;
assign APB_T3_PSLVERR  = APB_I3_PSLVERR ;
assign APB_T4_PSLVERR  = APB_I4_PSLVERR ;
assign APB_T11_PSLVERR  = APB_I11_PSLVERR ;
assign APB_T12_PSLVERR  = APB_I12_PSLVERR ;
assign APB_T13_PSLVERR  = APB_I13_PSLVERR ;
assign APB_T14_PSLVERR  = APB_I14_PSLVERR ;
assign APB_T15_PSLVERR  = APB_I15_PSLVERR ;
assign APB_I0_PADDR     = APB_T0_PADDR  ;
assign APB_I3_PADDR     = APB_T3_PADDR  ;
assign APB_I4_PADDR     = APB_T4_PADDR  ;
assign APB_I11_PADDR     = APB_T11_PADDR  ;
assign APB_I12_PADDR     = APB_T12_PADDR  ;
assign APB_I13_PADDR     = APB_T13_PADDR  ;
assign APB_I14_PADDR     = APB_T14_PADDR  ;
assign APB_I15_PADDR     = APB_T15_PADDR  ;
assign APB_I0_PWRITE    = APB_T0_PWRITE ;
assign APB_I3_PWRITE    = APB_T3_PWRITE ;
assign APB_I4_PWRITE    = APB_T4_PWRITE ;
assign APB_I11_PWRITE    = APB_T11_PWRITE ;
assign APB_I12_PWRITE    = APB_T12_PWRITE ;
assign APB_I13_PWRITE    = APB_T13_PWRITE ;
assign APB_I14_PWRITE    = APB_T14_PWRITE ;
assign APB_I15_PWRITE    = APB_T15_PWRITE ;
assign APB_I0_PENABLE   = APB_T0_PENABLE;
assign APB_I3_PENABLE   = APB_T3_PENABLE;
assign APB_I4_PENABLE   = APB_T4_PENABLE;
assign APB_I11_PENABLE   = APB_T11_PENABLE;
assign APB_I12_PENABLE   = APB_T12_PENABLE;
assign APB_I13_PENABLE   = APB_T13_PENABLE;
assign APB_I14_PENABLE   = APB_T14_PENABLE;
assign APB_I15_PENABLE   = APB_T15_PENABLE;
assign APB_I0_PWDATA    = APB_T0_PWDATA ;
assign APB_I3_PWDATA    = APB_T3_PWDATA ;
assign APB_I4_PWDATA    = APB_T4_PWDATA ;
assign APB_I11_PWDATA    = APB_T11_PWDATA ;
assign APB_I12_PWDATA    = APB_T12_PWDATA ;
assign APB_I13_PWDATA    = APB_T13_PWDATA ;
assign APB_I14_PWDATA    = APB_T14_PWDATA ;
assign APB_I15_PWDATA    = APB_T15_PWDATA ;
assign APB_I0_PSEL      = APB_T0_PSEL   ;
assign APB_I3_PSEL      = APB_T3_PSEL   ;
assign APB_I4_PSEL      = APB_T4_PSEL   ;
assign APB_I11_PSEL      = APB_T11_PSEL   ;
assign APB_I12_PSEL      = APB_T12_PSEL   ;
assign APB_I13_PSEL      = APB_T13_PSEL   ;
assign APB_I14_PSEL      = APB_T14_PSEL   ;
assign APB_I15_PSEL      = APB_T15_PSEL   ;


endmodule