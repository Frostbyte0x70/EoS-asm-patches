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

; This hack allows using each of the leader's 4 moves with L+A, L+B, L+X and L+Y, in that order.
; The shortcut to open the message log is moved from L+B to Y+X

; This file is intended to be used with armips v0.11
; Required ROM: Explorers of Sky, european version
; Required files: arm9.bin, overlay_0029.bin

.nds
; #####################################
; ##             Functions           ##
; #####################################
.open "overlay_0029.bin", 0x022DCB80
; We overwrite the code that would normally check which move is set and store the index in r4, or show a message if no move is set
.org 0x22F2470
.area 0x22F24E0 - 0x22F2470

; -----------------
; Check if L+BXY is pressed and select the corresponding attack if it's the case
; If Y is pressed, this code also bypasses the X check to open the menu (so it doesn't try to open the menu when Y+X is pressed,
; since that's the new shortcut to open the message log)
; -----------------
moveShortcuts:
	; Available registers: r0, r1
	ldr r0,=237D294h ; This value must stay here when returning, since it's needed by the code that checks if X is pressed to open the menu
	ldrh r1,[r0]
	tst r1,200h ; Check if L is pressed
	beq @@noL
	ldrh r1,[r0,2h]
	tst r1,2h ; Check if B has been pressed in this frame
	movne r4,1h
	bne 22F24E0h ; Uses the move indicated by r4. Branching here guarantees a break from the loop that checks for player input,
	; so we don't have to worry about what happens next.
	tst r1,400h ; Check if X has been pressed in this frame
	movne r4,2h
	bne 22F24E0h
	tst r1,800h ; Check if Y has been pressed in this frame
	movne r4,3h
	bne 22F24E0h
	b @@originalRet; We could branch to 22F26C4h because we know X isn't pressed so it's not necessary to perform the check to open the menu,
	; but I'll leave it like this for compatibility
@@noL:
	tst r1,800h ; Check if Y is pressed
	bne 22F26C4h ; If so, skip the check to open the menu
@@originalRet:
	bx lr

; -----------------
; Disables the grid when pressing Y+X to open the message log
; -----------------
removeGrid:
	beq 22F2844h ; Original instruction: If X isn't pressed, don't open the message log
	push r2,lr
	bl 233836Ch ; Hides the grid. Preserves r3-r8.
	ldr r1,=237D5A6h
	mov r0,0h
	strb r0,[r1]
	pop r2,pc

.pool
.endarea

; #####################################
; ##          Hooks / Patches        ##
; #####################################
; -----------------
; Optimize the code that goes after the area we have overwritten to obtain extra instructions
; -----------------
.org 0x22F24E0
	mov r3,0h
.org 0x22F24F0
	movne r0,1h
	moveq r0,0h

; -----------------
; Make L+A always use the first move instead of whichever is set
; -----------------
.org 0x22F246C
	; Previous instruction: mov r4,0h
	b 22F24E0h

; -----------------
; Other buttons hook
; -----------------
.org 0x22F2694
	bl moveShortcuts

; -----------------
; Set Y+X as the message log shortcut
; -----------------
.org 0x22F27F8
	tst r0,800h
.org 0x22F2808
	tst r0,400h
	bl removeGrid

.close

; -----------------
; Patch: Show a button icon next to the move names indicating which button each move is associated with
; (replaces the checkmark that used to indicate that a move was set)
; -----------------
.open "arm9.bin", 0x02000000
.org 0x201367C
.area 0x20136A4 - 0x201367C
	; Reorder and optimize some instructions from the original code
	bl 2025B90h
	str r0,[sp]
	
	; Available registers: r0, r1, r5
	
	; The address of the text representing the icon to show has to end up in r8. In this case, we use a string stored down here
	; that we modify depending on the index of the current move (stored in r9)
	add r8,=@@buttonIcon
	mov r0,'2'
	add r0,r0,r9
	strb r0,[r8,4h] ; Replace the '?' character
	
	mov r0,r6 ; From the original code
	b 0x20136A4 ; Resume normal execution
	
	@@buttonIcon:
	; The '?' is replaced at runtime with 2-5 depending on the index of the move
	.ascii "[M:B?]", 0
	.align 4
.endarea
; Move down a couple of instructions from the original code so we can get extra space
.org 0x20136A4
	bl 2013AF8h
	add r1,r13,10h
	;str r5 [r13] - No longer needed since we stored this before
	
.close
