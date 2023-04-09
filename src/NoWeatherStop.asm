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

; Changes weather damage messages so they don't make the player stop running

; This file is intended to be used with armips v0.11
; The patch "ExtraSpace.asm" must be applied before this one
; Required ROM: Explorers of Sky (EU/US)
; Required files: overlay_0029.bin, overlay_0036.bin

.nds
.include "common/regionSelect.asm"

.open "overlay_0036.bin", ov_36
.orga 0x1380
.area 0x13B8 - 0x1380

stopPlayerFlag:
.word 1
clearFlagAndCallDamageFunc:
	push lr
	mov r12,0h
	str r12,[stopPlayerFlag]
	bl fn_EU_230DB90 ; Some variant of CalcDamage
	; Reset the flag, just in case the message didn't get printed in the end
	mov r0,1h
	str r0,[stopPlayerFlag]
	pop pc

; Contitionally calls fn_EU_22F399C depending on whether the stop player flag is set. Resets the flag to 1.
hook:
	ldr r12,[stopPlayerFlag]
	cmp r12,1h
	beq fn_EU_22F399C ; Makes the player stop running, among other things
	; Reset the flag and return
	mov r12,1h
	str r12,[stopPlayerFlag]
	bx lr

.endarea
.close

.open "overlay_0029.bin", ov_29

.org EU_2310C54
	bl clearFlagAndCallDamageFunc
.org EU_2310CF0
	bl clearFlagAndCallDamageFunc

.org EU_234C2FC
	bl hook

.close