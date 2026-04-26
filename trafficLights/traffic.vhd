library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity traffic is
        port (
                clk: in std_logic;
                rst: in std_logic;

                light: out std_logic_vector(2 downto 0)
        );
end entity traffic;


architecture A1 of traffic is
        type traffic_state is (red, amber, green);
        signal current_state, last_state: traffic_state := red;

        signal counter: integer range 0 to 9 := 0;
        constant maxCount: integer := 9;
        signal change_pulse: std_logic := '0';
begin
        seq_state_proc: process(clk)
        begin
                if rising_edge(clk) then
                        if rst='1' then
                                current_state <= red;
                        else
                                if change_pulse='1' then
                                        case current_state is
                                                when red =>
                                                        current_state <= amber;
                                                        last_state <= red;
                                                when amber =>
                                                        if last_state=red then
                                                                current_state <= green;
                                                        else
                                                                current_state <= red;
                                                        end if;
                                                        last_state <= amber;
                                                when green =>
                                                        current_state <= amber;
                                                        last_state <= green;
                                                when others =>
                                                        NULL;
                                        end case;
                                end if;
                        end if;
                end if;
        end process;

        -- Can understand why we split comb and sequential now.
        -- When the light assignments were in the sequential process, there was a 1
        -- clock delay on assignment.
        comb_light_proc: process(current_state)
        begin
                case current_state is
                        when red =>
                                light <= "001";
                        when amber =>
                                light <= "010";
                        when green =>
                                light <= "100";
                        when others =>
                                NULL;
                end case;
        end process comb_light_proc;

        pulse_proc: process(clk)
        begin
                if rising_edge(clk) then
                        if rst='1' then
                                counter <= 1;
                                change_pulse <= '1';
                        else
                                if counter < maxCount then
                                        counter <= counter + 1;
                                        change_pulse <= '0';
                                else
                                        counter <= 0;
                                        change_pulse <= '1';
                                end if;
                        end if;
                end if;
        end process;
end architecture A1;
