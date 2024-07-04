--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;


--entity MAC is
--  Port (
--    control : in integer;
--    --kernel
--    input1: in signed(8 downto 0);
--    --filter
--    input2: in signed(7 downto 0);
--    clk: in std_logic;
--    reset: in std_logic;
--    outputi: out integer;
--    p: out integer
    
    
--     );
--end MAC;

--architecture Behavioral of MAC is
--signal blk: signed(16 downto 0);
--signal acc: signed (19 downto 0);--:=(others=>'0');
--begin
--process(clk, reset)
--begin

--if rising_edge(clk) then
--    if control = 0 then
--        --output <= (others=>'0');
--        acc<=(others=>'0');
--        blk<=(others=>'0');
--    elsif (control =1) then
--        blk<=input1* input2;
--    elsif (control=6) then    
--        acc<=acc+blk;  
--        p<=to_integer(signed(acc));     
--        --output <= kernel * element;
----        outint<=to_integer(signed(acc));
----        kerint<=to_integer(signed(kernel));
----        eleint<=to_integer(signed(element));
--    elsif (control =2) then
--        outputi<=to_integer(signed(acc));    
--         --output <= kernel(0)*element(0) + kernel(1)*element(1) + kernel(2)*element(2) + kernel(3)*element(3) + kernel(4)*element(4) + kernel(5)*element(5) + kernel(6)*element(6) + kernel(7)*element(7) + kernel(8)*element(8);
--    end if;
--end if;
--end process;




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity MAC is
  Port (
    control : in integer;
    --kernel
    input1: in signed(8 downto 0);
    --filter
    input2: in signed(7 downto 0);
    clk: in std_logic;
    reset: in std_logic;
    outputi: out signed(16 downto 0)
     );
end MAC;

architecture Behavioral of MAC is
signal blk: signed(16 downto 0);
signal acc: signed (16 downto 0);
begin
process(clk, reset)
begin

if rising_edge(clk) then
    if control = 0 then
        --output <= (others=>'0');
        acc<=(others=>'0');
        blk<=(others=>'0');
    elsif (control =1) then
        blk<=input1* input2;
        acc<=acc+blk;       
        --output <= kernel * element;
--        outint<=to_integer(signed(acc));
--        kerint<=to_integer(signed(kernel));
--        eleint<=to_integer(signed(element));
    elsif (control =2) then
        outputi<=acc;    
         --output <= kernel(0)*element(0) + kernel(1)*element(1) + kernel(2)*element(2) + kernel(3)*element(3) + kernel(4)*element(4) + kernel(5)*element(5) + kernel(6)*element(6) + kernel(7)*element(7) + kernel(8)*element(8);
    end if;
end if;
end process;

end Behavioral;

