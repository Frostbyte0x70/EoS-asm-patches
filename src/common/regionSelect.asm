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

; ########################
; Specify the game region of the ROM you want to apply the patches to here. Valid values: "US" and "EU"
_REGION equ "EU"
; ########################


.relativeinclude on
.if _REGION == "US"
	.notice "Applying patch for rom region: USA"
.elseif _REGION == "EU"
	.notice "Applying patch for rom region: EUROPE"
.else
	.error "Invalid region specified"
.endif

; The equs inside the offset files can't be inside a conditional directive so we have to do this instead
.include "offsets" + _REGION + ".asm"

.relativeinclude off