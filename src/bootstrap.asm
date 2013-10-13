;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; BOOTLOADER EXECUTABLE CODE
;
; This file contains the exectuable portion of the bootloader. It is included 
; automatically into the boot sector and copied across.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Entry point for our bootloader
start:

; Print our Hello World
mov	si, szHello
call printk

; End
cli ; Clear interrupts
hlt ; Halt

; Print a null-terminated string in si
printk:
	lodsb
	or al, al
	jz @f
	mov ah, 0x0e
	int 0x10
	jmp printk
@@:
	ret

; Null-terminated string
szHello db "Hello, World!", 0x00
