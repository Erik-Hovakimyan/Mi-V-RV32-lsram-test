// Copyright (c) 2022, Microchip Corporation
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
// Description: MiV PLIC Interrupt Enable Register.
//
// SVN Revision Information:
// SVN $Revision: 39273 $
// SVN $Date: 2021-11-08 16:13:58 +0000 (Mon, 08 Nov 2021) $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
// ****************************************************************************/
`timescale 1ns/100ps
module interrupt_enable_register(
   clock,
   resetn,
   interrupt_enable_wr_valid,
   interrupt_enable_wr_data,
   interrupt_enable_data
   );

// Input signals
input clock;
input resetn;
input interrupt_enable_wr_valid;
input [0:0] interrupt_enable_wr_data;

// output signals
output [0:0] interrupt_enable_data;

parameter SYNC_RESET = 0; 
wire aresetn;
wire sresetn;

assign aresetn = (SYNC_RESET == 1) ? 1'b1 : resetn;
assign sresetn = (SYNC_RESET == 1) ? resetn : 1'b1;

reg interrupt_enable_reg;

assign interrupt_enable_data =  interrupt_enable_reg;

always@(posedge clock or negedge aresetn)
   begin
      if((~aresetn) || (!sresetn))
         begin
            interrupt_enable_reg <= 1'b0;
         end
      else
         begin
            if (interrupt_enable_wr_valid)
               begin
                  interrupt_enable_reg <= interrupt_enable_wr_data;
               end

         end
   end

endmodule
