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

; Adds the hero to the list of pokémon that will cause you to get kicked out of the dungeon when they faint under certain conditions

; This file is intended to be used with armips v0.11
; The patch "ExtraSpace.asm" must be applied before this one
; Required ROM: Explorers of Sky (EU/US)
; Required files: overlay_0029.bin, overlay_0036.bin

.nds
.include "common/regionSelect.asm"
; #####################################
; ##             Functions           ##
; #####################################
.open "overlay_0036.bin", ov_36
.orga 0x700
.area 44h

; -----------------
; New list of values that can trigger a kick from a dungeon when a partner faints.
; The function is fully rewritten instead of patched because the original function is called in some other places.
; -----------------
joinedAtKickList:
	cmp r0,0D6h
	cmpne r0,0D7h
	beq @@retTrue
	cmp r0,0ECh
	bcc @@retFalse
	cmp r0,0F0h
	bhi @@retFalse
@@retTrue:
	mov r0,1h
	bx lr
@@retFalse:
	mov r0,0h
	bx lr

.endarea
.close

; #####################################
; ##          Hooks / Patches        ##
; #####################################
.open "overlay_0029.bin", ov_29
.org EU_22F8A40
	bl joinedAtKickList
.close