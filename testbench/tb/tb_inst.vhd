	component tb is
		port (
			clk_clk               : in    std_logic                    := 'X';             -- clk
			reset_reset_n         : in    std_logic                    := 'X';             -- reset_n
			ts4231_d_io           : inout std_logic_vector(9 downto 0) := (others => 'X'); -- d_io
			ts4231_e_io           : inout std_logic_vector(9 downto 0) := (others => 'X'); -- e_io
			ts4231_current_state  : out   std_logic_vector(3 downto 0);                    -- current_state
			ts4231_current_sensor : out   std_logic_vector(7 downto 0);                    -- current_sensor
			ts4231_sensor_state   : out   std_logic_vector(2 downto 0);                    -- sensor_state
			ts4231_watch_state    : out   std_logic_vector(9 downto 0)                     -- watch_state
		);
	end component tb;

	u0 : component tb
		port map (
			clk_clk               => CONNECTED_TO_clk_clk,               --    clk.clk
			reset_reset_n         => CONNECTED_TO_reset_reset_n,         --  reset.reset_n
			ts4231_d_io           => CONNECTED_TO_ts4231_d_io,           -- ts4231.d_io
			ts4231_e_io           => CONNECTED_TO_ts4231_e_io,           --       .e_io
			ts4231_current_state  => CONNECTED_TO_ts4231_current_state,  --       .current_state
			ts4231_current_sensor => CONNECTED_TO_ts4231_current_sensor, --       .current_sensor
			ts4231_sensor_state   => CONNECTED_TO_ts4231_sensor_state,   --       .sensor_state
			ts4231_watch_state    => CONNECTED_TO_ts4231_watch_state     --       .watch_state
		);

