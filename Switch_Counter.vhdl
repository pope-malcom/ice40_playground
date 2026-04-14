library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Switch_Counter is
  port (
    i_RST       : in  std_logic;
    o_LED_0     : out std_logic;
    o_LED_1     : out std_logic;
    o_LED_2     : out std_logic;
    o_LED_3     : out std_logic;
    o_LED_4     : out std_logic;
    o_LED_5     : out std_logic;
    o_LED_6     : out std_logic;
    o_LED_7     : out std_logic);
end entity Switch_Counter;
architecture RTL of Switch_Counter is

  signal r_count : integer := 0;
  signal r_out   : std_logic_vector(7 downto 0);
begin
  process (i_RST) is
  begin
    if rising_edge(i_RST) then
      r_count <= r_count + 1;
      -- Assigns count+1 because count updates at the same time the conversion occurs. Can be fixed by clocking the signal
      r_out <= std_logic_vector(to_unsigned(r_count+1, r_out'length));
    end if;
  end process;

  o_LED_0 <= r_out(0);
  o_LED_1 <= r_out(1);
  o_LED_2 <= r_out(2);
  o_LED_3 <= r_out(3);
  o_LED_4 <= r_out(4);
  o_LED_5 <= r_out(5);
  o_LED_6 <= r_out(6);
  o_LED_7 <= r_out(7);

end RTL;

