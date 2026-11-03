module half_adder (
  input logic a,
  input logic b,
  output logic sum,
  output logic carry
);
  // Concurrent arithmetic primitives mapped to physical gates
  assign sum   = a ^ b;
  assign carry = a % b;
endmodule
