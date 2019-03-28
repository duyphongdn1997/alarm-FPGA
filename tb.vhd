--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:57:18 03/17/2019
-- Design Name:   
-- Module Name:   /home/ise/xilin/alarm/tb.vhd
-- Project Name:  alarm
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: topmodule
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb IS
END tb;
 
ARCHITECTURE behavior OF tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT topmodule
    PORT(
         reset : IN  std_logic;
         clk : IN  std_logic;
         H_in1 : INout  std_logic_vector(1 downto 0);
         H_in0 : INout  std_logic_vector(3 downto 0);
         M_in1 : INout  std_logic_vector(3 downto 0);
         M_in0 : INout  std_logic_vector(3 downto 0);
         LD_time : IN  std_logic;
         LD_alarm : IN  std_logic;
         Stop_Al : IN  std_logic;
         Al_on : IN  std_logic;
         alarm : OUT  std_logic;
         H_out1 : inOUT  std_logic_vector(1 downto 0);
         H_out0 : inOUT  std_logic_vector(3 downto 0);
         M_out1 : inOUT  std_logic_vector(3 downto 0);
         M_out0 : inOUT  std_logic_vector(3 downto 0);
         S_out1 : inOUT  std_logic_vector(3 downto 0);
         S_out0 : inOUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal H_in1 : std_logic_vector(1 downto 0) := (others => '0');
   signal H_in0 : std_logic_vector(3 downto 0) := (others => '0');
   signal M_in1 : std_logic_vector(3 downto 0) := (others => '0');
   signal M_in0 : std_logic_vector(3 downto 0) := (others => '0');
   signal LD_time : std_logic := '0';
   signal LD_alarm : std_logic := '0';
   signal Stop_Al : std_logic := '0';
   signal Al_on : std_logic := '0';

 	--Outputs
   signal alarm : std_logic;
   signal H_out1 : std_logic_vector(1 downto 0);
   signal H_out0 : std_logic_vector(3 downto 0);
   signal M_out1 : std_logic_vector(3 downto 0);
   signal M_out0 : std_logic_vector(3 downto 0);
   signal S_out1 : std_logic_vector(3 downto 0);
   signal S_out0 : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: topmodule PORT MAP (
          reset => reset,
          clk => clk,
          H_in1 => H_in1,
          H_in0 => H_in0,
          M_in1 => M_in1,
          M_in0 => M_in0,
          LD_time => LD_time,
          LD_alarm => LD_alarm,
          Stop_Al => Stop_Al,
          Al_on => Al_on,
          alarm => alarm,
          H_out1 => H_out1,
          H_out0 => H_out0,
          M_out1 => M_out1,
          M_out0 => M_out0,
          S_out1 => S_out1,
          S_out0 => S_out0
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset <= '1';
		LD_time <= '1';
		wait for 100 ns;	
		reset <= '0';
		LD_time <= '0';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
