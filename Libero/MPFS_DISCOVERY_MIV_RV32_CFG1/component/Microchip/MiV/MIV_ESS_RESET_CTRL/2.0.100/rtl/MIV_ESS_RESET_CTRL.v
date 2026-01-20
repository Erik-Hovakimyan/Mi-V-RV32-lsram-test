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
 
module MIV_ESS_RESET_CTRL (
                   //  input ports
                   PCLK,
                   ESS_RESETN,
                   ESS_RESET_REQ_0,
                   ESS_RESET_REQ_1,
                   
                   //  output ports
                   ESS_GEN_RESETN,
                   ESS_SYS_RESETN
                   );
 
   parameter		FAMILY = 26;
   parameter        RST_POR_DURATION = 100;
   localparam       SYNC_RESET = (FAMILY == 25) ? 1 : 0 ;
   
   //  input ports
   input            PCLK;
   wire             PCLK;
   input            ESS_RESETN;
   wire             ESS_RESETN;

   input            ESS_RESET_REQ_0;
   wire             ESS_RESET_REQ_0;
   input            ESS_RESET_REQ_1;
   wire             ESS_RESET_REQ_1;
//  output ports
   output           ESS_GEN_RESETN;
   reg              ESS_GEN_RESETN;
    
   output           ESS_SYS_RESETN;
   reg              ESS_SYS_RESETN; 

   wire             ESS_RESET_REQ;

   assign ESS_RESET_REQ = ESS_RESET_REQ_0 || ESS_RESET_REQ_1;
   
   always@ (posedge PCLK) ESS_SYS_RESETN <= (ESS_RESETN && ~|{ESS_RESET_REQ_1, ESS_RESET_REQ_0});
   
   RESET_CTRL
   #(
   .SYNC_RESET         (SYNC_RESET),
   .RST_POR_DURATION   (RST_POR_DURATION)
   )
   BOOT_RST
   (
   .PCLK                (PCLK),
   .ESS_RESETN          (ESS_RESETN),  
   .ESS_RESET_REQ       (ESS_RESET_REQ),
   .ESS_GEN_RESETN      (ESS_GEN_RESETN)
   );
   
endmodule