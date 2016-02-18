library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity c64pla_tb is
end c64pla_tb;

architecture test of c64pla_tb is
    component c64pla is
        port (
            i0:         in std_logic;
            i1:         in std_logic;
            i2:         in std_logic;
            i3:         in std_logic;
            i4:         in std_logic;
            i5:         in std_logic;
            i6:         in std_logic;
            i7:         in std_logic;
            i8:         in std_logic;
            i9:         in std_logic;
            i10:        in std_logic;
            i11:        in std_logic;
            i12:        in std_logic;
            i13:        in std_logic;
            i14:        in std_logic;
            i15:        in std_logic;
            f0:         out std_logic;
            f1:         out std_logic;
            f2:         out std_logic;
            f3:         out std_logic;
            f4:         out std_logic;
            f5:         out std_logic;
            f6:         out std_logic;
            f7:         out std_logic
        );
    end component;
    signal n_cas               : std_logic;
    signal n_loram             : std_logic;
    signal n_hiram             : std_logic;
    signal n_charen            : std_logic;
    signal n_va14              : std_logic;
    signal a15                 : std_logic;
    signal a14                 : std_logic;
    signal a13                 : std_logic;
    signal a12                 : std_logic;
    signal ba                  : std_logic;
    signal n_aec               : std_logic;
    signal rd                  : std_logic;
    signal n_exrom             : std_logic;
    signal n_game              : std_logic;
    signal va13                : std_logic;
    signal va12                : std_logic;
    signal n_casram            : std_logic;
    signal n_basic             : std_logic;
    signal n_kernal            : std_logic;
    signal n_charrom           : std_logic;
    signal n_grw               : std_logic;
    signal n_io                : std_logic;
    signal n_roml              : std_logic;
    signal n_romh              : std_logic;
    signal n_casram_test       : std_logic;
    signal n_basic_test        : std_logic;
    signal n_kernal_test       : std_logic;
    signal n_charrom_test      : std_logic;
    signal n_grw_test          : std_logic;
    signal n_io_test           : std_logic;
    signal n_roml_test         : std_logic;
    signal n_romh_test         : std_logic;
begin
    uut: c64pla port map (
        i0      => n_cas,
        i1      => n_loram,
        i2      => n_hiram,
        i3      => n_charen,
        i4      => n_va14,
        i5      => a15,
        i6      => a14,
        i7      => a13,
        i8      => a12,
        i9      => ba,
        i10     => n_aec,
        i11     => rd,
        i12     => n_exrom,
        i13     => n_game,
        i14     => va13,
        i15     => va12,
        f0      => n_casram,
        f1      => n_basic,
        f2      => n_kernal,
        f3      => n_charrom,
        f4      => n_grw,
        f5      => n_io,
        f6      => n_roml,
        f7      => n_romh
    );

    do_test: process
        variable l:     line;
        variable b:     bit_vector(0 to 23);
        file f:         text is "c64pla_tb.txt";
    begin
    
    while not endfile(f) loop
        readline(f, l);
        read(l, b);
        n_cas     <= to_stdulogic(b(0));
        n_loram   <= to_stdulogic(b(1));
        n_hiram   <= to_stdulogic(b(2));
        n_charen  <= to_stdulogic(b(3));
        n_va14    <= to_stdulogic(b(4));
        a15       <= to_stdulogic(b(5));
        a14       <= to_stdulogic(b(6));
        a13       <= to_stdulogic(b(7));
        a12       <= to_stdulogic(b(8));
        ba        <= to_stdulogic(b(9));
        n_aec     <= to_stdulogic(b(10));
        rd        <= to_stdulogic(b(11));
        n_exrom   <= to_stdulogic(b(12));
        n_game    <= to_stdulogic(b(13));
        va13      <= to_stdulogic(b(14));
        va12      <= to_stdulogic(b(15));
        n_casram_test <= to_stdulogic(b(16));
        n_basic_test  <= to_stdulogic(b(17));
        n_kernal_test <= to_stdulogic(b(18));
        n_charrom_test <= to_stdulogic(b(19));
        n_grw_test    <= to_stdulogic(b(20));
        n_io_test     <= to_stdulogic(b(21));
        n_roml_test   <= to_stdulogic(b(22));
        n_romh_test   <= to_stdulogic(b(23));
      
        wait for 100 ns;
        assert n_casram = n_casram_test   report "Test failed: n_casram wrong" severity error;
        assert n_basic = n_basic_test     report "Test failed: n_basic wrong" severity error;
        assert n_kernal = n_kernal_test   report "Test failed: n_kernal wrong" severity error;
        assert n_charrom = n_charrom_test report "Test failed: n_charrom wrong" severity error;
        assert n_grw = n_grw_test         report "Test failed: n_grw wrong" severity error;
        assert n_io = n_io_test           report "Test failed: n_io wrong" severity error;
        assert n_roml = n_roml_test       report "Test failed: n_roml wrong" severity error;
        assert n_romh = n_romh_test       report "Test failed: n_romh wrong" severity error;
    end loop;
    report "Test passed." severity note;
    wait;
end process;

end test;
