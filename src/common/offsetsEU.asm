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
ov_29 equ 0x022DCB80
ov_11 equ 0x022DCB80
ov_13 equ 0x0238AC80
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
.definelabel EU_201367C, 0x201367C
.definelabel EU_20136A4, 0x20136A4
.definelabel EU_201D5C4, 0x201D5C4
.definelabel EU_201D5F0, 0x201D5F0
.definelabel EU_204ADD0, 0x204ADD0
.definelabel EU_204D74C, 0x204D74C
.definelabel EU_204D944, 0x204D944
.definelabel EU_204EED4, 0x204EED4
.definelabel EU_204EEE4, 0x204EEE4
.definelabel EU_204EF00, 0x204EF00
.definelabel EU_204F318, 0x204F318
.definelabel EU_205909C, 0x205909C
.definelabel EU_20590AC, 0x20590AC
.definelabel EU_20590D8, 0x20590D8
.definelabel EU_20590E4, 0x20590E4
.definelabel EU_20590EC, 0x20590EC
.definelabel EU_20590F0, 0x20590F0
.definelabel EU_20591E4, 0x20591E4
.definelabel EU_20592A0, 0x20592A0
.definelabel EU_20592B0, 0x20592B0
.definelabel EU_205931C, 0x205931C
.definelabel EU_2083BA4, 0x2083BA4
.definelabel EU_20928F0, 0x20928F0
.definelabel EU_2092938, 0x2092938
.definelabel EU_209CE8C, 0x209CE8C
.definelabel EU_20A2314, 0x20A2314
.definelabel EU_20A2E40, 0x20A2E40
.definelabel EU_20AF7A8, 0x20AF7A8
.definelabel EU_20AFAD0, 0x20AFAD0

; overlay_0011.bin
.definelabel EU_22DDA70, 0x22DDA70
.definelabel EU_22E4C94, 0x22E4C94
.definelabel EU_23259C0, 0x23259C0

; overlay_0013.bin
.definelabel EU_238C48C, 0x238C48C

; overlay_0029.bin
.definelabel EU_22F1D18, 0x22F1D18
.definelabel EU_22F1D64, 0x22F1D64
.definelabel EU_22F23CC, 0x22F23CC
.definelabel EU_22F2418, 0x22F2418
.definelabel EU_22F2424, 0x22F2424
.definelabel EU_22F2470, 0x22F2470
.definelabel EU_22F24E0, 0x22F24E0
.definelabel EU_22F24F0, 0x22F24F0
.definelabel EU_22F246C, 0x22F246C
.definelabel EU_22F25FC, 0x22F25FC
.definelabel EU_22F2694, 0x22F2694
.definelabel EU_22F26CC, 0x22F26CC
.definelabel EU_22F26EC, 0x22F26EC
.definelabel EU_22F2748, 0x22F2748
.definelabel EU_22F2764, 0x22F2764
.definelabel EU_22F27A4, 0x22F27A4
.definelabel EU_22F27F8, 0x22F27F8
.definelabel EU_22F2808, 0x22F2808
.definelabel EU_22F2A98, 0x22F2A98
.definelabel EU_22F3318, 0x22F3318
.definelabel EU_22F3324, 0x22F3324
.definelabel EU_22F7C44, 0x22F7C44
.definelabel EU_22F7C5C, 0x22F7C5C
.definelabel EU_22F8A40, 0x22F8A40
.definelabel EU_2302A18, 0x2302A18
.definelabel EU_2302A2C, 0x2302A2C
.definelabel EU_2302A3C, 0x2302A3C
.definelabel EU_2302A48, 0x2302A48
.definelabel EU_2302A54, 0x2302A54
.definelabel EU_2302A58, 0x2302A58
.definelabel EU_2302B58, 0x2302B58
.definelabel EU_2302B6C, 0x2302B6C
.definelabel EU_2302B7C, 0x2302B7C
.definelabel EU_2302B90, 0x2302B90
.definelabel EU_2302B9C, 0x2302B9C
.definelabel EU_2302BA0, 0x2302BA0
.definelabel EU_230338C, 0x230338C
.definelabel EU_2304544, 0x2304544
.definelabel EU_230A614, 0x230A614
.definelabel EU_230E5D8, 0x230E5D8
.definelabel EU_2310C54, 0x2310C54
.definelabel EU_2310CF0, 0x2310CF0
.definelabel EU_23118B8, 0x23118B8
.definelabel EU_2311A60, 0x2311A60
.definelabel EU_23118E0, 0x23118E0
.definelabel EU_231873C, 0x231873C
.definelabel EU_23187A0, 0x23187A0
.definelabel EU_2340E48, 0x2340E48
.definelabel EU_2341008, 0x2341008
.definelabel EU_2344A54, 0x2344A54
.definelabel EU_2344AA0, 0x2344AA0
.definelabel EU_234C2FC, 0x234C2FC
.definelabel EU_234DAF0, 0x234DAF0
.definelabel EU_2354138, 0x2354138

; Functions
	; arm9.bin
	.definelabel fn_loadOverlayFallback,        0x2003D2C
	.definelabel fn_EU_2008194,                 0x2008194
	.definelabel fn_EU_2013AF8,                 0x2013AF8
	.definelabel fn_EU_2025B90,                 0x2025B90
	.definelabel fn_deleteMoveMenu,             0x2030B44
	.definelabel fn_setMoveData,                0x203FCC8
	.definelabel fn_createMoveMenu,             0x2040488
	.definelabel fn_deallocMoveMenu,            0x2040ABC
	.definelabel fn_getGroundVar,               0x204B824
	.definelabel fn_getPerfomanceProgress,      0x204CDCC
	.definelabel fn_addExtraPokemon,            0x204FC18
	.definelabel CanEnemyEvolve,                0x2051738
	.definelabel fn_getSpeciesIQGroup,          0x2052E60
	.definelabel fn_getOverlayData,             0x2080034
	.definelabel fn_loadOverlayInRam,           0x2080130
	.definelabel fn_EU_2080254,                 0x2080254

	; overlay_0029.bin
	.definelabel fn_EU_22E15F8,                 0x22E15F8
	.definelabel fn_waitFrame,                  0x22EA990
	.definelabel fn_setDispMode,                0x22EADD8
	.definelabel EvolveMonster,                 0x23046A8
	.definelabel RestoreMovePP,                 0x2318680
	.definelabel fn_EU_22F399C,                 0x22F399C
	.definelabel fn_EU_230DB90,                 0x230DB90
	.definelabel fn_hideMap,                    0x233AE2C
	.definelabel GenerateMaze,                  0x234103C
	.definelabel fn_sendMessageWithIDCheckULog, 0x234BEA4

; Other
.definelabel EU_237D294, 237D294h

; Registers
ApplyDamageAttackerRegister equ r10