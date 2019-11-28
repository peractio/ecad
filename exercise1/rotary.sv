// rotary decoder template

module rotary
  (
	input  wire clk,
	input  wire rst,
	input  wire [1:0] rotary_in,
	output logic [7:0] rotary_pos,
        output logic rot_cw,
        output logic rot_ccw
   );


	/* Add wire and register definitions */
	logic[1:0] db_rotary_in;
	reg [1:0] prev_rotary_in;
	logic[1:0] clockwise_counter;

	/* Instantiate debouncing components */
	// debounce rotary_in
	debounce dut(.clk(clk), .rst(rst), .bouncy_in(rotary_in[0]), .clean_out(db_rotary_in[0]));
	debounce dut2(.clk(clk), .rst(rst), .bouncy_in(rotary_in[1]), .clean_out(db_rotary_in[1]));

	/* Synchronous output value manipulation logic */
	// detect cw, acw (update all outputs, if not cw or acw then update rot to 0)
	always_ff @ (posedge clk or posedge rst)
		if(rst) begin
			rotary_pos <= 8'b0;
			clockwise_counter <= 2'b00;
		end
		else if (prev_rotary_in != db_rotary_in)
			// clockwise: assume right turn
			if ((db_rotary_in == 2'b01 && prev_rotary_in == 2'b00) ||
				(db_rotary_in == 2'b11 && prev_rotary_in == 2'b01) ||
				(db_rotary_in == 2'b10 && prev_rotary_in == 2'b11) ||
				(db_rotary_in == 2'b00 && prev_rotary_in == 2'b10)) begin
				if(clockwise_counter == 2) begin
					prev_rotary_in <= db_rotary_in;
					rot_cw <= 1;
					rot_ccw <= 0;
					rotary_pos <= rotary_pos + 1;
					clockwise_counter <= clockwise_counter + 1; // change to 3
				end
				else begin
					prev_rotary_in <= db_rotary_in;
					rot_cw <= 1;
					rot_ccw <= 0;
					clockwise_counter <= clockwise_counter + 1;
				end					
			end
			// anti-clockwise
			else begin
				if(clockwise_counter == 2) begin
					prev_rotary_in <= db_rotary_in;
					rot_ccw <= 1;
					rot_cw <= 0;
					rotary_pos <= rotary_pos - 1;
					clockwise_counter <= clockwise_counter - 1; // change to 1
				end
				else begin
					prev_rotary_in <= db_rotary_in;
					rot_ccw <= 1;
					rot_cw <= 0;
					clockwise_counter <= clockwise_counter - 1;
				end
			end
		else begin
			prev_rotary_in <= db_rotary_in;
			rot_cw <= 0;
			rot_ccw <= 0;
		end


endmodule // rotarydecoder
