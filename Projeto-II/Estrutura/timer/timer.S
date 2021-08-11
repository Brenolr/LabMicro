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
	.file	"timer.c"
	.comm	timer,144,4
	.text
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
.L3:
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
	beq	.L2
	ldr	r3, [fp, #-8]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L2
	ldr	r3, [fp, #-12]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L3
.L2:
	ldr	r3, [fp, #-8]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L4
	ldr	r3, [fp, #-12]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L4
	mov	r3, #0
	b	.L5
.L4:
	mov	r3, #1
.L5:
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
	b	.L7
.L8:
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
.L7:
	ldr	r3, [fp, #-12]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L8
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
	b	.L10
.L11:
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L10:
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
	bne	.L11
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
	ldr	r3, .L13
	mov	r1, r2
	mov	r2, r3
	mov	r3, #9
	mov	r0, r1
	mov	r1, r2
	mov	r2, r3
	bl	memcpy
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
.L14:
	.align	2
.L13:
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
	ldr	r3, .L16
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
.L17:
	.align	2
.L16:
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
	ldr	r3, .L19
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
.L20:
	.align	2
.L19:
	.word	timer
	.size	timer_stop, .-timer_stop
	.align	2
	.global	timer_clearInterrupt
	.type	timer_clearInterrupt, %function
timer_clearInterrupt:
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
	ldr	r3, .L22
	add	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #0]
	add	r3, r3, #12
	mvn	r2, #0
	str	r2, [r3, #0]
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
.L23:
	.align	2
.L22:
	.word	timer
	.size	timer_clearInterrupt, .-timer_clearInterrupt
	.align	2
	.global	timer_handler
	.type	timer_handler, %function
timer_handler:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	ldr	r2, [fp, #-16]
	mov	r3, r2
	mov	r3, r3, asl #3
	add	r3, r3, r2
	mov	r3, r3, asl #2
	mov	r2, r3
	ldr	r3, .L27
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
	bne	.L25
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
	bne	.L26
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
	bne	.L26
	ldr	r3, [fp, #-8]
	mov	r2, #0
	str	r2, [r3, #12]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #8]
	add	r2, r3, #1
	ldr	r3, [fp, #-8]
	str	r2, [r3, #8]
.L26:
	ldr	r3, [fp, #-8]
	ldr	r1, [r3, #16]
	ldr	r3, .L27+4
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
	ldr	r3, .L27+4
	umull	r1, r3, r2, r3
	mov	r3, r3, lsr #3
	and	r3, r3, #255
	add	r3, r3, #48
	and	r2, r3, #255
	ldr	r3, [fp, #-8]
	strb	r2, [r3, #26]
	ldr	r3, [fp, #-8]
	ldr	r1, [r3, #12]
	ldr	r3, .L27+4
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
	ldr	r3, .L27+4
	umull	r1, r3, r2, r3
	mov	r3, r3, lsr #3
	and	r3, r3, #255
	add	r3, r3, #48
	and	r2, r3, #255
	ldr	r3, [fp, #-8]
	strb	r2, [r3, #23]
	ldr	r3, [fp, #-8]
	ldr	r1, [r3, #8]
	ldr	r3, .L27+4
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
	ldr	r3, .L27+4
	umull	r1, r3, r2, r3
	mov	r3, r3, lsr #3
	and	r3, r3, #255
	add	r3, r3, #48
	and	r2, r3, #255
	ldr	r3, [fp, #-8]
	strb	r2, [r3, #20]
.L25:
	ldr	r0, [fp, #-16]
	bl	timer_clearInterrupt
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
.L28:
	.align	2
.L27:
	.word	timer
	.word	-858993459
	.size	timer_handler, .-timer_handler
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	mov	r3, #0
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	main, .-main
	.ident	"GCC: (Sourcery CodeBench Lite 2011.09-69) 4.6.1"
