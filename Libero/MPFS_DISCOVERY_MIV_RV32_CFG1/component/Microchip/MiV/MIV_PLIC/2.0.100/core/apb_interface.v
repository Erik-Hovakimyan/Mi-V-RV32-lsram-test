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
// Description: MiV PLIC APB Interface
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
module apb_interface (
   TARGET_PCLK,
   TARGET_PRESETn,
   TARGET_PENABLE,
   TARGET_PSEL,
   TARGET_PADDR,
   TARGET_PWRITE,
   TARGET_PWDATA,
   TARGET_PRDATA,

   interrupt_enable_wr_valid,
   interrupt_enable_wr_data,
   interrupt_enable_data,
   interrupt_claim_complete_data,
   interrupt_claim_complete_wr_valid
   
   );


   // APB Interface
   input               TARGET_PCLK;
   input               TARGET_PRESETn;
   input               TARGET_PENABLE;
   input               TARGET_PSEL;
   input       [31:0]  TARGET_PADDR;
   input               TARGET_PWRITE;
   input       [31:0]  TARGET_PWDATA;
   output reg  [31:0]  TARGET_PRDATA;
   

   // PLIC interface   
   input      [31:0]  interrupt_enable_data;
   output reg [31:0]  interrupt_enable_wr_data;
   output reg  [0:0]  interrupt_enable_wr_valid;
   input      [31:0]  interrupt_claim_complete_data;
   output reg  [0:0]  interrupt_claim_complete_wr_valid;
   
   parameter SYNC_RESET = 0; 
   wire aresetn;
   wire sresetn;

   assign aresetn = (SYNC_RESET == 1) ? 1'b1 : TARGET_PRESETn;
   assign sresetn = (SYNC_RESET == 1) ? TARGET_PRESETn : 1'b1;

   // local parameter PLIC register addresses
   localparam [23:0] IP_REG_ADDR           = 24'h00_1000;
   localparam [23:0] IE_REG_ADDR           = 24'h00_2000;
   localparam [23:0] CLAIM_COMPLETE_ADDR   = 24'h20_0004;


   wire rd_enable;
   wire wr_enable;  

   assign wr_enable = (TARGET_PENABLE && TARGET_PWRITE && TARGET_PSEL);
   assign rd_enable = (!TARGET_PWRITE && TARGET_PSEL);

      always@(posedge TARGET_PCLK or negedge aresetn)
      begin
         if((~aresetn) || (!sresetn))
            begin
               interrupt_enable_wr_valid <= 1'b0;
               interrupt_enable_wr_data  <= 32'b0;
               interrupt_claim_complete_wr_valid <= 1'b0;
               TARGET_PRDATA <= 'b0;
            end
         else
            begin
               case(TARGET_PADDR[23:0])
                  IE_REG_ADDR:
                     begin
                        if ( wr_enable )
                           begin
                              interrupt_enable_wr_valid <= 1'b1;
                              interrupt_enable_wr_data <= TARGET_PWDATA;
                           end
                        else if (rd_enable)
                           begin
                              interrupt_enable_wr_valid <= 1'b0;
                              TARGET_PRDATA <= interrupt_enable_data;
                           end
                        else
                           begin
                              interrupt_enable_wr_valid <= 1'b0;
                              interrupt_enable_wr_data <= 32'b0;
                           end
                     end

                  CLAIM_COMPLETE_ADDR:
                     begin
                        if (wr_enable)
                           begin
                              interrupt_claim_complete_wr_valid <= 1'b1;
                           end
                        else if (rd_enable)
                           begin
                              interrupt_claim_complete_wr_valid <= 1'b0;
                              TARGET_PRDATA <= interrupt_claim_complete_data;
                           end
                        else
                           begin
                              interrupt_claim_complete_wr_valid <= 1'b0;
                           end
                     end

                  default:
                     begin
                        interrupt_enable_wr_valid <= 1'b0;
                        interrupt_claim_complete_wr_valid <= 1'b0;
                        interrupt_enable_wr_data  <= 32'b0;
                        TARGET_PRDATA <= 32'b0;
                     end

               endcase
            end
      end
endmodule