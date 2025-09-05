`timescale 1s / 1ms  // 1 time unit = 1 second, precision = 1 millisecond

module LED_Controller_tb;

  // Inputs
  reg clk;

  // Outputs
  wire [7:0] led;

  
  LED_Controller uut (
    .clk(clk),
    .led(led)
  );

  
  initial begin
    clk       = 0;
    uut.led   = 8'b0000_0000;  // initialise the DUT's led register to 0
  end

  // Clock generation: toggle every 1 second
  always #1 clk = ~clk;

  // Monitor output
  initial begin
    $display("Time (s)\tLED Output");
    $monitor("%0t\t%b", $time, led);
  end

  // Run simulation for 20 seconds, then finish
  initial begin
    #20;
    $finish;
  end

endmodule

