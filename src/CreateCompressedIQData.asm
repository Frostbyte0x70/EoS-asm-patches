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

; This patch can be used to automatically create a compressed version of the list of IQ skills learnt by each IQ groups needed for the CompressIQData patch.
; Applying this patch will break the game, make sure to have a backup

; This file is intended to be used with armips v0.11
; Required ROM: Explorers of Sky (EU)
; Required files: arm9.bin

.nds

.open "arm9.bin", 0x2000000
; Overwrite ground item lists
.org 0x209FD60
.area 0x20A1058 - 0x209FD60
result:
	; Area where the result will be written
	.fill 9 * 16, 0
.align 4

; -----------------
; Creates the bit array for each IQ group
; -----------------
createArray:
	ldr r4,=0x20A2314 ; r4: Pointer to the IQ skill data
	add r5,=result ; r5: Current entry being written in the result area
	mov r6,0h ; r6: Current IQ group ID
	; Iterate IQ groups
@@groupLoop:
	mov r0,25 ; Skills per group
	mla r3,r6,r0,r4 ; r3: Pointer to the current group
	mov r7,0h ; r7: Skill index inside the current group
	; Iterate skills inside the group
@@skillLoop:
	ldrb r0,[r3,r7] ; r0: Current skill ID
	cmp r0,0FFh
	beq @@nextIterGroup
	
	; Set the bit corresponding to this skill in the result
	mov r1,r0,lsr 3h ; r1: Byte offset inside the current result entry
	and r2,r0,7h ; r2: Number of the bit to set
	mov r0,1h
	mov r0,r0,lsl r2 ; r0: Bit to set
	ldrb r2,[r5,r1]
	orr r2,r2,r0
	strb r2,[r5,r1]
	
	add r7,r7,1h
	cmp r7,25
	blt @@skillLoop
@@nextIterGroup:
	add r6,r6,1h
	add r5,r5,9h
	cmp r6,10h
	blt @@groupLoop
.ascii "CRASH GOES HERE"
.pool
.endarea

; Hook the function that would normally process the overwritten ground lists and call our code instead
; This can be triggered by checking the mission board
.org 0x200E0DC
	b createArray

.close