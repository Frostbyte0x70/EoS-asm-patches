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

; This patch can be used to automatically create the dungeon data table needed for the EditExtraPokemon patch by calling the function that
; runs before going into a dungeon repeatedly with all the possible dungeon IDs.
; Applying this patch will break the game, make sure to have a backup

; This file is intended to be used with armips v0.11
; Required ROM: Explorers of Sky (EU)
; Required files: arm9.bin

.nds

.open "arm9.bin", 0x2000000
; Overwrite ground item lists
.org 0x209FD60
.area 0x20A1058 - 0x209FD60
data:
	; Values set during the execution
	; If an additional pokémon is added to the team, the index of the entry read will be stored here
	.word 0
	; Same but if a second entry is read in the same iteration
	.word 0
	; 1 if SIDE01_BOSS2ND was checked
	.byte 0
.align 4

; -----------------
; Creates the dungeon data table
; r7 contains the pointer to the dungeon properties to set and can't be overwritten
; -----------------
createTable:
	mov r6,0h ; r6: Current dungeon ID
	add r8,=table ; r9: Current entry being written in the table
@@loop:
	add r1,=data
	mvn r0,0h
	str r0,[r1]
	str r0,[r1,4h]
	mov r0,0h
	strb r0,[r1,8h]
	; Call the part of the code that initalizes additional pokémon
	bl 0x204EEE4
	; Now look at what happened and build the current entry from that
	; r2: Value for the current entry
	mov r2,0h
	
	; [data] contains the index of the first entry that was read from the table, or -1 if none was read.
	add r0,=data
	ldr r0,[r0]
	mvn r1,0h
	cmp r0,r1
	beq @@checkR4
	mov r2,r0
	; [data+4] contains the index of the second entry that was read from the table, or -1 if only the first one was read.
	add r0,=data
	ldr r0,[r0,4h]
	mvn r1,0h
	cmp r0,r1
	orrne r2,r2,r0,lsl 8h
	; [data+8] = 1 means SIDE01_BOSS2ND was checked
	add r0,=data
	ldrb r0,[r0,8h]
	cmp r0,1h
	moveq r0,8000h
	orreq r2,r2,r0
@@checkR4:
	; r4 = 1 means Hidden Land restrictions have been enabled
	cmp r4,1h
	moveq r0,80h
	orreq r2,r2,r0
	; r5 = 1 means recruitment has been disabled
	cmp r5,1h
	moveq r0,40h
	orreq r2,r2,r0
	; If the dungeon ID is between 0x26 and 0x2B (Hidden Land - Temporal Pinnacle), we have to enable Hidden Land restrictions
	; on subsequent visits to the dungeon
	cmp r6,26h
	blt @@nextIter
	cmp r6,2Bh
	bgt @@nextIter
	mov r0,4000h
	orr r2,r2,r0
@@nextIter:
	; Save the current entry
	strh r2,[r8]
	; Increment counters
	add r6,r6,1h
	add r8,r8,2h
	cmp r6,0B4h
	blt @@loop
.ascii "CRASH GOES HERE"
.align 4

; -----------------
; Patch the function that reads ground mode variables to make it write a 1 to [data+8] if the variable read
; is 10h (SIDE01_BOSS2ND)
; -----------------
getGroundVarHook:
	mov r1,r2 ; Original instruction
	cmp r4,10h
	bxne lr
	ldr r0,=data
	mov r2,1h
	strb r2,[r0,8h]
	; Simulate a return 0 so the pokémon is always added
	mov r0,0h
	add sp,sp,8h ; space allocated by getGroundVar
	pop r4,pc
.pool

; -----------------
; This is the area where the table will be written
; -----------------
.align 16
table:
	.fill 0xB4 * 2, 0
	.ascii "END"
.endarea

.org 0x204EECC
	b createTable
.org 0x204EEE4
	push r6,r8,lr
.org 0x204F26C
	pop r6,r8,pc
; Remove the PERFOMANCE_PROGRESS_LIST check in Brine Cave
.org 0x204F168
	nop

; -----------------
; Overwrite the function that normally adds additional pokémon to the team to make it write the entry index to [data]
; or [data+4] instead
; r1: 0 if this is the first pokémon added to the team, 1 if it's the second
; r2: Pointer to the entry to read
; -----------------
.org 0x204FC18
.area 0x204FC90 - 0x204FC18
	push r3,r4,lr
	mov r4,r1
	ldr r0,=0x20A2E40 ; Address of the first entry
	sub r0,r2,r0
	mov r1,24h
	bl 0x209023C ; Division
	; r0: Entry index
	; Add 1 since 0 is used to represent that no pokémon will be added to the team
	add r0,r0,1h
	ldr r1,=data
	cmp r4,0h
	streq r0,[r1]
	strne r0,[r1,4h]
	pop r3,r4,pc
.pool

.endarea

.org 0x204B834
	bl getGroundVarHook

; Disable ground item lists processing
.org 0x200E0DC
	bx lr

.close