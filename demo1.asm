    PROCESSOR 6502
    INCLUDE "vcs.h"

    ORG $F000

START:
    SEI
    CLD
    LDX #$FF
    TXS
    LDA #$00
CLEAR:
    STA 0,X
    DEX
    BNE CLEAR
    