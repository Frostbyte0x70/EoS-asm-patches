; ----------------------------------------------------------------------
; Copyright © 2023 End45
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

; This patch unlocks all locks when the user presses A+B+X+Y during a cutscene, forcing the game to continue running the script

; This file is intended to be used with armips v0.11
; The patch "ExtraSpace.asm" must be applied before this one
; Required ROM: Explorers of Sky (EU/US)
; Required files: overlay_0011.bin, overlay_0036.bin

.nds
.include "common/regionSelect.asm"

.open "overlay_0036.bin", ov_36
.orga 0xBC0
.area 0x50
; -----------------
; Checks if A+B+X+Y is pressed and unlocks all locks if so
; Available registers: At least r0-r8
; -----------------
checkButtons:
	push lr
	; Check GBA button inputs (A and B)
	ldr r0,=0x4000130
	ldrh r0,[r0]
	tst r0,3h
	bne @@ret
	; Check DS button inputs (X and Y)
	ldr r0,=0x27FFFA8
	ldrh r0,[r0]
	tst r0,0C00h
	bne @@ret
	; All 4 buttons have been pressed, unlock all locks
	mov r4,0h
@@loop:
	mov r0,r4
	bl EU_22DDA70 ; Unlocks the lock specified in r0
	add r4,r4,1h
	cmp r4,15h
	blt @@loop
@@ret:
	; Original instruction
	ldr r0,=EU_23259C0
	pop pc
.pool
.endarea

.close

.open "overlay_0011.bin", ov_11
.org EU_22E4C94
	bl checkButtons

.close