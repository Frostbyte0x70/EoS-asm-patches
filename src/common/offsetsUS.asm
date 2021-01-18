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
ov_29 equ 0x022DC240
ov_13 equ 0x0238A140
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
.definelabel EU_201367C, 0x20135D4
.definelabel EU_20136A4, 0x20135FC
.definelabel EU_204D74C, 0x204D414
.definelabel EU_204D944, 0x204D60C
.definelabel EU_20928F0, 0x2092558
.definelabel EU_2092938, 0x20925A0
.definelabel EU_20AFAD0, 0x20AF230

; overlay_0013.bin
.definelabel EU_238C48C, 0x238B94C

; overlay_0029.bin
.definelabel EU_22F2470, 0x22F1ABC
.definelabel EU_22F24E0, 0x22F1B2C
.definelabel EU_22F24F0, 0x22F1B3C
.definelabel EU_22F246C, 0x22F1AB8
.definelabel EU_22F2694, 0x22F1CE0
.definelabel EU_22F26CC, 0x22F1D18
.definelabel EU_22F26EC, 0x22F1D38
.definelabel EU_22F2748, 0x22F1D94
.definelabel EU_22F2764, 0x22F1DB0
.definelabel EU_22F27A4, 0x22F1DF0
.definelabel EU_22F27F8, 0x22F1E44
.definelabel EU_22F2808, 0x22F1E54
.definelabel EU_22F3324, 0x22F2970
.definelabel EU_234DAF0, 0x234CEF0

; Functions
; Prefixed with fn_ to differentiate them from labels declared inside the hacks
	; arm9.bin
	.definelabel fn_loadOverlayFallback, 0x2003D2C
	.definelabel fn_EU_2008194, 0x2008194
	.definelabel fn_EU_2013AF8, 2013A50h
	.definelabel fn_EU_2025B90, 20258C4h
	.definelabel fn_getOverlayData, 0x207FC9C
	.definelabel fn_loadOverlayInRam, 0x207FD98
	.definelabel fn_EU_2080254, 0x207FEBC

	; overlay_0029.bin
	.definelabel fn_EU_22E15F8, 22E0CB8h

; Other
.definelabel EU_237D294, 237C694h