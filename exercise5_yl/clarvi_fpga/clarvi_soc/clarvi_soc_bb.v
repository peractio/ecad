
module clarvi_soc (
	clk_clk,
	pio_displaybuttons_external_connection_export,
	pio_hexdigits_external_connection_export,
	pio_leds_external_connection_export,
	pio_leftdial_external_connection_export,
	pio_rightdial_external_connection_export,
	pixelstream_0_conduit_end_0_lcd_red,
	pixelstream_0_conduit_end_0_lcd_green,
	pixelstream_0_conduit_end_0_lcd_blue,
	pixelstream_0_conduit_end_0_lcd_hsync,
	pixelstream_0_conduit_end_0_lcd_vsync,
	pixelstream_0_conduit_end_0_lcd_de,
	pixelstream_0_conduit_end_0_lcd_dclk,
	pixelstream_0_conduit_end_0_lcd_dclk_en,
	reset_reset_n);	

	input		clk_clk;
	input	[15:0]	pio_displaybuttons_external_connection_export;
	output	[23:0]	pio_hexdigits_external_connection_export;
	output	[9:0]	pio_leds_external_connection_export;
	input	[7:0]	pio_leftdial_external_connection_export;
	input	[7:0]	pio_rightdial_external_connection_export;
	output	[7:0]	pixelstream_0_conduit_end_0_lcd_red;
	output	[7:0]	pixelstream_0_conduit_end_0_lcd_green;
	output	[7:0]	pixelstream_0_conduit_end_0_lcd_blue;
	output		pixelstream_0_conduit_end_0_lcd_hsync;
	output		pixelstream_0_conduit_end_0_lcd_vsync;
	output		pixelstream_0_conduit_end_0_lcd_de;
	output		pixelstream_0_conduit_end_0_lcd_dclk;
	output		pixelstream_0_conduit_end_0_lcd_dclk_en;
	input		reset_reset_n;
endmodule
