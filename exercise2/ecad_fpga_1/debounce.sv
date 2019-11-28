// debounce template

module debounce
  (
	input wire       clk,       // 50MHz clock input
	input wire       rst,       // reset input (positive)
	input wire       bouncy_in, // bouncy asynchronous input
	output reg 	 clean_out  // clean debounced output
   );

        /* Add wire and register definitions */
	logic [13:0] counter; // 14 bits to count up to 10**4
	reg prev;
	reg rise;
	reg fall;
	reg result;

	// uses synchroniser module
	synchroniser dut(.async_sig(bouncy_in), .clk(clk), .rise(rise), .fall(fall), .result(result));

        /* Add synchronous debouncing logic */
	always_ff @ (posedge clk or posedge rst)
		if (rst) begin
			counter <=  0;
		end
		else if (counter <= 14'd10000) begin
			if(!rise && !fall) counter <=  counter + 1;
			else counter <= 0;
		end
		else begin
			clean_out <= result;
			counter <= 0;
		end
   
endmodule // debounce
