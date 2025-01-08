library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------
-- Testbench pour hdmi_generator
-------------------------------------------------------------------------------
entity hdmi_generator_tb is
end entity hdmi_generator_tb;

architecture tb of hdmi_generator_tb is

  -----------------------------------------------------------------------------
  -- 1) Signaux internes (entrées/sorties de l'UUT, y compris l'horloge)
  -----------------------------------------------------------------------------
  signal i_clk          : std_logic := '0';   -- Horloge
  signal i_reset_n      : std_logic := '0';   -- Reset actif bas

  signal o_hdmi_hs      : std_logic;  -- Synchro horizontale
  signal o_hdmi_vs      : std_logic;  -- Synchro verticale
  signal o_hdmi_de      : std_logic;  -- Data Enable
  signal o_pixel_en     : std_logic;  -- Pixel enable
  signal o_pixel_address: natural;    -- Adresse du pixel
  signal o_x_counter    : natural;    -- Compteur horizontal
  signal o_y_counter    : natural;    -- Compteur vertical
  signal o_new_frame    : std_logic;  -- Indique une nouvelle image

begin

  -----------------------------------------------------------------------------
  -- 2) Instanciation du composant hdmi_generator
  -----------------------------------------------------------------------------
  DUT: entity work.hdmi_generator
    generic map(
      -- Timings et résolutions réduits pour accélérer la simulation
      h_res  => 16,  -- Résolution horizontale réduite
      v_res  => 12,  -- Résolution verticale réduite
      h_sync => 2,   -- Synchro horizontale courte
      h_fp   => 2,   -- Front porch horizontal
      h_bp   => 2,   -- Back porch horizontal
      v_sync => 1,   -- Synchro verticale courte
      v_fp   => 1,   -- Front porch vertical
      v_bp   => 1    -- Back porch vertical
    )
    port map(
      i_clk           => i_clk,           -- Horloge
      i_reset_n       => i_reset_n,       -- Reset
      o_hdmi_hs       => o_hdmi_hs,       -- Sortie : synchro horizontale
      o_hdmi_vs       => o_hdmi_vs,       -- Sortie : synchro verticale
      o_hdmi_de       => o_hdmi_de,       -- Sortie : Data Enable
      o_pixel_en      => o_pixel_en,      -- Sortie : pixel enable
      o_pixel_address => o_pixel_address, -- Adresse des pixels
      o_x_counter     => o_x_counter,     -- Compteur horizontal
      o_y_counter     => o_y_counter,     -- Compteur vertical
      o_new_frame     => o_new_frame      -- Indique une nouvelle image
    );

  -----------------------------------------------------------------------------
  -- 3) Génération de l’horloge (période de 20 ns = 50 MHz)
  -----------------------------------------------------------------------------
  clk_process: process
  begin
    while true loop
      i_clk <= '0';
      wait for 10 ns;  -- Demi-période de 10 ns
      i_clk <= '1';
      wait for 10 ns;  -- Demi-période de 10 ns
    end loop;
  end process clk_process;

  -----------------------------------------------------------------------------
  -- 4) Processus de reset
  -----------------------------------------------------------------------------
  reset_process: process
  begin
    -- Maintien du reset à 0 pendant 100 ns
    i_reset_n <= '0';
    wait for 100 ns;

    -- Relâchement du reset
    i_reset_n <= '1';

    -- Simulation active pendant 1 ms
    wait for 1 ms;

    -- Fin de la simulation
    wait;
  end process reset_process;

end architecture tb;
