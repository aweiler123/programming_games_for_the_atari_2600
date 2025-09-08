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

SHOW_FRAME:
    LDA #$88
    STA COLUBK
    LDA #$0F
    STA COLUP0
    LDA #$00
    STA COLUP1
    
    STA WSYNC
    LDA #2
    STA VSYNC
    STA WSYNC
    STA WSYNC
    STA WSYNC
    LDA #0
    STA VSYNC

    ; Player 0 and 1 horizontal position
    STA WSYNC ; Cycle 3
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
    STA RESP0 ;28
    NOP ;30
    NOP ;32
    NOP ;34
    NOP ;36
    NOP ;38
    NOP ;40
    NOP ;42
    NOP ;44
    NOP ;46
    STA RESP1 ;48

    LDX #35 ;35 scanlines of top border
TOP:
    STA WSYNC
    DEX 
    BNE TOP
    LDA #0
    STA VBLANK ;Disable blanking

    LDX #92 ;92 scanlines of blue
VISIBLE:
    STA WSYNC
    DEX
    BNE VISIBLE

    STA WSYNC ;one scanline
    LDA #$3c
    STA GRP0
    STA GRP1

    STA WSYNC ;one scanline
    LDA #$42
    STA GRP0
    STA GRP1

    STA WSYNC ;one scanline
    LDA #$a5
    STA GRP0
    STA GRP1

    STA WSYNC ;one scanline
    LDA #$81
    STA GRP0
    STA GRP1

    STA WSYNC ;one scanline
    LDA #$a5
    STA GRP0
    STA GRP1

    STA WSYNC ;one scanline
    LDA #$99
    STA GRP0
    STA GRP1

    STA WSYNC ;one scanline
    LDA #$42
    STA GRP0
    STA GRP1

    STA WSYNC ;one scanline
    LDA #$3c
    STA GRP0
    STA GRP1

    STA WSYNC ;one scanline
    LDA #$00
    STA GRP0
    STA GRP1

    LDA #$F8
    STA COLUBK

    LDX #91
VISIBLE2:
    STA WSYNC
    DEX
    BNE VISIBLE2

    LDA #2
    STA VBLANK
    LDX #30
BOTTOM:
    STA WSYNC
    DEX
    BNE BOTTOM

    JMP SHOW_FRAME

    ORG $FFFC
    .word START
    .word START

