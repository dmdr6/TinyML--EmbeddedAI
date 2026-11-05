module full_adder (
  input logic a,
  input logic b,
  input logic cin,
  output logic sum,
  output logic cout
);
  // Sum is true if an odd number of inputs are high
  assign sum = a ^ b ^ cin;
  
  // Cout is true if at least two inputs are high
  assign cout = (a & b) | (cin & (a ^ b));
endmodule
