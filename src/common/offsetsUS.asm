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
ov_29 equ 0x022DC240

; arm9.bin
.definelabel EU_201367C , 0x20135D4
.definelabel EU_20136A4 , 0x20135FC

; overlay_0029.bin
.definelabel EU_22F2470, 0x22F1ABC
.definelabel EU_22F24E0, 0x22F1B2C
.definelabel EU_22F24F0, 0x22F1B3C
.definelabel EU_22F246C, 0x22F1AB8
.definelabel EU_22F2694, 0x22F1CE0
.definelabel EU_22F27F8, 0x22F1E44
.definelabel EU_22F2808, 0x22F1E54

; Functions
; Prefixed with fn_ to differentiate them from labels declared inside the hacks
.definelabel fn_EU_2025B90, 20258C4h
.definelabel fn_EU_2013AF8 , 2013A50h

; Other
.definelabel EU_237D294, 237C694h