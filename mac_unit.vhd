library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--use work.mp.all;

entity MAC_tb is
end MAC_tb;

architecture Behavioral of MAC_tb is
signal clk : std_logic;
signal reset : std_logic := '0';
--signal kernel : arr;
--signal element : arr;
signal element: signed(8 downto 0);
signal kernel: signed(8 downto 0);
signal output : signed(23 downto 0);
signal blk: signed(17 downto 0);
signal acc: signed (23 downto 0);
signal kerint: integer;
signal eleint: integer;
signal outint: integer;
signal control:integer;
--reset: in std_logic;
--signal control : integer:=0;
signal count:  integer;
--output: out signed(23 downto 0)

begin

clock : process
begin
clk <= '0';
wait for 5 ns;
clk <= '1';
wait for 5 ns;
end process;

control_proc: process
begin 
    control<=0;
    wait for 10 ns;
    control <=1;
    wait for 110 ns;
    control <=2;
    wait for 10ns;
end process;
testing : process
begin
    kernel(0) <= '0';
    wait for 5 ns;
--    kernel(0) <= '1';
--    wait for 5 ns;
--    kernel(0) <= '0';
--    wait for 5 ns;
end process;


    
    
process
begin
    kernel(1) <= '0';
    wait for 5 ns;
    kernel(1) <= '1';
    wait for 5 ns;
    
end process;
process    
begin
    kernel(2) <= '0';
    wait for 5 ns;
    kernel(2) <= '1';
    wait for 5 ns;
    
end process;
    
process
begin
    kernel(3) <= '0';
    wait for 5 ns;
    kernel(3) <= '1';
    wait for 5 ns;
    
end process;

process

begin
    kernel(4) <= '0';
    wait for 5 ns;
    kernel(4) <= '1';
    wait for 5 ns;
    
end process;

process

begin
    kernel(5) <= '0';
    wait for 5 ns;
    kernel(5) <= '1';
    wait for 5 ns;
    
end process;
    
process
begin
    kernel(6) <= '0';
    wait for 5 ns;
    kernel(6) <= '1';
    wait for 5 ns;
   
end process;
process    
begin
    kernel(7) <= '0';
    wait for 5 ns;
    kernel(7) <= '1';
    wait for 5 ns;
    
end process;
    
process
begin
    kernel(8) <= '0';
    wait for 5 ns;
    kernel(8) <= '1';
    wait for 5 ns;
    
end process; 

process    
begin
    element(0) <= '1';
    wait for 5 ns;
    element(0) <= '0';
    wait for 5 ns;
    
end process;
    
process
begin
    element(1) <= '0';
    wait for 5 ns;
    element(1) <= '1';
    wait for 5 ns;
    
end process;
process    
begin
    element(2) <= '0';
    wait for 5 ns;
    element(2) <= '1';
    wait for 5 ns;
    
end process;
    
process
begin
    element(3) <= '0';
    wait for 5 ns;
    element(3) <= '1';
    wait for 5 ns;
    
end process;

process

begin
    element(4) <= '0';
    wait for 5 ns;
    element(4) <= '1';
    wait for 5 ns;
    
end process;

process

begin
    element(5) <= '0';
    wait for 5 ns;
    element(5) <= '1';
    wait for 5 ns;
    
end process;
    
process
begin
    element(6) <= '0';
    wait for 5 ns;
    element(6) <= '1';
    wait for 5 ns;
    
end process;
process    
begin
    element(7) <= '0';
    wait for 5 ns;
    element(7) <= '1';
    wait for 5 ns;
    
end process;
    
process
begin
    element(8) <= '1';
    wait for 5 ns;
    element(8) <= '0';
    wait for 5 ns;
 
end process; 


process
begin    
    reset <= '0';
    wait for 5 ns;
    reset <= '1';
    wait for 5 ns;
end process;

process(clk, reset)
begin

if rising_edge(clk) then
    if control = 0 then
        --output <= (others=>'0');
        acc<=(others=>'0');
        blk<=(others=>'0');
    elsif (control =1) then
        blk<=kernel* element;
        acc<=acc+blk;       
        --output <= kernel * element;
        outint<=to_integer(signed(acc));
        kerint<=to_integer(signed(kernel));
        eleint<=to_integer(signed(element));
    elsif (control =2) then
        output<=acc;    
         --output <= kernel(0)*element(0) + kernel(1)*element(1) + kernel(2)*element(2) + kernel(3)*element(3) + kernel(4)*element(4) + kernel(5)*element(5) + kernel(6)*element(6) + kernel(7)*element(7) + kernel(8)*element(8);
    end if;
end if;
end process;

end Behavioral;
