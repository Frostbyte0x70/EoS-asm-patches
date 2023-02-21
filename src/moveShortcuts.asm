; ----------------------------------------------------------------------
; Copyright © 2022 End45
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

; This hack allows using each of the leader's 4 moves with L+A, L+B, L+X and L+Y, in that order.
; The shortcut to open the message log is moved from L+B to B+Y

; This file is intended to be used with armips v0.11
; The patch "ExtraSpace.asm" must be applied before this one
; Required ROM: Explorers of Sky (EU/US)
; Required files: arm9.bin, overlay_0029.bin, overlay_0036.bin

.nds
.include "common/regionSelect.asm"
; #####################################
; ##             Functions           ##
; #####################################
.open "overlay_0029.bin", ov_29
; We overwrite the code that would normally check which move is set and store the index in r4, or show a message if no move is set
.org EU_22F2470
.area EU_22F24E0 - EU_22F2470

; -----------------
; Checks if L+BXY is pressed and selects the corresponding move if it's the case
; Also displays/hides the move dialogue box
; -----------------
moveShortcuts:
	; Available registers: r0-r3
	ldr r0,=EU_237D294 ; This value must stay here when returning, since it's needed by the code that checks if X is pressed to open the menu
	ldrh r1,[r0]
	tst r1,200h ; Check if L is pressed
	beq @@ret
	mov r0,r6
	bl showMoveDB
	ldr r0,=EU_237D294
	ldrh r1,[r0,2h]
	tst r1,2h ; Check if B has been pressed in this frame
	movne r4,1h
	bne EU_22F24E0 ; Uses the move indicated by r4. Branching here guarantees a break from the loop that checks for player input,
	; so we don't have to worry about what happens next.
	tst r1,400h ; Check if X has been pressed in this frame
	movne r4,2h
	bne EU_22F24E0
	tst r1,800h ; Check if Y has been pressed in this frame
	movne r4,3h
	bne EU_22F24E0
	tst r1,100h ; Check if R has been pressed in this frame
	; Check this since we won't check any input after that
	bne @@throw
	; Here we directly branch to the end to avoid conflicts with other actions
	; (move with D-Pad or stylus, open menus, etc.)
	b EU_22F3318
@@throw:
	; Branch to the code that handles throwing rocks
	bl hideMoveDB
	b EU_22F2A98
@@ret:
	; If L is not pressed, resume the execution
	bl hideMoveDB
	ldr r0,=EU_237D294
	b afterShortcuts

.pool
.endarea

; #####################################
; ##          Hooks / Patches        ##
; #####################################
; -----------------
; Optimize the code that goes after the area we have overwritten to obtain extra instructions
; -----------------
.org EU_22F24E0
	bl checkMoveHook

.org EU_22F24F0
	movne r0,1h
	moveq r0,0h

; -----------------
; Make L+A always use the first move instead of whichever is set
; -----------------
.org EU_22F246C
	; Previous instruction: mov r4,0h
	b EU_22F24E0

; -----------------
; Hide the dialogue box if L is not pressed but A is
; -----------------
.org EU_22F25FC
	bl hookHideMove

; -----------------
; Other buttons hook
; -----------------
.org EU_22F2694
	b moveShortcuts
afterShortcuts:

; -----------------
; Set B+Y as the message log shortcut
; -----------------
.org EU_22F27F8
	tst r0,2h
.org EU_22F2808
	tst r0,800h

; -----------------
; Prevent the bag from opening if the L button is pressed (this can happen if you press L+B but the move associated with the B button can't be used)
; -----------------
; In order to get the extra space needed to implement the L check, a section above the place where the game checks if the bag should be opened is optimized
.org EU_22F26EC
.area EU_22F2748 - EU_22F26EC
; Original code shifted up 8 instructions
	bl fn_EU_22E15F8
	cmp r0,0h
	beq @L1
	mov r0,0h
	mov r1,1h
	strb r1,[r13,0B6h]
	strb r0,[r13,0B7h]
	strb r0,[r13,0B8h]
	strb r0,[r13,0B9h]
	strb r0,[r13,0BAh]
	b EU_22F3324
@L1:
	ldr r1,[EU_22F27A4] ; Change destination register so we can keep this value
	ldrh r0,[r1,6h]
	tst r0,2h
	beq EU_22F2764 ; If B isn't pressed, don't open the bag
	; Patch: If L is pressed, don't open the bag
	ldrh r0,[r1]
	tst r0,200h
	bne EU_22F2764
	b EU_22F2748 ; Else jump to the original code and continue normal execution
.endarea

; Update jump destination to account for the instruction shift
.org EU_22F26CC
	beq @L1


; -----------------
; Hide the dialogue box if stench is active
; -----------------
.org EU_22F2424
    bl hookHideMoveStench

; -----------------
; Prevent passing turn by pressing A+B if the move dialogue box is open
; -----------------
.org EU_22F1D18
.area 0x22F1D44 - .
	ldr r0,=move_shown
	ldr r0,[r0]
	mvn r1,1h
	cmp r0,r1
	bne EU_22F1D64
	; Original code, optimized
	ldr r1,[sp,8Ch]
	ldrh r0,[r1,46h]
	ldrh r1,[r1,48h]
	orrs r0,r0,r1 ; OR the belly and belly thousandths together to check if they are both zero
	b @@afterPool
.pool
@@afterPool:
.endarea

.org EU_22F23CC
.area 0x22F23F8 - .
	ldr r0,=move_shown
	ldr r0,[r0]
	mvn r1,1h
	cmp r0,r1
	bne EU_22F2418
	; Original code, optimized
	ldr r1,[sp,8Ch]
	ldrh r0,[r1,46h]
	ldrh r1,[r1,48h]
	orrs r0,r0,r1 ; OR the belly and belly thousandths together to check if they are both zero
	b @@afterPool
.pool
@@afterPool:
.endarea

.close

; -----------------
; Patch: Show a button icon next to the move names indicating which button each move is associated with
; (replaces the checkmark that used to indicate that a move was set)
; -----------------
.open "arm9.bin", arm9
.org EU_201367C
.area EU_20136A4 - EU_201367C
	; Reorder and optimize some instructions from the original code
	bl fn_EU_2025B90
	str r0,[sp]
	
	; Available registers: r0, r1, r5
	
	; The address of the text representing the icon to show has to end up in r8. In this case, we use a string stored down here
	; that we modify depending on the index of the current move (stored in r9)
	add r8,=@@buttonIcon
	mov r0,'2'
	add r0,r0,r9
	strb r0,[r8,4h] ; Replace the '?' character
	
	mov r0,r6 ; From the original code
	b EU_20136A4 ; Resume normal execution
	
	@@buttonIcon:
	; The '?' is replaced at runtime with 2-5 depending on the index of the move
	.ascii "[M:B?]", 0
	.align 4
.endarea
; Move down a couple of instructions from the original code so we can get extra space
.org EU_20136A4
	bl fn_EU_2013AF8
	add r1,r13,10h
	;str r5 [r13] - No longer needed since we stored this before
	
.close

; -----------------
; Uses overlay 36 to implement additional functions & hooks
; -----------------
.open "overlay_0036.bin", ov_36

.org ov_36+500h
.area ov_36+62Ch - (ov_36+500h)

showMoveDB: ; Shows the move dialogue box, if hidden
	push r4,lr
	mov r4,r0
	ldr r1,=move_shown
	ldr r0,[r1]
	mvn r2,1h
	cmp r0,r2
	bne @@ret
	mov r0,6h
	mov r1,0h
	bl fn_setDispMode
	mov r0,0h
	bl fn_hideMap
	mov r0,62h
	bl fn_waitFrame
	mov r0,62h
	bl fn_waitFrame
	ldr r0,=0x0A120202
	ldr r1,=EU_209CE8C
	str r0,[r1]
	mov r0,r4
	bl fn_setMoveData
	mov r0,7h
	mov r1,0h
	mov r2,0h
	bl fn_createMoveMenu
	ldr r1,=move_shown
	str r0,[r1]
@@ret:
	pop r4,pc

hideMoveDB: ; Hides the move dialogue box, if shown
	push lr
	ldr r1,=move_shown
	ldr r0,[r1]
	mvn r2,1h
	cmp r0,r2
	beq @@ret
	str r2,[r1]
	bl fn_deleteMoveMenu
	bl fn_deallocMoveMenu
	mov r0,62h
	bl fn_waitFrame
	mov r0,62h
	bl fn_waitFrame
	mov r0,0h
	mov r1,r0
	bl fn_setDispMode
	ldr r0,=0x0A120D02
	ldr r1,=EU_209CE8C
	str r0,[r1]
@@ret:
	pop pc
.pool

hookHideMove:
	push lr
	bl hideMoveDB
	ldr r0,[sp,38h]
	pop pc

checkMoveHook: ; Checks if the selected move exists and is not part of a link combo
	push lr
	add r0,r9,r4,lsl 3h
	ldrb r1,[r0,124h]
	tst r1,1h ; Exists
	addeq sp,sp,4h
	beq EU_22F3324 ; Don't use if it doesn't exist
	tst r1,2h ; Is Linked
	addne sp,sp,4h
	bne EU_22F3324 ; Don't use if it's linked to the previous move
	bl hideMoveDB
	mov r3,0h
	pop pc
move_shown:
	.word 0xFFFFFFFE

hookHideMoveStench:
    push r4,lr
    mov r4,r0
    cmp r4,0h
    blne hideMoveDB
    cmp r4,0h
    pop r4,pc

.endarea

.close
