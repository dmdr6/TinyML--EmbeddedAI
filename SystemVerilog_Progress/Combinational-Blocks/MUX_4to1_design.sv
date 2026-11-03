module mux_4to1 (
  input logic[3:0] in,	// Bundled inputs: in[3], in[2], in[1], in[0]
  input logic[1:0] sel, // 2-bit select line
  output logic out
);
  
  always_comb begin
    case (sel)
      2'b00:	out = in[0];
      2'b01:	out = in[1];
      2'b10:	out = in[2];
      2'b11:	out = in[3];
      default:	out = 1'b0;  	// Safety net against unintended latches
    endcase
  end
  
endmodule
