library ieee;
use ieee.std_logic_1164.all;

entity chenillard is
	port(
		i_clk : in std_logic;
		o_led : out std_logic_vector(5 downto 0)
		);
end entity chenillard;

architecture rtl of chenillard is
	signal shift_reg : std_logic_vector (5 downto 0) := "000001";
begin
	process(i_clk)
	variable counter : natural range 0 to 5000000;
	begin
		if(rising_edge(i_clk)) then
			if (counter = 5000000) then
				counter := 0;
				shift_reg <= shift_reg(4 downto 0) & shift_reg(5);
			else
				counter := counter + 1;
			end if;
		end if;
	end process;
	
	o_led <= shift_reg;
end architecture rtl;
				