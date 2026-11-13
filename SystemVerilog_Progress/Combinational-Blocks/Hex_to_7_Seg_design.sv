module hex_to_7seg (
  input logic [3:0] bin,		// 4-bit binary input (0 to 15)
  output logic [6:0] segments	// 7-bit output mapped to g-f-e-d-c-b-a
);
  
  // Active-high {g, f, e, d, c, b, a}
  always_comb begin
    case (bin)
      4'h0: segments = 7'b0111111;	// Display '0'
      4'h1: segments = 7'b0000110;	// Display '1'
      4'h2: segments = 7'b1011011;	// Display '2'
      4'h3: segments = 7'b1001111;	// Display '3'
      4'h4: segments = 7'b1100110;	// Display '4'
      4'h5: segments = 7'b1101101;	// Display '5'
      4'h6: segments = 7'b1111101;	// Display '6'
      4'h7: segments = 7'b0000111;	// Display '7'
      4'h8: segments = 7'b1111111;	// Display '8'
      4'h9: segments = 7'b1101111;	// Display '9'
      4'hA: segments = 7'b1110111;	// Display 'A'
      4'hB: segments = 7'b1111100;	// Display 'b'
      4'hC: segments = 7'b0111001;	// Display 'C'
      4'hD: segments = 7'b1011110;	// Display 'd'
      4'hE: segments = 7'b1111001;	// Display 'E'
      4'hF: segments = 7'b1110001;	// Display 'F'
      default: segments = 7'b0000000;	// Off for safety
    endcase
  end
  
endmodule
