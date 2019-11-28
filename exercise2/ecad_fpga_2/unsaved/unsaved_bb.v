
module unsaved (
	clk_clk,
	reset_reset_n,
	eightbitstosevenseg_0_led_pins_led0,
	eightbitstosevenseg_0_led_pins_led1,
	rotaryctl_0_rotary_in_rotary_in,
	rotaryctl_0_rotary_event_rotary_cw,
	rotaryctl_0_rotary_event_rotary_ccw);	

	input		clk_clk;
	input		reset_reset_n;
	output	[6:0]	eightbitstosevenseg_0_led_pins_led0;
	output	[6:0]	eightbitstosevenseg_0_led_pins_led1;
	input	[1:0]	rotaryctl_0_rotary_in_rotary_in;
	output		rotaryctl_0_rotary_event_rotary_cw;
	output		rotaryctl_0_rotary_event_rotary_ccw;
endmodule
