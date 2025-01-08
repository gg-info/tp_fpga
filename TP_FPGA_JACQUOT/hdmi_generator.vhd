library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hdmi_generator is
    generic (
        -- Résolution
        h_res : natural := 720;
        v_res : natural := 480;

        -- Timings "magic values" (480p)
        h_sync : natural := 61;
        h_fp   : natural := 58;
        h_bp   : natural := 18;

        v_sync : natural := 5;
        v_fp   : natural := 30;
        v_bp   : natural := 9
    );
    port (
        i_clk         : in  std_logic;
        i_reset_n     : in  std_logic;
        o_hdmi_hs     : out std_logic;
        o_hdmi_vs     : out std_logic;
        o_hdmi_de     : out std_logic;

        o_pixel_en    : out std_logic;
        o_pixel_address : out natural range 0 to (h_res * v_res - 1);
        o_x_counter   : out natural range 0 to (h_res - 1);
        o_y_counter   : out natural range 0 to (v_res - 1);
        o_new_frame   : out std_logic
    );
end hdmi_generator;

architecture rtl of hdmi_generator is

  ---------------------------------------------------------------------------
  -- 1) Calcul du total horizontal
  ---------------------------------------------------------------------------
  constant h_total : natural := h_res + h_fp + h_sync + h_bp;

  ---------------------------------------------------------------------------
  -- 2) Compteur horizontal (0 à h_total - 1)
  ---------------------------------------------------------------------------
  signal r_h_count : natural range 0 to h_total - 1 := 0;

begin

  ---------------------------------------------------------------------------
  -- 3) Processus qui incrémente r_h_count
  ---------------------------------------------------------------------------
  process(i_clk, i_reset_n)
  begin
    if i_reset_n = '0' then
      r_h_count <= 0;
    elsif rising_edge(i_clk) then
      if r_h_count = h_total - 1 then
        r_h_count <= 0;
      else
        r_h_count <= r_h_count + 1;
      end if;
    end if;
  end process;

  ---------------------------------------------------------------------------
  -- 4) Génération du signal de synchro horizontale (active bas)
  ---------------------------------------------------------------------------
  o_hdmi_hs <= '0' when (r_h_count < h_sync) else '1';

  ---------------------------------------------------------------------------
  -- 5) Pour le moment, on ne gère pas encore la partie verticale
  --    On met donc des valeurs "par défaut" ou inactives aux autres sorties
  ---------------------------------------------------------------------------
  o_hdmi_vs       <= '1';          -- Pas de synchro verticale implémentée
  o_hdmi_de       <= '0';          -- Data Enable inactif pour l’instant
  o_pixel_en      <= '0';
  o_pixel_address <= 0;
  o_x_counter     <= 0;
  o_y_counter     <= 0;
  o_new_frame     <= '0';

end architecture rtl;


