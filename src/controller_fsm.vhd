----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:42:49 PM
-- Design Name: 
-- Module Name: controller_fsm - FSM
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controller_fsm is
    Port ( i_reset : in STD_LOGIC;
           i_adv : in STD_LOGIC;
           o_cycle : out STD_LOGIC_VECTOR (3 downto 0));
end controller_fsm;

architecture FSM of controller_fsm is

type sm_state is (clear, operand1, operand2, result);

signal f_Q, f_Q_next: sm_state;

begin

 f_Q_next <= operand1 when (i_adv = '1' and f_Q = clear) else -- going up
                operand2 when (i_adv = '1' and f_Q = operand1) else -- going up
                result when (i_adv = '1' and f_Q = operand2) else -- going up
                clear when (i_adv = '1' and f_Q = result) else -- going up
                
                clear; -- default case
 
 o_cycle <= "0001" when(f_Q = clear) else
               "0010" when(f_Q = operand1) else
               "0100" when(f_Q = operand2) else
               "1000" when(f_Q = result);

fsm_proc : process(i_adv, i_reset)
	begin
		if i_reset = '1' then
			f_Q <= clear;
		elsif rising_edge(i_adv) then
			f_Q <= f_Q_next;
		end if;
	end process fsm_proc;


end FSM;
