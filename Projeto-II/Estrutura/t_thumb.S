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
	.code	16
	.file	"t.c"
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
	.comm	uart,32,4
	.text
	.align	2
	.global	uart_init
	.code	16
	.thumb_func
	.type	uart_init, %function
uart_init:
	push	{r7, lr}
	sub	sp, sp, #8
	add	r7, sp, #0
	mov	r3, #0
	str	r3, [r7, #4]
	b	.L2
.L3:
	ldr	r3, [r7, #4]
	lsl	r2, r3, #3
	ldr	r3, .L4
	add	r3, r2, r3
	str	r3, [r7]
	ldr	r3, [r7, #4]
	ldr	r2, .L4+4
	add	r3, r3, r2
	lsl	r3, r3, #12
	mov	r2, r3
	ldr	r3, [r7]
	str	r2, [r3]
	ldr	r3, [r7]
	ldr	r2, [r7, #4]
	str	r2, [r3, #4]
	ldr	r3, [r7, #4]
	add	r3, r3, #1
	str	r3, [r7, #4]
.L2:
	ldr	r3, [r7, #4]
	cmp	r3, #3
	ble	.L3
	ldr	r3, .L4
	ldr	r2, .L4+8
	str	r2, [r3, #24]
	mov	r0, r3
	mov	sp, r7
	add	sp, sp, #8
	@ sp needed for prologue
	pop	{r7, pc}
.L5:
	.align	2
.L4:
	.word	uart
	.word	66033
	.word	268472320
	.size	uart_init, .-uart_init
	.align	2
	.global	ugetc
	.code	16
	.thumb_func
	.type	ugetc, %function
ugetc:
	push	{r7, lr}
	sub	sp, sp, #8
	add	r7, sp, #0
	str	r0, [r7, #4]
	mov	r8, r8
.L7:
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	add	r3, r3, #24
	ldrb	r3, [r3]
	mov	r2, r3
	mov	r3, #16
	and	r3, r2
	bne	.L7
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	ldrb	r3, [r3]
	mov	r0, r3
	mov	sp, r7
	add	sp, sp, #8
	@ sp needed for prologue
	pop	{r7, pc}
	.size	ugetc, .-ugetc
	.align	2
	.global	uputc
	.code	16
	.thumb_func
	.type	uputc, %function
uputc:
	push	{r7, lr}
	sub	sp, sp, #8
	add	r7, sp, #0
	str	r0, [r7, #4]
	mov	r2, r1
	add	r3, r7, #3
	strb	r2, [r3]
	mov	r8, r8
.L9:
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	add	r3, r3, #24
	ldrb	r3, [r3]
	mov	r2, r3
	mov	r3, #32
	and	r3, r2
	bne	.L9
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	add	r2, r7, #3
	ldrb	r2, [r2]
	strb	r2, [r3]
	mov	sp, r7
	add	sp, sp, #8
	@ sp needed for prologue
	pop	{r7, pc}
	.size	uputc, .-uputc
	.align	2
	.global	upgets
	.code	16
	.thumb_func
	.type	upgets, %function
upgets:
	push	{r7, lr}
	sub	sp, sp, #8
	add	r7, sp, #0
	str	r0, [r7, #4]
	str	r1, [r7]
	b	.L11
.L12:
	ldr	r3, [r7]
	ldrb	r3, [r3]
	ldr	r2, [r7, #4]
	mov	r0, r2
	mov	r1, r3
	bl	uputc
	ldr	r3, [r7]
	add	r3, r3, #1
	str	r3, [r7]
.L11:
	ldr	r3, [r7, #4]
	mov	r0, r3
	bl	ugetc
	mov	r3, r0
	mov	r2, r3
	ldr	r3, [r7]
	strb	r2, [r3]
	ldr	r3, [r7]
	ldrb	r3, [r3]
	cmp	r3, #13
	bne	.L12
	ldr	r3, [r7]
	mov	r2, #0
	strb	r2, [r3]
	mov	sp, r7
	add	sp, sp, #8
	@ sp needed for prologue
	pop	{r7, pc}
	.size	upgets, .-upgets
	.align	2
	.global	uprints
	.code	16
	.thumb_func
	.type	uprints, %function
uprints:
	push	{r7, lr}
	sub	sp, sp, #8
	add	r7, sp, #0
	str	r0, [r7, #4]
	str	r1, [r7]
	b	.L14
.L15:
	ldr	r3, [r7]
	ldrb	r3, [r3]
	ldr	r2, [r7]
	add	r2, r2, #1
	str	r2, [r7]
	ldr	r2, [r7, #4]
	mov	r0, r2
	mov	r1, r3
	bl	uputc
.L14:
	ldr	r3, [r7]
	ldrb	r3, [r3]
	cmp	r3, #0
	bne	.L15
	mov	sp, r7
	add	sp, sp, #8
	@ sp needed for prologue
	pop	{r7, pc}
	.size	uprints, .-uprints
	.align	2
	.global	strcmp
	.code	16
	.thumb_func
	.type	strcmp, %function
strcmp:
	push	{r7, lr}
	sub	sp, sp, #8
	add	r7, sp, #0
	str	r0, [r7, #4]
	str	r1, [r7]
	mov	r8, r8
.L18:
	ldr	r3, [r7, #4]
	ldrb	r2, [r3]
	ldr	r3, [r7]
	ldrb	r3, [r3]
	sub	r3, r2, r3
	neg	r2, r3
	adc	r3, r3, r2
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	ldr	r2, [r7, #4]
	add	r2, r2, #1
	str	r2, [r7, #4]
	ldr	r2, [r7]
	add	r2, r2, #1
	str	r2, [r7]
	cmp	r3, #0
	beq	.L17
	ldr	r3, [r7, #4]
	ldrb	r3, [r3]
	cmp	r3, #0
	beq	.L17
	ldr	r3, [r7]
	ldrb	r3, [r3]
	cmp	r3, #0
	bne	.L18
.L17:
	ldr	r3, [r7, #4]
	ldrb	r3, [r3]
	cmp	r3, #0
	bne	.L19
	ldr	r3, [r7]
	ldrb	r3, [r3]
	cmp	r3, #0
	bne	.L19
	mov	r3, #0
	b	.L20
.L19:
	mov	r3, #1
.L20:
	mov	r0, r3
	mov	sp, r7
	add	sp, sp, #8
	@ sp needed for prologue
	pop	{r7, pc}
	.size	strcmp, .-strcmp
	.section	.rodata
	.align	2
.LC2:
	.ascii	"\012\015Enter lines from serial terminal 0\012\015\000"
	.align	2
.LC4:
	.ascii	"\012\015[You have input:] \000"
	.align	2
.LC6:
	.ascii	"\012\015\000"
	.align	2
.LC8:
	.ascii	"end\000"
	.align	2
.LC10:
	.ascii	"Compute sum of array:\012\015\000"
	.align	2
.LC14:
	.ascii	"sum = \000"
	.global	__aeabi_idiv
	.global	__aeabi_idivmod
	.align	2
.LC16:
	.ascii	"\012\015END OF RUN\012\015\000"
	.text
	.align	2
	.global	main
	.code	16
	.thumb_func
	.type	main, %function
main:
	push	{r7, lr}
	sub	sp, sp, #72
	add	r7, sp, #0
	bl	uart_init
	ldr	r3, .L28
	str	r3, [r7, #64]
	ldr	r2, [r7, #64]
	ldr	r3, .L28+4
	mov	r0, r2
	mov	r1, r3
	bl	uprints
	b	.L24
.L27:
	mov	r8, r8
.L24:
	ldr	r2, [r7, #64]
	mov	r3, r7
	mov	r0, r2
	mov	r1, r3
	bl	upgets
	ldr	r2, [r7, #64]
	ldr	r3, .L28+8
	mov	r0, r2
	mov	r1, r3
	bl	uprints
	ldr	r2, [r7, #64]
	mov	r3, r7
	mov	r0, r2
	mov	r1, r3
	bl	uprints
	ldr	r2, [r7, #64]
	ldr	r3, .L28+12
	mov	r0, r2
	mov	r1, r3
	bl	uprints
	mov	r2, r7
	ldr	r3, .L28+16
	mov	r0, r2
	mov	r1, r3
	bl	strcmp
	mov	r3, r0
	bne	.L27
	mov	r8, r8
	ldr	r2, [r7, #64]
	ldr	r3, .L28+20
	mov	r0, r2
	mov	r1, r3
	bl	uprints
	ldr	r3, .L28+24
	mov	r2, #0
	str	r2, [r3]
	mov	r3, #0
	str	r3, [r7, #68]
	b	.L25
.L26:
	ldr	r3, .L28+28
	ldr	r2, [r7, #68]
	lsl	r2, r2, #2
	ldr	r2, [r2, r3]
	ldr	r3, .L28+24
	ldr	r3, [r3]
	add	r2, r2, r3
	ldr	r3, .L28+24
	str	r2, [r3]
	ldr	r3, [r7, #68]
	add	r3, r3, #1
	str	r3, [r7, #68]
.L25:
	ldr	r3, [r7, #68]
	cmp	r3, #9
	ble	.L26
	ldr	r2, [r7, #64]
	ldr	r3, .L28+32
	mov	r0, r2
	mov	r1, r3
	bl	uprints
	ldr	r3, .L28+24
	ldr	r3, [r3]
	mov	r0, r3
	mov	r1, #10
	bl	__aeabi_idiv
	mov	r3, r0
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	add	r3, r3, #48
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	ldr	r2, [r7, #64]
	mov	r0, r2
	mov	r1, r3
	bl	uputc
	ldr	r3, .L28+24
	ldr	r3, [r3]
	mov	r0, r3
	mov	r1, #10
	bl	__aeabi_idivmod
	mov	r3, r1
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	add	r3, r3, #48
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	ldr	r2, [r7, #64]
	mov	r0, r2
	mov	r1, r3
	bl	uputc
	ldr	r2, [r7, #64]
	ldr	r3, .L28+36
	mov	r0, r2
	mov	r1, r3
	bl	uprints
	mov	r0, r3
	mov	sp, r7
	add	sp, sp, #72
	@ sp needed for prologue
	pop	{r7, pc}
.L29:
	.align	2
.L28:
	.word	uart
	.word	.LC2
	.word	.LC4
	.word	.LC6
	.word	.LC8
	.word	.LC10
	.word	sum
	.word	v
	.word	.LC14
	.word	.LC16
	.size	main, .-main
	.ident	"GCC: (Sourcery CodeBench Lite 2011.09-69) 4.6.1"
