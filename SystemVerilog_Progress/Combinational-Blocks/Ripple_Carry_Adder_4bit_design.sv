// 1-bit Full Adder Primitive
module full_adder (
  input  logic a,
  input  logic b,
  input  logic cin,
  output logic sum,
  output logic cout
);
  // Compute sum and carry
  assign sum  = a ^ b ^ cin;
  assign cout = (a & b) | (cin & (a ^ b));
endmodule

// 4-bit Ripple-Carry Adder built by chaining 4 Full Adders
module rca_4bit (
  input  logic [3:0] a,
  input  logic [3:0] b,
  input  logic       cin,
  output logic [3:0] sum,
  output logic       cout
);
  // Internal carry wires connecting the stages together
  logic c1, c2, c3;
  
  // Stage 0: LSB (Least Significant Bit)
  full_adder fa0 (
    .a(a[0]), .b(b[0]), .cin(cin), 
    .sum(sum[0]), .cout(c1)
  );
  
  // Stage 1
  full_adder fa1 (
	.a(a[1]), .b(b[1]), .cin(c1), 
    .sum(sum[1]), .cout(c2)
  );

  // Stage 2
  full_adder fa2 (
	.a(a[2]), .b(b[2]), .cin(c2), 
    .sum(sum[2]), .cout(c3)
  );

  // Stage 3: MSB (Most Significant Bit)
  full_adder fa3 (
	.a(a[3]), .b(b[3]), .cin(c3), 
    .sum(sum[3]), .cout(cout)
    );

endmodule
