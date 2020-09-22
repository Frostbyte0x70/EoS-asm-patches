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

; File load addresses
arm9 equ 0x02000000
ov_29 equ 0x022DCB80

; arm9.bin
.definelabel EU_201367C , 0x201367C
.definelabel EU_20136A4 , 0x20136A4

; overlay_0029.bin
.definelabel EU_22F2470, 0x22F2470
.definelabel EU_22F24E0, 0x22F24E0
.definelabel EU_22F24F0, 0x22F24F0
.definelabel EU_22F246C, 0x22F246C
.definelabel EU_22F2694, 0x22F2694
.definelabel EU_22F27F8, 0x22F27F8
.definelabel EU_22F2808, 0x22F2808

; Functions
; Prefixed with fn_ to differentiate them from labels declared inside the hacks
.definelabel fn_EU_2025B90, 2025B90h
.definelabel fn_EU_2013AF8 , 2013AF8h

; Other
.definelabel EU_237D294, 237D294h