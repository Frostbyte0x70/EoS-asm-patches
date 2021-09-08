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

; This patch changes the way the game stores which IQ skills each IQ group learns to remove the maximum of 25 skills per group
; It has the side effect of causing IQ skills to be sorted by ID in the IQ skills menu
; WARNING: If applied, any changes manually made to this data will be lost

; This file is intended to be used with armips v0.11
; Required ROM: Explorers of Sky (EU/US)
; Required files: arm9.bin, overlay_0029.bin

.nds
.include "common/regionSelect.asm"

.open "arm9.bin", arm9
; Write compressed IQ data (instead of listing the ID of all the skills, it uses a bit array)
.org EU_20A2314
.area 0x20A24A4 - 0x20A2314
.byte \
0x8E, 0x91, 0xF2, 0x8D, 0x60, 0x00, 0x40, 0x42, 0x0E, \ ; Group A
0x8E, 0x81, 0xFA, 0x49, 0x41, 0x40, 0x9C, 0x40, 0x04, \ ; Group B
0x8E, 0x03, 0xD2, 0x01, 0x34, 0x91, 0x03, 0x99, 0x04, \ ; Group C
0xAC, 0x41, 0xFC, 0xA5, 0x80, 0x49, 0x01, 0x90, 0x01, \ ; Group D
0x9C, 0x85, 0xD1, 0x01, 0xB9, 0xA0, 0xB4, 0x01, 0x00, \ ; Group E
0x8E, 0x99, 0xD4, 0xB5, 0x40, 0x72, 0x00, 0x02, 0x04, \ ; Group F
0xAC, 0x43, 0xDC, 0x95, 0x00, 0x0A, 0x60, 0x18, 0x03, \ ; Group G
0xAC, 0x95, 0xD4, 0x49, 0x41, 0x20, 0xB8, 0x01, 0x01, \ ; Group H
0x8C, 0x01, 0xD0, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, \ ; Unused group 1
0x8C, 0x01, 0xD0, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, \ ; Unused group 2
0xAC, 0x93, 0xD4, 0xA1, 0x34, 0x81, 0xA0, 0x14, 0x00, \ ; Group I
0x9C, 0xA9, 0xD1, 0x85, 0x18, 0x62, 0x01, 0x12, 0x02, \ ; Group J
0x8C, 0x01, 0xD0, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, \ ; Unused group 3
0x8C, 0x01, 0xD0, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, \ ; Unused group 4
0x8C, 0x01, 0xD0, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, \ ; Unused group 5
0x8C, 0x01, 0xD0, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00    ; Unused group 6
.align 4
; The rest of this area is now free space that we can use to store extra instructions

; -----------------
; Checks if a given pokémon species can learn the specified IQ skill
; r0: Species ID
; r1: ID of the skill to check
; ret r0: 1 if the species can learn the IQ skill specified, 0 otherwise
; -----------------
canLearnSkill:
	push r4,lr
	mov r4,r1
	bl fn_getSpeciesIQGroup
	ldr r1,=EU_20A2314
	mov r2,9h
	mla r0,r0,r2,r1
	mov r1,r4
	bl arrayContainsSkill
	pop r4,pc
.pool

.endarea

; -----------------
; Checks if a given IQ group skill list contains the specified IQ skill
; r0: Pointer to the bit array of the group to check
; r1: ID of the skill to check
; ret r0: 1 if the group can learn the IQ skill specified, 0 otherwise
; 
; This function overwrites another that is no longer needed after applying this patch
; -----------------
.org EU_20591E4
.area 0x2059208 - 0x20591E4
arrayContainsSkill:
	add r0,r0,r1,lsr 3h ; r0: Pointer to the byte that contains the skill to check
	and r2,r1,7h ; r2: Number of the bit to check
	mov r1,1h
	mov r1,r1,lsl r2 ; r1: Bit to check
	ldrb r2,[r0]
	tst r2,r1
	moveq r0,0h
	movne r0,1h
	bx lr
.endarea

; -----------------
; Patch the function used by the game to get the list of skills learnt by a pokémon
; -----------------
.org EU_205909C
	mov r11,9h
.org EU_20590AC
	mla r0,r0,r11,r4
	mov r1,r5
	bl arrayContainsSkill
	cmp r0,0h
	beq EU_20590EC ; Next iteration
	cmp r5,18h
.org EU_20590D8
	mov r1,r5
.org EU_20590E4
	strneb r5,[r10,r6]
.org EU_20590F0
	cmp r5,45h

; -----------------
; Rewrite the function that returns the next IQ skill that a pokémon will learn
; -----------------
.org EU_20592A0
	push r3-r8,lr
.org EU_20592B0
	mov r1,9h
	mla r12,r0,r1,r2
	mov r8,0h
	mov r7,r8
	mov r3,1h ; Skill #0 isn't checked
	ldr r6,[EU_205931C]
@@loop:
	mov r0,r12
	mov r1,r3
	bl arrayContainsSkill
	cmp r0,0h
	beq @@nextIter
	ldr r5,[r6,r3,lsl 2h]
	cmp r5,r4
	ble @@nextIter
	cmp r7,0h
	beq @@L1
	cmp r5,r7
	bge @@nextIter
@@L1:
	mov r7,r5,lsl 10h
	mov r8,r3
	mov r7,r7,asr 10h
@@nextIter:
	add r3,r3,1h
	cmp r3,45h
	blt @@loop
	mov r0,r8
	pop r3-r8,pc

.close

.open "overlay_0029.bin", ov_29
; -----------------
; Patch the function used to save changes made in the IQ skills menu of a pokémon
; -----------------
.org EU_2302B58
	bl canLearnSkill
	cmp r0,0h
	beq EU_2302B9C ; Next iteration
	nop
.org EU_2302B6C
	mov r1,r6
.org EU_2302B7C
	mov r1,r6
.org EU_2302B90
	mov r1,r6
.org EU_2302BA0
	cmp r6,45h

; -----------------
; Patch the function used to set enemy IQ skills (It's the same as the previous one, just a different area)
; -----------------
.org EU_2302A18
	bl canLearnSkill
	cmp r0,0h
	beq EU_2302A54 ; Next iteration
	nop
.org EU_2302A2C
	mov r1,r6
.org EU_2302A3C
	mov r1,r6
.org EU_2302A48
	mov r1,r6
.org EU_2302A58
	cmp r6,45h

.close