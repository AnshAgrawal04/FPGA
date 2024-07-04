library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Base is
    Port (
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
end entity Base;

architecture checker of Base is

    constant H_DISPLAY : integer := 640;
    constant H_L_BORDER : integer := 48;
    constant H_R_BORDER : integer := 16;
    constant H_RETRACE : integer := 96;
    constant H_MAX : integer := 799;--H_DISPLAY + H_L_BORDER + H_R_BORDER + H_RETRACE - 1;
    constant START_H_RETRACE : integer :=656;-- H_DISPLAY + H_R_BORDER;
    constant END_H_RETRACE : integer :=751;-- H_DISPLAY + H_R_BORDER + H_RETRACE - 1;

    constant V_DISPLAY : integer := 480;
    constant V_T_BORDER : integer := 10;
    constant V_B_BORDER : integer := 33;
    constant V_RETRACE : integer := 2;
    constant V_MAX : integer := V_DISPLAY + V_T_BORDER + V_B_BORDER + V_RETRACE - 1;
    constant START_V_RETRACE : integer := V_DISPLAY + V_B_BORDER;
    constant END_V_RETRACE : integer := V_DISPLAY + V_B_BORDER + V_RETRACE - 1;

    constant START_H : integer := 100;
    constant START_V : integer := 100;    
    constant WIDTH : integer := 64;
    constant HEIGHT : integer :=64;
        
    signal pixel_reg : STD_LOGIC_VECTOR(1 downto 0);
    signal pixel_next : STD_LOGIC_VECTOR(1 downto 0);
    signal pixel_tick : STD_LOGIC;
    

    signal h_count_reg : STD_LOGIC_VECTOR(9 downto 0);
    signal h_count_next : STD_LOGIC_VECTOR(9 downto 0);
    signal v_count_reg : STD_LOGIC_VECTOR(9 downto 0);
    signal v_count_next : STD_LOGIC_VECTOR(9 downto 0);
    signal thisthat: integer:=1;
    signal vsync_reg : STD_LOGIC;
    signal hsync_reg : STD_LOGIC;
    signal vsync_next : STD_LOGIC;
    signal hsync_next : STD_LOGIC;  
   
    signal p_tick_maker:std_logic_vector(3 downto 0);


begin


pixel_reg_process: process(clk, reset)
    begin
        if reset = '1' then
            p_tick_maker <= "0000";
        elsif rising_edge(clk) then
            if (thisthat=1) then
                p_tick_maker<="0000";
                thisthat<=thisthat+1; 
            elsif (thisthat=2) then
                p_tick_maker<="0000";
                thisthat<=thisthat+1;
            elsif (thisthat=3) then
                p_tick_maker<="0000";
                thisthat<=thisthat+1; 
            elsif (thisthat=4) then
                p_tick_maker<="1111";
                thisthat<=1;       
            end if;
            pixel_reg <= pixel_next;
        end if;
    end process pixel_reg_process;
   pixel_tick<='1' when p_tick_maker="1111" else '0';


     
    RegisterState: process(clk, reset)
    begin
        if reset = '1' then
            v_count_reg <= (others => '0');
            h_count_reg <= (others => '0');
            vsync_reg <= '0';
            hsync_reg <= '0';
        elsif rising_edge(clk) then
            if pixel_tick = '1' then
                if h_count_reg = H_MAX then
                    h_count_reg <= (others => '0');
                    if v_count_reg = V_MAX then
                        v_count_reg <= (others => '0');
                    else
                        v_count_reg <= v_count_reg + 1;
                        --report "this is running";
                    end if;
                else
                    h_count_reg <= h_count_reg + 1;
                end if;
            end if;
            if v_count_reg >= START_V_RETRACE and v_count_reg <= END_V_RETRACE then
                vsync_reg <= '1';
            else
                vsync_reg <= '0';
            end if;
                if h_count_reg >= START_H_RETRACE and h_count_reg <= END_H_RETRACE then
                hsync_reg <= '1';
            else
                hsync_reg <= '0';
            end if;
        end if;
    end process;
     ------------
     Vid:process(h_count_reg,v_count_reg) 
     begin  
        if   100<=h_count_reg and h_count_reg<= 100 + WIDTH - 1  and 100<=v_count_reg and v_count_reg <= 100 + HEIGHT - 1 then
            video_on <= '1';
        else
            video_on <= '0';
        end if;
    end process;
    hsync <=  hsync_reg;
    vsync <= vsync_reg;
    x <= h_count_reg(5 downto 0)-START_H;
    y <= v_count_reg(5 downto 0) -START_V;
    rad<= (v_count_reg(5 downto 0)-START_V)&(h_count_reg(5 downto 0)-START_H);
    p_tick <= pixel_tick;

end architecture checker;



