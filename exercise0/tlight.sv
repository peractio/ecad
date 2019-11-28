module tlight(input logic clk,
				output logic r,
				output logic a,
				output logic g);

logic [2:0] state;
logic rst;

always_ff @ (posedge clk or posedge rst)
	if (rst)
		state <= 3'b100;
	else
		case(state)
			3'b100: state<= 3'b110;
			3'b110: state<= 3'b001;
			3'b001: state<= 3'b010;
			default: state<= 3'b100;
		endcase

assign g = state[0];
assign a = state[1];
assign r = state[2];

endmodule