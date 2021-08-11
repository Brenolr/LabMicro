	.cpu arm926ej-s
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"full.c"
	.global	v
	.data
	.align	2
	.type	v, %object
	.size	v, 40
v:
	.word	1
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6
	.word	7
	.word	8
	.word	9
	.word	10
	.comm	sum,4,4
	.comm	timer,144,4
	.comm	uart,32,4
	.text
	.align	2
	.global	uart_init
	.type	uart_init, %function
uart_init:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L2
.L3:
	ldr	r3, [fp, #-8]
	mov	r2, r3, asl #3
	ldr	r3, .L4
	add	r3, r2, r3
	str	r3, [fp, #-12]
	ldr	r2, [fp, #-8]
	ldr	r3, .L4+4
	add	r3, r2, r3
	mov	r3, r3, asl #12
	mov	r2, r3
	ldr	r3, [fp, #-12]
	str	r2, [r3, #0]
	ldr	r3, [fp, #-12]
	ldr	r2, [fp, #-8]
	str	r2, [r3, #4]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L2:
	ldr	r3, [fp, #-8]
	cmp	r3, #3
	ble	.L3
	ldr	r3, .L4
	ldr	r2, .L4+8
	str	r2, [r3, #24]
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
.L5:
	.align	2
.L4:
	.word	uart
	.word	66033
	.word	268472320
	.size	uart_init, .-uart_init
	.align	2
	.global	ugetc
	.type	ugetc, %function
ugetc:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	mov	r0, r0	@ nop
.L7:
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #0]
	add	r3, r3, #24
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	and	r3, r3, #16
	cmp	r3, #0
	bne	.L7
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #0]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	ugetc, .-ugetc
	.align	2
	.global	uputc
	.type	uputc, %function
uputc:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	mov	r3, r1
	strb	r3, [fp, #-9]
	mov	r0, r0	@ nop
.L9:
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #0]
	add	r3, r3, #24
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	and	r3, r3, #32
	cmp	r3, #0
	bne	.L9
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #0]
	ldrb	r2, [fp, #-9]
	strb	r2, [r3, #0]
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	uputc, .-uputc
	.align	2
	.global	upgets
	.type	upgets, %function
upgets:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	b	.L11
.L12:
	ldr	r3, [fp, #-12]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r0, [fp, #-8]
	mov	r1, r3
	bl	uputc
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L11:
	ldr	r0, [fp, #-8]
	bl	ugetc
	mov	r3, r0
	mov	r2, r3
	ldr	r3, [fp, #-12]
	strb	r2, [r3, #0]
	ldr	r3, [fp, #-12]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #13
	bne	.L12
	ldr	r3, [fp, #-12]
	mov	r2, #0
	strb	r2, [r3, #0]
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
	.size	upgets, .-upgets
	.align	2
	.global	uprints
	.type	uprints, %function
uprints:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	b	.L14
.L15:
	ldr	r3, [fp, #-12]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	ldr	r2, [fp, #-12]
	add	r2, r2, #1
	str	r2, [fp, #-12]
	ldr	r0, [fp, #-8]
	mov	r1, r3
	bl	uputc
.L14:
	ldr	r3, [fp, #-12]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L15
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
	.size	uprints, .-uprints
	.align	2
	.global	strcmp
	.type	strcmp, %function
strcmp:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	mov	r0, r0	@ nop
.L18:
	ldr	r3, [fp, #-8]
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	ldr	r3, [fp, #-12]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r2, r3
	movne	r3, #0
	moveq	r3, #1
	and	r3, r3, #255
	ldr	r2, [fp, #-8]
	add	r2, r2, #1
	str	r2, [fp, #-8]
	ldr	r2, [fp, #-12]
	add	r2, r2, #1
	str	r2, [fp, #-12]
	cmp	r3, #0
	beq	.L17
	ldr	r3, [fp, #-8]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L17
	ldr	r3, [fp, #-12]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L18
.L17:
	ldr	r3, [fp, #-8]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L19
	ldr	r3, [fp, #-12]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L19
	mov	r3, #0
	b	.L20
.L19:
	mov	r3, #1
.L20:
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	strcmp, .-strcmp
	.align	2
	.global	strcpy
	.type	strcpy, %function
strcpy:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	b	.L22
.L23:
	ldr	r3, [fp, #-12]
	ldrb	r2, [r3, #0]	@ zero_extendqisi2
	ldr	r3, [fp, #-8]
	strb	r2, [r3, #0]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L22:
	ldr	r3, [fp, #-12]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L23
	ldr	r3, [fp, #-8]
	mov	r2, #0
	strb	r2, [r3, #0]
	ldr	r3, [fp, #-8]
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	strcpy, .-strcpy
	.align	2
	.global	strlen
	.type	strlen, %function
strlen:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L25
.L26:
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L25:
	ldr	r3, [fp, #-16]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #0
	moveq	r3, #0
	movne	r3, #1
	and	r3, r3, #255
	ldr	r2, [fp, #-16]
	add	r2, r2, #1
	str	r2, [fp, #-16]
	cmp	r3, #0
	bne	.L26
	ldr	r3, [fp, #-8]
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	strlen, .-strlen
	.section	.rodata
	.align	2
.LC0:
	.ascii	"00:00:00\000"
	.text
	.align	2
	.global	timer_init_single
	.type	timer_init_single, %function
timer_init_single:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	ldr	r2, [fp, #-12]
	ldr	r3, [fp, #-8]
	str	r2, [r3, #0]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #0]
	mov	r2, #0
	str	r2, [r3, #0]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #0]
	add	r3, r3, #4
	mvn	r2, #0
	str	r2, [r3, #0]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #0]
	add	r3, r3, #16
	mov	r2, #0
	str	r2, [r3, #0]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #0]
	add	r3, r3, #20
	mov	r2, #0
	str	r2, [r3, #0]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #0]
	mov	r2, #256
	str	r2, [r3, #0]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #0]
	add	r3, r3, #8
	mov	r2, #102
	str	r2, [r3, #0]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #0]
	add	r3, r3, #24
	mov	r2, #7168
	str	r2, [r3, #0]
	mov	r3, #0
	ldr	r2, [fp, #-8]
	str	r3, [r2, #16]
	ldr	r2, [fp, #-8]
	str	r3, [r2, #12]
	ldr	r2, [fp, #-8]
	str	r3, [r2, #8]
	ldr	r2, [fp, #-8]
	str	r3, [r2, #4]
	ldr	r3, [fp, #-8]
	add	r2, r3, #20
	ldr	r3, .L28
	mov	r1, r2
	mov	r2, r3
	mov	r3, #9
	mov	r0, r1
	mov	r1, r2
	mov	r2, r3
	bl	memcpy
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
.L29:
	.align	2
.L28:
	.word	.LC0
	.size	timer_init_single, .-timer_init_single
	.align	2
	.global	timer_start
	.type	timer_start, %function
timer_start:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	ldr	r2, [fp, #-16]
	mov	r3, r2
	mov	r3, r3, asl #3
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, .L31
	add	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #0]
	add	r2, r3, #8
	add	r3, r3, #8
	ldr	r3, [r3, #0]
	orr	r3, r3, #128
	str	r3, [r2, #0]
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
.L32:
	.align	2
.L31:
	.word	timer
	.size	timer_start, .-timer_start
	.align	2
	.global	timer_stop
	.type	timer_stop, %function
timer_stop:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	ldr	r2, [fp, #-16]
	mov	r3, r2
	mov	r3, r3, asl #3
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, .L34
	add	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #0]
	add	r2, r3, #8
	add	r3, r3, #8
	ldr	r3, [r3, #0]
	and	r3, r3, #127
	str	r3, [r2, #0]
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
.L35:
	.align	2
.L34:
	.word	timer
	.size	timer_stop, .-timer_stop
	.align	2
	.global	timer_handler
	.type	timer_handler, %function
timer_handler:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	ldr	r2, [fp, #-16]
	mov	r3, r2
	mov	r3, r3, asl #3
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, .L39
	add	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #4]
	add	r2, r3, #1
	ldr	r3, [fp, #-8]
	str	r2, [r3, #4]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #4]
	cmp	r3, #20
	bne	.L36
	ldr	r3, [fp, #-8]
	mov	r2, #0
	str	r2, [r3, #4]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #16]
	add	r2, r3, #1
	ldr	r3, [fp, #-8]
	str	r2, [r3, #16]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #16]
	cmp	r3, #60
	bne	.L38
	ldr	r3, [fp, #-8]
	mov	r2, #0
	str	r2, [r3, #16]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #12]
	add	r2, r3, #1
	ldr	r3, [fp, #-8]
	str	r2, [r3, #12]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #12]
	cmp	r3, #60
	bne	.L38
	ldr	r3, [fp, #-8]
	mov	r2, #0
	str	r2, [r3, #12]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #8]
	add	r2, r3, #1
	ldr	r3, [fp, #-8]
	str	r2, [r3, #8]
.L38:
	ldr	r3, [fp, #-8]
	ldr	r1, [r3, #16]
	ldr	r3, .L39+4
	umull	r2, r3, r1, r3
	mov	r2, r3, lsr #3
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #1
	rsb	r2, r3, r1
	and	r3, r2, #255
	add	r3, r3, #48
	and	r2, r3, #255
	ldr	r3, [fp, #-8]
	strb	r2, [r3, #27]
	ldr	r3, [fp, #-8]
	ldr	r2, [r3, #16]
	ldr	r3, .L39+4
	umull	r1, r3, r2, r3
	mov	r3, r3, lsr #3
	and	r3, r3, #255
	add	r3, r3, #48
	and	r2, r3, #255
	ldr	r3, [fp, #-8]
	strb	r2, [r3, #26]
	ldr	r3, [fp, #-8]
	ldr	r1, [r3, #12]
	ldr	r3, .L39+4
	umull	r2, r3, r1, r3
	mov	r2, r3, lsr #3
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #1
	rsb	r2, r3, r1
	and	r3, r2, #255
	add	r3, r3, #48
	and	r2, r3, #255
	ldr	r3, [fp, #-8]
	strb	r2, [r3, #24]
	ldr	r3, [fp, #-8]
	ldr	r2, [r3, #12]
	ldr	r3, .L39+4
	umull	r1, r3, r2, r3
	mov	r3, r3, lsr #3
	and	r3, r3, #255
	add	r3, r3, #48
	and	r2, r3, #255
	ldr	r3, [fp, #-8]
	strb	r2, [r3, #23]
	ldr	r3, [fp, #-8]
	ldr	r1, [r3, #8]
	ldr	r3, .L39+4
	umull	r2, r3, r1, r3
	mov	r2, r3, lsr #3
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #1
	rsb	r2, r3, r1
	and	r3, r2, #255
	add	r3, r3, #48
	and	r2, r3, #255
	ldr	r3, [fp, #-8]
	strb	r2, [r3, #21]
	ldr	r3, [fp, #-8]
	ldr	r2, [r3, #8]
	ldr	r3, .L39+4
	umull	r1, r3, r2, r3
	mov	r3, r3, lsr #3
	and	r3, r3, #255
	add	r3, r3, #48
	and	r2, r3, #255
	ldr	r3, [fp, #-8]
	strb	r2, [r3, #20]
.L36:
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
.L40:
	.align	2
.L39:
	.word	timer
	.word	-858993459
	.size	timer_handler, .-timer_handler
	.section	.rodata
	.align	2
.LC1:
	.ascii	"\012\015Enter lines from serial terminal 0\012\015\000"
	.align	2
.LC2:
	.ascii	"   \000"
	.align	2
.LC3:
	.ascii	"\012\015\000"
	.align	2
.LC4:
	.ascii	"end\000"
	.align	2
.LC5:
	.ascii	"Compute sum of array:\012\015\000"
	.align	2
.LC6:
	.ascii	"sum = \000"
	.align	2
.LC7:
	.ascii	"\012\015END OF RUN\012\015\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 80
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #80
	ldr	r0, [fp, #-12]
	ldr	r1, .L48
	bl	timer_init_single
	bl	uart_init
	ldr	r3, .L48+4
	str	r3, [fp, #-16]
	ldr	r0, [fp, #-16]
	ldr	r1, .L48+8
	bl	uprints
	b	.L44
.L47:
	mov	r0, r0	@ nop
.L44:
	sub	r3, fp, #80
	ldr	r0, [fp, #-16]
	mov	r1, r3
	bl	upgets
	ldr	r0, [fp, #-16]
	ldr	r1, .L48+12
	bl	uprints
	sub	r3, fp, #80
	ldr	r0, [fp, #-16]
	mov	r1, r3
	bl	uprints
	ldr	r0, [fp, #-16]
	ldr	r1, .L48+16
	bl	uprints
	sub	r3, fp, #80
	mov	r0, r3
	ldr	r1, .L48+20
	bl	strcmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L47
	mov	r0, r0	@ nop
	ldr	r0, [fp, #-16]
	ldr	r1, .L48+24
	bl	uprints
	ldr	r3, .L48+28
	mov	r2, #0
	str	r2, [r3, #0]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L45
.L46:
	ldr	r3, .L48+32
	ldr	r2, [fp, #-8]
	ldr	r2, [r3, r2, asl #2]
	ldr	r3, .L48+28
	ldr	r3, [r3, #0]
	add	r2, r2, r3
	ldr	r3, .L48+28
	str	r2, [r3, #0]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L45:
	ldr	r3, [fp, #-8]
	cmp	r3, #9
	ble	.L46
	ldr	r0, [fp, #-16]
	ldr	r1, .L48+36
	bl	uprints
	ldr	r3, .L48+28
	ldr	r3, [r3, #0]
	ldr	r2, .L48+40
	smull	r1, r2, r3, r2
	mov	r2, r2, asr #2
	mov	r3, r3, asr #31
	rsb	r3, r3, r2
	and	r3, r3, #255
	add	r3, r3, #48
	and	r3, r3, #255
	ldr	r0, [fp, #-16]
	mov	r1, r3
	bl	uputc
	ldr	r3, .L48+28
	ldr	r1, [r3, #0]
	ldr	r3, .L48+40
	smull	r2, r3, r1, r3
	mov	r2, r3, asr #2
	mov	r3, r1, asr #31
	rsb	r2, r3, r2
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #1
	rsb	r2, r3, r1
	and	r3, r2, #255
	add	r3, r3, #48
	and	r3, r3, #255
	ldr	r0, [fp, #-16]
	mov	r1, r3
	bl	uputc
	ldr	r0, [fp, #-16]
	ldr	r1, .L48+44
	bl	uprints
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
.L49:
	.align	2
.L48:
	.word	270409728
	.word	uart
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	sum
	.word	v
	.word	.LC6
	.word	1717986919
	.word	.LC7
	.size	main, .-main
	.ident	"GCC: (Sourcery CodeBench Lite 2011.09-69) 4.6.1"
