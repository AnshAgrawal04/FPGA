LIBRARY IEEE;
LIBRARY WORK;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;

ENTITY memory_module is
PORT(
    --clock
    clk : IN std_logic;
    --rom drivers
    rom_add : IN std_logic_vector(11 downto 0);
    rom_data : OUT std_logic_vector(7 downto 0);
    --filter drivers
    filter_add : IN std_logic_vector(3 downto 0);
    filter_data : OUT std_logic_vector(7 downto 0);
    --output ram drivers
    ram_add : IN std_logic_vector(11 downto 0);
    write_enable : IN std_logic;
    ram_data_in : IN std_logic_vector(7 downto 0);
    ram_data_out : OUT std_logic_vector(7 downto 0)
);
end ENTITY memory_module;

ARCHITECTURE CON of memory_module is



COMPONENT blk_mem_gen_1
      PORT (
        clka : IN STD_LOGIC;
        --ena : IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
      );
      
END COMPONENT;

COMPONENT blk_mem_gen_2
      PORT (
        clka : IN STD_LOGIC;
        wea : IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
      );
END COMPONENT;

COMPONENT blk_mem_gen_0
    PORT (
        clka : IN STD_LOGIC;
        --ena : IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END COMPONENT;

begin
output_image : blk_mem_gen_2
PORT MAP(
    clka => clk,
    wea => write_enable,
    addra => ram_add,
    dina => ram_data_in,
    douta => ram_data_out
);
rom_image : blk_mem_gen_1
PORT MAP(
    clka => clk,
    --ena => enable,
    addra => rom_add,
    douta => rom_data
);

filter : blk_mem_gen_0
PORT MAP(
    clka => clk,
    --ena => enable,
    addra => filter_add,
    douta => filter_data
);
end CON;