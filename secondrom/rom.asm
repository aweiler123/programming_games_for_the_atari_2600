    PROCESSOR 6502
    INCLUDE "vcs.h"

    ORG $F000

    ;Set up the registers
START:
    SEI ;Set to not accept external interrupts
    CLD ;Clear internal decimal flag bit
    LDX #$FF ;Load stack pointer
    TXS
    LDA #$00
CLEAR: ;Clear internal memory to a known state
    STA 0,X
    DEX
    BNE CLEAR
SHOW_FRAME:
    LDA #$88
    STA COLUBK ;Set the background color
    
    STA WSYNC
    LDA #2
    STA VSYNC ;Start the VSYNC portion, 3 lines
    STA WSYNC
    STA WSYNC
    STA WSYNC
    LDA #0
    STA VSYNC

    LDX #36 ;36 lines for op border
TOP:
    STA WSYNC
    DEX
    BNE TOP

    LDA #0
    STA VBLANK
    LDX #96
VISIBLE: ;Visible portion
    STA WSYNC
    DEX
    BNE VISIBLE

    LDA #$F8
    STA COLUBK

    LDX #96
VISIBLE2:
    STA WSYNC
    DEX
    BNE VISIBLE2

    LDA #2
    STA VBLANK
    LDX #30
BOTTOM: ;30 lines for bottom border
    STA WSYNC
    DEX
    BNE BOTTOM

    JMP SHOW_FRAME

    ORG $FFFC
    .word START
    .word START

