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
// Description: MiV PLIC Interrupt Claim Complete Register.
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
module interrupt_claim_complete(
   clock,
   resetn,
   plic_irq,
   interrupt_complete_data,
   int_pending_reg,
   int_enable_data,
   interrupt_claim_complete_wr_valid,
   plic_irq_id

);

parameter NUM_OF_INTERRUPTS = 8; 
// Input signals
input clock;
input resetn;
input [31:0] int_enable_data; 
input [31:0] int_pending_reg;

// Output signals
output plic_irq;
output reg [NUM_OF_INTERRUPTS:0] interrupt_complete_data;
input interrupt_claim_complete_wr_valid;
output reg [31:0] plic_irq_id;

reg [31:0] int_priority;
wire [31:0] valid;

parameter SYNC_RESET = 0; 
wire aresetn;
wire sresetn;

assign aresetn = (SYNC_RESET == 1) ? 1'b1 : resetn;
assign sresetn = (SYNC_RESET == 1) ? resetn : 1'b1;

assign valid[0] = 1'b0;
assign interrupt_complete_data[0] =  1'b0;

////////////////////////////////////////////////////////////////////////////////////////////////
// Interrupt Priority Arbitor
////////////////////////////////////////////////////////////////////////////////////////////////
always@(posedge clock or negedge aresetn)
   begin
      if((~aresetn) || (!sresetn))
         begin
            int_priority <= 'b0;
         end
      else
         begin
            int_priority <=   (int_pending_reg[1])  ? 32'b00000000000000000000000000000010 :
                              (int_pending_reg[2])  ? 32'b00000000000000000000000000000100 : 
                              (int_pending_reg[3])  ? 32'b00000000000000000000000000001000 :
                              (int_pending_reg[4])  ? 32'b00000000000000000000000000010000 :
                              (int_pending_reg[5])  ? 32'b00000000000000000000000000100000 :
                              (int_pending_reg[6])  ? 32'b00000000000000000000000001000000 :
                              (int_pending_reg[7])  ? 32'b00000000000000000000000010000000 :
                              (int_pending_reg[8])  ? 32'b00000000000000000000000100000000 :
                              (int_pending_reg[9])  ? 32'b00000000000000000000001000000000 :
                              (int_pending_reg[10]) ? 32'b00000000000000000000010000000000 :
                              (int_pending_reg[11]) ? 32'b00000000000000000000100000000000 :
                              (int_pending_reg[12]) ? 32'b00000000000000000001000000000000 :
                              (int_pending_reg[13]) ? 32'b00000000000000000010000000000000 :
                              (int_pending_reg[14]) ? 32'b00000000000000000100000000000000 :
                              (int_pending_reg[15]) ? 32'b00000000000000001000000000000000 :
                              (int_pending_reg[16]) ? 32'b00000000000000010000000000000000 :
                              (int_pending_reg[17]) ? 32'b00000000000000100000000000000000 :
                              (int_pending_reg[18]) ? 32'b00000000000001000000000000000000 :
                              (int_pending_reg[19]) ? 32'b00000000000010000000000000000000 :
                              (int_pending_reg[20]) ? 32'b00000000000100000000000000000000 :
                              (int_pending_reg[21]) ? 32'b00000000001000000000000000000000 :
                              (int_pending_reg[22]) ? 32'b00000000010000000000000000000000 :
                              (int_pending_reg[23]) ? 32'b00000000100000000000000000000000 :
                              (int_pending_reg[24]) ? 32'b00000001000000000000000000000000 :
                              (int_pending_reg[25]) ? 32'b00000010000000000000000000000000 :
                              (int_pending_reg[26]) ? 32'b00000100000000000000000000000000 :
                              (int_pending_reg[27]) ? 32'b00001000000000000000000000000000 :
                              (int_pending_reg[28]) ? 32'b00010000000000000000000000000000 :
                              (int_pending_reg[29]) ? 32'b00100000000000000000000000000000 :
                              (int_pending_reg[30]) ? 32'b01000000000000000000000000000000 :
                              (int_pending_reg[31]) ? 32'b10000000000000000000000000000000 :
                              32'b00000000000000000000000000000000;
         end
   end
      
////////////////////////////////////////////////////////////////////////////////////////////////
// Valid signal generation
////////////////////////////////////////////////////////////////////////////////////////////////
genvar plic_valid ;
generate 
   begin : plic_valid_signal_generation
      for (plic_valid = 1; plic_valid <= NUM_OF_INTERRUPTS; plic_valid = plic_valid + 1)
         begin
            assign valid[plic_valid] = (int_enable_data[plic_valid] && int_pending_reg[plic_valid]) ? 1'b1 : 1'b0;
         end
   end
endgenerate

////////////////////////////////////////////////////////////////////////////////////////////////
// Interrupt complete signal generation
////////////////////////////////////////////////////////////////////////////////////////////////
genvar plic_inst_num ;
generate 
   begin:plic_interrupt_complete_generation
   for (plic_inst_num = 1; plic_inst_num <= NUM_OF_INTERRUPTS; plic_inst_num =  plic_inst_num +1 )
      begin
         always@(posedge clock or negedge aresetn)
            begin
               if((~aresetn) || (!sresetn))
                  begin
                     interrupt_complete_data[plic_inst_num] <= 1'b0;
                  end
               else
                  begin
                     if (interrupt_claim_complete_wr_valid)
                        begin
                           interrupt_complete_data[plic_inst_num] <= 1'b0;
                        end
                     else 
                        begin       
                           if (valid[plic_inst_num] && int_priority[plic_inst_num])
                              begin
                                 interrupt_complete_data[plic_inst_num] <= int_pending_reg[plic_inst_num];
                                 
                              end
                           else
                              begin
                                 interrupt_complete_data[plic_inst_num] <=  interrupt_complete_data[plic_inst_num];
                              end
                           end
                     end
                  end
               end
            end
endgenerate   

generate if (NUM_OF_INTERRUPTS < 31)
   begin    
      assign valid[31:(NUM_OF_INTERRUPTS+1)] = 'b0;
   end
endgenerate

////////////////////////////////////////////////////////////////////////////////////////////////
// Generation of the PLIC IRQ singnal
////////////////////////////////////////////////////////////////////////////////////////////////
assign plic_irq = ((int_enable_data[0] && int_pending_reg[0]) ||
                   (int_enable_data[1] && int_pending_reg[1]) ||
                   (int_enable_data[2] && int_pending_reg[2]) ||
                   (int_enable_data[3] && int_pending_reg[3]) ||
                   (int_enable_data[4] && int_pending_reg[4]) ||
                   (int_enable_data[5] && int_pending_reg[5]) ||
                   (int_enable_data[6] && int_pending_reg[6]) ||
                   (int_enable_data[7] && int_pending_reg[7]) ||
                   (int_enable_data[8] && int_pending_reg[8]) ||
                   (int_enable_data[9] && int_pending_reg[9]) ||
                   (int_enable_data[10] && int_pending_reg[10]) ||
                   (int_enable_data[11] && int_pending_reg[11]) ||
                   (int_enable_data[12] && int_pending_reg[12]) ||
                   (int_enable_data[13] && int_pending_reg[13]) ||
                   (int_enable_data[14] && int_pending_reg[14]) ||
                   (int_enable_data[15] && int_pending_reg[15]) ||
                   (int_enable_data[16] && int_pending_reg[16]) ||
                   (int_enable_data[17] && int_pending_reg[17]) ||
                   (int_enable_data[18] && int_pending_reg[18]) ||
                   (int_enable_data[19] && int_pending_reg[19]) ||
                   (int_enable_data[20] && int_pending_reg[20]) ||
                   (int_enable_data[21] && int_pending_reg[21]) ||
                   (int_enable_data[22] && int_pending_reg[22]) ||
                   (int_enable_data[23] && int_pending_reg[23]) ||
                   (int_enable_data[24] && int_pending_reg[24]) ||
                   (int_enable_data[25] && int_pending_reg[25]) ||
                   (int_enable_data[26] && int_pending_reg[26]) ||
                   (int_enable_data[27] && int_pending_reg[27]) ||
                   (int_enable_data[28] && int_pending_reg[28]) ||
                   (int_enable_data[29] && int_pending_reg[29]) ||
                   (int_enable_data[30] && int_pending_reg[30]) ||
                   (int_enable_data[31] && int_pending_reg[31]) );
                   


////////////////////////////////////////////////////////////////////////////////////////////////
// PLIC ID generation
////////////////////////////////////////////////////////////////////////////////////////////////
always@(posedge clock or negedge aresetn)
   begin
      if((~aresetn) || (!sresetn))
         begin
            plic_irq_id <= 32'b0;
         end
      else
         begin
            plic_irq_id <= (valid[1] && int_priority[1]) ? 32'h00000001 :
                           (valid[2] && int_priority[2]) ? 32'h00000002 :
                           (valid[3] && int_priority[3]) ? 32'h00000003 :
                           (valid[4] && int_priority[4]) ? 32'h00000004 :
                           (valid[5] && int_priority[5]) ? 32'h00000005 :
                           (valid[6] && int_priority[6]) ? 32'h00000006 :
                           (valid[7] && int_priority[7]) ? 32'h00000007 :
                           (valid[8] && int_priority[8]) ? 32'h00000008 :
                           (valid[9] && int_priority[9]) ? 32'h00000009 :
                           (valid[10] && int_priority[10]) ? 32'h0000000a :
                           (valid[11] && int_priority[11]) ? 32'h0000000b :
                           (valid[12] && int_priority[12]) ? 32'h0000000c :
                           (valid[13] && int_priority[13]) ? 32'h0000000d :
                           (valid[14] && int_priority[14]) ? 32'h0000000e :
                           (valid[15] && int_priority[15]) ? 32'h0000000f :
                           (valid[16] && int_priority[16]) ? 32'h00000010 :
                           (valid[17] && int_priority[17]) ? 32'h00000011 :  
                           (valid[18] && int_priority[18]) ? 32'h00000012 :  
                           (valid[19] && int_priority[19]) ? 32'h00000013 :  
                           (valid[20] && int_priority[20]) ? 32'h00000014 :  
                           (valid[21] && int_priority[21]) ? 32'h00000015 :  
                           (valid[22] && int_priority[22]) ? 32'h00000016 :  
                           (valid[23] && int_priority[23]) ? 32'h00000017 :  
                           (valid[24] && int_priority[24]) ? 32'h00000018 :  
                           (valid[25] && int_priority[25]) ? 32'h00000019 :  
                           (valid[26] && int_priority[26]) ? 32'h0000001a :  
                           (valid[27] && int_priority[27]) ? 32'h0000001b :  
                           (valid[28] && int_priority[28]) ? 32'h0000001c :  
                           (valid[29] && int_priority[29]) ? 32'h0000001d :  
                           (valid[30] && int_priority[30]) ? 32'h0000001e :  
                           (valid[31] && int_priority[31]) ? 32'h0000001f :  
                           32'h00000000;
                           
         end
   end

endmodule
