module tb_hex_to_7seg;
  
  // 1. Testbench driver signals
  logic [3:0] bin_sig;
  
  // 2. Outputs monitored from the DUT
  logic [6:0] seg_sig;
  
  // 3. Instantiate the Decoder (DUT)
  hex_to_7seg uut (
    .bin(bin_sig),
    .segments(seg_sig)
  );
  
  // Variable for loop iteration
  integer i;
  
  // 4. Initialize stimulus block and print truth table header
  initial begin
    $display("-----------------------------------");
    $display("Time | Hex Input | Segments (g-f-e-d-c-b-a)");
    $display("-----------------------------------");
    
    // Loop through all values from 0 to 15 (4'h0 to 4'hF)
    for (i = 0; i < 16; i++) begin
      bin_sig = i[3:0];
      #10;
      $display("%0t  |    %h      |   %b", $time, bin_sig, seg_sig);
    end
    
    $display("-----------------------------------");
    $finish;
  end
  
endmodule
