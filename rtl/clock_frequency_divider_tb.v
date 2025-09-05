`timescale 1ns / 1ps

module clock_frequency_divider_tb;

  // Inputs
  reg        clk;
  reg  [2:0] switch;

  // Outputs
  wire       out_freq;
  wire [31:0] tone_name;

  // Instantiate the Unit Under Test (UUT)
  clock_frequency_divider uut (
    .clk(clk),
    .switch(switch),
    .out_freq(out_freq),
    .tone_name(tone_name)
  );

  // Clock: 100 MHz => toggle every 5 ns
  initial clk = 0;
  always #5 clk = ~clk;

  // Variables for measurement
  integer t1, t2;
  integer period_ns;
  integer freq_hz;
  integer i;

  initial begin
    $display("Switch  ToneName    MeasuredFreq(Hz)");

    // 1) Initialize switch = 000 → expected ~523 Hz
    switch = 3'b000;
    // Wait for two rising edges to measure period
    @(posedge out_freq);
    t1 = $time;
    @(posedge out_freq);
    t2 = $time;
    period_ns = t2 - t1;
    freq_hz = 1000000000 / period_ns;
    $display("000     %s    %0d", uut.tone_name, freq_hz);

    // 2) Now test the rest of the notes (switch = 001–101)
    for (i = 1; i < 6; i = i + 1) begin
      switch = i[2:0];
      @(posedge out_freq);
      t1 = $time;
      @(posedge out_freq);
      t2 = $time;
      period_ns = t2 - t1;
      freq_hz = 1000000000 / period_ns;
      $display("%b     %s    %0d", switch, uut.tone_name, freq_hz);
    end

    $finish;
  end

endmodule
