`timescale 1ns / 1ps

module tb_tlight(
	output r,
	output a,
	output g);

	logic clk;	// clock signal we are going to generate
	logic rst;

	// instantiate design under test (dut)
	tlight dut(.clk(clk), .r(r), .a(a), .g(g));

	initial
		begin
			clk = 0;
			rst = 1; // yl: at time=0, set reset to active
			#2 rst = 0; // after 2 clock ticks set reset to inactive (0)
		end

	always #5
		clk <= !clk;

	always @ (negedge clk)
		$display("time=%05d: (r,a,g) = (%1d, %1d, %1d)",
			$time,
			r,a,g);

endmodule