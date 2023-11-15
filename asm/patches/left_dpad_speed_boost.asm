
; Changes how the left-dpad button works.
; When pressed (not held) it should give the player a burst of speed.
.open "sys/main.dol"
.org 0x80234BF8 ; In dScnPly_Draw
  b left_dpad_speed_boost ; branch to our code

.org @NextFreeSpace
.global left_dpad_speed_boost
left_dpad_speed_boost:
  lis r3, 0x803ED84C@ha ; Bitfield of buttons pressed this frame
  addi r3, r3, 0x803ED84C@l ; Bitfield of buttons pressed this frame
  lwz r0, 0 (r3) ; load the value of the bitfields by pointer with offset 0
  li r3, 0x01 ; D-pad left bitfield
  and r0, r0, r3 ; AND to get which buttons in the combo are currently being pressed
  cmpw r0, r3 ; Check to make sure all of the buttons in the combo are pressed
  bne RETURN_FROM_LEFT_DPAD_SPEED_BOOST ; If not, return to old code

  ; 803CA754,4 pointer to link
  ; 0x35bc player speed offset
  ; load the player pointer
  lis r3, 0x803CA754@ha ; load a static pointer to the player pointer
  addi r3, r3, 0x803CA754@l ; load a static pointer to the player pointer
  lwz r3, 0 (r3) ; load the actual pointer to the player

  lis r0, 0x44c80000@ha ; set the speed value f32(1600.0) to r0

  stw r0, 0x35bc (r3) ; set the speed value to the player + speed offset

; pointer and rewrite of what we overwrote
.global RETURN_FROM_LEFT_DPAD_SPEED_BOOST
RETURN_FROM_LEFT_DPAD_SPEED_BOOST:
  lha r0, 8 (r27) ; Replace a line of code we overwrote to jump here
  ; Return to normal code
  lis r3, 0x80234BFC@ha
  addi r3, r3, 0x80234BFC@l
  mtctr r3
  bctrl
  ; 
.close
