library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;



entity module is 
--PORT()


end module;
--package mp is
--    type arr is array(0 to 8) of integer;
--    type small_arr is array(0 to 2) of integer;
--end mp;

----package mp_small is
   
----end mp_small;

--USE work.mp.all;
architecture edge of module is
    COMPONENT blk_mem_gen_2
        PORT (
            clka : IN STD_LOGIC;
            addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            wea : IN STD_LOGIC (0 downto 0);
            douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT blk_mem_gen_0
        PORT (
            clka : IN STD_LOGIC;
            ena : IN STD_LOGIC;
            addra : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT blk_mem_gen_1
        PORT (
            clka : IN STD_LOGIC;
            ena : IN STD_LOGIC;
            addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
    
    SIGNAL clk:std_logic:='0';
    --memory elemnts
    SIGNAL write_enable : STD_LOGIC := '1';
    SIGNAL data_to_write : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL rom_address : STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0');
    SIGNAL rom_data : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL ram_address : STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0');
    SIGNAL ram_data : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    --for loop
    SIGNAL convolution : INTEGER := 0; 
    SIGNAL i : INTEGER := 0;
    --for filter
    signal filteraddress: std_logic_vector(3 downto 0);
    signal filterdata: std_logic_vector(7 downto 0);
    signal startfilter: std_logic;
    --for loop
    signal mode:integer:=0;
    signal filtercycle: integer:=0;
    signal j:integer:=0;
    --for the signal
    signal filter_matrix:integer_vector(9 downto 0);
    signal prever:integer_vector(2 downto 0);
    signal currer:integer_vector(9 downto 0);
    signal nexer:integer_vector(9 downto 0);
    signal ps:integer:=0;
    signal int_min: integer :=10000;
    signal int_max: integer :=-10000;
    signal en : std_logic := '1';
    signal changer: integer:=0;
    signal clamp:std_logic:='0';
begin 
    clock_proc:process
    begin
        clk<= not clk after 5 ns;
    end process;
    ram : blk_mem_gen_2 PORT MAP(
            dina => data_to_write,
            wea => write_enable,
            clka => clk,
            douta => ram_data,
            addra => ram_address
            );

    rom : blk_mem_gen_0 PORT MAP(
            clka => clk,
            douta => rom_data,
            addra => rom_address,
            ena=>en
        );
    filterr: blk_mem_gen_1 PORT MAP(
            clka=>clk,
            douta=>filterdata,
            addra=>filteraddress,
            ena=>en
    ); 
    
    stim_proc: process(clk)
--variable r4: std_logic_vector(8 downto 0) :=(others=>'0');
   begin
    
if(rising_edge(clk)) then
    if (i<4096) then
        if (mode=0) then
            if (j<8) then 
                if (filtercycle=0) then
                    filteraddress<=std_logic_vector(to_unsigned(j,4));        
                elsif (filtercycle=3) then
                    filter_matrix(j)<=to_integer(signed(filterdata));
                end if;
                if (filtercycle=6) then 
                    filtercycle<=0;
                    j<=j+1;
                else
                    filtercycle<=filtercycle+1;
                end if;
            else
                mode<=1;
                --startfilter<='1';
            end if;
        elsif (mode=1) then
            if (i<64) then
                prever(0)<=0;
                prever(1)<=0;
                prever(2)<=0;
                mode<=2;
            elsif (i mod 64 =0) then
                if (ps=0) then
                    rom_address<=std_logic_vector(to_unsigned(i-64,12));
                elsif(ps=3) then
                    prever(0)<=0;
                elsif (ps=5) then
                    prever(1)<=to_integer(unsigned(rom_data));  
                elsif (ps=7) then
                    rom_address<=std_logic_vector(to_unsigned(i-63,12));
                elsif (ps=10) then
                    prever(2)<=to_integer(unsigned(rom_data));                           
                end if; 
                if (ps=12) then 
                    ps<=0;
                    mode<=2;
                else
                    ps<=ps+1;
                end if;    
            elsif (i mod 64=63) then
                if (ps=0) then
                    prever(0)<=prever(1);
                    prever(1)<=prever(2);
                    prever(2)<=0;
                end if;
                if (ps=4) then
                    ps<=0;
                    mode<=2;
                else
                    ps<=ps+1;    
                end if;
            else
                if (ps=0) then
                    rom_address<=std_logic_vector(to_unsigned(i-63,12));
                elsif (ps=2) then
                        prever(0)<=prever(1);
                        prever(1)<=prever(2);
                        --prever(2)<=0;
                elsif (ps=4) then
                        prever(2)<=to_integer(unsigned(rom_data));
                end if;
                if (ps=6) then
                    ps<=0;
                    mode<=2;
                elsif (ps<6) then
                    ps<=ps+1;    
                end if;   
            end if;
        elsif (mode=2) then
            if (i>4031) then
                nexer(0)<=0;
                nexer(1)<=0;
                nexer(2)<=0;
                mode<=3;
            elsif (i mod 64 =0) then
                if (ps=0) then
                    rom_address<=std_logic_vector(to_unsigned(i+64,12));
                elsif(ps=2) then
                    nexer(0)<=0;
                elsif (ps=4) then
                    nexer(1)<=to_integer(unsigned(rom_data));  
                elsif (ps=6) then
                    rom_address<=std_logic_vector(to_unsigned(i+65,12));
                elsif (ps=10) then
                    nexer(2)<=to_integer(unsigned(rom_data));                           
                end if; 
                if (ps=13) then 
                    ps<=0;
                    mode<=3;
                else
                    ps<=ps+1;
                end if;    
            elsif (i mod 64=63) then
                if (ps=0) then
                    nexer(0)<=nexer(1);
                    nexer(1)<=nexer(2);
                    nexer(2)<=0;
                end if;
                if (ps=4) then
                    ps<=0;
                    mode<=3;
                elsif(ps<4) then
                    ps<=ps+1;    
                end if;
            else
                if (ps=0) then
                    rom_address<=std_logic_vector(to_unsigned(i+65,12));
                elsif (ps=2) then
                        nexer(0)<=nexer(1);
                        nexer(1)<=nexer(2);
                        --prever(2)<=0;
                elsif (ps=4) then
                        nexer(2)<=to_integer(unsigned(rom_data));
                end if;
                if (ps=6) then
                    ps<=0;
                    mode<=3;
                elsif (ps<6) then
                    ps<=ps+1;    
                end if;   
            end if;
         elsif (mode=3) then
--            if (i>4031) then
--                nexer(0)<=0;
--                nexer(1)<=0;
--                nexer(2)<=0;
--                mode<=3;
            if (i mod 64 =0) then
                if (ps=0) then
                    rom_address<=std_logic_vector(to_unsigned(i,12));
                elsif(ps=2) then
                    currer(0)<=0;
                elsif (ps=5) then
                    currer(1)<=to_integer(unsigned(rom_data));  
                elsif (ps=7) then
                    rom_address<=std_logic_vector(to_unsigned(i+1,12));
                elsif (ps=10) then
                    currer(2)<=to_integer(unsigned(rom_data));                           
                end if; 
                if (ps=13) then 
                    ps<=0;
                    mode<=4;
                else
                    ps<=ps+1;
                end if;    
            elsif (i mod 64=63) then
                if (ps=0) then
                    currer(0)<=currer(1);
                    currer(1)<=currer(2);
                    currer(2)<=0;
                end if;
                if (ps=4) then
                    ps<=0;
                    mode<=4;
                elsif(ps<4) then
                    ps<=ps+1;    
                end if;
            else
                if (ps=0) then
                    rom_address<=std_logic_vector(to_unsigned(i+1,12));
                elsif (ps=2) then
                        currer(0)<=currer(1);
                        currer(1)<=currer(2);
                        --prever(2)<=0;
                elsif (ps=4) then
                        currer(2)<=to_integer(unsigned(rom_data));
                end if;
                if (ps=6) then
                    ps<=0;
                    mode<=4;
                elsif (ps<6) then
                    ps<=ps+1;    
                end if;   
            end if; 
        elsif (mode =4) then
            if (ps=0) then
            ---Implement MAC unit here????????
                convolution<=filter_matrix(0)*prever(0)+filter_matrix(1)*prever(1)+filter_matrix(2)*prever(2)+filter_matrix(3)*currer(0)+filter_matrix(4)*currer(1)+filter_matrix(5)*currer(2)+filter_matrix(6)*nexer(0)+filter_matrix(7)*nexer(1)+filter_matrix(8)*nexer(2);
            end if;
            if (ps=2) then
                ps<=0;
                if (i=4095) then
                    clamp<='1';
                    mode<=6;
                else
                    if (clamp='0' ) then 
                        mode<=5;
                    else    
                        mode<=5;
                    end if;    
                end if;  
            end if;     
        elsif (mode=5) then
            if (ps=0) then
                if (convolution>int_max) then
                    int_max<=convolution;
                end if;
                if (convolution<int_min) then
                    int_min<=convolution;
                end if;
            end if;
            if (ps=2) then
                ps<=0;
                mode<=1;
                i<=i+1;
            else
                ps<=ps+1; 
            end if;      
        elsif (mode=6) then
            if (ps=0) then
                convolution<=(convolution-int_min) *255/(int_max-int_min);   
            elsif (ps=2) then
                ram_address<=std_logic_vector(to_unsigned(i,12));
            elsif (ps=5) then
                data_to_write<=std_logic_vector(to_unsigned(convolution,8));
                
            end if;
            if (ps=10)then
                ps<=0;
                mode<=0;
                i<=i+1;
            else
                ps<=ps+1;
            end if;   

        end if;
    elsif (i>4095) then
        if (changer=0) then
            changer<=1;
            i<=0;
        else
            changer<=1;
            i<=4096;
        end if;        
            
    end if;
    
    end if;
    end process;

    
    
end architecture;
    


