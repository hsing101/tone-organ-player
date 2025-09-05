module LED_Controller(
  input clk,
  output reg [7:0] led
);

reg direction=1'b1;
  always @(posedge clk) begin
    if (led == 8'b00000000) begin
      led <= 8'b00000001; // Start with the first LED on
      direction <= 1'b1; // Set direction to right
    end
    else if (direction ==1'b1) begin
      if (led[0]==1'b1) begin
       led<=led<<1;
       direction<=1'b0; // Reset to the first LED
     end else 
      begin
        led <= led>>1; // Change direction to right
      end
    end
      else if ( direction ==1'b0) begin
        if (led[7]==1'b1) begin
          led<=led>>1;
          direction<=1'b1; // Reset to the last LED
        end else 
        begin
          led <= led<<1; // Change direction to left
        end
      end // Toggle the LED state
  end
endmodule