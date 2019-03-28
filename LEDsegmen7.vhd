----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:48:01 03/28/2019 
-- Design Name: 
-- Module Name:    LEDsegmen7 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LEDsegmen7 is
port (
	reset : in std_logic;
	clk : in std_logic;
	in0 : in std_logic_vector (3 downto 0);
	in1 : in std_logic_vector (3 downto 0);
	in2 : in std_logic_vector (3 downto 0);
	in3 : in std_logic_vector (3 downto 0);
	LED_out : out std_logic_vector (6 downto 0);
	Anode_Activate :out std_logic_vector (3 downto 0));
end LEDsegmen7;

architecture Behavioral of LEDsegmen7 is
component LEDdisplay is
Port ( Z : in  STD_LOGIC_VECTOR (3 downto 0);
           LED : out  STD_LOGIC_VECTOR (6 downto 0));
end component;
signal LED_BCD : std_logic_vector (3 downto 0);
signal refresh_counter : std_logic_vector (7 downto 0); 
signal LED_activating_counter : std_logic_vector (1 downto 0);
begin
	--process tao xung clk voi' tan so = 100Mhz / 2 ^ ( sizeof (refresh_counter) + 1)
	process(clk,reset)
	begin 
		if(reset='1') then
			refresh_counter <= x"00";
			elsif(rising_edge(clk)) then
				refresh_counter <= refresh_counter + 1;
		end if;
	end process;
	LED_activating_counter <= refresh_counter(7 downto 6);
	-- 4-to-1 MUX to generate anode activating signals for 4 LEDs 
	process(LED_activating_counter)
	begin
		 case LED_activating_counter is
		 when "00" =>
			  Anode_Activate <= "0111"; 
			  -- activate LED1 and Deactivate LED2, LED3, LED4
			  LED_BCD <= in0;
			  -- Hien thi. in0 vao` LED 7seg thu' nhat'.
		 when "01" =>
			  Anode_Activate <= "1011"; 
			  -- activate LED2 and Deactivate LED1, LED3, LED4
			  LED_BCD <= in1;
			  -- Hien? thi. in1 vao` LED 7seg thu' hai.
		 when "10" =>
			  Anode_Activate <= "1101"; 
			  -- activate LED3 and Deactivate LED2, LED1, LED4
			  LED_BCD <= in2;
			  -- Hien? thi. in2 vao` LED 7seg thu' ba.
		 when "11" =>
			  Anode_Activate <= "1110"; 
			  -- activate LED4 and Deactivate LED2, LED3, LED1
			  LED_BCD <= in3;
			  -- Hien? thi. in3 vao` LED 7seg thu' tu. 
		 when others => 
			  Anode_Activate <= "1111";
		 end case;
	end process;
	--display 7LED 
	led_bcd1: LEDdisplay port map (
		Z => LED_BCD,
		LED => LEd_out
		);
end Behavioral;

