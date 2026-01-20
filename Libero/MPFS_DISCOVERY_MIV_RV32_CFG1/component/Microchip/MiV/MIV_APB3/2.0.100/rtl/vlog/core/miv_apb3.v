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
// Description:	MIV_APB3 - AMBA APB3 bus fabric
//				Instantiates the following modules:
//				MIV_APB3_MUXPTOB3
//              miv_apb3_iaddr_reg
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// *********************************************************************/
`timescale 1ns/1ps
module MIV_APB3 #(
parameter [0:0]APBSLOT0ENABLE	= 1,
parameter [0:0]APBSLOT1ENABLE	= 1,
parameter [0:0]APBSLOT2ENABLE	= 1,
parameter [0:0]APBSLOT3ENABLE	= 1,
parameter [0:0]APBSLOT4ENABLE	= 1,
parameter [0:0]APBSLOT5ENABLE	= 1,
parameter [0:0]APBSLOT6ENABLE	= 1,
parameter [0:0]APBSLOT7ENABLE	= 1,
parameter [0:0]APBSLOT8ENABLE	= 1,
parameter [0:0]APBSLOT9ENABLE	= 1,
parameter [0:0]APBSLOT10ENABLE	= 1,
parameter [0:0]APBSLOT11ENABLE	= 1,
parameter [0:0]APBSLOT12ENABLE	= 1,
parameter [0:0]APBSLOT13ENABLE	= 1,
parameter [0:0]APBSLOT14ENABLE	= 1,
parameter [0:0]APBSLOT15ENABLE	= 1,
parameter FAMILY  = 19,
parameter SYNC_RESET = (FAMILY == 25) ? 1 : 0
)
(
//input           [31:0]              IADDR,
//input								PRESETN,
//input								PCLK,
input			[31:0]				PADDR,
input								PWRITE,
input								PENABLE,
input								PSEL,
input			[31:0]				PWDATA,
output wire		[31:0]				PRDATA,
output	wire						PREADY,
output	wire						PSLVERR,
output	reg 	[31:0]				PADDRS,
output	wire						PWRITES,
output	wire						PENABLES,
output	wire	[31:0]				PWDATAS,
output	wire						PSELS0,
output	wire						PSELS1,
output	wire						PSELS2,
output	wire						PSELS3,
output	wire						PSELS4,
output	wire						PSELS5,
output	wire						PSELS6,
output	wire						PSELS7,
output	wire						PSELS8,
output	wire						PSELS9,
output	wire						PSELS10,
output	wire						PSELS11,
output	wire						PSELS12,
output	wire						PSELS13,
output	wire						PSELS14,
output	wire						PSELS15,
// Slot 16 removed from MIV_APB3
//output	reg 						PSELS16,
input			[31:0]				PRDATAS0,
input			[31:0]				PRDATAS1,
input			[31:0]				PRDATAS2,
input			[31:0]				PRDATAS3,
input			[31:0]				PRDATAS4,
input			[31:0]				PRDATAS5,
input			[31:0]				PRDATAS6,
input			[31:0]				PRDATAS7,
input			[31:0]				PRDATAS8,
input			[31:0]				PRDATAS9,
input			[31:0]				PRDATAS10,
input			[31:0]				PRDATAS11,
input			[31:0]				PRDATAS12,
input			[31:0]				PRDATAS13,
input			[31:0]				PRDATAS14,
input			[31:0]				PRDATAS15,
// Slot 16 removed from MIV_APB3
//input			[31:0]				PRDATAS16,
input								PREADYS0,
input								PREADYS1,
input								PREADYS2,
input								PREADYS3,
input								PREADYS4,
input								PREADYS5,
input								PREADYS6,
input								PREADYS7,
input								PREADYS8,
input								PREADYS9,
input								PREADYS10,
input								PREADYS11,
input								PREADYS12,
input								PREADYS13,
input								PREADYS14,
input								PREADYS15,
// Slot 16 removed from MIV_APB3
//input								PREADYS16,
input								PSLVERRS0,
input								PSLVERRS1,
input								PSLVERRS2,
input								PSLVERRS3,
input								PSLVERRS4,
input								PSLVERRS5,
input								PSLVERRS6,
input								PSLVERRS7,
input								PSLVERRS8,
input								PSLVERRS9,
input								PSLVERRS10,
input								PSLVERRS11,
input								PSLVERRS12,
input								PSLVERRS13,
input								PSLVERRS14,
input								PSLVERRS15
// Slot 16 removed from MIV_APB3 ,
//input								PSLVERRS16
);
//----------------------------------------------------------------------
// Constant declarations
//----------------------------------------------------------------------
//----------------------------------------------------------------------
localparam  [0:0] L_APBSLOT15_REG_EN   = 1;              // APB Slot 15 Reserverd Register Address Space Enable
localparam [31:0] L_VERSION_NUM_ADDR   = 28'hFFFFBFC;
localparam [31:0] L_MIV_VERSION_NUM    = 32'h020000C8;   // MIV Version Number Register Address (RO) - {MAJOR[31:24], MINOR [23:16] BUILD[15:0]}
//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Fixed localparam values in MIV_APB3
//----------------------------------------------------------------------
localparam [5:0]  APB_DWIDTH	     = 32;
localparam        IADDR_OPTION       = 0;
localparam [5:0]  MADDR_BITS         = 28;
localparam [3:0]  UPR_NIBBLE_POSN    = 6;
localparam  [0:0] SC_0               = 0;
localparam  [0:0] SC_1               = 0;
localparam  [0:0] SC_2               = 0;
localparam  [0:0] SC_3               = 0;
localparam  [0:0] SC_4               = 0;
localparam  [0:0] SC_5               = 0;
localparam  [0:0] SC_6               = 0;
localparam  [0:0] SC_7               = 0;
localparam  [0:0] SC_8               = 0;
localparam  [0:0] SC_9               = 0;
localparam  [0:0] SC_10              = 0;
localparam  [0:0] SC_11              = 0;
localparam  [0:0] SC_12              = 0;
localparam  [0:0] SC_13              = 0;
localparam  [0:0] SC_14              = 0;
localparam  [0:0] SC_15              = 0;
//----------------------------------------------------------------------
localparam IADDR_NOTINUSE =  0;
localparam IADDR_EXTERNAL =  1;
localparam IADDR_SLOT0    =  2;
localparam IADDR_SLOT1    =  3;
localparam IADDR_SLOT2    =  4;
localparam IADDR_SLOT3    =  5;
localparam IADDR_SLOT4    =  6;
localparam IADDR_SLOT5    =  7;
localparam IADDR_SLOT6    =  8;
localparam IADDR_SLOT7    =  9;
localparam IADDR_SLOT8    = 10;
localparam IADDR_SLOT9    = 11;
localparam IADDR_SLOT10   = 12;
localparam IADDR_SLOT11   = 13;
localparam IADDR_SLOT12   = 14;
localparam IADDR_SLOT13   = 15;
localparam IADDR_SLOT14   = 16;
localparam IADDR_SLOT15   = 17;
localparam [15:0] SL0  = (APBSLOT0ENABLE  || SC_0  || (IADDR_OPTION == IADDR_SLOT0 )) * (2**0);
localparam [15:0] SL1  = (APBSLOT1ENABLE  || SC_1  || (IADDR_OPTION == IADDR_SLOT1 )) * (2**1);
localparam [15:0] SL2  = (APBSLOT2ENABLE  || SC_2  || (IADDR_OPTION == IADDR_SLOT2 )) * (2**2);
localparam [15:0] SL3  = (APBSLOT3ENABLE  || SC_3  || (IADDR_OPTION == IADDR_SLOT3 )) * (2**3);
localparam [15:0] SL4  = (APBSLOT4ENABLE  || SC_4  || (IADDR_OPTION == IADDR_SLOT4 )) * (2**4);
localparam [15:0] SL5  = (APBSLOT5ENABLE  || SC_5  || (IADDR_OPTION == IADDR_SLOT5 )) * (2**5);
localparam [15:0] SL6  = (APBSLOT6ENABLE  || SC_6  || (IADDR_OPTION == IADDR_SLOT6 )) * (2**6);
localparam [15:0] SL7  = (APBSLOT7ENABLE  || SC_7  || (IADDR_OPTION == IADDR_SLOT7 )) * (2**7);
localparam [15:0] SL8  = (APBSLOT8ENABLE  || SC_8  || (IADDR_OPTION == IADDR_SLOT8 )) * (2**8);
localparam [15:0] SL9  = (APBSLOT9ENABLE  || SC_9  || (IADDR_OPTION == IADDR_SLOT9 )) * (2**9);
localparam [15:0] SL10 = (APBSLOT10ENABLE || SC_10 || (IADDR_OPTION == IADDR_SLOT10)) * (2**10);
localparam [15:0] SL11 = (APBSLOT11ENABLE || SC_11 || (IADDR_OPTION == IADDR_SLOT11)) * (2**11);
localparam [15:0] SL12 = (APBSLOT12ENABLE || SC_12 || (IADDR_OPTION == IADDR_SLOT12)) * (2**12);
localparam [15:0] SL13 = (APBSLOT13ENABLE || SC_13 || (IADDR_OPTION == IADDR_SLOT13)) * (2**13);
localparam [15:0] SL14 = (APBSLOT14ENABLE || SC_14 || (IADDR_OPTION == IADDR_SLOT14)) * (2**14);
localparam [15:0] SL15 = (APBSLOT15ENABLE || SC_15 || (IADDR_OPTION == IADDR_SLOT15)) * (2**15);
localparam [15:0]SC = {
    SC_15,
    SC_14,
    SC_13,
    SC_12,
    SC_11,
    SC_10,
    SC_9,
    SC_8,
    SC_7,
    SC_6,
    SC_5,
    SC_4,
    SC_3,
    SC_2,
    SC_1,
    SC_0
};
localparam [15:0] SC_qual = SC
                                & {
									(IADDR_OPTION != IADDR_SLOT15),
									(IADDR_OPTION != IADDR_SLOT14),
									(IADDR_OPTION != IADDR_SLOT13),
									(IADDR_OPTION != IADDR_SLOT12),
									(IADDR_OPTION != IADDR_SLOT11),
									(IADDR_OPTION != IADDR_SLOT10),
									(IADDR_OPTION != IADDR_SLOT9 ),
									(IADDR_OPTION != IADDR_SLOT8 ),
									(IADDR_OPTION != IADDR_SLOT7 ),
									(IADDR_OPTION != IADDR_SLOT6 ),
									(IADDR_OPTION != IADDR_SLOT5 ),
									(IADDR_OPTION != IADDR_SLOT4 ),
									(IADDR_OPTION != IADDR_SLOT3 ),
									(IADDR_OPTION != IADDR_SLOT2 ),
									(IADDR_OPTION != IADDR_SLOT1 ),
									(IADDR_OPTION != IADDR_SLOT0 )
                                };

wire	[31:0] iPRDATA;
wire	[31:0] iPRDATAS0;
wire	[31:0] iPRDATAS1;
wire	[31:0] iPRDATAS2;
wire	[31:0] iPRDATAS3;
wire	[31:0] iPRDATAS4;
wire	[31:0] iPRDATAS5;
wire	[31:0] iPRDATAS6;
wire	[31:0] iPRDATAS7;
wire	[31:0] iPRDATAS8;
wire	[31:0] iPRDATAS9;
wire	[31:0] iPRDATAS10;
wire	[31:0] iPRDATAS11;
wire	[31:0] iPRDATAS12;
wire	[31:0] iPRDATAS13;
wire	[31:0] iPRDATAS14;
wire	[31:0] iPRDATAS15;
wire	[31:0] IA_PRDATA;
wire	[15:0] iPREADYS;
wire	[15:0] iPSLVERRS;
reg		[15:0] iPSELS_raw;
reg		[15:0] iPSELS;   
reg     [31:0] PRDATA_RES;
wire           PREADY_RES;
wire           PSLVERR_RES;
wire	[3:0]	slotSel;
wire    [31:0]  IADDR_REG;
wire    [31:0]  infill;
wire    [31:0]  infill_upr;
wire	[31:0]	TieOffLo32;	
wire			TieOffHi;	
wire			TieOffLo;	
wire            PrdataEn;
reg             reserve_addr_det;
assign TieOffLo32	= 32'b0;
assign TieOffHi		= 1'b1;
assign TieOffLo		= 1'b0;
assign PWRITES	= PWRITE;
assign PENABLES	= PENABLE;
assign PWDATAS	= PWDATA[31:0];
assign slotSel = PADDR[MADDR_BITS-1:MADDR_BITS-4];

assign reserve_addr_det = ((L_APBSLOT15_REG_EN) & ((PADDR[27:0] >= 28'hFFFF000) && (PADDR[27:0] <= 28'hFFFFFFF))) ? 1'b1 : 1'b0;

always @ (*)
begin
	if (PSEL == 1'b1)
	begin
		case (slotSel)
			4'b0000: iPSELS_raw = SL0;
			4'b0001: iPSELS_raw = SL1;
			4'b0010: iPSELS_raw = SL2;
			4'b0011: iPSELS_raw = SL3;
			4'b0100: iPSELS_raw = SL4;
			4'b0101: iPSELS_raw = SL5;
			4'b0110: iPSELS_raw = SL6;
			4'b0111: iPSELS_raw = SL7;
			4'b1000: iPSELS_raw = SL8;
			4'b1001: iPSELS_raw = SL9;
			4'b1010: iPSELS_raw = SL10;
			4'b1011: iPSELS_raw = SL11;
			4'b1100: iPSELS_raw = SL12;
			4'b1101: iPSELS_raw = SL13;
			4'b1110: iPSELS_raw = SL14;
			4'b1111: iPSELS_raw = (reserve_addr_det) ? 16'h8000 : SL15;
			default: iPSELS_raw = 16'b0000000000000000;
		endcase
        iPSELS[15:0] = iPSELS_raw & ~SC_qual;
		//Removed from MIV_APB3
        //PSELS16 = |(iPSELS_raw & SC_qual);
	end
	else
	begin
		iPSELS = 16'b0000000000000000;
		iPSELS_raw = 16'b0000000000000000;
	end
end
generate
begin: g_tieoffs
    if (IADDR_OPTION == IADDR_SLOT0)  assign  iPRDATAS0[31:0] = IA_PRDATA[31:0];
    else if (APBSLOT0ENABLE)          assign  iPRDATAS0[31:0] = PRDATAS0[31:0];
    else                              assign  iPRDATAS0[31:0] = TieOffLo32;
    if (IADDR_OPTION == IADDR_SLOT1)  assign  iPRDATAS1[31:0] = IA_PRDATA[31:0];
    else if (APBSLOT1ENABLE)          assign  iPRDATAS1[31:0] = PRDATAS1[31:0];
    else                              assign  iPRDATAS1[31:0] = TieOffLo32;
    if (IADDR_OPTION == IADDR_SLOT2)  assign  iPRDATAS2[31:0] = IA_PRDATA[31:0];
    else if (APBSLOT2ENABLE)          assign  iPRDATAS2[31:0] = PRDATAS2[31:0];
    else                              assign  iPRDATAS2[31:0] = TieOffLo32;
    if (IADDR_OPTION == IADDR_SLOT3)  assign  iPRDATAS3[31:0] = IA_PRDATA[31:0];
    else if (APBSLOT3ENABLE)          assign  iPRDATAS3[31:0] = PRDATAS3[31:0];
    else                              assign  iPRDATAS3[31:0] = TieOffLo32;
    if (IADDR_OPTION == IADDR_SLOT4)  assign  iPRDATAS4[31:0] = IA_PRDATA[31:0];
    else if (APBSLOT4ENABLE)          assign  iPRDATAS4[31:0] = PRDATAS4[31:0];
    else                              assign  iPRDATAS4[31:0] = TieOffLo32;
    if (IADDR_OPTION == IADDR_SLOT5)  assign  iPRDATAS5[31:0] = IA_PRDATA[31:0];
    else if (APBSLOT5ENABLE)          assign  iPRDATAS5[31:0] = PRDATAS5[31:0];
    else                              assign  iPRDATAS5[31:0] = TieOffLo32;
    if (IADDR_OPTION == IADDR_SLOT6)  assign  iPRDATAS6[31:0] = IA_PRDATA[31:0];
    else if (APBSLOT6ENABLE)          assign  iPRDATAS6[31:0] = PRDATAS6[31:0];
    else                              assign  iPRDATAS6[31:0] = TieOffLo32;
    if (IADDR_OPTION == IADDR_SLOT7)  assign  iPRDATAS7[31:0] = IA_PRDATA[31:0];
    else if (APBSLOT7ENABLE)          assign  iPRDATAS7[31:0] = PRDATAS7[31:0];
    else                              assign  iPRDATAS7[31:0] = TieOffLo32;
    if (IADDR_OPTION == IADDR_SLOT8)  assign  iPRDATAS8[31:0] = IA_PRDATA[31:0];
    else if (APBSLOT8ENABLE)          assign  iPRDATAS8[31:0] = PRDATAS8[31:0];
    else                              assign  iPRDATAS8[31:0] = TieOffLo32;
    if (IADDR_OPTION == IADDR_SLOT9)  assign  iPRDATAS9[31:0] = IA_PRDATA[31:0];
    else if (APBSLOT9ENABLE)          assign  iPRDATAS9[31:0] = PRDATAS9[31:0];
    else                              assign  iPRDATAS9[31:0] = TieOffLo32;
    if (IADDR_OPTION == IADDR_SLOT10) assign iPRDATAS10[31:0] = IA_PRDATA[31:0];
    else if (APBSLOT10ENABLE)         assign iPRDATAS10[31:0] = PRDATAS10[31:0];
    else                              assign iPRDATAS10[31:0] = TieOffLo32;
    if (IADDR_OPTION == IADDR_SLOT11) assign iPRDATAS11[31:0] = IA_PRDATA[31:0];
    else if (APBSLOT11ENABLE)         assign iPRDATAS11[31:0] = PRDATAS11[31:0];
    else                              assign iPRDATAS11[31:0] = TieOffLo32;
    if (IADDR_OPTION == IADDR_SLOT12) assign iPRDATAS12[31:0] = IA_PRDATA[31:0];
    else if (APBSLOT12ENABLE)         assign iPRDATAS12[31:0] = PRDATAS12[31:0];
    else                              assign iPRDATAS12[31:0] = TieOffLo32;
    if (IADDR_OPTION == IADDR_SLOT13) assign iPRDATAS13[31:0] = IA_PRDATA[31:0];
    else if (APBSLOT13ENABLE)         assign iPRDATAS13[31:0] = PRDATAS13[31:0];
    else                              assign iPRDATAS13[31:0] = TieOffLo32;
    if (IADDR_OPTION == IADDR_SLOT14) assign iPRDATAS14[31:0] = IA_PRDATA[31:0];
    else if (APBSLOT14ENABLE)         assign iPRDATAS14[31:0] = PRDATAS14[31:0];
    else                              assign iPRDATAS14[31:0] = TieOffLo32;
    if (IADDR_OPTION == IADDR_SLOT15) assign iPRDATAS15[31:0] = IA_PRDATA[31:0];
    else if (APBSLOT15ENABLE || L_APBSLOT15_REG_EN)         
	                                  assign iPRDATAS15[31:0] = (reserve_addr_det) ? PRDATA_RES : PRDATAS15[31:0];
    else                              assign iPRDATAS15[31:0] = TieOffLo32;
    if (IADDR_OPTION == IADDR_SLOT0)  assign iPREADYS[ 0] = TieOffHi;
    else if (APBSLOT0ENABLE)          assign iPREADYS[ 0] = PREADYS0;
    else                              assign iPREADYS[ 0] = TieOffHi;
    if (IADDR_OPTION == IADDR_SLOT1)  assign iPREADYS[ 1] = TieOffHi;
    else if (APBSLOT1ENABLE)          assign iPREADYS[ 1] = PREADYS1;
    else                              assign iPREADYS[ 1] = TieOffHi;
    if (IADDR_OPTION == IADDR_SLOT2)  assign iPREADYS[ 2] = TieOffHi;
    else if (APBSLOT2ENABLE)          assign iPREADYS[ 2] = PREADYS2;
    else                              assign iPREADYS[ 2] = TieOffHi;
    if (IADDR_OPTION == IADDR_SLOT3)  assign iPREADYS[ 3] = TieOffHi;
    else if (APBSLOT3ENABLE)          assign iPREADYS[ 3] = PREADYS3;
    else                              assign iPREADYS[ 3] = TieOffHi;
    if (IADDR_OPTION == IADDR_SLOT4)  assign iPREADYS[ 4] = TieOffHi;
    else if (APBSLOT4ENABLE)          assign iPREADYS[ 4] = PREADYS4;
    else                              assign iPREADYS[ 4] = TieOffHi;
    if (IADDR_OPTION == IADDR_SLOT5)  assign iPREADYS[ 5] = TieOffHi;
    else if (APBSLOT5ENABLE)          assign iPREADYS[ 5] = PREADYS5;
    else                              assign iPREADYS[ 5] = TieOffHi;
    if (IADDR_OPTION == IADDR_SLOT6)  assign iPREADYS[ 6] = TieOffHi;
    else if (APBSLOT6ENABLE)          assign iPREADYS[ 6] = PREADYS6;
    else                              assign iPREADYS[ 6] = TieOffHi;
    if (IADDR_OPTION == IADDR_SLOT7)  assign iPREADYS[ 7] = TieOffHi;
    else if (APBSLOT7ENABLE)          assign iPREADYS[ 7] = PREADYS7;
    else                              assign iPREADYS[ 7] = TieOffHi;
    if (IADDR_OPTION == IADDR_SLOT8)  assign iPREADYS[ 8] = TieOffHi;
    else if (APBSLOT8ENABLE)          assign iPREADYS[ 8] = PREADYS8;
    else                              assign iPREADYS[ 8] = TieOffHi;
    if (IADDR_OPTION == IADDR_SLOT9)  assign iPREADYS[ 9] = TieOffHi;
    else if (APBSLOT9ENABLE)          assign iPREADYS[ 9] = PREADYS9;
    else                              assign iPREADYS[ 9] = TieOffHi;
    if (IADDR_OPTION == IADDR_SLOT10) assign iPREADYS[10] = TieOffHi;
    else if (APBSLOT10ENABLE)         assign iPREADYS[10] = PREADYS10;
    else                              assign iPREADYS[10] = TieOffHi;
    if (IADDR_OPTION == IADDR_SLOT11) assign iPREADYS[11] = TieOffHi;
    else if (APBSLOT11ENABLE)         assign iPREADYS[11] = PREADYS11;
    else                              assign iPREADYS[11] = TieOffHi;
    if (IADDR_OPTION == IADDR_SLOT12) assign iPREADYS[12] = TieOffHi;
    else if (APBSLOT12ENABLE)         assign iPREADYS[12] = PREADYS12;
    else                              assign iPREADYS[12] = TieOffHi;
    if (IADDR_OPTION == IADDR_SLOT13) assign iPREADYS[13] = TieOffHi;
    else if (APBSLOT13ENABLE)         assign iPREADYS[13] = PREADYS13;
    else                              assign iPREADYS[13] = TieOffHi;
    if (IADDR_OPTION == IADDR_SLOT14) assign iPREADYS[14] = TieOffHi;
    else if (APBSLOT14ENABLE)         assign iPREADYS[14] = PREADYS14;
    else                              assign iPREADYS[14] = TieOffHi;
    if (IADDR_OPTION == IADDR_SLOT15) assign iPREADYS[15] = TieOffHi;
    else if (APBSLOT15ENABLE || L_APBSLOT15_REG_EN)         
	                                  assign iPREADYS[15] = (reserve_addr_det) ? PREADY_RES : PREADYS15; 
    else                              assign iPREADYS[15] = TieOffHi;
    if (IADDR_OPTION == IADDR_SLOT0)  assign iPSLVERRS[ 0] = TieOffLo;
    else if (APBSLOT0ENABLE)          assign iPSLVERRS[ 0] = PSLVERRS0;
    else                              assign iPSLVERRS[ 0] = TieOffLo;
    if (IADDR_OPTION == IADDR_SLOT1)  assign iPSLVERRS[ 1] = TieOffLo;
    else if (APBSLOT1ENABLE)          assign iPSLVERRS[ 1] = PSLVERRS1;
    else                              assign iPSLVERRS[ 1] = TieOffLo;
    if (IADDR_OPTION == IADDR_SLOT2)  assign iPSLVERRS[ 2] = TieOffLo;
    else if (APBSLOT2ENABLE)          assign iPSLVERRS[ 2] = PSLVERRS2;
    else                              assign iPSLVERRS[ 2] = TieOffLo;
    if (IADDR_OPTION == IADDR_SLOT3)  assign iPSLVERRS[ 3] = TieOffLo;
    else if (APBSLOT3ENABLE)          assign iPSLVERRS[ 3] = PSLVERRS3;
    else                              assign iPSLVERRS[ 3] = TieOffLo;
    if (IADDR_OPTION == IADDR_SLOT4)  assign iPSLVERRS[ 4] = TieOffLo;
    else if (APBSLOT4ENABLE)          assign iPSLVERRS[ 4] = PSLVERRS4;
    else                              assign iPSLVERRS[ 4] = TieOffLo;
    if (IADDR_OPTION == IADDR_SLOT5)  assign iPSLVERRS[ 5] = TieOffLo;
    else if (APBSLOT5ENABLE)          assign iPSLVERRS[ 5] = PSLVERRS5;
    else                              assign iPSLVERRS[ 5] = TieOffLo;
    if (IADDR_OPTION == IADDR_SLOT6)  assign iPSLVERRS[ 6] = TieOffLo;
    else if (APBSLOT6ENABLE)          assign iPSLVERRS[ 6] = PSLVERRS6;
    else                              assign iPSLVERRS[ 6] = TieOffLo;
    if (IADDR_OPTION == IADDR_SLOT7)  assign iPSLVERRS[ 7] = TieOffLo;
    else if (APBSLOT7ENABLE)          assign iPSLVERRS[ 7] = PSLVERRS7;
    else                              assign iPSLVERRS[ 7] = TieOffLo;
    if (IADDR_OPTION == IADDR_SLOT8)  assign iPSLVERRS[ 8] = TieOffLo;
    else if (APBSLOT8ENABLE)          assign iPSLVERRS[ 8] = PSLVERRS8;
    else                              assign iPSLVERRS[ 8] = TieOffLo;
    if (IADDR_OPTION == IADDR_SLOT9)  assign iPSLVERRS[ 9] = TieOffLo;
    else if (APBSLOT9ENABLE)          assign iPSLVERRS[ 9] = PSLVERRS9;
    else                              assign iPSLVERRS[ 9] = TieOffLo;
    if (IADDR_OPTION == IADDR_SLOT10) assign iPSLVERRS[10] = TieOffLo;
    else if (APBSLOT10ENABLE)         assign iPSLVERRS[10] = PSLVERRS10;
    else                              assign iPSLVERRS[10] = TieOffLo;
    if (IADDR_OPTION == IADDR_SLOT11) assign iPSLVERRS[11] = TieOffLo;
    else if (APBSLOT11ENABLE)         assign iPSLVERRS[11] = PSLVERRS11;
    else                              assign iPSLVERRS[11] = TieOffLo;
    if (IADDR_OPTION == IADDR_SLOT12) assign iPSLVERRS[12] = TieOffLo;
    else if (APBSLOT12ENABLE)         assign iPSLVERRS[12] = PSLVERRS12;
    else                              assign iPSLVERRS[12] = TieOffLo;
    if (IADDR_OPTION == IADDR_SLOT13) assign iPSLVERRS[13] = TieOffLo;
    else if (APBSLOT13ENABLE)         assign iPSLVERRS[13] = PSLVERRS13;
    else                              assign iPSLVERRS[13] = TieOffLo;
    if (IADDR_OPTION == IADDR_SLOT14) assign iPSLVERRS[14] = TieOffLo;
    else if (APBSLOT14ENABLE)         assign iPSLVERRS[14] = PSLVERRS14;
    else                              assign iPSLVERRS[14] = TieOffLo;
    if (IADDR_OPTION == IADDR_SLOT15) assign iPSLVERRS[15] = TieOffLo;
    else if (APBSLOT15ENABLE || L_APBSLOT15_REG_EN)         
	                                  assign iPSLVERRS[15] = (reserve_addr_det) ? PSLVERR_RES : PSLVERRS15;
    else                              assign iPSLVERRS[15] = TieOffLo;
end
endgenerate
MIV_APB3_MUXPTOB3 u_mux_p_to_b3 (
	.PSELS		({1'b0, iPSELS[15:0]}), // PSELS16 always 0 in MIV_APB3
	.PRDATAS0	(iPRDATAS0[31:0]),
	.PRDATAS1	(iPRDATAS1[31:0]),
	.PRDATAS2	(iPRDATAS2[31:0]),
	.PRDATAS3	(iPRDATAS3[31:0]),
	.PRDATAS4	(iPRDATAS4[31:0]),
	.PRDATAS5	(iPRDATAS5[31:0]),
	.PRDATAS6	(iPRDATAS6[31:0]),
	.PRDATAS7	(iPRDATAS7[31:0]),
	.PRDATAS8	(iPRDATAS8[31:0]),
	.PRDATAS9	(iPRDATAS9[31:0]),
	.PRDATAS10	(iPRDATAS10[31:0]),
	.PRDATAS11	(iPRDATAS11[31:0]),
	.PRDATAS12	(iPRDATAS12[31:0]),
	.PRDATAS13	(iPRDATAS13[31:0]),
	.PRDATAS14	(iPRDATAS14[31:0]),
	.PRDATAS15	(iPRDATAS15[31:0]),
	// Slot 16 removed from MIV_APB3=
	//.PRDATAS16 (PRDATAS16[31:0]),
	//.PREADYS	 ({PREADYS16, iPREADYS[15:0]}),
	//.PSLVERRS  ({PSLVERRS16, iPSLVERRS[15:0]}),
	.PRDATAS16	(32'b0),
	.PREADYS	({1'b0, iPREADYS[15:0]}),
	.PSLVERRS	({1'b0, iPSLVERRS[15:0]}),
	.PREADY		(PREADY),
	.PSLVERR	(PSLVERR),
	.PRDATA		(iPRDATA[31:0])
);
assign PRDATA[31:0] = iPRDATA[31:0];
generate
begin: g_psels
    if (IADDR_OPTION == IADDR_SLOT0 ) assign PSELS0  = 1'b0; else assign PSELS0  = iPSELS[ 0];
    if (IADDR_OPTION == IADDR_SLOT1 ) assign PSELS1  = 1'b0; else assign PSELS1  = iPSELS[ 1];
    if (IADDR_OPTION == IADDR_SLOT2 ) assign PSELS2  = 1'b0; else assign PSELS2  = iPSELS[ 2];
    if (IADDR_OPTION == IADDR_SLOT3 ) assign PSELS3  = 1'b0; else assign PSELS3  = iPSELS[ 3];
    if (IADDR_OPTION == IADDR_SLOT4 ) assign PSELS4  = 1'b0; else assign PSELS4  = iPSELS[ 4];
    if (IADDR_OPTION == IADDR_SLOT5 ) assign PSELS5  = 1'b0; else assign PSELS5  = iPSELS[ 5];
    if (IADDR_OPTION == IADDR_SLOT6 ) assign PSELS6  = 1'b0; else assign PSELS6  = iPSELS[ 6];
    if (IADDR_OPTION == IADDR_SLOT7 ) assign PSELS7  = 1'b0; else assign PSELS7  = iPSELS[ 7];
    if (IADDR_OPTION == IADDR_SLOT8 ) assign PSELS8  = 1'b0; else assign PSELS8  = iPSELS[ 8];
    if (IADDR_OPTION == IADDR_SLOT9 ) assign PSELS9  = 1'b0; else assign PSELS9  = iPSELS[ 9];
    if (IADDR_OPTION == IADDR_SLOT10) assign PSELS10 = 1'b0; else assign PSELS10 = iPSELS[10];
    if (IADDR_OPTION == IADDR_SLOT11) assign PSELS11 = 1'b0; else assign PSELS11 = iPSELS[11];
    if (IADDR_OPTION == IADDR_SLOT12) assign PSELS12 = 1'b0; else assign PSELS12 = iPSELS[12];
    if (IADDR_OPTION == IADDR_SLOT13) assign PSELS13 = 1'b0; else assign PSELS13 = iPSELS[13];
    if (IADDR_OPTION == IADDR_SLOT14) assign PSELS14 = 1'b0; else assign PSELS14 = iPSELS[14];
    if (IADDR_OPTION == IADDR_SLOT15) assign PSELS15 = 1'b0; else assign PSELS15 = iPSELS[15];
end
endgenerate
generate
begin: g_iaddr_reg
    if (IADDR_OPTION == IADDR_NOTINUSE) assign IADDR_REG = 32'b0;
    if (IADDR_OPTION == IADDR_EXTERNAL) assign IADDR_REG = 32'b0;                                            // PCLK tied to 1'b0 and PRESETN tied to 1'b1 since they are removed from MIV_APB
    if (IADDR_OPTION == IADDR_SLOT0 ) miv_apb3_iaddr_reg #(SYNC_RESET, APB_DWIDTH, MADDR_BITS) iaddr_reg (1'b0, 1'b1, PENABLE, iPSELS[ 0], PADDR, PWRITE, PWDATA, IA_PRDATA, IADDR_REG);
    if (IADDR_OPTION == IADDR_SLOT1 ) miv_apb3_iaddr_reg #(SYNC_RESET, APB_DWIDTH, MADDR_BITS) iaddr_reg (1'b0, 1'b1, PENABLE, iPSELS[ 1], PADDR, PWRITE, PWDATA, IA_PRDATA, IADDR_REG);
    if (IADDR_OPTION == IADDR_SLOT2 ) miv_apb3_iaddr_reg #(SYNC_RESET, APB_DWIDTH, MADDR_BITS) iaddr_reg (1'b0, 1'b1, PENABLE, iPSELS[ 2], PADDR, PWRITE, PWDATA, IA_PRDATA, IADDR_REG);
    if (IADDR_OPTION == IADDR_SLOT3 ) miv_apb3_iaddr_reg #(SYNC_RESET, APB_DWIDTH, MADDR_BITS) iaddr_reg (1'b0, 1'b1, PENABLE, iPSELS[ 3], PADDR, PWRITE, PWDATA, IA_PRDATA, IADDR_REG);
    if (IADDR_OPTION == IADDR_SLOT4 ) miv_apb3_iaddr_reg #(SYNC_RESET, APB_DWIDTH, MADDR_BITS) iaddr_reg (1'b0, 1'b1, PENABLE, iPSELS[ 4], PADDR, PWRITE, PWDATA, IA_PRDATA, IADDR_REG);
    if (IADDR_OPTION == IADDR_SLOT5 ) miv_apb3_iaddr_reg #(SYNC_RESET, APB_DWIDTH, MADDR_BITS) iaddr_reg (1'b0, 1'b1, PENABLE, iPSELS[ 5], PADDR, PWRITE, PWDATA, IA_PRDATA, IADDR_REG);
    if (IADDR_OPTION == IADDR_SLOT6 ) miv_apb3_iaddr_reg #(SYNC_RESET, APB_DWIDTH, MADDR_BITS) iaddr_reg (1'b0, 1'b1, PENABLE, iPSELS[ 6], PADDR, PWRITE, PWDATA, IA_PRDATA, IADDR_REG);
    if (IADDR_OPTION == IADDR_SLOT7 ) miv_apb3_iaddr_reg #(SYNC_RESET, APB_DWIDTH, MADDR_BITS) iaddr_reg (1'b0, 1'b1, PENABLE, iPSELS[ 7], PADDR, PWRITE, PWDATA, IA_PRDATA, IADDR_REG);
    if (IADDR_OPTION == IADDR_SLOT8 ) miv_apb3_iaddr_reg #(SYNC_RESET, APB_DWIDTH, MADDR_BITS) iaddr_reg (1'b0, 1'b1, PENABLE, iPSELS[ 8], PADDR, PWRITE, PWDATA, IA_PRDATA, IADDR_REG);
    if (IADDR_OPTION == IADDR_SLOT9 ) miv_apb3_iaddr_reg #(SYNC_RESET, APB_DWIDTH, MADDR_BITS) iaddr_reg (1'b0, 1'b1, PENABLE, iPSELS[ 9], PADDR, PWRITE, PWDATA, IA_PRDATA, IADDR_REG);
    if (IADDR_OPTION == IADDR_SLOT10) miv_apb3_iaddr_reg #(SYNC_RESET, APB_DWIDTH, MADDR_BITS) iaddr_reg (1'b0, 1'b1, PENABLE, iPSELS[10], PADDR, PWRITE, PWDATA, IA_PRDATA, IADDR_REG);
    if (IADDR_OPTION == IADDR_SLOT11) miv_apb3_iaddr_reg #(SYNC_RESET, APB_DWIDTH, MADDR_BITS) iaddr_reg (1'b0, 1'b1, PENABLE, iPSELS[11], PADDR, PWRITE, PWDATA, IA_PRDATA, IADDR_REG);
    if (IADDR_OPTION == IADDR_SLOT12) miv_apb3_iaddr_reg #(SYNC_RESET, APB_DWIDTH, MADDR_BITS) iaddr_reg (1'b0, 1'b1, PENABLE, iPSELS[12], PADDR, PWRITE, PWDATA, IA_PRDATA, IADDR_REG);
    if (IADDR_OPTION == IADDR_SLOT13) miv_apb3_iaddr_reg #(SYNC_RESET, APB_DWIDTH, MADDR_BITS) iaddr_reg (1'b0, 1'b1, PENABLE, iPSELS[13], PADDR, PWRITE, PWDATA, IA_PRDATA, IADDR_REG);
    if (IADDR_OPTION == IADDR_SLOT14) miv_apb3_iaddr_reg #(SYNC_RESET, APB_DWIDTH, MADDR_BITS) iaddr_reg (1'b0, 1'b1, PENABLE, iPSELS[14], PADDR, PWRITE, PWDATA, IA_PRDATA, IADDR_REG);
    if (IADDR_OPTION == IADDR_SLOT15) miv_apb3_iaddr_reg #(SYNC_RESET, APB_DWIDTH, MADDR_BITS) iaddr_reg (1'b0, 1'b1, PENABLE, iPSELS[15], PADDR, PWRITE, PWDATA, IA_PRDATA, IADDR_REG);
end
endgenerate
generate
begin
    if (IADDR_OPTION == IADDR_NOTINUSE)
    begin
        assign infill_upr = PADDR;
        assign infill     = 32'b0;
    end
    else if (IADDR_OPTION == IADDR_EXTERNAL)
    begin
	    //  Removed in MIV_APB3
        //assign infill_upr = IADDR;
        //assign infill     = IADDR;
        assign infill_upr = 32'b0;
        assign infill     = 32'b0;
    end
    else
    begin
        assign infill_upr = IADDR_REG;
        assign infill     = IADDR_REG;
    end
end
endgenerate
generate if (MADDR_BITS == 12)
begin
    always @(*)
        case (UPR_NIBBLE_POSN)
            2: PADDRS = {infill_upr[31:12], PADDR[11:0]};
            3: PADDRS = {infill_upr[31:16], PADDR[11:8], infill[11:8], PADDR[7:0]};
            4: PADDRS = {infill_upr[31:20], PADDR[11:8], infill[15:8], PADDR[7:0]};
            5: PADDRS = {infill_upr[31:24], PADDR[11:8], infill[19:8], PADDR[7:0]};
            6: PADDRS = {infill_upr[31:28], PADDR[11:8], infill[23:8], PADDR[7:0]};
            7: PADDRS = {                   PADDR[11:8], infill[27:8], PADDR[7:0]};
            8: PADDRS = {                                infill[31:8], PADDR[7:0]};
        endcase
end
endgenerate
generate if (MADDR_BITS == 16)
begin
    always @(*)
        case (UPR_NIBBLE_POSN)
            2: PADDRS = {infill_upr[31:16], PADDR[15:0]};
            3: PADDRS = {infill_upr[31:16], PADDR[15:0]};
            4: PADDRS = {infill_upr[31:20], PADDR[15:12], infill[15:12], PADDR[11:0]};
            5: PADDRS = {infill_upr[31:24], PADDR[15:12], infill[19:12], PADDR[11:0]};
            6: PADDRS = {infill_upr[31:28], PADDR[15:12], infill[23:12], PADDR[11:0]};
            7: PADDRS = {                   PADDR[15:12], infill[27:12], PADDR[11:0]};
            8: PADDRS = {                                 infill[31:12], PADDR[11:0]};
        endcase
end
endgenerate
generate if (MADDR_BITS == 20)
begin
    always @(*)
        case (UPR_NIBBLE_POSN)
            2: PADDRS = {infill_upr[31:20], PADDR[19:0]};
            3: PADDRS = {infill_upr[31:20], PADDR[19:0]};
            4: PADDRS = {infill_upr[31:20], PADDR[19:0]};
            5: PADDRS = {infill_upr[31:24], PADDR[19:16], infill[19:16], PADDR[15:0]};
            6: PADDRS = {infill_upr[31:28], PADDR[19:16], infill[23:16], PADDR[15:0]};
            7: PADDRS = {                   PADDR[19:16], infill[27:16], PADDR[15:0]};
            8: PADDRS = {                                 infill[31:16], PADDR[15:0]};
        endcase
end
endgenerate
generate if (MADDR_BITS == 24)
begin
    always @(*)
        case (UPR_NIBBLE_POSN)
            2: PADDRS = {infill_upr[31:24], PADDR[23:0]};
            3: PADDRS = {infill_upr[31:24], PADDR[23:0]};
            4: PADDRS = {infill_upr[31:24], PADDR[23:0]};
            5: PADDRS = {infill_upr[31:24], PADDR[23:0]};
            6: PADDRS = {infill_upr[31:28], PADDR[23:20], infill[23:20], PADDR[19:0]};
            7: PADDRS = {                   PADDR[23:20], infill[27:20], PADDR[19:0]};
            8: PADDRS = {                                 infill[31:20], PADDR[19:0]};
        endcase
end
endgenerate
generate if (MADDR_BITS == 28)
begin
    always @(*)
        case (UPR_NIBBLE_POSN)
            2: PADDRS = {infill_upr[31:28], PADDR[27:0]};
            3: PADDRS = {infill_upr[31:28], PADDR[27:0]};
            4: PADDRS = {infill_upr[31:28], PADDR[27:0]};
            5: PADDRS = {infill_upr[31:28], PADDR[27:0]};
            6: PADDRS = {infill_upr[31:28], PADDR[27:0]};
            7: PADDRS = {                   PADDR[27:24], infill[27:24], PADDR[23:0]};
            8: PADDRS = {                                 infill[31:24], PADDR[23:0]};
        endcase
end
endgenerate
generate if (MADDR_BITS == 32)
begin
    always @(*)
        PADDRS = PADDR[31:0];
end
endgenerate

 //----------------------------------------------------------------------
 // APB read data
 //----------------------------------------------------------------------
 assign PREADY_RES  = 1'b1;
 assign PSLVERR_RES = (iPSELS[15] & PENABLE & PWRITE); 
 assign PrdataEn    = (iPSELS[15] & PENABLE & !PWRITE);

 always @(PADDR or PrdataEn)
 begin 
     if  (PrdataEn)
	   begin
         case (PADDR[27:0])
             L_VERSION_NUM_ADDR : PRDATA_RES <= L_MIV_VERSION_NUM;
			            default : PRDATA_RES <= 0;
         endcase
	   end
     else
	   begin
	     PRDATA_RES <= 0;
	   end
 end 

endmodule
