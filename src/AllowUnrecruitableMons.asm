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

; There's some pokémon in the game that are hardcoded to be unrecruitable in dungeons (all of Deoxys froms except the first one and the 3 regis).
; This patch removes that restriction so they can be recruited in dungeons just like any other pokémon.

; This file is intended to be used with armips v0.11
; Required ROM: Explorers of Sky (EU/US)
; Required files: overlay_0029.bin

.nds
.include "common/regionSelect.asm"

.open "overlay_0029.bin", ov_29
.org EU_230E5D8
.area 0x230E63C - 0x230E5D8
	mov r0,1h
	pop r4,pc
.endarea

.close