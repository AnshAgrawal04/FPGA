
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
LIBRARY WORK;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity regi is
  Port ( 
    data_in : in signed(7 downto 0);
    data_out: out signed(7 downto 0);
    clock: in std_logic;
    we_re: in std_logic);
    
end regi;
--package mp is
--    type arr is array(0 to 8) of integer;
--    type small_arr is array(0 to 2) of integer;
--end mp;

--package mp_small is
   
--end mp_small;

--USE work.mp.all;

architecture Behavioral of regi is

begin
    resiter_proc:process(clock)
    begin
        if (rising_edge(clock)) then
            if (we_re='1') then
                data_out<=data_in;
            end if;    
        end if;    
    end process;


end Behavioral;
