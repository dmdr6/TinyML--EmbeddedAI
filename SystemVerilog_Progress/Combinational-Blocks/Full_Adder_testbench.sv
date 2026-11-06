module tb_full_adder;
  
  // 1. Testbench driver signals
  logic a_sig;
  logic b_sig;
  logic cin_sig;
  
  // 2. Outputs monitored from the DUT
  logic sum_sig;
  logic cout_sig;
  
  // 3. Instantiate the Full Adder (DUT)
  full_adder uut (
    .a(a_sig),
    .b(b_sig),
    .cin(cin_sig),
    .sum(sum_sig),
    .cout(cout_sig)
  );
  
  // 4. Initialize stimulus block and print truth table header
  initial begin
    $display("-------------------------------");
    $display("Time | Cin | A | B | Cout | Sum");
    $display("-------------------------------");
    
    // 3-bit combinations (0 to 7)
    
    // Combination 0: 000
    cin_sig = 1'b0; a_sig = 1'b0; b_sig = 1'b0; #10;    
    $display("%0t   |  %b  | %b | %b |   %b  |  %b", $time, cin_sig, a_sig, b_sig, cout_sig, sum_sig);
    
    // Combination 1: 001
    cin_sig = 1'b0; a_sig = 1'b0; b_sig = 1'b1; #10;    
    $display("%0t   |  %b  | %b | %b |   %b  |  %b", $time, cin_sig, a_sig, b_sig, cout_sig, sum_sig);
    
    // Combination 2: 010
    cin_sig = 1'b0; a_sig = 1'b1; b_sig = 1'b0; #10;    
    $display("%0t   |  %b  | %b | %b |   %b  |  %b", $time, cin_sig, a_sig, b_sig, cout_sig, sum_sig);   
  
    // Combination 3: 011
    cin_sig = 1'b0; a_sig = 1'b1; b_sig = 1'b1; #10;    
    $display("%0t   |  %b  | %b | %b |   %b  |  %b", $time, cin_sig, a_sig, b_sig, cout_sig, sum_sig);
    
    // Combination 4: 100
    cin_sig = 1'b1; a_sig = 1'b0; b_sig = 1'b0; #10;    
    $display("%0t   |  %b  | %b | %b |   %b  |  %b", $time, cin_sig, a_sig, b_sig, cout_sig, sum_sig);
    
    // Combination 5: 101
    cin_sig = 1'b1; a_sig = 1'b0; b_sig = 1'b1; #10;    
    $display("%0t   |  %b  | %b | %b |   %b  |  %b", $time, cin_sig, a_sig, b_sig, cout_sig, sum_sig);
    
    // Combination 6: 110
    cin_sig = 1'b1; a_sig = 1'b1; b_sig = 1'b0; #10;    
    $display("%0t   |  %b  | %b | %b |   %b  |  %b", $time, cin_sig, a_sig, b_sig, cout_sig, sum_sig);
    
    // Combination 7: 111
    cin_sig = 1'b1; a_sig = 1'b1; b_sig = 1'b1; #10;    
    $display("%0t   |  %b  | %b | %b |   %b  |  %b", $time, cin_sig, a_sig, b_sig, cout_sig, sum_sig);    
    
    $display("-------------------------------");
    $finish;
  end
  
endmodule
