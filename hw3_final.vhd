------------------------------------------------------------------------------------
---- Company: ME
---- Engineer: ME
---- 
---- Create Date: 11/10/2023 12:00:55 AM
---- Design Name: 
---- Module Name: hw3_final - Behavioral
---- Project Name: 
---- Target Devices: 
---- Tool Versions: 
---- Description: 
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 0.01 - File Created
---- Additional Comments:
---- 
------------------------------------------------------------------------------------


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--USE IEEE.STD_LOGIC_UNSIGNED.ALL;
--USE ieee.numeric_std.ALL;



--entity fsm is
----  Port (
----    clk: in std_logic;
----    reset: in std_logic;
----    Hsync: out std_logic;
----    Vsync : out std_logic;
----    rgb: out std_logic_vector(11 downto 0)
----   );
--end fsm;

--architecture Behavioral of fsm is
--type t_State is (filterstate,minstate);
--signal current_state: t_State:=filterstate;
--signal next_state: t_State;
--signal ps: integer:=0;
--signal i: integer:=0;
--signal mode:integer:=0;

--signal reg2: signed(7 downto 0);
--signal reg1: signed (8 downto 0);
--signal reg3:integer;
--signal reg4:integer;
--signal reg5:integer;

--signal mac_control: integer;
----signal input1:  signed (8 downto 0);
----signal input2: signed (8 downto 0);

--signal filterdata: std_logic_vector(7 downto 0);
--signal filteraddress: std_logic_vector(3 downto 0);
--signal romdata: std_logic_vector(7 downto 0);
--signal romaddress: std_logic_vector(11 downto 0);
--signal flag:std_logic:='0';

--signal ram_address:std_logic_vector(11 downto 0);
--signal ram_data: std_logic_vector(7 downto 0);
--signal data_in_ram: std_logic_vector(7 downto 0);
--signal write_enable: std_logic;

--signal maximum:integer:=-10000;
--signal minimum:integer:=10000;
--signal inte:integer;


--signal color_vector:std_logic_vector(11 downto 0);
--signal video_onn:std_logic;
--signal rdaddress: std_logic_vector(11 downto 0);

--signal tester: integer:=0;
----------
--signal clk: std_logic;
--signal reset:  std_logic:='0';
--signal Hsync:  std_logic;
--signal Vsync:std_logic;
--signal rgb:  std_logic_vector(11 downto 0);
----------

--component memory_module is 
--    port(
--        clk : IN std_logic;
--        --rom drivers
--        rom_add : IN std_logic_vector(11 downto 0);
--        rom_data : OUT std_logic_vector(7 downto 0);
--        --filter drivers
--        filter_add : IN std_logic_vector(3 downto 0);
--        filter_data : OUT std_logic_vector(7 downto 0);
--        --output ram drivers
--        ram_add : IN std_logic_vector(11 downto 0);
--        write_enable : IN std_logic;
--        ram_data_in : IN std_logic_vector(7 downto 0);
--        ram_data_out : OUT std_logic_vector(7 downto 0)
--    );
--end component;

--component MAC is
--    PORT(
--    control : in integer;
--    --kernel
--    input1: in signed(8 downto 0);
--    --filter
--    input2: in signed(7 downto 0);
--    clk: in std_logic;
--    reset: in std_logic;
--    outputi: out integer;
--    p: out integer
--    );
--end component;  

--COMPONENT Base is
--    PORT(
--        clk : in STD_LOGIC;
--        reset : in STD_LOGIC;
--        hsync : out STD_LOGIC;
--        vsync : out STD_LOGIC;
--        video_on : out STD_LOGIC;
--        p_tick : out STD_LOGIC;
--        x : out STD_LOGIC_VECTOR(9 downto 0);
--        rad: out STD_LOGIC_VECTOR(11 downto 0);
--        y : out STD_LOGIC_VECTOR(9 downto 0)
--    );
--END COMPONENT;

--BEGIN

------------------------------------
--process
--begin
--    clk<='0';
--    wait for 5ns;
--    clk<='1';
--    wait for 5ns;
--end process;
-------------------------------------
--vga_CON: Base
--    PORT MAP(
--        clk=>clk,
--        reset=>reset,
--        hsync=>Hsync,
--        vsync=>Vsync,
--        video_on=>video_onn,
--        rad=>rdaddress,
--        x=>open,
--        y=>open,
--        p_tick=>open
--    );
--mac_con: MAC    
--PORT MAP(
--    control=>mac_control,
--    input1=>reg1,
--    input2=>reg2,
--    clk=>clk,
--    reset=>reset,
--    p=>reg4,
--    outputi=>reg3
--    );
--memory_con: memory_module
--    PORT MAP(
--        CLK=>CLK,
--        rom_add=>romaddress,
--        rom_data=> romdata,
--        filter_add=> filteraddress,
--        filter_data=> filterdata,
--        ram_add=> ram_address,
--        ram_data_in=> data_in_ram,
--        ram_data_out=>ram_data,
--        write_enable=>write_enable); 
        
        
           
--process(clk, reset)
--begin 
--    if (reset = '1') then
--        current_state <= filterstate;
--    elsif rising_edge(clk) then
--        current_state <= next_state;
--    end if;  
--end process;


--process(current_state,clk)
--begin 
--    if (rising_edge(clk)) then
--        case current_state is
--            when filterstate=> 
--                if (i<4096) then
--                    if (mode<9) then
--                        if (ps=0) then
--                            --tester<=1;
--                            filteraddress<=std_logic_vector(to_unsigned(mode,4));
--                            flag<='0';
--                        elsif (ps=3)   then
--                            if (mode=0) then
--                                if(i<64 or (i mod 64=0)) then
--                                    romaddress<=std_logic_vector(to_unsigned(i,12));
--                                    flag<='1';
--                                else
--                                    romaddress<=std_logic_vector(to_unsigned(i-65,12));
--                                end if;
--                            elsif (mode=1) then
--                                if (i<64) then
--                                    romaddress<=std_logic_vector(to_unsigned(i,12));
--                                    flag<='1';
--                                else
--                                    romaddress<=std_logic_vector(to_unsigned(i-64,12));
--                                end if;
--                            elsif (mode=2) then
--                                if (i<64 or (i mod 64=63)) then
--                                    romaddress<=std_logic_vector(to_unsigned(i,12));
--                                    flag<='1';
--                                else
--                                    romaddress<=std_logic_vector(to_unsigned(i-63,12));      
--                                end if;
--                            elsif (mode=3) then
--                                if( i mod 64=0) then
--                                    romaddress<=std_logic_vector(to_unsigned(i,12));
--                                    flag<='1';
--                                else
--                                    romaddress<=std_logic_vector(to_unsigned(i-1,12));
--                                end if;
--                            elsif (mode=4) then                                
--                                romaddress<=std_logic_vector(to_unsigned(i,12));                         
--                            elsif (mode=5) then
--                                if ( i mod 64=63) then
--                                    romaddress<=std_logic_vector(to_unsigned(i,12));
--                                    flag<='1';
--                                else
--                                    romaddress<=std_logic_vector(to_unsigned(i+1,12));      
--                                end if;    
--                            elsif (mode=6) then
--                                if(i>=4032 or (i mod 64=0)) then
--                                    romaddress<=std_logic_vector(to_unsigned(i,12));
--                                    flag<='1';
--                                else
--                                    romaddress<=std_logic_vector(to_unsigned(i+63,12));
--                                end if;
--                            elsif (mode=7) then
--                                if (i>=4032) then
--                                    romaddress<=std_logic_vector(to_unsigned(i,12));
--                                    flag<='1';
--                                else
--                                    romaddress<=std_logic_vector(to_unsigned(i+64,12));
--                                end if;
--                            elsif (mode=8) then
--                                if (i>=4032 or (i mod 64=63)) then
--                                    romaddress<=std_logic_vector(to_unsigned(i,12));
--                                    flag<='1';
--                                else
--                                    romaddress<=std_logic_vector(to_unsigned(i+65,12));      
--                                end if;    
--                            end if;
--                        elsif (ps=7) then
--                            reg2<=signed(filterdata);
--                            if (flag='1') then
--                                flag<='0';
--                                reg1<=(others=>'0');
--                            else
--                                reg1<=signed('0'&romdata); 
--                            end if;                            
--                            mac_control<=3;
--                            if (i=0 and mode=0) then
--                                mac_control<=0;
--                            end if;    
                            
                           
--                        elsif (ps=13) then
--                            mac_control<=1;
--                        elsif (ps=15) then
--                            mac_control<=6;    
--                        elsif (ps=16) then
--                            reg5<=reg4;
--                            mac_control<=3;
--                        end if;
--                        if (ps<18) then
--                            ps<=ps+1;
--                        else
--                            ps<=0;
--                            mode<=mode+1;
--                        end if;
--                    elsif (mode=9) then
--                        if (ps=0) then
--                            mac_control<=2;
--                        elsif (ps=2) then
--                            tester<=reg3;
                            
--                        elsif (ps=5) then   
--                            if (minimum>tester) then
--                                minimum<=tester;
--                            end if; 
--                            if (maximum<tester) then
--                                maximum<=tester;
--                            end if;
--                        elsif (ps=8) then    
--                            mac_control<=0;
--                        end if;
--                        if (ps<11) then
--                            ps<=ps+1;
--                        else
--                            ps<=0;
--                            mode<=0;
--                            if (i<4096) then
--                                i<=i+1;
--                                --mac_control<=0;
--                            else
--                                i<=0;                                
--                            end if;
--                        end if;                        
--                    end if;         
--                elsif(i>=4096) then
--                    next_state<=minstate;
--                    write_enable<='1';
--                    i<=0;
--                    --ps<=0;
--                    --mode<=0;
--                end if;
--            when minstate=> 
--                if (i<4096) then
--                    if (mode<9) then
--                        if (ps=0) then
--                            filteraddress<=std_logic_vector(to_unsigned(mode,4));
--                        elsif (ps=3) then
--                            if (mode=0) then
--                                if(i<64 or i mod 64=0) then
--                                    romaddress<=std_logic_vector(to_unsigned(i,12));
--                                    flag<='1';
--                                else
--                                    romaddress<=std_logic_vector(to_unsigned(i-65,12));
--                                end if;
--                            elsif (mode=1) then
--                                if (i<64) then
--                                    romaddress<=std_logic_vector(to_unsigned(i,12));
--                                    flag<='1';
--                                else
--                                    romaddress<=std_logic_vector(to_unsigned(i-64,12));
--                                end if;
--                            elsif (mode=2) then
--                                if (i<64 or i mod 64=63) then
--                                    romaddress<=std_logic_vector(to_unsigned(i,12));
--                                    flag<='1';
--                                else
--                                    romaddress<=std_logic_vector(to_unsigned(i-63,12));      
--                                end if;
--                            elsif (mode=3) then
--                                if( i mod 64=0) then
--                                    romaddress<=std_logic_vector(to_unsigned(i,12));
--                                    flag<='1';
--                                else
--                                    romaddress<=std_logic_vector(to_unsigned(i-1,12));
--                                end if;
--                            elsif (mode=4) then                                
--                                romaddress<=std_logic_vector(to_unsigned(i,12));                         
--                            elsif (mode=5) then
--                                if ( i mod 64=63) then
--                                    romaddress<=std_logic_vector(to_unsigned(i,12));
--                                    flag<='1';
--                                else
--                                    romaddress<=std_logic_vector(to_unsigned(i+1,12));      
--                                end if;    
--                            elsif (mode=6) then
--                                if(i>=4032 or i mod 64=0) then
--                                    romaddress<=std_logic_vector(to_unsigned(i,12));
--                                    flag<='1';
--                                else
--                                    romaddress<=std_logic_vector(to_unsigned(i+63,12));
--                                end if;
--                            elsif (mode=7) then
--                                if (i>=4032) then
--                                    romaddress<=std_logic_vector(to_unsigned(i,12));
--                                    flag<='1';
--                                else
--                                    romaddress<=std_logic_vector(to_unsigned(i+64,12));
--                                end if;
--                            elsif (mode=8) then
--                                if (i>=4032 or i mod 64=63) then
--                                    romaddress<=std_logic_vector(to_unsigned(i,12));
--                                    flag<='1';
--                                else
--                                    romaddress<=std_logic_vector(to_unsigned(i+65,12));      
--                                end if;    
--                            end if;
--                        elsif (ps=7) then
--                            reg2<=signed(filterdata);
--                            if (flag='1') then
--                                flag<='0';
--                                reg1<=(others=>'0');
--                            else
--                                reg1<=signed('0' & romdata) ; 
--                            end if;                            
--                            mac_control<=4;
--                        elsif (ps=14) then
--                            mac_control<=1;
--                        elsif (ps=15) then
--                            mac_control<=3;
--                        end if;
--                        if (ps<20) then
--                            ps<=ps+1;
--                        else
--                            ps<=0;
--                            mode<=mode+1;
--                        end if;
--                    elsif (mode=9) then
--                        if (ps=0) then
--                            mac_control<=2;
--                        elsif (ps=2) then
--                            ram_address<=std_logic_vector(to_unsigned(i,12));
--                        elsif (ps=14) then 
--                            write_enable<='1';   
--                            inte<=reg3;
--                        elsif (ps=35) then
--                            mac_control<=0;
--                            inte<=inte-minimum;
--                        elsif (ps=75) then
--                            inte<=inte*255;
--                        elsif (ps=105) then
--                            inte<=inte/(maximum-minimum);
--                        elsif (ps=170) then
--                            data_in_ram<=std_logic_vector(to_unsigned(inte,8));
--                        end if;
--                        if (ps<192) then
--                            ps<=ps+1;
--                        else
--                            ps<=0;
--                            mode<=0;
--                            i<=i+1;
--                            if (i>4095) then
--                                write_enable<='0';
--                            end if;    
--                        end if;
--                    end if;         
--                elsif(i>=4096) then
                
--                    write_enable<='0';
--                    ram_address<=rdaddress;
--                    romaddress<=rdaddress; 
--                    i<=i+1;
--                    ps<=0;
--                    mode<=0;
--                end if;
--            end case;  
--    end if;          
--end process;

--sendColor: process (ram_data,video_onn)
--    begin    
--    if (i>4095) then
--    if (video_onn='1') then
--    color_vector <= ram_data(7 DOWNTO 4) & ram_data(7 DOWNTO 4) & ram_data(7 DOWNTO 4);       
--    else
--    color_vector<="001000100000";
--    end if;
--    end if;
--    end process;


--rgb <= color_vector when video_onn = '1' else "001000100000";

--end Behavioral;


----------------------------------------------------------------------------------
-- Company: ME
-- Engineer: ME
-- 
-- Create Date: 11/10/2023 12:00:55 AM
-- Design Name: 
-- Module Name: hw3_final - Behavioral
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;



entity fsm is
--  Port (
--    clk: in std_logic;
--    reset: in std_logic;
--    Hsync: out std_logic;
--    Vsync : out std_logic;
--    rgb: out std_logic_vector(11 downto 0)
--   );
end fsm;

architecture Behavioral of fsm is
type t_State is (filterstate,minstate);
signal current_state: t_State:=filterstate;
signal next_state: t_State;
signal ps: integer:=0;
signal i: integer:=0;
signal mode:integer:=0;

signal reg2: signed(7 downto 0);
signal reg1: signed (8 downto 0);
signal reg3:signed(16 downto 0);
signal mac_control: integer;
--signal input1:  signed (8 downto 0);
--signal input2: signed (8 downto 0);

signal filterdata: std_logic_vector(7 downto 0);
signal filteraddress: std_logic_vector(3 downto 0);
signal romdata: std_logic_vector(7 downto 0);
signal romaddress: std_logic_vector(11 downto 0);
signal flag:std_logic;

signal ram_address:std_logic_vector(11 downto 0);
signal ram_data: std_logic_vector(7 downto 0);
signal data_in_ram: std_logic_vector(7 downto 0);
signal write_enable: std_logic;

signal maximum:integer:=-10000;
signal minimum:integer:=10000;
signal inter:integer;


signal color_vector:std_logic_vector(11 downto 0);
signal video_onn:std_logic;
signal rdaddress: std_logic_vector(11 downto 0);

signal tester: integer:=0;
--------
signal clk: std_logic;
signal reset:  std_logic:='0';
signal Hsync:  std_logic;
signal Vsync:std_logic;
signal rgb:  std_logic_vector(11 downto 0);
--------

component memory_module is 
    port(
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
end component;

component MAC is
    PORT(
    control : in integer;
    --kernel
    input1: in signed(8 downto 0);
    --filter
    input2: in signed(7 downto 0);
    clk: in std_logic;
    reset: in std_logic;
    outputi: out signed(16 downto 0)
    );
end component;  

COMPONENT Base is
    PORT(
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        hsync : out STD_LOGIC;
        vsync : out STD_LOGIC;
        video_on : out STD_LOGIC;
        p_tick : out STD_LOGIC;
        x : out STD_LOGIC_VECTOR(5 downto 0);
        rad: out STD_LOGIC_VECTOR(11 downto 0);
        y : out STD_LOGIC_VECTOR(5 downto 0)
    );
END COMPONENT;

BEGIN

----------------------------------
process
begin
    clk<='0';
    wait for 5ns;
    clk<='1';
    wait for 5ns;
end process;
-----------------------------------
vga_CON: Base
    PORT MAP(
        clk=>clk,
        reset=>reset,
        hsync=>Hsync,
        vsync=>Vsync,
        video_on=>video_onn,
        rad=>rdaddress,
        x=>open,
        y=>open,
        p_tick=>open
    );
mac_con: MAC    
PORT MAP(
    control=>mac_control,
    input1=>reg1,
    input2=>reg2,
    clk=>clk,
    reset=>reset,
    outputi=>reg3
    );
memory_con: memory_module
    PORT MAP(
        CLK=>CLK,
        rom_add=>romaddress,
        rom_data=> romdata,
        filter_add=> filteraddress,
        filter_data=> filterdata,
        ram_add=> ram_address,
        ram_data_in=> data_in_ram,
        ram_data_out=>ram_data,
        write_enable=>write_enable); 
        
        
           
process(clk, reset)
begin 
    if (reset = '1') then
        current_state <= filterstate;
    elsif rising_edge(clk) then
        current_state <= next_state;
    end if;  
end process;


process(current_state,clk)
begin 
    if (rising_edge(clk)) then
        case current_state is
            when filterstate=> 
                if (i<4096) then
                    if (mode<9) then
                        if (ps=0) then
                            tester<=1;
                            filteraddress<=std_logic_vector(to_unsigned(mode,4));
                        elsif (ps=3)   then
                            if (mode=0) then
                                if(i<64 or i mod 64=0) then
                                    romaddress<=std_logic_vector(to_unsigned(i,12));
                                    flag<='1';
                                else
                                    romaddress<=std_logic_vector(to_unsigned(i-65,12));
                                end if;
                            elsif (mode=1) then
                                if (i<64) then
                                    romaddress<=std_logic_vector(to_unsigned(i,12));
                                    flag<='1';
                                else
                                    romaddress<=std_logic_vector(to_unsigned(i-64,12));
                                end if;
                            elsif (mode=2) then
                                if (i<64 or i mod 64=63) then
                                    romaddress<=std_logic_vector(to_unsigned(i,12));
                                    flag<='1';
                                else
                                    romaddress<=std_logic_vector(to_unsigned(i-63,12));      
                                end if;
                            elsif (mode=3) then
                                if( i mod 64=0) then
                                    romaddress<=std_logic_vector(to_unsigned(i,12));
                                    flag<='1';
                                else
                                    romaddress<=std_logic_vector(to_unsigned(i-1,12));
                                end if;
                            elsif (mode=4) then                                
                                romaddress<=std_logic_vector(to_unsigned(i,12));                         
                            elsif (mode=5) then
                                if ( i mod 64=63) then
                                    romaddress<=std_logic_vector(to_unsigned(i,12));
                                    flag<='1';
                                else
                                    romaddress<=std_logic_vector(to_unsigned(i+1,12));      
                                end if;    
                            elsif (mode=6) then
                                if(i>=4032 or i mod 64=0) then
                                    romaddress<=std_logic_vector(to_unsigned(i,12));
                                    flag<='1';
                                else
                                    romaddress<=std_logic_vector(to_unsigned(i+63,12));
                                end if;
                            elsif (mode=7) then
                                if (i>=4032) then
                                    romaddress<=std_logic_vector(to_unsigned(i,12));
                                    flag<='1';
                                else
                                    romaddress<=std_logic_vector(to_unsigned(i+64,12));
                                end if;
                            elsif (mode=8) then
                                if (i>=4032 or i mod 64=63) then
                                    romaddress<=std_logic_vector(to_unsigned(i,12));
                                    flag<='1';
                                else
                                    romaddress<=std_logic_vector(to_unsigned(i+65,12));      
                                end if;    
                            end if;
                        elsif (ps=7) then
                            reg2<=signed(filterdata);
                            if (flag='1') then
                                flag<='0';
                                reg1<=(others=>'0');
                            else
                                reg1<='0'&signed(romdata); 
                            end if;
                            if (i=0 and mode=0) then
                                mac_control<=0;
                            else
                                mac_control<=4;    
                            end if;                                
                            --mac_control<=4;
                        elsif (ps=13) then
                            mac_control<=1;
                        elsif (ps=14) then
                            mac_control<=3;
                        end if;
                        if (ps<18) then
                            ps<=ps+1;
                        else
                            ps<=0;
                            mode<=mode+1;
                        end if;
                    elsif (mode=9) then
                        if (ps=0) then
                            mac_control<=2;
                        elsif (ps=2) then
                            if (minimum>to_integer(signed(reg3))) then
                                minimum<=to_integer(signed(reg3));
                            end if;
                        elsif (ps=5) then    
                            if (maximum<to_integer(signed(reg3))) then
                                maximum<=to_integer(signed(reg3));
                            end if;
                        elsif (ps=8) then    
                            mac_control<=0;
                        end if;
                        if (ps<11) then
                            ps<=ps+1;
                        else
                            ps<=0;
                            mode<=0;
                            if (i<4096) then
                                i<=i+1;
                                mac_control<=0;
                            else
                                i<=0;                                
                            end if;
                        end if;                        
                    end if;         
                elsif(i>=4096) then
                    next_state<=minstate;
                    write_enable<='1';
                    i<=0;
                    --ps<=0;
                    --mode<=0;
                end if;
            when minstate=> 
                if (i<4096) then
                    if (mode<9) then
                        if (ps=0) then
                            filteraddress<=std_logic_vector(to_unsigned(mode,4));
                        elsif (ps=3) then
                            if (mode=0) then
                                if(i<64 or i mod 64=0) then
                                    romaddress<=std_logic_vector(to_unsigned(i,12));
                                    flag<='1';
                                else
                                    romaddress<=std_logic_vector(to_unsigned(i-65,12));
                                end if;
                            elsif (mode=1) then
                                if (i<64) then
                                    romaddress<=std_logic_vector(to_unsigned(i,12));
                                    flag<='1';
                                else
                                    romaddress<=std_logic_vector(to_unsigned(i-64,12));
                                end if;
                            elsif (mode=2) then
                                if (i<64 or i mod 64=63) then
                                    romaddress<=std_logic_vector(to_unsigned(i,12));
                                    flag<='1';
                                else
                                    romaddress<=std_logic_vector(to_unsigned(i-63,12));      
                                end if;
                            elsif (mode=3) then
                                if( i mod 64=0) then
                                    romaddress<=std_logic_vector(to_unsigned(i,12));
                                    flag<='1';
                                else
                                    romaddress<=std_logic_vector(to_unsigned(i-1,12));
                                end if;
                            elsif (mode=4) then                                
                                romaddress<=std_logic_vector(to_unsigned(i,12));                         
                            elsif (mode=5) then
                                if ( i mod 64=63) then
                                    romaddress<=std_logic_vector(to_unsigned(i,12));
                                    flag<='1';
                                else
                                    romaddress<=std_logic_vector(to_unsigned(i+1,12));      
                                end if;    
                            elsif (mode=6) then
                                if(i>=4032 or i mod 64=0) then
                                    romaddress<=std_logic_vector(to_unsigned(i,12));
                                    flag<='1';
                                else
                                    romaddress<=std_logic_vector(to_unsigned(i+63,12));
                                end if;
                            elsif (mode=7) then
                                if (i>=4032) then
                                    romaddress<=std_logic_vector(to_unsigned(i,12));
                                    flag<='1';
                                else
                                    romaddress<=std_logic_vector(to_unsigned(i+64,12));
                                end if;
                            elsif (mode=8) then
                                if (i>=4032 or i mod 64=63) then
                                    romaddress<=std_logic_vector(to_unsigned(i,12));
                                    flag<='1';
                                else
                                    romaddress<=std_logic_vector(to_unsigned(i+65,12));      
                                end if;    
                            end if;
                        elsif (ps=7) then
                            reg2<=signed(filterdata);
                            if (flag='1') then
                                flag<='0';
                                reg1<=(others=>'0');
                            else
                                reg1<='0' &signed(romdata) ; 
                            end if;       
                            if (i=0 and mode=0) then
                                mac_control<=0;
                            else
                                mac_control<=4;    
                            end if;                     
                           -- mac_control<=4;
                        elsif (ps=14) then
                            mac_control<=1;
                        elsif (ps=15) then
                            mac_control<=3;
                        end if;
                        if (ps<20) then
                            ps<=ps+1;
                        else
                            ps<=0;
                            mode<=mode+1;
                        end if;
                    elsif (mode=9) then
                        if (ps=0) then
                            mac_control<=2;
                        elsif (ps=2) then
                            ram_address<=std_logic_vector(to_unsigned(i,12));
                        elsif (ps=14) then 
                            write_enable<='1';   
                            inter<=to_integer(reg3);
                        elsif (ps=35) then
                            mac_control<=0;
                            inter<=inter-minimum;
                        elsif (ps=75) then
                            inter<=inter*255;
                        elsif (ps=105) then
                            inter<=inter/(maximum-minimum);
                        elsif (ps=170) then
                            data_in_ram<=std_logic_vector(to_unsigned(inter,8));
                        end if;

                        if (ps<192) then
                            ps<=ps+1;
                        else
                            ps<=0;
                            mode<=0;
                            i<=i+1;
                            if (i>4095) then
                                write_enable<='0';
                            end if;    
                        end if;
                    end if;         
                elsif(i>=4096) then
                
                    write_enable<='0';
                    ram_address<=rdaddress;
                    --romaddress<=rdaddress; 
		    if (i>8000) then
			i<=8000;
		    else
			i<=i+1;
		    end if;	
                   -- i<=i+1;
                    ps<=0;
                    mode<=0;
                end if;
            end case;  
    end if;          
end process;

TransferToRegister: process (ram_data)
    begin
        color_vector <= ram_data(7 DOWNTO 4) & ram_data(7 DOWNTO 4) & ram_data(7 DOWNTO 4);        
    end process;
--TO display ROM    
--    TransferToRegister: process (rom_data)
--    begin
--        color_vector <= rom_data(7 DOWNTO 4) & rom_data(7 DOWNTO 4) & rom_data(7 DOWNTO 4);        
--    end process;    

    FinalOutput: process(video_onn,clk)
    begin
        if video_onn = '1' then
            rgb <= color_vector;
--Adding colors            
--"10111101" & rgb_reg(3 downto 0) ;
        else
            rgb <= "000000000000";
        end if;
    end process;




end Behavioral;


















