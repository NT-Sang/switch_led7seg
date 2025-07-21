library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity add is
    Port (
        sw : in STD_LOGIC_VECTOR (7 downto 0);
        seg0 : out STD_LOGIC_VECTOR (6 downto 0);  
        seg1 : out STD_LOGIC_VECTOR (6 downto 0)   
    );
end add;

architecture Behavioral of add is
    signal A, B : unsigned(3 downto 0);
    signal Sum : unsigned(4 downto 0);  
    signal tens1, units1 : unsigned(3 downto 0);
begin
   
    A <= unsigned(sw(3 downto 0));
    B <= unsigned(sw(7 downto 4));
    Sum <= resize(A, 5) + resize(B, 5);

  
    process (Sum)
        variable temp : integer;
    begin
        temp := to_integer(Sum);
        tens1  <= to_unsigned(temp / 10, 4);
        units1 <= to_unsigned(temp mod 10, 4);
    end process;

    
    process (units1)
    begin
        case units1 is
                                  --abcdefg
            when "0000" => seg0 <= "1111110";  -- 0
            when "0001" => seg0 <= "0110000";  -- 1
            when "0010" => seg0 <= "1101101";  -- 2
            when "0011" => seg0 <= "1111001";  -- 3
            when "0100" => seg0 <= "0110011";  -- 4
            when "0101" => seg0 <= "1011011";  -- 5
            when "0110" => seg0 <= "1011111";  -- 6
            when "0111" => seg0 <= "1110000";  -- 7
            when "1000" => seg0 <= "1111111";  -- 8
            when "1001" => seg0 <= "1111011";  -- 9
            when others => seg0 <= "0000000";  
        end case;
    end process;

    process (tens1)
    begin
        case tens1 is
            when "0000" => seg1 <= "1111110";  -- 0
            when "0001" => seg1 <= "0110000";  -- 1
            when "0010" => seg1 <= "1101101";  -- 2
            when "0011" => seg1 <= "1111001";  -- 3
            when others => seg1 <= "0000000"; 
        end case;
    end process;

end Behavioral;
