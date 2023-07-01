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

; This patch fixes the unused chance in dungeon properties, restoring its original functionality. If the chance passes, one of the rooms in the current
; floor will be turned into a maze made up of walls.

; This file is intended to be used with armips v0.11
; The patch "ExtraSpace.asm" must be applied before this one
; Required ROM: Explorers of Sky (EU/US)
; Required files: overlay_0029.bin, overlay_0036.bin

.nds
.include "common/regionSelect.asm"

.open "overlay_0029.bin", ov_29

; Skip the check that disables this feature
.org EU_2340E48
	nop

; Mark rooms where a wall maze has been generated as inelegible for secondary terrain generation. This stops the game from generating both a maze and water/lava lakes,
; which can make some tiles unreachable, potentially softlocking the player if the stairs happen to be there.
.org EU_2341008
	bl hook
	; Restore the original code that might have been removed by an oldder version of this patch
	b . + 20h

.close

.open "overlay_0036.bin", ov_36
.orga 0x13F0
.area 0x8
hook:
	strb r1,[r0,1Dh] ; Disable the byte that allows generating secondary terrain in this room
	b GenerateMaze
.endarea

.close