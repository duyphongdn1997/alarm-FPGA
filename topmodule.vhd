----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:22:41 03/17/2019 
-- Design Name: 
-- Module Name:    topmodule - Behavioral 
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

entity topmodule is
    Port ( reset : in  STD_LOGIC; -- reset signal	
           clk : in  STD_LOGIC; -- xung clock tu board mach (100Mhz)
           H_in1 : in  STD_LOGIC_VECTOR (1 downto 0); -- dau` vao` chon. gio` ex: 1    1    :    1    1 
           H_in0 : in  STD_LOGIC_VECTOR (3 downto 0); -- dau` vao` chon. gio`		 |    |         |    |  
           M_in1 : in  STD_LOGIC_VECTOR (3 downto 0); -- dau` vao` chon. phut'   Hin1 Hin0     Min1  Min0
           M_in0 : in  STD_LOGIC_VECTOR (3 downto 0); -- dau` vao` chon. phut'
           LD_time : in  STD_LOGIC; --switch --> nhap thoi` gian ban dau`.
           LD_alarm : in  STD_LOGIC; --switch --> nhap thoi` gian bao' thuc'.
           Stop_Al : in  STD_LOGIC; -- button --> tat' bao' thuc', chi hoat dong. khi dang co' tin' hieu' alarm.
           Al_on : in  STD_LOGIC; -- switch --> cho phep' dat. bao' thuc'.
           alarm : out  STD_LOGIC; -- signal alarm.
           H_out1 : inout  STD_LOGIC_VECTOR (1 downto 0); --
           H_out0 : inout  STD_LOGIC_VECTOR (3 downto 0); --
           M_out1 : inout  STD_LOGIC_VECTOR (3 downto 0); -- Hien thi. thoi` gian hien tai.
           M_out0 : inout  STD_LOGIC_VECTOR (3 downto 0); --	hay thoi` gian dem' gio`.
           S_out1 : inout  STD_LOGIC_VECTOR (3 downto 0); --
           S_out0 : inout  STD_LOGIC_VECTOR (3 downto 0); --
			  Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
           LED_out : out STD_LOGIC_VECTOR (6 downto 0));-- Cathode patterns of 7-segment display			  
end topmodule;

architecture Behavioral of topmodule is
signal 	clk_1s: STD_LOGIC; -- tin' hieu. clk 1Hz de kich' dem' mach.
signal	tmp_1s : STD_LOGIC_VECTOR (3 downto 0); -- bien' tam. de? tao. clk_1s 
signal	c_hour0,a_hour0,c_min1,a_min1,c_min0 : STD_LOGIC_VECTOR (3 downto 0); -- bien' luu tru~ thoi` gian bao' thuc'.
signal	a_min0,c_sec1,a_sec1,c_sec0,a_sec0 : STD_LOGIC_VECTOR (3 downto 0); -- thoi` gian dem' duoc.
signal	c_hour1,a_hour1 : STD_LOGIC_VECTOR (1 downto 0);
signal	tmp_hour, tmp_minute, tmp_second : STD_LOGIC_VECTOR (5 downto 0); -- bien' dem' thoi` gian.
-- component chia tan so' clk 100Mhz --> 1Hz.
COMPONENT clock_divider_100MHz_to_1Hz
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;          
		clk_out : OUT std_logic
		);
	END COMPONENT;
-- Component hien? thi. 4 LED 7 doan.
component LEDsegmen7
	Port ( reset : in std_logic;
			clk : in std_logic;
			in0 : in std_logic_vector (3 downto 0);
			in1 : in std_logic_vector (3 downto 0);
			in2 : in std_logic_vector (3 downto 0);
			in3 : in std_logic_vector (3 downto 0);
			LED_out : out std_logic_vector (6 downto 0);
			Anode_Activate : out std_logic_vector (3 downto 0));
end component;	
begin
	
	
	LED7: LEDsegmen7 port map (
		reset => reset,
		clk => clk,
		in0 => M_out1,
		in1 => M_out0,
		in2 => S_out1,
		in3 => S_out0,
		LED_out => LED_out,
		Anode_Activate => Anode_activate
		);
	
	
	U3: clock_divider_100MHz_to_1Hz PORT MAP(
		clk => clk,
		reset => reset,
		clk_out => clk_1s
	);



	-- 7-segment display controller
	-- generate refresh period of 10.5ms
--	process(clk,reset)
--	begin 
--		if(reset='1') then
	--		refresh_counter <= (others => '0');
		--	elsif(rising_edge(clk)) then
			--	if (refresh_counter = x"FFFFE") then 
				--	refresh_counter <= x"00000";
--				end if;
	--			refresh_counter <= refresh_counter + x"00001";
		--end if;
--	end process;
--	LED_activating_counter <= refresh_counter(19 downto 18);
	-- 4-to-1 MUX to generate anode activating signals for 4 LEDs 
--	process(LED_activating_counter)
--	begin
--		 case LED_activating_counter is
--		 when "00" =>
--			  Anode_Activate <= "0111"; 
--			  -- activate LED1 and Deactivate LED2, LED3, LED4
--			  LED_BCD <= M_out1;
			  -- the first hex digit of the 16-bit number
--		 when "01" =>
--			  Anode_Activate <= "1011"; 
			  -- activate LED2 and Deactivate LED1, LED3, LED4
--			  LED_BCD <= M_out0;
			  -- the second hex digit of the 16-bit number
--		 when "10" =>
	--		  Anode_Activate <= "1101"; 
			  -- activate LED3 and Deactivate LED2, LED1, LED4
		--	  LED_BCD <= S_out1;
			  -- the third hex digit of the 16-bit number
		-- when "11" =>
			--  Anode_Activate <= "1110"; 
			  -- activate LED4 and Deactivate LED2, LED3, LED1
			  --LED_BCD <= S_out0;
			  -- the fourth hex digit of the 16-bit number 
		 --when others => 
			--  Anode_Activate <= "1111";
		 --end case;
	--end process;
	--display 7LED 
--	led_bcd1: LEDdisplay port map (
	--	Z => LED_BCD,
--		LED => LEd_out
--		);
	--H_in1 <= "00";
	--H_in0 <= "0000";
	--M_in1 <= "0000";
	--M_in0 <= "0000";



-- process cho hoat. dong. chinh' cua? mach 
-- thuc hien. cac' chuc' nang :
-- 	nap. thoi` gian thuc.;
--		nap. thoi` gian bao' thuc';
--		thuc. hien. dem' de? chay. dong` ho`		
	process (clk_1s, reset) is
	begin
		if (reset = '1') then 
			a_hour1 <= "00";
			a_hour0 <= "0000";
			a_min1 <= "0000";
			a_min0 <= "0000";
			a_sec1 <= "0000";
			a_sec0 <= "0000";
			--std_logic_vector(to_unsigned((to_integer(unsigned(A)) * to_integer(unsigned(B))),n)) ;
			tmp_hour <= std_logic_vector(to_unsigned((to_integer(unsigned(H_in1)) * 10),6))  + H_in0;
			tmp_minute <= std_logic_vector(to_unsigned((to_integer(unsigned(M_in1)) * 10),6)) + M_in0;
			tmp_second <= "000000";
		end if;
		
		-- Nhap thoi` gian bao' thuc'.
		
		if (LD_alarm = '1') then
			a_hour1 <= H_in1;
			a_hour0 <= H_in0;
			a_min1 <= M_in1;
			a_min0 <= M_in0;
			a_sec1 <= "0000";
			a_sec0 <= "0000";
		end if;
		
		-- Nhap thoi` gian thuc. (hoac thoi` gian bat' dau` dem')
		
		if (LD_time = '1') then
			tmp_hour <= std_logic_vector(to_unsigned((to_integer(unsigned(H_in1)) * 10),6)) + H_in0;
			tmp_minute <= std_logic_vector(to_unsigned((to_integer(unsigned(M_in1)) * 10),6)) + M_in0;
			tmp_second <= "000000";
		
		-- Neu' khong thuc hien. nhap. input --> thuc hien dem'.
		
		else 
			tmp_second <= tmp_second + "000001"; 
			if (tmp_second >= x"3B") then -- khi tmp_second = 59 --> tmp_minute++ va` reset tmp_second
				tmp_minute <= tmp_minute + "000001";
				tmp_second <= "000000";
				if (tmp_minute >= x"3B") then -- khi tmp_minute = 59 --> tmp_hour++ va` reset tmp_minute
					tmp_hour <= tmp_hour + "000001";
					tmp_minute <= "000000";
						if (tmp_hour >= x"18") then -- khi tmp_hour = 23 --> reset tmp_hour
							tmp_hour <= "000000";
						end if;
				end if;
			end if;
		end if;
	end process;
	
	
	--process (clk,reset) is
	--begin
		--if (reset = '1') then
			--tmp_1s <= "0000";
			--clk_1s <= '0';
		--else
			--tmp_1s <= tmp_1s + "1";
			--if (tmp_1s <= x"5") then
				--clk_1s <= '0';
			--elsif (tmp_1s >= x"A") then
				--clk_1s <= '1';
				--tmp_1s <= "0001";
				--else clk_1s <= '1';
			--end if;
		--end if;
	--end process;
 
 
 -- process chuyen? doi? tmp_hour, tmp_min, tmp_sec => c_hour, c_min, c_sec de? xuat' ra va` hien? thi.	
	process (clk) is
	begin
		if (tmp_hour >= x"14") then -- x"14" = 20
			c_hour1 <= "10";
		elsif (tmp_hour >= x"A") then -- x"A" = 10
			c_hour1 <= "01";
			else c_hour1 <= "00";
		end if;
		c_hour0 <= std_logic_vector(to_unsigned(to_integer(unsigned(tmp_hour)) - (to_integer(unsigned(c_hour1)) * 10),4));
		c_min1 <= std_logic_vector(to_unsigned((to_integer(unsigned(tmp_minute)) / 10),4)); -- chia lay' thuong
		c_min0 <= std_logic_vector(to_unsigned(to_integer(unsigned(tmp_minute)) - (to_integer(unsigned(c_min1)) * 10),4));
		c_sec1 <= std_logic_vector(to_unsigned((to_integer(unsigned(tmp_second)) / 10),4)); -- chia lay' thuong
		c_sec0 <= std_logic_vector(to_unsigned(to_integer(unsigned(tmp_second)) - (to_integer(unsigned(c_sec1)) * 10),4));
	end process;
	
	-- Xuat cac gia' tri. gio`, phut', giay cua dong` ho`.
	H_out1 <= c_hour1;
	H_out0 <= c_hour0;
	M_out1 <= c_min1;
	M_out0 <= c_min0;
	S_out1 <= c_sec1;
	s_out0 <= c_sec0;
	
	
	-- process thuc. hien. chuc' nang bao' thuc'.
	-- de? tat' bao' thuc' --> kich' Stop_alarm len muc' cao.
	process (clk_1s, reset) is
	begin
		if (reset = '1') then Alarm <= '0';
		elsif ((a_hour1 = c_hour1) and (a_hour0 = c_hour0) and (a_min1 = c_min1) and (a_min0 = c_min0) and (a_sec1 = c_sec1) and (a_sec0 = c_sec0)) then 
			if (Al_on = '1') then
				Alarm <= '1';
			end if;
			if (Stop_al = '1') then
				Alarm <= '0';
			end if;
		end if;
	end process;

end Behavioral;

