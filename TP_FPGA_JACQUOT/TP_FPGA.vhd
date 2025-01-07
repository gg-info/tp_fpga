library ieee;
use ieee.std_logic_1164.all;

entity TP_FPGA is
	port (
		sw : in std_logic_vector(3 downto 0);
		led : out std_logic_vector(3 downto 0)
);
end entity TP_FPGA;

architecture rtl of TP_FPGA is
begin
	led <= sw;
end architecture rtl;