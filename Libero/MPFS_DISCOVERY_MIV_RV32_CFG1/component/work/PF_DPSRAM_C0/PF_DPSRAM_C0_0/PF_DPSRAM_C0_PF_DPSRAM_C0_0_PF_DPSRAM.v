`timescale 1 ns/100 ps
// Version: 2025.2 2025.2.0.14


module PF_DPSRAM_C0_PF_DPSRAM_C0_0_PF_DPSRAM(
       A_DIN,
       A_DOUT,
       B_DIN,
       B_DOUT,
       A_ADDR,
       B_ADDR,
       CLK,
       A_WEN,
       B_WEN
    );
input  [19:0] A_DIN;
output [19:0] A_DOUT;
input  [19:0] B_DIN;
output [19:0] B_DOUT;
input  [9:0] A_ADDR;
input  [9:0] B_ADDR;
input  CLK;
input  A_WEN;
input  B_WEN;

    wire \ACCESS_BUSY[0][0] , VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K20 #( .MEMORYFILE("PF_DPSRAM_C0_PF_DPSRAM_C0_0_PF_DPSRAM_R0C0.mem")
        , .RAMINDEX("PF_DPSRAM_C0_0%1024-1024%20-20%SPEED%0%0%DUAL-PORT%C:/polarfire-soc-discovery-kit-reference-design_REPO_N2/MPFS_DISCOVERY_MIV_RV32_CFG1/sram_init_file.mem%ECC_EN-0")
         )  PF_DPSRAM_C0_PF_DPSRAM_C0_0_PF_DPSRAM_R0C0 (.A_DOUT({
        A_DOUT[19], A_DOUT[18], A_DOUT[17], A_DOUT[16], A_DOUT[15], 
        A_DOUT[14], A_DOUT[13], A_DOUT[12], A_DOUT[11], A_DOUT[10], 
        A_DOUT[9], A_DOUT[8], A_DOUT[7], A_DOUT[6], A_DOUT[5], 
        A_DOUT[4], A_DOUT[3], A_DOUT[2], A_DOUT[1], A_DOUT[0]}), 
        .B_DOUT({B_DOUT[19], B_DOUT[18], B_DOUT[17], B_DOUT[16], 
        B_DOUT[15], B_DOUT[14], B_DOUT[13], B_DOUT[12], B_DOUT[11], 
        B_DOUT[10], B_DOUT[9], B_DOUT[8], B_DOUT[7], B_DOUT[6], 
        B_DOUT[5], B_DOUT[4], B_DOUT[3], B_DOUT[2], B_DOUT[1], 
        B_DOUT[0]}), .DB_DETECT(), .SB_CORRECT(), .ACCESS_BUSY(
        \ACCESS_BUSY[0][0] ), .A_ADDR({A_ADDR[9], A_ADDR[8], A_ADDR[7], 
        A_ADDR[6], A_ADDR[5], A_ADDR[4], A_ADDR[3], A_ADDR[2], 
        A_ADDR[1], A_ADDR[0], GND, GND, GND, GND}), .A_BLK_EN({VCC, 
        VCC, VCC}), .A_CLK(CLK), .A_DIN({A_DIN[19], A_DIN[18], 
        A_DIN[17], A_DIN[16], A_DIN[15], A_DIN[14], A_DIN[13], 
        A_DIN[12], A_DIN[11], A_DIN[10], A_DIN[9], A_DIN[8], A_DIN[7], 
        A_DIN[6], A_DIN[5], A_DIN[4], A_DIN[3], A_DIN[2], A_DIN[1], 
        A_DIN[0]}), .A_REN(VCC), .A_WEN({A_WEN, A_WEN}), .A_DOUT_EN(
        VCC), .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .B_ADDR({
        B_ADDR[9], B_ADDR[8], B_ADDR[7], B_ADDR[6], B_ADDR[5], 
        B_ADDR[4], B_ADDR[3], B_ADDR[2], B_ADDR[1], B_ADDR[0], GND, 
        GND, GND, GND}), .B_BLK_EN({VCC, VCC, VCC}), .B_CLK(CLK), 
        .B_DIN({B_DIN[19], B_DIN[18], B_DIN[17], B_DIN[16], B_DIN[15], 
        B_DIN[14], B_DIN[13], B_DIN[12], B_DIN[11], B_DIN[10], 
        B_DIN[9], B_DIN[8], B_DIN[7], B_DIN[6], B_DIN[5], B_DIN[4], 
        B_DIN[3], B_DIN[2], B_DIN[1], B_DIN[0]}), .B_REN(VCC), .B_WEN({
        B_WEN, B_WEN}), .B_DOUT_EN(VCC), .B_DOUT_ARST_N(VCC), 
        .B_DOUT_SRST_N(VCC), .ECC_EN(GND), .BUSY_FB(GND), .A_WIDTH({
        VCC, GND, GND}), .A_WMODE({GND, GND}), .A_BYPASS(VCC), 
        .B_WIDTH({VCC, GND, GND}), .B_WMODE({GND, GND}), .B_BYPASS(VCC)
        , .ECC_BYPASS(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
