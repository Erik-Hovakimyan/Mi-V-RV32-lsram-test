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
// Description: MiV Plic Gateway
//
// SVN Revision Information:
// SVN $Revision: 39272 $
// SVN $Date: 2021-11-08 16:08:14 +0000 (Mon, 08 Nov 2021) $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
// ****************************************************************************/
`timescale 1ns/100ps
module plic_gateway (
clock,
    resetn,
    src_irq,
    interrupt_request_ready,
    interrupt_complete,
    interrupt_request_valid       
 );

// Input signals
input clock;
input resetn;
input src_irq;
input interrupt_request_ready;
input interrupt_complete;

// output signals
output interrupt_request_valid;

parameter SYNC_RESET = 0; 
wire aresetn;
wire sresetn;

assign aresetn = (SYNC_RESET == 1) ? 1'b1 : resetn;
assign sresetn = (SYNC_RESET == 1) ? resetn : 1'b1;

reg interrupt_in_flight;
wire gen_interrupt_in_flight;

assign gen_interrupt_in_flight = (src_irq & interrupt_request_ready) | interrupt_in_flight;
assign interrupt_request_valid = src_irq & ~interrupt_in_flight;

always@(posedge clock or negedge aresetn)
    begin
        if((~aresetn) || (~sresetn))
            begin
                interrupt_in_flight <= 1'b0;
            end
        else if (interrupt_complete)
            begin
                interrupt_in_flight <= 1'b0;
            end
        else
            begin
                interrupt_in_flight <= gen_interrupt_in_flight;
            end            
    end
endmodule