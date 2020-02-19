----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.02.2020 18:25:49
-- Design Name: 
-- Module Name: TB_VGA_Controller - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library WORK;
use WORK.SYSTEM_PARAMETERS.ALL;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_VGA_Controller is
--  Port ( );
end TB_VGA_Controller;

architecture Behavioral of TB_VGA_Controller is

    component VGA_Controller is
        port (
            -- Inputs
            Clk          : in std_logic;
            i_Pixel_Data : in std_logic_vector(BPP-1 downto 0);
            -- Outputs
            o_Adr        : out std_logic_vector(FB_ADR_BUS_WIDTH-1 downto 0);
            o_HSync      : out std_logic;
            o_VSync      : out std_logic;
            o_Red        : out std_logic_vector(3 downto 0);
            o_Blue       : out std_logic_vector(3 downto 0);
            o_Green      : out std_logic_vector(3 downto 0)
        );
    end component;

    signal Clk_Period   : time := 10 ns;
    signal Clk          : std_logic := '0';
    signal Pixel_Data   : std_logic_vector(BPP-1 downto 0) := (others => '0');
    signal Adr          : std_logic_vector(FB_ADR_BUS_WIDTH-1 downto 0) := (others => '0');
    signal HSync        : std_logic := '0';
    signal VSync        : std_logic := '0';
    signal Red          : std_logic_vector(3 downto 0) := (others => '0');
    signal Green        : std_logic_vector(3 downto 0) := (others => '0');
    signal Blue         : std_logic_vector(3 downto 0) := (others => '0');
    
begin

    Clocking: process
    begin
        Clk <= NOT Clk;
        wait for Clk_Period /2;
    end process;
    
    UUT: VGA_Controller
        port map (
            Clk         => Clk,
            i_Pixel_Data=> Pixel_Data,
            o_Adr       => Adr,
            o_HSync     => HSync,
            o_VSync     => VSync,
            o_Red       => Red,
            o_Blue      => Blue,    
            o_Green     => Green
    );
    
    Data_Generator: process
    begin
        for i in 0 to 255 loop
            Pixel_Data <= std_logic_vector(to_unsigned(i,8));
            wait for Clk_Period;
        end loop;
    end process;
    
    end Behavioral;
