module tb_rca_4bit;
  // Testbench driver signals (vectors)
  logic [3:0] a_sig;
  logic [3:0] b_sig;
  logic       cin_sig;
  
  // Outputs monitored from the DUT
  logic [3:0] sum_sig;
  logic       cout_sig;

  // Instantiate the 4-bit Ripple-Carry Adder (DUT)
  rca_4bit uut (
    .a(a_sig),
    .b(b_sig),
    .cin(cin_sig),
    .sum(sum_sig),
    .cout(cout_sig)
  );

  // Initialize stimulus block and print header
  initial begin
    $display("--------------------------------------------");
    $display("Time | Cin |   A   |   B   | Cout |   Sum   ");
    $display("--------------------------------------------");

    // Test Case 1: 4 + 3 = 7 (0100 + 0011 = 0111)
    a_sig = 4'd4; b_sig = 4'd3; cin_sig = 1'b0; #10;
    $display("%0t   |  %b  |  %b |  %b |   %b  |  %b", $time, cin_sig, a_sig, b_sig, cout_sig, sum_sig);

    // Test Case 2: 5 + 9 = 14 (0101 + 1001 = 1110)
    a_sig = 4'd5; b_sig = 4'd9; cin_sig = 1'b0; #10;
    $display("%0t   |  %b  |  %b |  %b |   %b  |  %b", $time, cin_sig, a_sig, b_sig, cout_sig, sum_sig);

    // Test Case 3: Overflow condition -> 15 + 1 = 16 (1111 + 0001 = Cout:1, Sum:0000)
    a_sig = 4'd15; b_sig = 4'd1; cin_sig = 1'b0; #10;
    $display("%0t   |  %b  |  %b |  %b |   %b  |  %b", $time, cin_sig, a_sig, b_sig, cout_sig, sum_sig);

    $display("--------------------------------------------");
    $finish;
  end

endmodule
