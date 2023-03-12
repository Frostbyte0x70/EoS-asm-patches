; ----------------------------------------------------------------------
; Copyright © 2023 End45
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

; This patch updates the stats, level and moves of evolved enemies to match those of its new species

; This file is intended to be used with armips v0.11
; The patch "ExtraSpace.asm" must be applied before this one
; Required ROM: Explorers of Sky (EU/US)
; Required files: overlay_0029.bin, overlay_0036.bin

; Patch parameters:
;	_UpdateStats: True to update the level and stats of the evolved enemy
;	_FullHeal: True to fully heal the evolved enemy
;	_UpdateMoves: True to reroll the moves of the evolved enemy using the learnset of the new species
;	_StatBoost: After evolving, the enemy will have its Atk/SpAtk/Def/SpDef increased by this amount (0-255)
;	_EvolveWithRevive: True to allow enemies to evolve even if the pokémon they defeat is revived

.nds
.include "common/regionSelect.asm"

.open "overlay_0036.bin", ov_36

.orga 0x11A0
.area 0x150
; -----------------
; Evolves an enemy.
; If _UpdateStats is != 0, the stats of the enemy are set to the stats of its evolution. The level is also updated.
; If _FullHeal is != 0, the enemy is fully healed.
; If _UpdateMoves is != 0, the moves of the enemy are rerolled according to its evolution's learnset
; The enemy's Atk/SpAtk/Def/SpDef are increased by an amount equal to _StatBoost
; r0, r10: Pointer to the entity struct of the pokémon to evolve
; -----------------
evolve:
	push r2-r9,lr
	sub sp,sp,8h
	; r0 and r1 must remain unchanged before this call
	bl EvolveMonster
	ldr r5,[r10,0B4h] ; r5 = Pointer to the pokémon's monster struct
	ldrh r1,[r5,2h] ; r1 = New species ID
	; Access the table that contains the stats of the pokémon that spawn on this floor
	ldr r6,=EU_2354138
	ldr r6,[r6]
	add r6,0F4h
	add r6,3400h ; r6 = Start of the stats table
	; Loop the entries in the table until we find the species we are looking for (or until we reach the end, although that shouldn't happen since
	; the game won't try to evolve an enemy if its evolution can't be found in the current floor's enemy spawn table)
	mov r4,40h ; r4 = Max amount of iterations
@@loop:
	ldrsh r3,[r6]
	cmp r3,0h
	beq @@ret
	cmp r3,r1
	bne @@nextIter
	; We found the entry corresponding to the current species. We copy the stats to the data of the pokémon and increase them if required
.if _UpdateStats != 0
	; Update max HP
	ldrh r0,[r6,0Ch]
	strh r0,[r5,12h]
.endif
	; Update the rest of the stats
	mov r7,0h ; r7 = Loop index
.if _UpdateStats != 0
	add r8,r6,0Eh ; r8 = Source base address
.else
	add r8,r5,1Ah ; r8 = Source base address
.endif
	add r9,r5,1Ah ; r9 = Destination base address
@@copyStatsLoop:
	ldrb r3,[r8,r7]
	add r3,r3,_StatBoost
	cmp r3,0FFh
	movgt r3,0FFh
	strb r3,[r9,r7]
	add r7,r7,1h
	cmp r7,4h
	blt @@copyStatsLoop
.if _UpdateStats != 0
	; Update the level of the evolved enemy to match the spawn level of its evolution
	ldrh r2,[r6,2h] ; 2 bytes
	strb r2,[r5,0Ah]
.endif
	; EvolveMonster sets the EXP of the pokémon to the amount it should have at its current level. We set it back to 0 since enemies aren't supposed to have EXP.
	; (This can also cause enemies to unexpectedly level up if the level was changed above)
	mov r0,0h
	str r0,[r5,20h]
.if _FullHeal != 0
	ldrsh r2,[r5,12h]
	ldrsh r3,[r5,16h]
	add r2,r2,r3
	strh r2,[r5,10h] ; Current HP = Max HP
.endif
.if _UpdateMoves != 0
	; Now we reroll the moves of the enemy using the moveset of its new species
	; The ID is already in r1, we don't have to set that
	mov r0,sp
	ldrh r2,[r6,2h]
	bl EU_2304544 ; Picks 4 moves given a species and its level and stores them in the buffer passed in r0
	; Since ldrh doesn't accept a third parameter, we unroll this loop
	add r5,r5,128h
	ldrh r0,[sp]
	strh r0,[r5]
	ldrh r0,[sp,2h]
	strh r0,[r5,8h]
	ldrh r0,[sp,4h]
	strh r0,[r5,10h]
	ldrh r0,[sp,6h]
	strh r0,[r5,18h]
	; Recharge the PP of all the moves
	mov r0,r10
	mov r1,r10
	ldr r2,=3E7h
	mov r3,2h ; Custom parameter value: Fully suppresses all the messages and animations of the function
	bl RestoreMovePP
.endif
	b @@ret
@@nextIter:
	add r6,r6,12h ; Point to the next entry
	subs r4,r4,1h
	bne @@loop
@@ret:
	add sp,sp,8h
	pop r2-r9,pc

; -----------------
; Checks if the parameter passed to RestoreMovePP in r3 is 2 and forces it to return early if so.
; This stops the function from printing messages and displaying an animation
; -----------------
CheckSilentPP:
	cmp r8,2h
	beq EU_23187A0 ; Jump to the end of the function
	cmp r6,0h ; Original instruction
	bx lr

; -----------------
; Checks if a pokémon who just defeated another one that could still revive should evolve
; r10 (r8 in US): Pointer to the entity struct of the pokémon who defeated another one. Can also be a placeholder struct if the fainted pokémon wasn't defeated by another one.
; -----------------
EvolveWithRevive:
	push lr
.if _EvolveWithRevive != 0
	ldr r0,[ApplyDamageAttackerRegister]
	cmp r0,1h ; Ensure that it's a pokémon
	bne @@ret
	ldr r3,[ApplyDamageAttackerRegister,0B4h]
	ldrb r0,[r3,6h]
	cmp r0,1h
	bne @@ret
	; Check if enemy evolution is enabled in this dungeon
	ldr r2,=EU_2354138
	ldr r2,[r2]
	ldrb r0,[r2,748h]
	bl CanEnemyEvolve
	cmp r0,1h
	bne @@ret
	; Set the required flags to allow this enemy to evolve
	mov r0,1h
	strb r0,[r2,0Fh]
	strb r0,[r3,153h]
.endif
@@ret:
	mov r0,0h ; Original instruction
	pop pc

.pool
.endarea

.close


.open "overlay_0029.bin", ov_29

; -----------------
; Evolve hook
; -----------------
.org EU_230338C
	bl evolve

; -----------------
; CheckSilentPP hook
; -----------------
.org EU_231873C
	bl CheckSilentPP


; -----------------
; EvolveWithRevive hook
; -----------------
.org EU_230A614
	bl EvolveWithRevive

.close