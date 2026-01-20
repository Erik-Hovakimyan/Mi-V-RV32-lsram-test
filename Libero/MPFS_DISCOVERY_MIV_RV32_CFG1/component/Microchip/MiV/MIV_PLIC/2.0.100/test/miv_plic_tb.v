`timescale 1ns/100ps
module testbench ();

parameter SYSCLK_PERIOD = 100;// 10MHZ
parameter NUM_OF_INTS = 4;

reg SYSCLK;
reg NSYSRESET, TARGET_PENABLE, TARGET_PSEL, TARGET_PWRITE;
reg [31:0] TARGET_PADDR, TARGET_PWDATA, read_data;
reg [NUM_OF_INTS-1:0] SRC_IRQ;


wire [31:0] TARGET_PRDATA;
wire PLIC_IRQ;


//////////////////////////////////////////////////////////////////////
// Task Definitions
//////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////
// APB Write
//////////////////////////////////////////////////////////////////////
task apb_write;
   input [31:0] addr;
   input [31:0] data;
   begin
      TARGET_PENABLE = 1'b1;
      TARGET_PSEL     =1'b1;
      TARGET_PADDR = addr;
      TARGET_PWDATA = data;
      TARGET_PWRITE = 1'b1;
      #(SYSCLK_PERIOD * 1);
      TARGET_PENABLE = 1'b0;
      TARGET_PSEL     =1'b0;
      TARGET_PADDR = addr;
      TARGET_PWDATA = data;
      TARGET_PWRITE = 1'b0;
   end
endtask

//////////////////////////////////////////////////////////////////////
// APB Read
//////////////////////////////////////////////////////////////////////
task apb_read;
   input [31:0] addr;
   output [31:0] read_data;
   begin
      TARGET_PENABLE = 1'b0;
      TARGET_PSEL     =1'b1;
      TARGET_PADDR = addr;
      TARGET_PWRITE = 1'b0;
      #(SYSCLK_PERIOD);
      TARGET_PENABLE = 1'b0;
      TARGET_PSEL     =1'b0;
      TARGET_PWRITE = 1'b0;
      read_data = TARGET_PRDATA;
   end
endtask

//////////////////////////////////////////////////////////////////////
// Enable Interrupts
//////////////////////////////////////////////////////////////////////
task enable_interrupt;
   begin
    $display("Interrupts enabled :: time is %0t",$time); 
    apb_read(32'h40002000,read_data);    
    #(SYSCLK_PERIOD * 1);
    apb_write(32'h40002000, 32'h000000FF);
    #(SYSCLK_PERIOD * 1);   
   end
endtask

//////////////////////////////////////////////////////////////////////
// Disable Interrupts
//////////////////////////////////////////////////////////////////////
task disable_interrupt;
   begin
    $display("Interrupts disabled :: time is %0t",$time); 
    apb_read(32'h40002000,read_data);    
    #(SYSCLK_PERIOD * 1);
    apb_write(32'h40002000, 32'h00000000);
    #(SYSCLK_PERIOD * 1);   
   end
endtask

//////////////////////////////////////////////////////////////////////
// External Interrupt 
//////////////////////////////////////////////////////////////////////
task external_interrupt;
   input [NUM_OF_INTS-1:0] ext_src;
   begin
    SRC_IRQ[ext_src] = 1'b1;    
    #(SYSCLK_PERIOD * 1);    
    SRC_IRQ[ext_src] = 1'b0;      
    #(SYSCLK_PERIOD * 1);
   end
endtask

//////////////////////////////////////////////////////////////////////
// Plic Claim Complete
//////////////////////////////////////////////////////////////////////
task plic_claim;
   begin
      apb_read(32'h4020_0004,read_data);
      #(SYSCLK_PERIOD * 1);
      apb_write(32'h4020_0004,read_data);
      $display("Interrupt 0x%0h has been claimed:: time is %0t", read_data, $time); 
   end
endtask

initial
begin
    SYSCLK = 1'b0;
    NSYSRESET = 1'b0;
    SRC_IRQ = 'b0;
    TARGET_PADDR = 'b0;
    TARGET_PWDATA = 'b0;
    read_data = 'b0; 
    TARGET_PENABLE = 1'b0;
    TARGET_PSEL = 1'b0;
    TARGET_PWRITE = 1'b0;
end

//////////////////////////////////////////////////////////////////////
// Resetting the IP Core
//////////////////////////////////////////////////////////////////////
task system_reset;
   begin
      #(SYSCLK_PERIOD * 10 );
      NSYSRESET = 1'b1;
      $display("Reset Complete :: time is %0t",$time);
   end
endtask

task display_tests();
   begin
      $display("MIV_PLIC Testbench :: time is %0t",$time);
      $display("Test 1: Reset the PLIC");
      $display("Test 2: Enable the PLIC");
      $display("Test 3: Assert and external interrupt 1 and service it");
      $display("Test 4: Assert and external interrupt 2 and service it");
      $display("Test 5: Assert and external interrupt 3 and service it");
      $display("Test 6: Disable all interrupts and attempt an external interrupt 1");
   end  
endtask     
//////////////////////////////////////////////////////////////////////
// Clock Driver
//////////////////////////////////////////////////////////////////////
always @(SYSCLK)
    #(SYSCLK_PERIOD / 2.0) SYSCLK <= !SYSCLK;


//////////////////////////////////////////////////////////////////////
// Testing Interrupt
//////////////////////////////////////////////////////////////////////

initial
begin
    display_tests();
    system_reset();
    enable_interrupt();    
   // Interrupt 1 task
    external_interrupt(31'h1);     
    assert(PLIC_IRQ) $display("Interrupt has occured :: time is %0t",$time); 
    #(SYSCLK_PERIOD * 2 );
    plic_claim();
    #(SYSCLK_PERIOD * 10 );
   // Interrupt 2 task
    external_interrupt(31'h2);     
    assert(PLIC_IRQ) $display("Interrupt has occured :: time is %0t",$time); 
    #(SYSCLK_PERIOD * 2 );
    plic_claim();

    #(SYSCLK_PERIOD * 10 );
   // Interrupt 3 task
    external_interrupt(31'h3);     
    assert(PLIC_IRQ) $display("Interrupt has occured :: time is %0t",$time); 
    #(SYSCLK_PERIOD * 2 );
    plic_claim();    
    
    // disable Interrupt task
    disable_interrupt();

    // Interrupt 1 task while interrupts are disabled
    external_interrupt(31'h1);     
    assert(~PLIC_IRQ) $display("Interrupt should be disabled therefore no interrupt! :: time is %0t",$time); 
    #(SYSCLK_PERIOD * 10 );
    $stop;
    $finish;
end


//////////////////////////////////////////////////////////////////////
// Instantiate Unit Under Test:  MIV_PLIC
//////////////////////////////////////////////////////////////////////
MIV_PLIC #( 
        .NUM_OF_INTS ( NUM_OF_INTS ) )
        MIV_PLIC_inst_0(
    .SRC_IRQ(SRC_IRQ),
    .PCLK(SYSCLK),
    .PRESETn(NSYSRESET),
    .TARGET_PADDR(TARGET_PADDR),
    .TARGET_PSEL(TARGET_PSEL),
    .TARGET_PENABLE(TARGET_PENABLE),
    .TARGET_PWRITE(TARGET_PWRITE),
    .TARGET_PWDATA(TARGET_PWDATA),

    // Outputs
    .PLIC_IRQ(PLIC_IRQ ),
    .TARGET_PRDATA(TARGET_PRDATA ) 
        );

endmodule