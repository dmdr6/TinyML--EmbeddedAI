module tb_not_gate;
  
  // 1. Signals to drive the Device Under Test (DUT)
  logic in_sig;
  logic out_sig;
  
  // 2. Instantiate the NOT Gate
  not_gate uut (
    .in(in_sig),
    .out(out_sig)
  );
  
  // 3. Truth table verification
  initial begin
    $display("--------------");
    $display("Time | Input | Out");
    $display("--------------");

    // Input 0 -> Output 1
    in_sig = 1'b0; #10;
    $display("%0t   |   %b   | %b", $time, in_sig, out_sig); 
 
    // Input 1 -> Output 0
    in_sig = 1'b1; #10;
    $display("%0t   |   %b   | %b", $time, in_sig, out_sig);     
    
    $display("--------------");
    $finish;
  end
  
endmodule
