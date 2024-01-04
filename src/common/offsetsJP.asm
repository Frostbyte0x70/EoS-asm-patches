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
ov_29 equ 0x022DD8E0
ov_11 equ 0x022DD8E0
ov_13 equ 0x0238B6A0
ov_36 equ 0x023A7080 ; Extra overlay

; arm9.bin
.definelabel EU_2001238, 0x2001238
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
.definelabel EU_201367C, 0x20135A4
.definelabel EU_20136A4, 0x20135CC
.definelabel EU_201D5C4, 0x201D580
.definelabel EU_201D5F0, 0x201D5AC
.definelabel EU_204ADD0, 0x204AE00
.definelabel EU_204D74C, 0x204D774
.definelabel EU_204D944, 0x204D96C
.definelabel EU_204EED4, 0x204EEF4
.definelabel EU_204EEE4, 0x204EF04
.definelabel EU_204EF00, 0x204EF20
.definelabel EU_204F318, 0x204F338
.definelabel EU_205909C, 0x205901C
.definelabel EU_20590AC, 0x205902C
.definelabel EU_20590D8, 0x2059058
.definelabel EU_20590E4, 0x2059064
.definelabel EU_20590EC, 0x205906C
.definelabel EU_20590F0, 0x2059070
.definelabel EU_20591E4, 0x2059164
.definelabel EU_20592A0, 0x2059220
.definelabel EU_20592B0, 0x2059230
.definelabel EU_205931C, 0x205929C
.definelabel EU_2083BA4, 0x2083AF4
.definelabel EU_20928F0, 0x2092840
.definelabel EU_2092938, 0x2092888
.definelabel EU_209CE8C, 0x209DD24
.definelabel EU_20A2314, 0x20A3164
.definelabel EU_20A2E40, 0x20A3C90
.definelabel EU_20AF7A8, 0x20B0348
.definelabel EU_20AFAD0, 0x20B0670

; overlay_0011.bin
.definelabel EU_22DDA70, 0x22DE7D0
.definelabel EU_22E4C94, 0x22E5980
.definelabel EU_23259C0, 0x23263E0

; overlay_0013.bin
.definelabel EU_238C48C, 0x238CEB0

; overlay_0029.bin
.definelabel EU_22F1D18, 0x22F295C
.definelabel EU_22F1D64, 0x22F13B0
.definelabel EU_22F23CC, 0x22F3010
.definelabel EU_22F2418, 0x22F305C
.definelabel EU_22F2424, 0x22F3068
.definelabel EU_22F2470, 0x22F30B4
.definelabel EU_22F24E0, 0x22F3124
.definelabel EU_22F24F0, 0x22F3134
.definelabel EU_22F246C, 0x22F30B0
.definelabel EU_22F25FC, 0x22F3240
.definelabel EU_22F2694, 0x22F32D8
.definelabel EU_22F26CC, 0x22F3310
.definelabel EU_22F26EC, 0x22F3330
.definelabel EU_22F2748, 0x22F338C
.definelabel EU_22F2764, 0x22F33A8
.definelabel EU_22F27A4, 0x22F33E8
.definelabel EU_22F27F8, 0x22F343C
.definelabel EU_22F2808, 0x22F344C
.definelabel EU_22F2A98, 0x22F36DC
.definelabel EU_22F3318, 0x22F3F5C
.definelabel EU_22F3324, 0x22F3F68
.definelabel EU_22F7C44, 0x22F8858
.definelabel EU_22F7C5C, 0x22F8870
.definelabel EU_22F8A40, 0x22F95F4
.definelabel EU_2302A18, 0x230353C
.definelabel EU_2302A2C, 0x2303550
.definelabel EU_2302A3C, 0x2303560
.definelabel EU_2302A48, 0x230356C
.definelabel EU_2302A54, 0x2303578
.definelabel EU_2302A58, 0x230357C
.definelabel EU_2302B58, 0x230367C
.definelabel EU_2302B6C, 0x2303690
.definelabel EU_2302B7C, 0x23036A0
.definelabel EU_2302B90, 0x23036B4
.definelabel EU_2302B9C, 0x23036C0
.definelabel EU_2302BA0, 0x23036C4
.definelabel EU_230338C, 0x2303EB0
.definelabel EU_2304544, 0x2305068
.definelabel EU_230A614, 0x230B180
.definelabel EU_230E5D8, 0x230F0A4
.definelabel EU_2310C54, 0x231171C
.definelabel EU_2310CF0, 0x23117B8
.definelabel EU_23118B8, 0x2312380
.definelabel EU_2311A60, 0x2312528
.definelabel EU_23118E0, 0x23123A8
.definelabel EU_231873C, 0x23191AC
.definelabel EU_23187A0, 0x2319210
.definelabel EU_233B3F4, 0x233BBD4
.definelabel EU_2340E48, 0x2341624
.definelabel EU_2341008, 0x23417E4
.definelabel EU_2342064, 0x2342840
.definelabel EU_2344A54, 0x2345234
.definelabel EU_2344AA0, 0x2345280
.definelabel EU_234C2FC, 0x234C96C
.definelabel EU_234DAF0, 0x234E154
.definelabel EU_2354138, 0x23547B8

; Functions
	; arm9.bin
	.definelabel fn_NitroMain,                  0x2000C6C
	.definelabel fn_loadOverlayFallback,        0x2003D2C
	.definelabel fn_EU_2008194,                 0x2008194
	.definelabel fn_EU_2013AF8,                 0x2013A20
	.definelabel fn_EU_2025B90,                 0x20258A4
	.definelabel fn_deleteMoveMenu,             0x2030B94
	.definelabel fn_setMoveData,                0x203FD58
	.definelabel fn_createMoveMenu,             0x2040518
	.definelabel fn_deallocMoveMenu,            0x2040B4C
	.definelabel fn_getGroundVar,               0x204B84C
	.definelabel fn_getPerfomanceProgress,      0x204CDF4
	.definelabel fn_addExtraPokemon,            0x204FC34
	.definelabel CanEnemyEvolve,                0x2051750
	.definelabel fn_getSpeciesIQGroup,          0x2052E60
	.definelabel fn_getOverlayData,             0x207FF84
	.definelabel fn_loadOverlayInRam,           0x2080080
	.definelabel fn_EU_2080254,                 0x20801A4

	; overlay_0029.bin
	.definelabel fn_EU_22E15F8,                 0x22E2348
	.definelabel fn_waitFrame,                  0x22EB648
	.definelabel fn_setDispMode,                0x22EBA90
	.definelabel EvolveMonster,                 0x23051CC
	.definelabel RestoreMovePP,                 0x23190F0
	.definelabel fn_EU_22F399C,                 0x22F45DC
	.definelabel fn_EU_230DB90,                 0x230E65C
	.definelabel fn_hideMap,                    0x233B60C
	.definelabel GenerateMaze,                  0x2341818
	.definelabel fn_sendMessageWithIDCheckULog, 0x234C514

; Other
.definelabel EU_237D294, 237D914h

; Registers
ApplyDamageAttackerRegister equ r8

; Offsets
BellyOffset equ 42h
MoveBitfieldOffset equ 120h
MoveIDOffset equ 124h
EnemyEvoOffset equ 14fh
StatTableOffset equ 0A4h