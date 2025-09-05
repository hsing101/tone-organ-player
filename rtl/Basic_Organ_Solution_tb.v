`timescale 1ns / 1ps

module Basic_Organ_Solution_tb;

  // Inputs
  reg CLOCK_50;
  reg [3:0] KEY;
  reg [9:0] SW;

  // Outputs
  wire [9:0] LEDR;
  wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

  // Unused in this testbench (no models)
  wire AUD_ADCDAT, AUD_ADCLRCK, AUD_BCLK, AUD_DACDAT, AUD_DACLRCK, AUD_XCK;
  wire FPGA_I2C_SCLK;
  wire FPGA_I2C_SDAT;
  wire [35:0] GPIO_0, GPIO_1;

  // Instantiate the Unit Under Test (UUT)
  Basic_Organ_Solution uut (
    .CLOCK_50(CLOCK_50),
    .KEY(KEY),
    .SW(SW),
    .LEDR(LEDR),
    .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2),
    .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5),
    .AUD_ADCDAT(AUD_ADCDAT),
    .AUD_ADCLRCK(AUD_ADCLRCK),
    .AUD_BCLK(AUD_BCLK),
    .AUD_DACDAT(AUD_DACDAT),
    .AUD_DACLRCK(AUD_DACLRCK),
    .AUD_XCK(AUD_XCK),
    .FPGA_I2C_SCLK(FPGA_I2C_SCLK),
    .FPGA_I2C_SDAT(FPGA_I2C_SDAT),
    .GPIO_0(GPIO_0),
    .GPIO_1(GPIO_1)
  );

  // Clock generation
  initial CLOCK_50 = 0;
  always #10 CLOCK_50 = ~CLOCK_50;  // 50 MHz clock (20ns period)

  // Stimulus
  initial begin
    // Initialize inputs
    KEY = 4'b1111;
    SW = 10'b0000000000;

    // Wait for reset
    #100;

    // Toggle switches and keys
    SW = 10'b0000000001; #100;
    SW = 10'b0000000010; #100;
    KEY = 4'b1110;       #50;   // Press KEY[0]
    KEY = 4'b1111;       #50;

    SW = 10'b0000010000; #100;
    KEY = 4'b1101;       #50;   // Press KEY[1]
    KEY = 4'b1111;       #50;

    $stop;
  end

endmodule
