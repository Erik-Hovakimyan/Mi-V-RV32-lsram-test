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
// Description: MiV PLIC Top Level
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
module MIV_PLIC(
   TARGET_PCLK,
   TARGET_PRESETn,
   TARGET_PENABLE,
   TARGET_PSEL,
   TARGET_PADDR,
   TARGET_PWRITE,
   TARGET_PWDATA,
   TARGET_PRDATA,
   
   PLIC_IRQ,
   SRC_IRQ

);

parameter NUM_OF_INTS = 8;
parameter FAMILY = 25;
localparam SYNC_RESET = (FAMILY == 25) ? 1 : 0;   

input          TARGET_PCLK;
input          TARGET_PRESETn;
input          TARGET_PENABLE;
input          TARGET_PSEL;
input  [31:0]  TARGET_PADDR;
input          TARGET_PWRITE;
input  [31:0]  TARGET_PWDATA;
output [31:0]  TARGET_PRDATA;

input [NUM_OF_INTS-1:0]  SRC_IRQ; 
output                   PLIC_IRQ;

wire        interrupt_enable_wr_valid;
wire        interrupt_claim_complete_wr_valid;
wire [31:0] interrupt_enable_wr_data;
wire [31:0] interrupt_enable_data;
wire [31:0] interrupt_pending_reg;
wire [31:0] plic_irq_id;
wire [NUM_OF_INTS:0] interrupt_complete_data;
wire [NUM_OF_INTS:0] interrupt_request_valid;
wire [NUM_OF_INTS:0] interrupt_pending_ready;
wire [NUM_OF_INTS:0] src_interrupts;

assign src_interrupts[0] = 1'b0;
assign interrupt_request_valid[0] = 1'b0;
assign interrupt_pending_ready[0] = 1'b0;
assign interrupt_enable_data[0] = 1'b0;
assign interrupt_pending_reg[0] = 1'b0;
assign src_interrupts[NUM_OF_INTS:1] = SRC_IRQ[NUM_OF_INTS-1:0];


////////////////////////////////////////////////////////////////////////////////////////////////
// APB Interface
////////////////////////////////////////////////////////////////////////////////////////////////
apb_interface #(.SYNC_RESET(SYNC_RESET)) apb_interface_0(
   .TARGET_PCLK(TARGET_PCLK),
   .TARGET_PRESETn(TARGET_PRESETn),
   .TARGET_PENABLE(TARGET_PENABLE),
   .TARGET_PSEL(TARGET_PSEL),
   .TARGET_PADDR(TARGET_PADDR),
   .TARGET_PWRITE(TARGET_PWRITE),
   .TARGET_PWDATA(TARGET_PWDATA),
   .TARGET_PRDATA(TARGET_PRDATA),
   .interrupt_enable_wr_valid(interrupt_enable_wr_valid),
   .interrupt_enable_wr_data(interrupt_enable_wr_data),
   .interrupt_enable_data(interrupt_enable_data),     
   .interrupt_claim_complete_wr_valid (  interrupt_claim_complete_wr_valid),
   .interrupt_claim_complete_data(plic_irq_id)
   );
   
////////////////////////////////////////////////////////////////////////////////////////////////
// Interrupt Claim Complete Register 
////////////////////////////////////////////////////////////////////////////////////////////////
interrupt_claim_complete #(.NUM_OF_INTERRUPTS(NUM_OF_INTS),
                           .SYNC_RESET(SYNC_RESET)) interrupt_claim_complete_0(
   .clock                             ( TARGET_PCLK ),
   .resetn                            ( TARGET_PRESETn ),
   .int_pending_reg                   ( interrupt_pending_reg  ),
   .int_enable_data                   ( interrupt_enable_data),
   .plic_irq                          ( PLIC_IRQ ),
   .interrupt_complete_data           ( interrupt_complete_data ),
   .interrupt_claim_complete_wr_valid ( interrupt_claim_complete_wr_valid ),
   .plic_irq_id                       ( plic_irq_id )
   );
 
genvar plic_inst_ie_num ;
generate 
   begin: plic_core_ie
   for (plic_inst_ie_num = 1; plic_inst_ie_num <= NUM_OF_INTS; plic_inst_ie_num = plic_inst_ie_num + 1)
      begin
         ////////////////////////////////////////////////////////////////////////////////////////////////
         // Interrupt Enable Register
         ////////////////////////////////////////////////////////////////////////////////////////////////
         interrupt_enable_register #(.SYNC_RESET(SYNC_RESET)) interrupt_enable_register_0(
            .clock                     (TARGET_PCLK),
            .resetn                    (TARGET_PRESETn),
            .interrupt_enable_wr_valid (interrupt_enable_wr_valid),
            .interrupt_enable_wr_data  (interrupt_enable_wr_data[plic_inst_ie_num]),
            .interrupt_enable_data     (interrupt_enable_data[plic_inst_ie_num])
            );
      end
   end
endgenerate

genvar plic_inst_ip_num ;
generate 
   begin: plic_core_ip
   for (plic_inst_ip_num = 1; plic_inst_ip_num <= NUM_OF_INTS; plic_inst_ip_num = plic_inst_ip_num + 1)
      begin
         ////////////////////////////////////////////////////////////////////////////////////////////////
         // Interrupt Pending Register
         ////////////////////////////////////////////////////////////////////////////////////////////////
         interrupt_pending_register #(.SYNC_RESET(SYNC_RESET)) interrupt_pending_register(
            .clock                              (TARGET_PCLK),
            .resetn                             (TARGET_PRESETn),
            .interrupt_pending_ready            (interrupt_pending_ready[plic_inst_ip_num]),
            .interrupt_pending_valid            (interrupt_request_valid[plic_inst_ip_num]),
            .interrupt_pending_reg              (interrupt_pending_reg[plic_inst_ip_num]),
            .interrupt_complete_data            (interrupt_complete_data[plic_inst_ip_num ]),
            .interrupt_claim_complete_wr_valid  (interrupt_claim_complete_wr_valid)
            );
      end
   end
endgenerate


genvar plic_inst_plic_gateway_num ;
generate 
   begin: plic_core_plic_gateway
   for (plic_inst_plic_gateway_num = 1; plic_inst_plic_gateway_num <= NUM_OF_INTS; plic_inst_plic_gateway_num = plic_inst_plic_gateway_num + 1)
      begin      
         ////////////////////////////////////////////////////////////////////////////////////////////////
         // PLIC Gateway 
         ////////////////////////////////////////////////////////////////////////////////////////////////
         plic_gateway #(.SYNC_RESET(SYNC_RESET)) plic_gateway(
            .clock                   (TARGET_PCLK),
            .resetn                  (TARGET_PRESETn),
            .src_irq                 (src_interrupts[plic_inst_plic_gateway_num]),
            .interrupt_request_ready (interrupt_pending_ready[plic_inst_plic_gateway_num]),
            .interrupt_complete      (interrupt_complete_data[plic_inst_plic_gateway_num]),
            .interrupt_request_valid (interrupt_request_valid[plic_inst_plic_gateway_num])
            );            
      end
   end
endgenerate


generate
   if (NUM_OF_INTS < 31)
   begin
      assign interrupt_pending_reg[31:NUM_OF_INTS+1] = 'b0;  
      assign interrupt_enable_data[31:NUM_OF_INTS+1] = 'b0;      
   end   
endgenerate

endmodule