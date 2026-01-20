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
// Description: 
//
// SVN Revision Information:
// SVN $Revision: 40028 $
// SVN $Date: 2022-01-24 16:58:16 +0000 (Mon, 24 Jan 2022) $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
// ****************************************************************************/

module RESET_CTRL (
                   //  input ports
                   PCLK,
                   ESS_RESETN,
                   ESS_RESET_REQ,
                   
                   //  output ports
                   ESS_GEN_RESETN
                   );
 
   parameter        RST_POR_DURATION = 100;
   parameter        SYNC_RESET = 1;
//  input ports
   input            PCLK;
   wire             PCLK;
   input            ESS_RESETN;
   wire             ESS_RESETN;

   input     [0:0]  ESS_RESET_REQ;
   wire      [0:0]  ESS_RESET_REQ;
//  output ports
   output           ESS_GEN_RESETN;
   reg              ESS_GEN_RESETN;
//  local signals
   reg       [31:0] rst_count;
   wire             sys_reset_reqn;
 
   wire            a_syn_resetn;
   wire            s_syn_resetn;
      
   // Assignments
   assign sys_reset_reqn = !(ESS_RESET_REQ); //Inverting for active low, similar to other resets.
   assign a_syn_resetn = (SYNC_RESET == 1) ? 1'b1 : ESS_RESETN && sys_reset_reqn;
   assign s_syn_resetn = (SYNC_RESET == 1) ? ESS_RESETN && sys_reset_reqn : 1'b1;
   
   always @( posedge PCLK or negedge a_syn_resetn )
     begin : RESET_COUNTER
     if ((!a_syn_resetn) || (!s_syn_resetn))
       begin
         ESS_GEN_RESETN <= 1'b0;
         rst_count <= 32'b0;
       end
     else
       begin
       if (ESS_GEN_RESETN == 0)
         begin
         if (rst_count == RST_POR_DURATION)
           begin
             ESS_GEN_RESETN <= 1'b1;
           end
         else
           begin
             rst_count <= rst_count + 1;
           end
         end
       end
     end
 
endmodule