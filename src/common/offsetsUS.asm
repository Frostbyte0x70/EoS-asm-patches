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
.definelabel EU_20011F0, 0x20015B8
.definelabel EU_2001238, 0x20015DC
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
.definelabel EU_204EED4, 0x204EB9C
.definelabel EU_204EEE4, 0x204EBAC
.definelabel EU_204EF00, 0x204EBC8
.definelabel EU_204F318, 0x204EFE0
.definelabel EU_20928F0, 0x2092558
.definelabel EU_2092938, 0x20925A0
.definelabel EU_209CE8C, 0x209C950
.definelabel EU_20A2E40, 0x20A28BC
.definelabel EU_20AF7A8, 0x20AEF08
.definelabel EU_20AFAD0, 0x20AF230

; overlay_0013.bin
.definelabel EU_238C48C, 0x238B94C

; overlay_0029.bin
.definelabel EU_22F2470, 0x22F1ABC
.definelabel EU_22F24E0, 0x22F1B2C
.definelabel EU_22F24F0, 0x22F1B3C
.definelabel EU_22F246C, 0x22F1AB8
.definelabel EU_22F25FC, 0x22F1C48
.definelabel EU_22F2694, 0x22F1CE0
.definelabel EU_22F26CC, 0x22F1D18
.definelabel EU_22F26EC, 0x22F1D38
.definelabel EU_22F2748, 0x22F1D94
.definelabel EU_22F2764, 0x22F1DB0
.definelabel EU_22F27A4, 0x22F1DF0
.definelabel EU_22F27F8, 0x22F1E44
.definelabel EU_22F2808, 0x22F1E54
.definelabel EU_22F2A98, 0x22F20E4
.definelabel EU_22F3318, 0x22F2964
.definelabel EU_22F3324, 0x22F2970
.definelabel EU_22F8A40, 0x22F8034
.definelabel EU_230E5D8, 0x230DB64
.definelabel EU_234DAF0, 0x234CEF0

; Functions
; Prefixed with fn_ to differentiate them from labels declared inside the patches
	; arm9.bin
	.definelabel fn_loadOverlayFallback,    2003D2Ch
	.definelabel fn_EU_2008194,             2008194h
	.definelabel fn_EU_2013AF8,             2013A50h
	.definelabel fn_EU_2025B90,             20258C4h
	.definelabel fn_deleteMoveMenu,         2030850h
	.definelabel fn_setMoveData,            203F9CCh
	.definelabel fn_createMoveMenu,         204018Ch
	.definelabel fn_deallocMoveMenu,        20407C0h
	.definelabel fn_getGroundVar,           204B4ECh
	.definelabel fn_getPerfomanceProgress,  204CA94h
	.definelabel fn_addExtraPokemon,        204F8E0h
	.definelabel fn_getOverlayData,         207FC9Ch
	.definelabel fn_loadOverlayInRam,       207FD98h
	.definelabel fn_EU_2080254,             207FEBCh

	; overlay_0029.bin
	.definelabel fn_EU_22E15F8,             22E0CB8h
	.definelabel fn_waitFrame,              22E9FE0h
	.definelabel fn_setDispMode,            22EA428h
	.definelabel fn_hideMap,                233A248h

; Other
.definelabel EU_237D294, 237C694h
