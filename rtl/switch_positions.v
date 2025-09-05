module switch_positions(
  input control_switch,
  input [3:0] switches,
  output reg [3:0] switch_value
);
always @(*) begin
  case (control_switch)
    1'b0: switch_value = switches; // switches values displayed in information mode
    1'b1: switch_value = 4'b0000; 
    default: switch_value = 4'b0000; // Default to 0
  endcase
end
endmodule