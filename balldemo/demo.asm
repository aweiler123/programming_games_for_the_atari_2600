    PROCESSOR 6502
    INCLUDE "vcs.h"

    ORG $F000
START:
    SEI ;Disable interrupts
    CLD ;Clear decimal mode
    LDX #$FF
    TXS
    LDA #$00
CLEAR:
    STA 0,X
    DEX
    BNE CLEAR

SHOW_FRAME:
    LDA #$88 ;Blue
    STA COLUBK ;Background color
    LDA #$0F ;White
    STA COLUPF ;Playfield color

    STA WSYNC
    LDA #2 ;Start of vertical retrace
    STA VSYNC
    STA WSYNC
    STA WSYNC
    STA WSYNC
    LDA #0 ;End of vertical retrace
    STA VSYNC

    ;BAll horizontal position (23 NOPs for center)
    STA WSYNC ;Cycle 3
    NOP ;5
    NOP ;7
    NOP ;9
    NOP ;11
    NOP ;13
    NOP ;15
    NOP ;17
    NOP ;19
    NOP ;21
    NOP ;23
    NOP ;25
    NOP ;27
    NOP ;29
    NOP ;31
    NOP ;33
    NOP ;35
    NOP ;37
    NOP ;39
    NOP ;41
    NOP ;43
    NOP ;45
    NOP ;47
    NOP ;49
    STA RESBL ;52 - set ball position

    LDX #35 ;Remaining 35 scanlines of top border
TOP:
    STA WSYNC
    DEX
    BNE TOP
    LDA #0 ;Disable blanking
    STA VBLANK

    LDX #95 ;95 scanlines in blue
VISIBLE:
    STA WSYNC
    DEX
    BNE VISIBLE
    STA WSYNC
    LDA #$02 ;Ball enable
    STA ENABL

    STA WSYNC ;one scanlne
    LDA #$00 ;disable ball
    STA ENABL

    LDA #$F8 ;sand color
    STA COLUBK
    LDX #95 ;95 scanlines
VISIBLE2:
    STA WSYNC
    DEX
    BNE VISIBLE2

    LDA #2 ;Enable blanking
    STA VBLANK
    LDX #30 ;30 scanlines to bottom
BOTTOM:
    STA WSYNC
    DEX
    BNE BOTTOM

    JMP SHOW_FRAME

    ORG $FFFC
    .word START
    .word START

