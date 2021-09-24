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

; This patch modifies the behaviour of the game when it fails to allocate a new block of memory. Instead of crashing, it will forcefully allocate
; it in the biggest free table entry it can find, ignoring the fact that there's not enough space there.
; If the memory table has no free entries, the game will softlock anyway.
; This patch is meant to help with memory issues caused by custom sprites. It could cause glitches when forcefully allocating memory, but it's still
; better than an unfixable crash.

; This file is intended to be used with armips v0.11
; The patch "ExtraSpace.asm" must be applied before this one
; Required ROM: Explorers of Sky (EU/US)
; Required files: arm9.bin, overlay_0036.bin

.nds
.include "common/regionSelect.asm"

.open "overlay_0036.bin", ov_36
.orga 0x780
.area 0x94
; -----------------
; Finds the biggest free entry in the specified memory table and returns its index. If there isn't a free entry in the table, crashes the game.
; Parameters:
; r0: Address to jump to if a free entry is found
; r4: Pointer to the memory table to check
; r5: Size of the block that must be allocated
; Ret r1: Index inside the table where the block should be allocated
; -----------------
forceAllocate:
	push r6,r7,lr
	mov r7,r0
	ldr r1,[r4,0Ch] ; r1: Number of entries in the table
	ldr r0,[r4,8h] ; r0: Entries data start address
	subs r2,r1,1h
	bmi @@noSpace
	mov r6,18h
	mla r6,r2,r6,r0
	mov r3,0h
	mvn r1,0h
	; r1: ID of the best entry found so far
	; r2: Current entry ID
	; r3: Biggest space found so far
	; r6: Current entry offset
@@loop:
	ldr r0,[r6,4h]
	tst r0,1h
	bne @@nextIter
	ldr r0,[r6,10h]
	cmp r0,r3
	; If this space is bigger, update the best one so far
	movgt r1,r2
	movgt r3,r0
@@nextIter:
	sub r2,r2,1h
	sub r6,r6,18h
	cmp r2,0h
	bge @@loop
	; Check if we found a free slot
	cmp r1,0h
	movge r0,r7
	popge r6,r7,lr
	bxge r0
@@noSpace:
	; If we get here, there are no free entries in the table. Return nothing and let the game crash.
	ldr r0,=EU_20AF7A8 ; Original instruction
	pop r6,r7,pc


; -----------------
; Functions called to initialize the required values for forceAllocate
; -----------------
preForceAllocate1:
	ldr r0,=EU_20011F0
	mov r1,r4
	mov r4,r5
	mov r5,r1
	b forceAllocate

preForceAllocate2:
	ldr r0,=EU_20015B8
	b forceAllocate

.pool
.endarea

.close

.open "arm9.bin", arm9
; -----------------
; forceAllocate hooks
; -----------------
.org EU_2001238
	bl preForceAllocate1

.org EU_20015DC
	bl preForceAllocate2

.close