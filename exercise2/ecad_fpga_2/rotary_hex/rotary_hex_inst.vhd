	component rotary_hex is
		port (
			clk_clk                                     : in    std_logic                     := 'X';             -- clk
			reset_reset_n                               : in    std_logic                     := 'X';             -- reset_n
			rotaryctl_0_rotary_event_rotary_cw          : out   std_logic;                                        -- rotary_cw
			rotaryctl_0_rotary_event_rotary_ccw         : out   std_logic;                                        -- rotary_ccw
			rotaryctl_0_rotary_in_rotary_in             : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- rotary_in
			shiftregctl_0_buttons_export                : inout std_logic_vector(15 downto 0) := (others => 'X'); -- export
			eightbitstosevenseg_0_led_pins_led0         : out   std_logic_vector(6 downto 0);                     -- led0
			eightbitstosevenseg_0_led_pins_led1         : out   std_logic_vector(6 downto 0);                     -- led1
			shiftregctl_0_shiftreg_clk_shiftreg_clk     : out   std_logic;                                        -- shiftreg_clk
			shiftregctl_0_shiftreg_loadn_shiftreg_loadn : out   std_logic;                                        -- shiftreg_loadn
			shiftregctl_0_shiftreg_out_shiftreg_out     : in    std_logic                     := 'X';             -- shiftreg_out
			eightbitstosevenseg_1_led_pins_led0         : out   std_logic_vector(6 downto 0);                     -- led0
			eightbitstosevenseg_1_led_pins_led1         : out   std_logic_vector(6 downto 0);                     -- led1
			rotaryctl_1_rotary_in_rotary_in             : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- rotary_in
			rotaryctl_1_rotary_event_rotary_cw          : out   std_logic;                                        -- rotary_cw
			rotaryctl_1_rotary_event_rotary_ccw         : out   std_logic                                         -- rotary_ccw
		);
	end component rotary_hex;

	u0 : component rotary_hex
		port map (
			clk_clk                                     => CONNECTED_TO_clk_clk,                                     --                            clk.clk
			reset_reset_n                               => CONNECTED_TO_reset_reset_n,                               --                          reset.reset_n
			rotaryctl_0_rotary_event_rotary_cw          => CONNECTED_TO_rotaryctl_0_rotary_event_rotary_cw,          --       rotaryctl_0_rotary_event.rotary_cw
			rotaryctl_0_rotary_event_rotary_ccw         => CONNECTED_TO_rotaryctl_0_rotary_event_rotary_ccw,         --                               .rotary_ccw
			rotaryctl_0_rotary_in_rotary_in             => CONNECTED_TO_rotaryctl_0_rotary_in_rotary_in,             --          rotaryctl_0_rotary_in.rotary_in
			shiftregctl_0_buttons_export                => CONNECTED_TO_shiftregctl_0_buttons_export,                --          shiftregctl_0_buttons.export
			eightbitstosevenseg_0_led_pins_led0         => CONNECTED_TO_eightbitstosevenseg_0_led_pins_led0,         -- eightbitstosevenseg_0_led_pins.led0
			eightbitstosevenseg_0_led_pins_led1         => CONNECTED_TO_eightbitstosevenseg_0_led_pins_led1,         --                               .led1
			shiftregctl_0_shiftreg_clk_shiftreg_clk     => CONNECTED_TO_shiftregctl_0_shiftreg_clk_shiftreg_clk,     --     shiftregctl_0_shiftreg_clk.shiftreg_clk
			shiftregctl_0_shiftreg_loadn_shiftreg_loadn => CONNECTED_TO_shiftregctl_0_shiftreg_loadn_shiftreg_loadn, --   shiftregctl_0_shiftreg_loadn.shiftreg_loadn
			shiftregctl_0_shiftreg_out_shiftreg_out     => CONNECTED_TO_shiftregctl_0_shiftreg_out_shiftreg_out,     --     shiftregctl_0_shiftreg_out.shiftreg_out
			eightbitstosevenseg_1_led_pins_led0         => CONNECTED_TO_eightbitstosevenseg_1_led_pins_led0,         -- eightbitstosevenseg_1_led_pins.led0
			eightbitstosevenseg_1_led_pins_led1         => CONNECTED_TO_eightbitstosevenseg_1_led_pins_led1,         --                               .led1
			rotaryctl_1_rotary_in_rotary_in             => CONNECTED_TO_rotaryctl_1_rotary_in_rotary_in,             --          rotaryctl_1_rotary_in.rotary_in
			rotaryctl_1_rotary_event_rotary_cw          => CONNECTED_TO_rotaryctl_1_rotary_event_rotary_cw,          --       rotaryctl_1_rotary_event.rotary_cw
			rotaryctl_1_rotary_event_rotary_ccw         => CONNECTED_TO_rotaryctl_1_rotary_event_rotary_ccw          --                               .rotary_ccw
		);

