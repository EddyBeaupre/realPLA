
library ieee;
use ieee.std_logic_1164.all;


entity c64pla is
    port (
        i0:     in std_logic;
        i1:     in std_logic;
        i2:     in std_logic;
        i3:     in std_logic;
        i4:     in std_logic;
        i5:     in std_logic;
        i6:     in std_logic;
        i7:     in std_logic;
        i8:     in std_logic;
        i9:     in std_logic;
        i10:    in std_logic;
        i11:    in std_logic;
        i12:    in std_logic;
        i13:    in std_logic;
        i14:    in std_logic;
        i15:    in std_logic;
        f0:     out std_logic;
        f1:     out std_logic;
        f2:     out std_logic;
        f3:     out std_logic;
        f4:     out std_logic;
        f5:     out std_logic;
        f6:     out std_logic;
        f7:     out std_logic
    );
end entity;

architecture a of c64pla is
    component c64pla_core is
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

begin

    u0: c64pla_core port map (
        i0  => i0,
        i1  => i1,
        i2  => i2,
        i3  => i3,
        i4  => i4,
        i5  => i5,
        i6  => i6,
        i7  => i7,
        i8  => i8,
        i9  => i9,
        i10 => i10,
        i11 => i11,
        i12 => i12,
        i13 => i13,
        i14 => i14,
        i15 => i15,
        f0  => f0,
        f1  => f1,
        f2  => f2,
        f3  => f3,
        f4  => f4,
        f5  => f5,
        f6  => f6,
        f7  => f7
    );

end architecture;
