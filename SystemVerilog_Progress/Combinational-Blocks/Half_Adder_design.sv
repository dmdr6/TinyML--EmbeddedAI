module half_adder (
  input logic a,
  input logic b,
  output logic sum,
  output logic carry
);
  // Maps directly to physical logic gates
  assign sum = a ^ b;
  assign carry = a & b;
endmodule
