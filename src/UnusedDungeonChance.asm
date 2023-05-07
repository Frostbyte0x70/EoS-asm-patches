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
; Required ROM: Explorers of Sky (EU/US)
; Required files: overlay_0029.bin

.nds
.include "common/regionSelect.asm"

.open "overlay_0029.bin", ov_29

; Skip the check that disables this feature
.org EU_2340E48
	nop

; Mark rooms where a wall maze has been generated as inelegible for secondary terrain generation. This stops the game from generating both a maze and water/lava lakes,
; which can make some tiles unreachable, potentially softlocking the player if the stairs happen to be there.
.org EU_2341008
.area 0x8
	; This overwrites the loop's break instruction, but it doesn't matter because only a maximum of one room is chosen to spawn a maze every floor
	; Another instruction could be fit in here by removing the branch at EU_2341000 and using conditional suffixes instead
	strb r1,[r0,1Dh] ; Disable the byte that allows generating secondary terrain in this room
	bl GenerateMaze
.endarea

.close