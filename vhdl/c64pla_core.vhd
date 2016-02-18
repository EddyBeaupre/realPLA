
library ieee;
use ieee.std_logic_1164.all;

entity c64pla_core is
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
end entity;

architecture a of c64pla_core is
    signal p0: std_logic;
    signal p1: std_logic;
    signal p2: std_logic;
    signal p3: std_logic;
    signal p4: std_logic;
    signal p5: std_logic;
    signal p6: std_logic;
    signal p7: std_logic;
    signal p8: std_logic;
    signal p9: std_logic;
    signal p10: std_logic;
    signal p11: std_logic;
    signal p12: std_logic;
    signal p13: std_logic;
    signal p14: std_logic;
    signal p15: std_logic;
    signal p16: std_logic;
    signal p17: std_logic;
    signal p18: std_logic;
    signal p19: std_logic;
    signal p20: std_logic;
    signal p21: std_logic;
    signal p22: std_logic;
    signal p23: std_logic;
    signal p24: std_logic;
    signal p25: std_logic;
    signal p26: std_logic;
    signal p27: std_logic;
    signal p28: std_logic;
    signal p29: std_logic;

    -- Two levels of logic for every I/O combination
    signal f0a, f0b, f1a, f2a, f3a, f4a, f5a, f6a, f7a: std_logic;
    attribute SYN_KEEP:             integer;
    attribute OPT:                  string;
    attribute SYN_KEEP of f0a, f0b, f1a, f2a, f3a, f4a, f5a, f6a, f7a: signal is 1;
    attribute OPT of f0a, f0b, f1a, f2a, f3a, f4a, f5a, f6a, f7a: signal is "KEEP";

begin
    p0 <= i1 and i2 and i5 and not i6 and i7 and not i10 and i11 and i13;
    p1 <= i2 and i5 and i6 and i7 and not i10 and i11 and i13;
    p2 <= i2 and i5 and i6 and i7 and not i10 and i11 and not i12 and not i13;
    p3 <= i2 and not i3 and i5 and i6 and not i7 and i8 and not i10 and i11 and i13;
    p4 <= i1 and not i3 and i5 and i6 and not i7 and i8 and not i10 and i11 and i13;
    p5 <= i2 and not i3 and i5 and i6 and not i7 and i8 and not i10 and i11 and not i12 and not i13;
    p6 <= i4 and i10 and i13 and not i14 and i15;
    p7 <= i4 and i10 and not i12 and not i13 and not i14 and i15;
    p8 <= i2 and i3 and i5 and i6 and not i7 and i8 and i9 and not i10 and i11 and i13;
    p9 <= i2 and i3 and i5 and i6 and not i7 and i8 and not i10 and not i11 and i13;
    p10 <= i1 and i3 and i5 and i6 and not i7 and i8 and i9 and not i10 and i11 and i13;
    p11 <= i1 and i3 and i5 and i6 and not i7 and i8 and not i10 and not i11 and i13;
    p12 <= i2 and i3 and i5 and i6 and not i7 and i8 and i9 and not i10 and i11 and not i12 and not i13;
    p13 <= i2 and i3 and i5 and i6 and not i7 and i8 and not i10 and not i11 and not i12 and not i13;
    p14 <= i1 and i3 and i5 and i6 and not i7 and i8 and i9 and not i10 and i11 and not i12 and not i13;
    p15 <= i1 and i3 and i5 and i6 and not i7 and i8 and not i10 and not i11 and not i12 and not i13;
    p16 <= i5 and i6 and not i7 and i8 and i9 and not i10 and i11 and i12 and not i13;
    p17 <= i5 and i6 and not i7 and i8 and not i10 and not i11 and i12 and not i13;
    p18 <= i1 and i2 and i5 and not i6 and not i7 and not i10 and i11 and not i12;
    p19 <= i5 and not i6 and not i7 and not i10 and i12 and not i13;
    p20 <= i2 and i5 and not i6 and i7 and not i10 and i11 and not i12 and not i13;
    p21 <= i5 and i6 and i7 and not i10 and i12 and not i13;
    p22 <= i10 and i12 and not i13 and i14 and i15;
    p23 <= not i5 and not i6 and i8 and i12 and not i13;
    p24 <= not i5 and not i6 and i7 and i12 and not i13;
    p25 <= not i5 and i6 and i12 and not i13;
    p26 <= i5 and not i6 and i7 and i12 and not i13;
    p27 <= i5 and i6 and not i7 and not i8 and i12 and not i13;
    p28 <= i0;
    p29 <= not i0 and i5 and i6 and not i7 and i8 and not i10 and not i11;

    f0a <= p0 or p1 or p2 or p3 or p4 or p5 or p6 or p7 or p8 or p9 or p10 or p11 or p12 or p13 or p14 or p15 or p16;
    f0b <= p17 or p18 or p19 or p20 or p21 or p22 or p23 or p24 or p25 or p26 or p27 or p28;
    f0 <= f0a or f0b;

    f1a <= not (p0);
    f1 <= f1a;

    f2a <= not (p1 or p2);
    f2 <= f2a;

    f3a <= not (p3 or p4 or p5 or p6 or p7);
    f3 <= f3a;

    f4a <= not (p29);
    f4 <= f4a;

    f5a <= not (p8 or p9 or p10 or p11 or p12 or p13 or p14 or p15 or p16 or p17);
    f5 <= f5a;

    f6a <= not (p18 or p19);
    f6 <= f6a;

    f7a <= not (p20 or p21 or p22);
    f7 <= f7a;

end architecture;
