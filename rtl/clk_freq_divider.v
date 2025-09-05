module 
clock_frequency_divider#(parameter D = 1,
    parameter o = 2,
    parameter R = 3,
    parameter e = 4,
    parameter M = 5,
    parameter i = 6,
    parameter F = 7,
    parameter a = 8,
    parameter S = 9,
    parameter L = 10)(
  input clk,
  input [2:0] switch,
  output reg out_freq,
  output reg [31:0] tone_name); 
  reg [31:0] count=0;
  reg [31:0] limit = 0;
  always @(*) begin
    case (switch) 
      3'b000: begin 
        limit <= 47820; // 523 Hz
        tone_name <= {D,o}; // do
      end
      3'b001: begin 
        limit <= 42645; // 587 Hz
        tone_name <= {R,e}; // re
      end
      3'b010: begin 
        limit <= 37936; // 659 Hz
        tone_name <= {M,i}; // mi
      end
      3'b011: begin 
        limit <= 35831; // 698 Hz
        tone_name <= {F,a}; // fa
      end
      3'b100: begin 
        limit <= 31924; // 783 Hz
        tone_name <= {S,o}; // so
      end
      3'b101: begin 
        limit <= 28409; // 880 Hz
        tone_name <= {L,a}; // la
      end
      3'b110: begin 
        limit <= 25341; // 987 Hz
        tone_name <= {S,i}; // si
      end
      3'b111: begin 
        limit <= 23907; // 1046 Hz
        tone_name <= {D,a}; // da (do2)
      end
      default: begin 
        limit <= 47820; // Default to 523 Hz
        tone_name <= {D,o}; // do
      end
    endcase
  end

always @(posedge clk) begin
  if (count < limit) begin
    count <= count + 1;
  end else begin
    count <= 0;
    out_freq <= ~out_freq; // Toggle output frequency
  end
end
endmodule