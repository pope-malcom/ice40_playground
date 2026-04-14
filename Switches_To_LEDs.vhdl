library ieee;
use ieee.std_logic_1164.all;

entity Switches_To_LEDs is
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
end entity Switches_To_LEDs;
architecture RTL of Switches_To_LEDs is
begin
  o_LED_3 <= i_Rst;
  o_LED_4 <= not i_RST;
end RTL;
