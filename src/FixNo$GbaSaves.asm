; ----------------------------------------------------------------------
; Copyright © 2024 Frostbyte0x70
; 
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
; 
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
; 
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <https://www.gnu.org/licenses/>.
; ----------------------------------------------------------------------

; This patch fixes an issue that causes saving to fail on the No$GBA emulator

; This file is intended to be used with armips v0.11
; The patch "ExtraSpace.asm" must be applied before this one
; Required ROM: Explorers of Sky (EU/US/JP)
; Required files: arm9.bin, overlay_0036.bin

.nds
.include "common/regionSelect.asm"

.open "overlay_0036.bin", ov_36
.orga 0x1BA0
.area 0x54
NoCashHookOne:
    push r14
    bl NoCashCheck
    movne r0,#0x8 ; vanilla code for if NOT on no$
    moveq r0,#0x7 ; modified code for if on no$
    pop r15

NoCashHookTwo:
    push r14
    bl NoCashCheck
    ldrne r0,=0x203F ; vanilla value for if NOT on no$
    ldreq r0,=0x20BF ; modified value for if on no$
    pop r15

NoCashCheck:
    push r1,r2
    ldr r1,=0x4FFFA00 ; No$GBA writes the string "no$gba <version number>" to this address for debugging purposes. this patch checks for that string to determine if we're running on no$.
    ldr r1,[r1]
    ldr r2,=0x67246F6E ; ASCII for "no$g"
    cmp r1,r2
    pop r1,r2
    bx lr
.pool
.endarea

.close

.open "arm9.bin", arm9
.org EU_204ADD0
    bl NoCashHookOne

.org EU_208385C
   bl NoCashHookTwo

.close
