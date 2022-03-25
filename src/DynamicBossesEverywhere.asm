; ----------------------------------------------------------------------
; Copyright © 2022 End45
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

; This patch allows placing the special fixed room entities #124-127 in any fixed room, not just in the Explorer Maze (#110). These special entities can be used to implement
; dynamic boss fights (for example, to fight pokémon in your own team or assembly).

; This file is intended to be used with armips v0.11
; The patch "ExtraSpace.asm" must be applied before this one
; Required ROM: Explorers of Sky (EU/US)
; Required files: overlay_0029.bin, overlay_0036.bin

.nds
.include "common/regionSelect.asm"

.open "overlay_0029.bin", ov_29
.org EU_2344A54
	bl clearDecoyFlag

.org EU_2344AA0
	bl hookDecoyCheck

.org EU_22F7C44
.area 24
	bl getDecoyFlag
	cmp r0, 0h
	popeq r3-r11, pc
	bne EU_22F7C5C
.endarea

.close

.open "overlay_0036.bin", ov_36
.orga 0x830
.area 0x48
; 1 if the current fixed floor includes a decoy entry, 0 otherwise
decoyFlag:
.byte 0
.align

; -----------------
; Sets the decoy flag to 0
; Available registers: At least r0-r2
; -----------------
clearDecoyFlag:
	mov r0, 0h
	ldr r1, =decoyFlag
	strb r0, [r1]
	
	; Original instruction
	mov r5, r9
	bx lr

; -----------------
; Checks if the current fixed room entity is a decoy and sets the decoy flag if so
; Available registers: At least r1-r2
; Parameters:
; 	r0: Species ID (Must stay unmodified when returning to the original function)
; -----------------
hookDecoyCheck:
	ldr r1, =229h ; Decoy
	cmp r0, r1
	moveq r1, 1h
	ldreq r2, =decoyFlag
	streqb r1, [r2]
	
	; Original instruction
	cmp r0, 0h
	bx lr

; -----------------
; Gets the value of the decoy flag
; Ret r0: The value of the decoy flag
; -----------------
getDecoyFlag:
	ldr r0, =decoyFlag
	ldrb r0, [r0]
	bx lr

.pool

.endarea
.close