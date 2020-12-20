; ----------------------------------------------------------------------
; Copyright © 2020 End45
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

; This hack allows selecting a partner with the same type as the hero after the personality test

; This file is intended to be used with armips v0.11
; Required ROM: Explorers of Sky (EU/US)
; Required files: overlay_0013.bin

.nds
.include "common/regionSelect.asm"

.open "overlay_0013.bin", ov_13
.org EU_238C48C
	nop

.close