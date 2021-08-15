; ----------------------------------------------------------------------
; Copyright © 2021 End45
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

; Changes the behaviour of the Perish Song effect to leave the target at 1 HP instead of fainting it

; This file is intended to be used with armips v0.11
; Required ROM: Explorers of Sky (EU/US)
; Required files: overlay_0029.bin

.nds
.include "common/regionSelect.asm"

.open "overlay_0029.bin", ov_29
; Optimize the code in this area to make space for one more instruction
.org EU_23118B8
.area 0x23118D8 - 0x23118B8
	mov r0,r5
	bne @@noProtect
	ldr r1,[EU_2311A60]
	bl fn_sendMessageWithIDCheckULog
	b EU_23118E0
@@noProtect:
	mov r2,0Bh
	; Change the damage amount from 9999 to (target's HP) - 1
	ldrh r1,[r4,10h]
	sub r1,r1,1h
.endarea
.close