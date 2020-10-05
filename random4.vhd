--random no generator
--with binary output and number showing random no in binary format on LEDS
--by Ninad Waingankar


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity random4 is
generic ( width : integer := 4 );
port (
		push : in std_logic;	--push button to generate random no
		clk:in std_logic;		--12Mhz clock 
		random_num : out std_logic_vector (width-1 downto 0) --output binary led
		);
end random4;

architecture Behavioral of random4 is
	signal divider:std_logic_vector(23 downto 0);	--clock divider signal
begin
	process(clk) 
	begin
		if(rising_edge(clk)) then
			divider<=divider+'1';
		end if;
	end process;

	process(divider(23),push)
		variable rand_temp : std_logic_vector(width-1 downto 0):=(width-1 => '1',others => '0');
		variable temp : std_logic := '0';
	begin
	if(push='1') then
		if(rising_edge(divider(21))) then
		--for random no generation
			temp := rand_temp(width-1) xor rand_temp(width-2);
			rand_temp(width-1 downto 1) := rand_temp(width-2 downto 0);
			rand_temp(0) := temp;
		end if;
	end if;
	
--developed by Ninad Waingankar	
		random_num <= rand_temp;
	end process;
end Behavioral;
