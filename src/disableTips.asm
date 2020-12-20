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

; This hack disables the tips shown at the start of the game and when interacting with certain items for the first time.
; Since some of the functions used to do this are no longer needed, it also frees up some space that could be used by another patch to store extra
; instructions if needed.
; Freed areas (both adresses inclusive):
; EU: 0x234DAF4 ~ 0x234DB5C (overlay_0029.bin), 0x204D588 ~ 0x204D610 (arm9.bin)
; US: 0x234CEF4 ~ 0x234CF5C (overlay_0029.bin), 0x204D250 ~ 0x204D2D8 (arm9.bin)

; This file is intended to be used with armips v0.11
; Required ROM: Explorers of Sky (EU/US)
; Required files: arm9.bin, overlay_0029.bin

.nds
.include "common/regionSelect.asm"

.open "overlay_0029.bin", ov_29
; Disable the function that displays the tips
.org EU_234DAF0
	bx lr

.close
.open "arm9.bin", arm9
; There are two functions that are used to get/set the value of one of the flags that keep track of which messages have been shown already.
; We remove all the calls made to them so they can be safely overwritten

.org EU_204D74C
	mov r0,0h
	
.org EU_204D944
	nop

.close