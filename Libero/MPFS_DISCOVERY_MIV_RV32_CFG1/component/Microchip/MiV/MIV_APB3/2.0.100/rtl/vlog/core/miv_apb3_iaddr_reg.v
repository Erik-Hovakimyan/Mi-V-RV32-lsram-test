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
// Description:	Implements indirect address registers for MIV_APB3
//
// SVN Revision Information:
// SVN $Revision: $
// SVN $Date: $
//
// *********************************************************************/
`timescale 1ns/1ps
module miv_apb3_iaddr_reg (
    PCLK,
    PRESETN,
    PENABLE,
    PSEL,
    PADDR,
    PWRITE,
    PWDATA,
    PRDATA,
    IADDR_REG
    );
	parameter               SYNC_RESET = 0;
    parameter [5:0]         APB_DWIDTH = 32;    
    parameter [5:0]         MADDR_BITS = 32;
    input                   PCLK;
    input                   PRESETN;
    input                   PENABLE;
    input                   PSEL;
    input   [31:0]          PADDR;
    input                   PWRITE;
    input   [31:0]          PWDATA;
    output  [31:0]          PRDATA;
    output  [31:0]          IADDR_REG;
    reg     [31:0]          PRDATA;
    reg     [31:0]          IADDR_REG;
    wire aresetn;
    wire sresetn; 
    assign aresetn = (SYNC_RESET==1) ? 1'b1 : PRESETN;
    assign sresetn = (SYNC_RESET==1) ? PRESETN : 1'b1;
	
    always @(posedge PCLK or negedge aresetn)
    begin
        if ((!aresetn) || (!sresetn))
        begin
            IADDR_REG <= 32'b0;
        end
        else
        begin
            if (PSEL && PENABLE && PWRITE)
            begin
                if (APB_DWIDTH == 32)
                begin
                    if (PADDR[MADDR_BITS-4-1:0] == {MADDR_BITS-4{1'b0}})
                    begin
                        IADDR_REG <= PWDATA;
                    end
                end
                if (APB_DWIDTH == 16)
                begin
                    if (PADDR[MADDR_BITS-4-1:4] == {MADDR_BITS-4-4{1'b0}})
                    begin
                        case (PADDR[3:0])
                            4'b0000: IADDR_REG[15: 0] <= PWDATA[15:0];
                            4'b0100: IADDR_REG[31:16] <= PWDATA[15:0];
                            4'b1000: IADDR_REG        <= IADDR_REG;
                            4'b1100: IADDR_REG        <= IADDR_REG;
                        endcase
                    end
                end
                if (APB_DWIDTH ==  8)
                begin
                    if (PADDR[MADDR_BITS-4-1:4] == {MADDR_BITS-4-4{1'b0}})
                    begin
                        case (PADDR[3:0])
                            4'b0000: IADDR_REG[ 7: 0] <= PWDATA[7:0];
                            4'b0100: IADDR_REG[15: 8] <= PWDATA[7:0];
                            4'b1000: IADDR_REG[23:16] <= PWDATA[7:0];
                            4'b1100: IADDR_REG[31:24] <= PWDATA[7:0];
                        endcase
                    end
                end
            end
        end
    end
    always @(*)
    begin
        PRDATA = 32'b0;
        if (APB_DWIDTH == 32)
        begin
            if (PADDR[MADDR_BITS-4-1:0] == {MADDR_BITS-4{1'b0}})
            begin
                PRDATA = IADDR_REG;
            end
        end
        if (APB_DWIDTH == 16)
        begin
            if (PADDR[MADDR_BITS-4-1:4] == {MADDR_BITS-4-4{1'b0}})
            begin
                case (PADDR[3:0])
                    4'b0000: PRDATA[15:0] = IADDR_REG[15: 0];
                    4'b0100: PRDATA[15:0] = IADDR_REG[31:16];
                    4'b1000: PRDATA       = 32'b0;
                    4'b1100: PRDATA       = 32'b0;
                endcase
            end
        end
        if (APB_DWIDTH ==  8)
        begin
            if (PADDR[MADDR_BITS-4-1:4] == {MADDR_BITS-4-4{1'b0}})
            begin
                case (PADDR[3:0])
                    4'b0000: PRDATA[7:0] = IADDR_REG[ 7: 0];
                    4'b0100: PRDATA[7:0] = IADDR_REG[15: 8];
                    4'b1000: PRDATA[7:0] = IADDR_REG[23:16];
                    4'b1100: PRDATA[7:0] = IADDR_REG[31:24];
                endcase
            end
        end
    end
endmodule
