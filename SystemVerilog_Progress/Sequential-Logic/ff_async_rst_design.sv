// Edge-triggered D Flip-Flop with active-low asynchronous reset
module ff_async_rst (
  input logic clk,		
  input logic rst_n,	// Active-low asynchronous clear
  input logic d,		// Data input
  output logic q		// Registered output
);
  
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q <= 1'b0;	// Asynchronously forces Q to 0, overriding clock
    end else begin
      q <= d;		// Samples data on the rising clock edge
    end
  end
  
endmodule
