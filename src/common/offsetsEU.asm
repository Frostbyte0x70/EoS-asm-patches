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

; File load addresses
arm9 equ 0x02000000
ov_29 equ 0x022DCB80
ov_13 equ 0x0238AC80
ov_36 equ 0x023A7080 ; Extra overlay

; arm9.bin
.definelabel EU_20040F8, 0x20040F8
.definelabel EU_2004158, 0x2004158
.definelabel EU_200415C, 0x200415C
.definelabel EU_2004168, 0x2004168
.definelabel EU_2004174, 0x2004174
.definelabel EU_2004180, 0x2004180
.definelabel EU_20041A4, 0x20041A4
.definelabel EU_20041B4, 0x20041B4
.definelabel EU_2004270, 0x2004270
.definelabel EU_20042A8, 0x20042A8
.definelabel EU_20042B4, 0x20042B4
.definelabel EU_2004780, 0x2004780
.definelabel EU_2004790, 0x2004790
.definelabel EU_20047A0, 0x20047A0
.definelabel EU_2004868, 0x2004868
.definelabel EU_201367C, 0x201367C
.definelabel EU_20136A4, 0x20136A4
.definelabel EU_204D74C, 0x204D74C
.definelabel EU_204D944, 0x204D944
.definelabel EU_20928F0, 0x20928F0
.definelabel EU_2092938, 0x2092938
.definelabel EU_20AFAD0, 0x20AFAD0

; overlay_0013.bin
.definelabel EU_238C48C, 0x238C48C

; overlay_0029.bin
.definelabel EU_22F2470, 0x22F2470
.definelabel EU_22F24E0, 0x22F24E0
.definelabel EU_22F24F0, 0x22F24F0
.definelabel EU_22F246C, 0x22F246C
.definelabel EU_22F2694, 0x22F2694
.definelabel EU_22F26CC, 0x22F26CC
.definelabel EU_22F26EC, 0x22F26EC
.definelabel EU_22F2748, 0x22F2748
.definelabel EU_22F2764, 0x22F2764
.definelabel EU_22F27A4, 0x22F27A4
.definelabel EU_22F27F8, 0x22F27F8
.definelabel EU_22F2808, 0x22F2808
.definelabel EU_22F3324, 0x22F3324
.definelabel EU_234DAF0, 0x234DAF0

; Functions
; Prefixed with fn_ to differentiate them from labels declared inside the hacks
	; arm9.bin
	.definelabel fn_loadOverlayFallback, 2003D2Ch
	.definelabel fn_EU_2008194, 2008194h
	.definelabel fn_EU_2013AF8, 2013AF8h
	.definelabel fn_EU_2025B90, 2025B90h
	.definelabel fn_getOverlayData, 2080034h
	.definelabel fn_loadOverlayInRam, 2080130h
	.definelabel fn_EU_2080254, 2080254h

	; overlay_0029.bin
	.definelabel fn_EU_22E15F8, 22E15F8h

; Other
.definelabel EU_237D294, 237D294h