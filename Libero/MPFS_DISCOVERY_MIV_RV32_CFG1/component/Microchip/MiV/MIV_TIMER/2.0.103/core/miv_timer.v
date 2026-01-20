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
// Description: MIV_Timer
//
// SVN Revision Information:
// SVN $Revision: 43495 $
// SVN $Date: 2023-07-27 13:47:01 +0100 (Thu, 27 Jul 2023) $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes:
//
// ****************************************************************************/

module MIV_TIMER 
//********************************************************************************
// Parameter description
	#(
		parameter INTERNAL_MTIME_IRQ          = 1,		//Internal timer interrupt enable
		parameter MTIME_RTC_CLOCK			  = 1,		//Real time clock enable
		parameter MTIME_PRESCALER    		  = 16'hFA	//Prescaler value - 1 used
	)

//********************************************************************************
// Port description

	( 
		input wire        PCLK,       // APB clock
		input wire        RTC_CLK,    // RTC clock

		input wire        PRESETn,    // APB reset 
		input wire        PENABLE,    // APB enable
		input wire        PSEL,       // APB select
		input wire [31:0] PADDR,      // APB address bus
		input wire        PWRITE,     // APB write
		input wire [31:0] PWDATA,     // APB write data
		output reg [31:0] PRDATA,     // APB read data
		output            PREADY,     // APB ready	
		output            PSLVERR,    // APB slv error	

        input             MTIMER_STALL,     //timer stall input
		output            MTIMER_IRQ,   	//timer interrupt output
		output     [63:0] MTIME_COUNT_OUT	//timer count output
	);                      
	
	  
//-----------------------------------------------------------------------------
// Parameters
//-----------------------------------------------------------------------------
	localparam        	  SYNC_RESET              = 1;			        //reset synchronizer enable

	localparam [23:0] l_mtimecmp_addr_base            = 23'h004000; // addr of lower 32-bits of mtime compare - retained from internal mtimer
	localparam [23:0] l_mtime_prescaler_addr          = 23'h005000; // 16 bit prescaler address - retained from internal mtimer
	localparam [23:0] l_mtime_addr_base               = 23'h00BFF8; // addr of lower 32-bits of mtime - retained from internal mtimer

	localparam [23:0] l_mtime_addr_u    = l_mtime_addr_base + 4; 	// addr reference to top 32-bits of mtime
	localparam [23:0] l_mtimecmp_addr_u = l_mtimecmp_addr_base + 4; // addr reference to top 32-bits of mtime compare
//-----------------------------------------------------------------------------
// Signal Declarations
//-----------------------------------------------------------------------------

	wire aresetn;		//reset a
	wire sresetn;		//reset b

	reg rtc_cdc;		//rtc cdc signal
	wire rtc_xor;		//sampled rtc xor signal
	reg rtc_sample_high, rtc_sample_low;

	wire timer_low_en;   
	wire timer_high_en;  
	wire timer_compare_low_en;
	wire timer_compare_high_en;
	
	wire rtc_pos_edge;

	wire rtc_sel;

	reg [63:0] mtimecmp;			//timer compare register
	reg [15:0] scaler_count;			//rtc counter register
	reg [63:0] mtime_count; 	//timer count select


//-----------------------------------------------------------------------------
// Assignments
//-----------------------------------------------------------------------------
	// APB
	assign PSLVERR = 1'b0;				//apb slave error
	assign PREADY  = (PSEL && PENABLE);	//apb ready signal

	// Enables
	assign timer_low_en   = ((PADDR[23:0] == l_mtime_addr_base   )) ? (PWRITE && PSEL && PENABLE) : 1'b0; //timer addr for [31:0]
	assign timer_high_en   = ((PADDR[23:0] == l_mtime_addr_u      )) ? (PWRITE && PSEL && PENABLE) : 1'b0; //timer addr for [63:32]
	assign timer_compare_low_en = ((INTERNAL_MTIME_IRQ) & (PADDR[23:0] == l_mtimecmp_addr_base)) ? (PWRITE && PSEL && PENABLE) : 1'b0; //timer compare addr for [31:0]
	assign timer_compare_high_en = ((INTERNAL_MTIME_IRQ) & (PADDR[23:0] == l_mtimecmp_addr_u   )) ? (PWRITE && PSEL && PENABLE) : 1'b0; //timer compare addr for [63:0]

	// Interrupts
	assign MTIME_COUNT_OUT = mtime_count;
	assign MTIMER_IRQ     = ((INTERNAL_MTIME_IRQ) & (mtime_count >= mtimecmp)) ? 1'b1 : 1'b0;	//if interrupt when mtime count is >= mtime compare

	// Sync Reset
	assign aresetn = (SYNC_RESET == 1) ? 1'b1 : PRESETn;		//aresetn == 1'b1
	assign sresetn = (SYNC_RESET == 1) ? PRESETn : 1'b1;		//sresetn == PRESETn

	// RTC
	assign rtc_sel  = (MTIME_RTC_CLOCK)			   ? 1'b1 : 1'b0;	//if MTIME_RTC_CLOCK parameter is on then real time clock is enabled

//-----------------------------------------------------------------------------
// Logic 
//-----------------------------------------------------------------------------
      
    //Clock CDC with Sampler
    always @ (posedge PCLK or negedge aresetn)
		begin
			if ((!aresetn) || (!sresetn))
                begin
                    rtc_sample_high <= 1'b0;
                    rtc_sample_low <= 1'b0;
                end
            else
                begin
                    rtc_sample_high <= RTC_CLK;
                    rtc_sample_low <= rtc_sample_high;
                end
        end
            
    
    assign rtc_xor = rtc_sample_high ^ rtc_sample_low;
    
    always @ (posedge PCLK or negedge aresetn)
		begin
			if ((!aresetn) || (!sresetn))
                rtc_cdc <= 1'b0;
            else
                begin
                    if (rtc_xor)
                        rtc_cdc <= ~rtc_cdc;
                    else
                        rtc_cdc <= rtc_cdc;
                end
        end
        
		
	assign rtc_pos_edge = (rtc_sel) && (rtc_xor) && (~rtc_cdc);
		
	//Prescaler
	always @(posedge PCLK or negedge aresetn) 	//only always on posedge clk
		begin
			if ((!aresetn) || (!sresetn))
				scaler_count <= 16'h0;					//reset counter
			else
				begin
				    if(!MTIMER_STALL)
					    begin
					        if(rtc_pos_edge) //on synchronized rtc tick 
					        	begin
					        		if(scaler_count == MTIME_PRESCALER - 1)
					        			scaler_count <= 16'h0;				//rct_tick reached value of the prescaler		
					        		else
					        			scaler_count <= scaler_count + 16'h1;	//increment count
					        	end
					        else if (!rtc_sel)
					        	begin
					        		if(scaler_count == MTIME_PRESCALER - 1)
					        			scaler_count <= 16'h0;				//rct_tick reached value of the prescaler		
					        		else
					        			scaler_count <= scaler_count + 16'h1;	//increment count
					        	end
					    end
				end
		end
				
	    
    // mtime_count Register
	always @(posedge PCLK or negedge aresetn)		//only always on posedge clk
		begin : p_MTIME
			if ((!aresetn) || (!sresetn)) //if in reset and internal mtime disabled
					mtime_count <= 64'b0;								//count stays 0 if internal mtime disabled, otherwise 0 initially
			else
				begin
					if (timer_low_en)
							mtime_count[31:0] <= PWDATA[31:0]; //initially at base address
					else if (timer_high_en) 
							mtime_count[63:32] <= PWDATA[31:0]; //any case after e.g. base address + 4
					else if ((scaler_count == MTIME_PRESCALER - 1) & (!MTIMER_STALL))
						begin							
                            if (rtc_pos_edge) //on synchronized rtc tick == mtime_count + 1
								mtime_count <=  mtime_count + 1;
							else if (!rtc_sel)
								mtime_count <=  mtime_count + 1;
						end
				end
		end
		
	// MTIMECMP Register
	always @(posedge PCLK or negedge aresetn)	//only always on posedge clk
		begin : p_MTIMECMP
			if ((!aresetn) || (!sresetn))		
					mtimecmp <= 64'hFFFF_FFFF_FFFF_FFFF; //on reset mtime compare == fff...
			else
				begin										
					if (timer_compare_low_en)
						mtimecmp[31:0]  <= PWDATA[31:0]; //mtime compare base addr = whatever apb PWDATA assigns
					if (timer_compare_high_en)
						mtimecmp[63:32] <= PWDATA[31:0]; //mtime compare base addr + 4 = whatever apb PWDATA assigns
				end
		end
	
	// APB_0 Read Register
	always @(posedge PCLK or negedge aresetn)
		begin : p_APB_0_Read
			if ((!aresetn) || (!sresetn))
				PRDATA <= 32'h00000000;
			else
				begin
					PRDATA <= 32'h00000000;	//Unless PSEL & !PWRITE are asserted, APB reads 0
					if (!PWRITE && PSEL)
						case (PADDR[23:0])		//This only occurs when a write is not in progress
							l_mtime_prescaler_addr: PRDATA <= {15'b0, MTIME_PRESCALER[15:0]};				//prescaler is only 16 bits long
							l_mtimecmp_addr_base: PRDATA <= mtimecmp[31:0];
							l_mtimecmp_addr_u: PRDATA <= mtimecmp[63:32];
							l_mtime_addr_base: PRDATA <= mtime_count[31:0];
							l_mtime_addr_u: PRDATA <= mtime_count[63:32];
							default: PRDATA <= 32'h00000000;
						endcase
				end
		end
	  
	
endmodule