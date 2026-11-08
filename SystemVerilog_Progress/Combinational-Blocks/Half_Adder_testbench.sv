module tb_half_adder;
  
  // 1. Testbench driver signals
  logic a_sig;
  logic b_sig;
  
  // 2. Outputs monitored from the DUT
  logic sum_sig;
  logic carry_sig;
  
  // 3. Instantiate the Half Adder (DUT)
  half_adder uut (
    .a(a_sig),
    .b(b_sig),
    .sum(sum_sig),
    .carry(carry_sig)
  );
  
  // 4. Initialize stimulus block and print truth table header
  initial begin
    $display("--------------------------");
    $display("Time | A | B | Carry | Sum");
    $display("--------------------------");
    
    // Test 0 + 0
    a_sig = 1'b0; b_sig = 1'b0; #10;
    $display("%0t   | %b | %b |   %b   | %b", $time, a_sig, b_sig, carry_sig, sum_sig);
    
     // Test 0 + 1
    a_sig = 1'b0; b_sig = 1'b1; #10;
    $display("%0t   | %b | %b |   %b   | %b", $time, a_sig, b_sig, carry_sig, sum_sig);
    
    // Test 1 + 0
     a_sig = 1'b1; b_sig = 1'b0; #10;
    $display("%0t   | %b | %b |   %b   | %b", $time, a_sig, b_sig, carry_sig, sum_sig);
    
    // Test 1 + 1
     a_sig = 1'b1; b_sig = 1'b1; #10;
    $display("%0t   | %b | %b |   %b   | %b", $time, a_sig, b_sig, carry_sig, sum_sig);
    
    $display("--------------------------");
    $finish;
  end
  
endmodule
