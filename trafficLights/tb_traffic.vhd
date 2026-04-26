library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tb_traffic is
end entity tb_traffic;


architecture A1 of tb_traffic is
        signal clk: std_logic := '0';
        signal rst: std_logic := '0';
        signal lightwire: std_logic_vector(2 downto 0);
        constant T: time := 10 ns;
        signal simDone: std_logic := '0';
begin
        dut: entity work.traffic
                port map(
                        clk=>clk,
                        rst=>rst,
                        light=>lightwire
                );

        clk_proc: process
        begin
                while simDone /= '1' loop
                        wait for T/2;
                        clk <= not clk;
                end loop;
                wait;
        end process clk_proc;

        stim_proc: process
        begin
                wait for T * 500;
                rst <= '1';
                wait for T * 200;
                rst <= '0';
                wait for T * 200;
                simDone <= '1';
                wait;
        end process stim_proc;
end architecture A1;
