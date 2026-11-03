module tb_mux_4to1;

    // Testbench signals
    logic [3:0] in_sig;
    logic [1:0] sel_sig;
    logic       out_sig;

    // Instantiate the 4-to-1 Mux (DUT)
    mux_4to1 uut (
        .in(in_sig),
        .sel(sel_sig),
        .out(out_sig)
    );

    initial begin
        $display("-----------------------------------");
     	$display("Time | Sel | In[3:2:1:0] | Out");
        $display("-----------------------------------");

        // Set unique data bits so we can visually verify which index is routed
        // in[3]=1, in[2]=0, in[1]=1, in[0]=0
        in_sig = 4'b1010; 

        // Test State 00 -> should route in[0] (which is 0)
        sel_sig = 2'b00; #10;
      	$display("%0t  |  %0b   |   %b      |  %b", $time, sel_sig, in_sig, out_sig);

        // Test State 01 -> should route in[1] (which is 1)
        sel_sig = 2'b01; #10;
      	$display("%0t  |  %0b   |   %b      |  %b", $time, sel_sig, in_sig, out_sig);

        // Test State 10 -> should route in[2] (which is 0)
        sel_sig = 2'b10; #10;
      	$display("%0t  |  %0b  |   %b      |  %b", $time, sel_sig, in_sig, out_sig);

        // Test State 11 -> should route in[3] (which is 1)
        sel_sig = 2'b11; #10;
      	$display("%0t  |  %0b  |   %b      |  %b", $time, sel_sig, in_sig, out_sig);

        $display("-----------------------------------");
        $finish;
    end

endmodule
