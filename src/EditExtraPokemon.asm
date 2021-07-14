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

; This patch changes the way the game adds additional pokémon to the team during the first visit to some dungeons. Instead of using a hardcoded entry
; depending on the dungeon ID, it will pull the data from a table.

; This file is intended to be used with armips v0.11
; Required ROM: Explorers of Sky (EU/US)
; Required files: arm9.bin

.nds
.include "common/regionSelect.asm"

.open "arm9.bin", arm9
.org EU_204EF00
.area 0x204F318 - 0x204EF00
; -----------------
; Reads the data that corresponds to the current dungeon from the dungeon data table created when applying this patch
; and uses it to add additional team members and set certain dungeon properties.
; Available registers: r0-r5
; Parameters:
; 	r6: Dungeon ID
; 	r7: Pointer to properties that will be set when entering the dungeon
; -----------------
	add r0,=dungeonEntries
	add r4,r0,r6,lsl 1h ; r4: Pointer to the dungeon data entry
	ldrh r1,[r4] ; r1: Dungeon data entry
	tst r1,80h
	movne r2,1h
	strneb r2,[r7,0Bh] ; Enables Hidden Land restrictions (Can't send home or change leader, if your partner faints you get kicked out of the dungeon)
	tst r1,40h
	movne r2,1h
	strneb r2,[r7,7h] ; Force disables recruiting
	tst r1,8000h
	beq @@continue
	; Get the value of SIDE01_BOSS2ND
	mov r0,0h
	mov r1,10h
	bl fn_getGroundVar
	cmp r0,0h
	bne end
@@continue:
	; Hardcoded: Additional pokémon aren't added to Brine Cave if PERFOMANCE_PROGRESS_LIST[25] = 1. This prevents Chatot from being added
	; to your team if you go back to the start of the dungeon after clearing the first part.
	cmp r6,23h
	bne @@addPokemon
	mov r0,19h
	bl fn_getPerfomanceProgress
	cmp r0,0h
	bne end
@@addPokemon:
	; First additional pokémon
	ldrb r0,[r4]
	and r0,r0,3Fh
	mov r1,0h
	bl addExtraPokemon
	; Second additional pokémon
	ldrb r0,[r4,1h]
	and r0,r0,3Fh
	mov r1,1h
	bl addExtraPokemon
	b end
dungeonCompleted:
	; Determine if the dungeon should have Hidden Land restrictions enabled once completed using the table instead of a hardcoded ID check
	add r0,=dungeonEntries
	add r4,r0,r6,lsl 1h
	ldrb r1,[r4,1h] ; Load just the high byte, we don't need the other one
	tst r1,40h
	mov r0,1h
	strneb r0,[r7,0Bh] ; Enable Hidden Land restrictions
	strb r0,[r7,0Dh] ; Set the dungeon completed value
end:
	mov r0,0h
	strb r0,[r7,4h]
	strb r0,[r7,11h]
	pop r3-r7,pc

; -----------------
; Looks up the extra pokémon data entry specified by r0 - 1 and adds that pokémon to the team as an additional team member.
; The index in r0 will be used to address the table containing this data if the index is <= 12h, or to address the second
; table crated by this patch to hold extra entries if the index is > 12h.
; Parameters:
;	r0: Index of the entry to read + 1. 0 represents an empty entry, in that case this function won't do anything.
;	r1: 0 if this is the first pokémon added, 1 if it's the second
;	r7: Pointer to the dungeon properties structure
; -----------------
addExtraPokemon:
	push r3,lr
	cmp r0,0h
	popeq pc,r3 ; Empty entry
	; Get the actual index
	sub r0,r0,1h
	cmp r0,12h
	ldrlt r2,=EU_20A2E40 ; Start address of the 18 entries present in the base game
	addge r2,=extraEntries ; Start address of the extra entries
	subge r0,r0,12h
	mov r3,24h
	mla r2,r0,r3,r2 ; r2: Pointer to the additional pokémon entry
	mov r0,r7
	; The r1 parameter is already set
	bl fn_addExtraPokemon
	pop r3,pc

.pool

dungeonEntries:
; This is the table that contains the dungeon data entries
; Entry size: 2 bytes
; Amount of entries: 180
; Total size: 0x168 bytes
; Entry format (little-endian): ABXXXXXX CDYYYYYY
;	A: 1 if Hidden Land restrictions should be enabled during the first visit
;	B: 1 to force disable recruitment
;	C: If 1, the extra pokémon will only be added to your team if SIDE01_BOSS2ND is 0
;	D: 1 if Hidden Land restrictions should be enabled after the dungeon is cleared
;	XXXXXX: Additional pokémon data index for the first pokémon added to your team + 1. The index will be used
;	to address the additional data entry. The first 18 will be at the same location as in the original game,
;	the next will be added in the extra space after this table.
;	A value of 0 means that no extra pokémon will be added to the team.
;	YYYYYY: Additional pokémon data index for the second pokémon added to your team + 1.
;	Follows the same format as XXXXX
.byte \
00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, \
03h, 00h, 10h, 00h, 0Fh, 00h, 05h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, \
00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, \
00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, \
06h, 00h, 0Ch, 0Bh, 09h, 00h, 0Ah, 00h, 00h, 00h, 00h, 00h, 4Dh, 40h, 4Dh, 40h, \
4Dh, 40h, 80h, 40h, 80h, 40h, 80h, 40h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, \
00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, \
00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 80h, 00h, 80h, 00h, \
80h, 00h, 80h, 00h, 80h, 00h, 8Eh, 00h, 8Eh, 00h, 8Eh, 00h, 00h, 00h, 00h, 00h, \
00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, \
00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, \
00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, \
00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, \
00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 11h, 00h, \
11h, 00h, 11h, 00h, 11h, 00h, 11h, 00h, 11h, 00h, 11h, 00h, 11h, 00h, 11h, 00h, \
11h, 00h, 11h, 00h, 11h, 00h, 12h, 80h, 04h, 80h, 00h, 00h, 00h, 00h, 00h, 00h, \
01h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 00h, \
00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, \
00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, \
00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, \
00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, \
00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, \
00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h

; The rest of the space will be used to add more additional pokémon data entries
extraEntries:
.fill EU_204F318 - ., 0
.endarea

; Update jump offsets
.org EU_204EED4
	beq dungeonCompleted
.org EU_204EEE4
	b end

.close