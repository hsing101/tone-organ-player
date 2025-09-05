module clk_1Hz(
  input clk,
  output reg outclk
);
  reg [31:0] count = 0;
  parameter COUNT_LIMIT = 25000000; // 50MHz / 1Hz

  always @(posedge clk) begin
    if (count < COUNT_LIMIT - 1) begin
      count <= count + 1;
    end else begin
      count <= 0;
      outclk <= ~outclk; // Toggle output clock
    end
  end
endmodule