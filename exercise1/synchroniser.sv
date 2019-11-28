module synchroniser (input async_sig,
						input clk,
						output reg rise,
						output reg fall,
						output reg result);

	reg [1:3] resync;

	always @ (posedge clk)
	begin
		rise <= resync[2] & !resync[3];
		fall <= resync[3] & !resync[2];
		resync <= {async_sig, resync[1:2]};
		result <= resync[3];
	end

endmodule