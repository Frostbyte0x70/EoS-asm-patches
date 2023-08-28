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

; File load addresses
arm9 equ 0x02000000
ov_29 equ 0x022DC240
ov_11 equ 0x022DC240
ov_13 equ 0x0238A140
ov_36 equ 0x023A7080 ; Extra overlay

; arm9.bin
.definelabel EU_2001238, 0x2001238
.definelabel EU_20015B8, 0x20015B8
.definelabel EU_20015DC, 0x20015DC
.definelabel EU_2002E98, 0x2002E98
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
.definelabel EU_201D5C4, 0x201D528
.definelabel EU_201D5F0, 0x201D554
.definelabel EU_204ADD0, 0x204AA98
.definelabel EU_204D74C, 0x204D414
.definelabel EU_204D944, 0x204D60C
.definelabel EU_204EED4, 0x204EB9C
.definelabel EU_204EEE4, 0x204EBAC
.definelabel EU_204EF00, 0x204EBC8
.definelabel EU_204F318, 0x204EFE0
.definelabel EU_205909C, 0x2058D20
.definelabel EU_20590AC, 0x2058D30
.definelabel EU_20590D8, 0x2058D5C
.definelabel EU_20590E4, 0x2058D68
.definelabel EU_20590EC, 0x2058D70
.definelabel EU_20590F0, 0x2058D74
.definelabel EU_20591E4, 0x2058E68
.definelabel EU_20592A0, 0x2058F24
.definelabel EU_20592B0, 0x2058F34
.definelabel EU_205931C, 0x2058FA0
.definelabel EU_2083BA4, 0x208380C
.definelabel EU_20928F0, 0x2092558
.definelabel EU_2092938, 0x20925A0
.definelabel EU_209CE8C, 0x209C950
.definelabel EU_20A2314, 0x20A1D90
.definelabel EU_20A2E40, 0x20A28BC
.definelabel EU_20AF7A8, 0x20AEF08
.definelabel EU_20AFAD0, 0x20AF230

; overlay_0011.bin
.definelabel EU_22DDA70, 0x22DD130
.definelabel EU_22E4C94, 0x22E4354
.definelabel EU_23259C0, 0x2324E80

; overlay_0013.bin
.definelabel EU_238C48C, 0x238B94C

; overlay_0029.bin
.definelabel EU_22F1D18, 0x22F1364
.definelabel EU_22F1D64, 0x22F13B0
.definelabel EU_22F23CC, 0x22F1A18
.definelabel EU_22F2418, 0x22F1A64
.definelabel EU_22F2424, 0x22F1A70
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
.definelabel EU_22F7C44, 0x22F728C
.definelabel EU_22F7C5C, 0x22F72A4
.definelabel EU_22F8A40, 0x22F8034
.definelabel EU_2302A18, 0x2301FEC
.definelabel EU_2302A2C, 0x2302000
.definelabel EU_2302A3C, 0x2302010
.definelabel EU_2302A48, 0x230201C
.definelabel EU_2302A54, 0x2302028
.definelabel EU_2302A58, 0x230202C
.definelabel EU_2302B58, 0x230212C
.definelabel EU_2302B6C, 0x2302140
.definelabel EU_2302B7C, 0x2302150
.definelabel EU_2302B90, 0x2302164
.definelabel EU_2302B9C, 0x2302170
.definelabel EU_2302BA0, 0x2302174
.definelabel EU_230338C, 0x2302960
.definelabel EU_2304544, 0x2303B18
.definelabel EU_230A614, 0x2309BE8
.definelabel EU_230E5D8, 0x230DB64
.definelabel EU_2310C54, 0x23101F4
.definelabel EU_2310CF0, 0x2310290
.definelabel EU_23118B8, 0x2310E58
.definelabel EU_2311A60, 0x2311000
.definelabel EU_23118E0, 0x2310E80
.definelabel EU_231873C, 0x2317CDC
.definelabel EU_23187A0, 0x2317D40
.definelabel EU_2340E48, 0x2340264
.definelabel EU_2341008, 0x2340424
.definelabel EU_2344A54, 0x2343E70
.definelabel EU_2344AA0, 0x2343EBC
.definelabel EU_234C2FC, 0x234B6FC
.definelabel EU_234DAF0, 0x234CEF0
.definelabel EU_2354138, 0x2353538

; Functions
	; arm9.bin
	.definelabel fn_loadOverlayFallback,        0x2003D2C
	.definelabel fn_EU_2008194,                 0x2008194
	.definelabel fn_EU_2013AF8,                 0x2013A50
	.definelabel fn_EU_2025B90,                 0x20258C4
	.definelabel fn_deleteMoveMenu,             0x2030850
	.definelabel fn_setMoveData,                0x203F9CC
	.definelabel fn_createMoveMenu,             0x204018C
	.definelabel fn_deallocMoveMenu,            0x20407C0
	.definelabel fn_getGroundVar,               0x204B4EC
	.definelabel fn_getPerfomanceProgress,      0x204CA94
	.definelabel fn_addExtraPokemon,            0x204F8E0
	.definelabel CanEnemyEvolve,                0x2051400
	.definelabel fn_getSpeciesIQGroup,          0x2052B28
	.definelabel fn_getOverlayData,             0x207FC9C
	.definelabel fn_loadOverlayInRam,           0x207FD98
	.definelabel fn_EU_2080254,                 0x207FEBC

	; overlay_0029.bin
	.definelabel fn_EU_22E15F8,                 0x22E0CB8
	.definelabel fn_waitFrame,                  0x22E9FE0
	.definelabel fn_setDispMode,                0x22EA428
	.definelabel EvolveMonster,                 0x2303C7C
	.definelabel RestoreMovePP,                 0x2317C20
	.definelabel fn_EU_22F399C,                 0x22F2FE4
	.definelabel fn_EU_230DB90,                 0x230D11C
	.definelabel fn_hideMap,                    0x233A248
	.definelabel GenerateMaze,                  0x2340458
	.definelabel fn_sendMessageWithIDCheckULog, 0x234B2A4

; Other
.definelabel EU_237D294, 237C694h

; Registers
ApplyDamageAttackerRegister equ r8