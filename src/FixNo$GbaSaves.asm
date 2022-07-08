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

; This patch fixes an issue that causes saving to fail on the No$GBA emulator

; This file is intended to be used with armips v0.11
; Required ROM: Explorers of Sky (EU/US)
; Required files: arm9.bin

.nds
.include "common/regionSelect.asm"

.open "arm9.bin", arm9
.org EU_204ADD0
	mov r0,7h
	
.org EU_2083BA4
.byte 0xBF

.close