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
	.align	2
	.global	strcpy
	.code	16
	.thumb_func
	.type	strcpy, %function
strcpy:
	push	{r7, lr}
	sub	sp, sp, #8
	add	r7, sp, #0
	str	r0, [r7, #4]
	str	r1, [r7]
	b	.L22
.L23:
	ldr	r3, [r7]
	ldrb	r2, [r3]
	ldr	r3, [r7, #4]
	strb	r2, [r3]
	ldr	r3, [r7, #4]
	add	r3, r3, #1
	str	r3, [r7, #4]
	ldr	r3, [r7]
	add	r3, r3, #1
	str	r3, [r7]
.L22:
	ldr	r3, [r7]
	ldrb	r3, [r3]
	cmp	r3, #0
	bne	.L23
	ldr	r3, [r7, #4]
	mov	r2, #0
	strb	r2, [r3]
	ldr	r3, [r7, #4]
	mov	r0, r3
	mov	sp, r7
	add	sp, sp, #8
	@ sp needed for prologue
	pop	{r7, pc}
	.size	strcpy, .-strcpy
	.align	2
	.global	strlen
	.code	16
	.thumb_func
	.type	strlen, %function
strlen:
	push	{r7, lr}
	sub	sp, sp, #16
	add	r7, sp, #0
	str	r0, [r7, #4]
	mov	r3, #0
	str	r3, [r7, #12]
	b	.L25
.L26:
	ldr	r3, [r7, #12]
	add	r3, r3, #1
	str	r3, [r7, #12]
.L25:
	ldr	r3, [r7, #4]
	ldrb	r3, [r3]
	sub	r2, r3, #1
	sbc	r3, r3, r2
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	ldr	r2, [r7, #4]
	add	r2, r2, #1
	str	r2, [r7, #4]
	cmp	r3, #0
	bne	.L26
	ldr	r3, [r7, #12]
	mov	r0, r3
	mov	sp, r7
	add	sp, sp, #16
	@ sp needed for prologue
	pop	{r7, pc}
	.size	strlen, .-strlen
	.align	2
	.global	timer_init_single
	.code	16
	.thumb_func
	.type	timer_init_single, %function
timer_init_single:
	push	{r7, lr}
	sub	sp, sp, #8
	add	r7, sp, #0
	str	r0, [r7, #4]
	str	r1, [r7]
	ldr	r2, [r7]
	ldr	r3, [r7, #4]
	str	r2, [r3]
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	mov	r2, #0
	str	r2, [r3]
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	add	r3, r3, #4
	mov	r2, #1
	neg	r2, r2
	str	r2, [r3]
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	add	r3, r3, #16
	mov	r2, #0
	str	r2, [r3]
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	add	r3, r3, #20
	mov	r2, #0
	str	r2, [r3]
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	mov	r2, #128
	lsl	r2, r2, #1
	str	r2, [r3]
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	add	r3, r3, #8
	mov	r2, #102
	str	r2, [r3]
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	add	r3, r3, #24
	mov	r2, #224
	lsl	r2, r2, #5
	str	r2, [r3]
	mov	r3, #0
	ldr	r2, [r7, #4]
	str	r3, [r2, #16]
	ldr	r2, [r7, #4]
	str	r3, [r2, #12]
	mov	r2, r3
	ldr	r3, [r7, #4]
	str	r2, [r3, #8]
	ldr	r3, [r7, #4]
	str	r2, [r3, #4]
	mov	sp, r7
	add	sp, sp, #8
	@ sp needed for prologue
	pop	{r7, pc}
	.size	timer_init_single, .-timer_init_single
	.align	2
	.global	timer_start
	.code	16
	.thumb_func
	.type	timer_start, %function
timer_start:
	push	{r7, lr}
	sub	sp, sp, #16
	add	r7, sp, #0
	str	r0, [r7, #4]
	ldr	r2, [r7, #4]
	mov	r3, r2
	lsl	r3, r3, #3
	add	r3, r3, r2
	lsl	r3, r3, #2
	mov	r2, r3
	ldr	r3, .L29
	add	r3, r2, r3
	str	r3, [r7, #12]
	ldr	r3, [r7, #12]
	ldr	r2, [r3]
	mov	r3, r2
	add	r3, r3, #8
	add	r2, r2, #8
	ldr	r2, [r2]
	mov	r1, #128
	orr	r2, r1
	str	r2, [r3]
	mov	sp, r7
	add	sp, sp, #16
	@ sp needed for prologue
	pop	{r7, pc}
.L30:
	.align	2
.L29:
	.word	timer
	.size	timer_start, .-timer_start
	.align	2
	.global	timer_stop
	.code	16
	.thumb_func
	.type	timer_stop, %function
timer_stop:
	push	{r7, lr}
	sub	sp, sp, #16
	add	r7, sp, #0
	str	r0, [r7, #4]
	ldr	r2, [r7, #4]
	mov	r3, r2
	lsl	r3, r3, #3
	add	r3, r3, r2
	lsl	r3, r3, #2
	mov	r2, r3
	ldr	r3, .L32
	add	r3, r2, r3
	str	r3, [r7, #12]
	ldr	r3, [r7, #12]
	ldr	r2, [r3]
	mov	r3, r2
	add	r3, r3, #8
	add	r2, r2, #8
	ldr	r1, [r2]
	mov	r2, #127
	and	r2, r1
	str	r2, [r3]
	mov	sp, r7
	add	sp, sp, #16
	@ sp needed for prologue
	pop	{r7, pc}
.L33:
	.align	2
.L32:
	.word	timer
	.size	timer_stop, .-timer_stop
	.align	2
	.global	timer_clearInterrupt
	.code	16
	.thumb_func
	.type	timer_clearInterrupt, %function
timer_clearInterrupt:
	push	{r7, lr}
	sub	sp, sp, #16
	add	r7, sp, #0
	str	r0, [r7, #4]
	ldr	r2, [r7, #4]
	mov	r3, r2
	lsl	r3, r3, #3
	add	r3, r3, r2
	lsl	r3, r3, #2
	mov	r2, r3
	ldr	r3, .L35
	add	r3, r2, r3
	str	r3, [r7, #12]
	ldr	r3, [r7, #12]
	ldr	r3, [r3]
	add	r3, r3, #12
	mov	r2, #1
	neg	r2, r2
	str	r2, [r3]
	mov	sp, r7
	add	sp, sp, #16
	@ sp needed for prologue
	pop	{r7, pc}
.L36:
	.align	2
.L35:
	.word	timer
	.size	timer_clearInterrupt, .-timer_clearInterrupt
	.global	__aeabi_uidivmod
	.global	__aeabi_uidiv
	.align	2
	.global	timer_handler
	.code	16
	.thumb_func
	.type	timer_handler, %function
timer_handler:
	push	{r7, lr}
	sub	sp, sp, #16
	add	r7, sp, #0
	str	r0, [r7, #4]
	ldr	r2, [r7, #4]
	mov	r3, r2
	lsl	r3, r3, #3
	add	r3, r3, r2
	lsl	r3, r3, #2
	mov	r2, r3
	ldr	r3, .L40
	add	r3, r2, r3
	str	r3, [r7, #12]
	ldr	r3, [r7, #12]
	ldr	r3, [r3, #4]
	add	r2, r3, #1
	ldr	r3, [r7, #12]
	str	r2, [r3, #4]
	ldr	r3, [r7, #12]
	ldr	r3, [r3, #4]
	cmp	r3, #20
	bne	.L38
	ldr	r3, [r7, #12]
	mov	r2, #0
	str	r2, [r3, #4]
	ldr	r3, [r7, #12]
	ldr	r3, [r3, #16]
	add	r2, r3, #1
	ldr	r3, [r7, #12]
	str	r2, [r3, #16]
	ldr	r3, [r7, #12]
	ldr	r3, [r3, #16]
	cmp	r3, #60
	bne	.L39
	ldr	r3, [r7, #12]
	mov	r2, #0
	str	r2, [r3, #16]
	ldr	r3, [r7, #12]
	ldr	r3, [r3, #12]
	add	r2, r3, #1
	ldr	r3, [r7, #12]
	str	r2, [r3, #12]
	ldr	r3, [r7, #12]
	ldr	r3, [r3, #12]
	cmp	r3, #60
	bne	.L39
	ldr	r3, [r7, #12]
	mov	r2, #0
	str	r2, [r3, #12]
	ldr	r3, [r7, #12]
	ldr	r3, [r3, #8]
	add	r2, r3, #1
	ldr	r3, [r7, #12]
	str	r2, [r3, #8]
.L39:
	ldr	r3, [r7, #12]
	ldr	r3, [r3, #16]
	mov	r0, r3
	mov	r1, #10
	bl	__aeabi_uidivmod
	mov	r3, r1
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	add	r3, r3, #48
	lsl	r3, r3, #24
	lsr	r2, r3, #24
	ldr	r3, [r7, #12]
	strb	r2, [r3, #27]
	ldr	r3, [r7, #12]
	ldr	r3, [r3, #16]
	mov	r0, r3
	mov	r1, #10
	bl	__aeabi_uidiv
	mov	r3, r0
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	add	r3, r3, #48
	lsl	r3, r3, #24
	lsr	r2, r3, #24
	ldr	r3, [r7, #12]
	strb	r2, [r3, #26]
	ldr	r3, [r7, #12]
	ldr	r3, [r3, #12]
	mov	r0, r3
	mov	r1, #10
	bl	__aeabi_uidivmod
	mov	r3, r1
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	add	r3, r3, #48
	lsl	r3, r3, #24
	lsr	r2, r3, #24
	ldr	r3, [r7, #12]
	strb	r2, [r3, #24]
	ldr	r3, [r7, #12]
	ldr	r3, [r3, #12]
	mov	r0, r3
	mov	r1, #10
	bl	__aeabi_uidiv
	mov	r3, r0
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	add	r3, r3, #48
	lsl	r3, r3, #24
	lsr	r2, r3, #24
	ldr	r3, [r7, #12]
	strb	r2, [r3, #23]
	ldr	r3, [r7, #12]
	ldr	r3, [r3, #8]
	mov	r0, r3
	mov	r1, #10
	bl	__aeabi_uidivmod
	mov	r3, r1
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	add	r3, r3, #48
	lsl	r3, r3, #24
	lsr	r2, r3, #24
	ldr	r3, [r7, #12]
	strb	r2, [r3, #21]
	ldr	r3, [r7, #12]
	ldr	r3, [r3, #8]
	mov	r0, r3
	mov	r1, #10
	bl	__aeabi_uidiv
	mov	r3, r0
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	add	r3, r3, #48
	lsl	r3, r3, #24
	lsr	r2, r3, #24
	ldr	r3, [r7, #12]
	strb	r2, [r3, #20]
.L38:
	ldr	r3, [r7, #4]
	mov	r0, r3
	bl	timer_clearInterrupt
	mov	sp, r7
	add	sp, sp, #16
	@ sp needed for prologue
	pop	{r7, pc}
.L41:
	.align	2
.L40:
	.word	timer
	.size	timer_handler, .-timer_handler
	.section	.rodata
	.align	2
.LC7:
	.ascii	"\012\015Enter lines from serial terminal 0\012\015\000"
	.align	2
.LC9:
	.ascii	"   \000"
	.align	2
.LC11:
	.ascii	"\012\015\000"
	.align	2
.LC13:
	.ascii	"end\000"
	.align	2
.LC15:
	.ascii	"Compute sum of array:\012\015\000"
	.align	2
.LC19:
	.ascii	"sum = \000"
	.global	__aeabi_idiv
	.global	__aeabi_idivmod
	.align	2
.LC21:
	.ascii	"h:\000"
	.align	2
.LC23:
	.ascii	" m:\000"
	.align	2
.LC25:
	.ascii	" s:\000"
	.align	2
.LC27:
	.ascii	"\012\015END OF RUN\012\015\000"
	.text
	.align	2
	.global	main
	.code	16
	.thumb_func
	.type	main, %function
main:
	push	{r7, lr}
	sub	sp, sp, #96
	add	r7, sp, #0
	ldr	r3, .L49
	str	r3, [r7, #88]
	ldr	r2, [r7, #88]
	ldr	r3, .L49+4
	mov	r0, r2
	mov	r1, r3
	bl	timer_init_single
	bl	uart_init
	ldr	r3, .L49+8
	str	r3, [r7, #84]
	mov	r0, #0
	bl	timer_start
	ldr	r2, [r7, #84]
	ldr	r3, .L49+12
	mov	r0, r2
	mov	r1, r3
	bl	uprints
	b	.L45
.L48:
	mov	r8, r8
.L45:
	ldr	r2, [r7, #84]
	add	r3, r7, #4
	mov	r0, r2
	mov	r1, r3
	bl	upgets
	ldr	r2, [r7, #84]
	ldr	r3, .L49+16
	mov	r0, r2
	mov	r1, r3
	bl	uprints
	ldr	r2, [r7, #84]
	add	r3, r7, #4
	mov	r0, r2
	mov	r1, r3
	bl	uprints
	ldr	r2, [r7, #84]
	ldr	r3, .L49+20
	mov	r0, r2
	mov	r1, r3
	bl	uprints
	add	r2, r7, #4
	ldr	r3, .L49+24
	mov	r0, r2
	mov	r1, r3
	bl	strcmp
	mov	r3, r0
	bne	.L48
	mov	r8, r8
	ldr	r3, [r7, #88]
	ldr	r3, [r3, #8]
	str	r3, [r7, #80]
	ldr	r3, [r7, #88]
	ldr	r3, [r3, #12]
	str	r3, [r7, #76]
	ldr	r3, [r7, #88]
	ldr	r3, [r3, #16]
	str	r3, [r7, #72]
	ldr	r3, [r7, #80]
	mov	r2, #225
	lsl	r2, r2, #4
	mov	r1, r2
	mul	r1, r3
	ldr	r2, [r7, #76]
	mov	r3, r2
	lsl	r3, r3, #4
	sub	r3, r3, r2
	lsl	r3, r3, #2
	add	r2, r1, r3
	ldr	r3, [r7, #72]
	add	r3, r2, r3
	str	r3, [r7, #68]
	ldr	r2, [r7, #84]
	ldr	r3, .L49+28
	mov	r0, r2
	mov	r1, r3
	bl	uprints
	ldr	r3, .L49+32
	mov	r2, #0
	str	r2, [r3]
	mov	r3, #0
	str	r3, [r7, #92]
	b	.L46
.L47:
	ldr	r3, .L49+36
	ldr	r2, [r7, #92]
	lsl	r2, r2, #2
	ldr	r2, [r2, r3]
	ldr	r3, .L49+32
	ldr	r3, [r3]
	add	r2, r2, r3
	ldr	r3, .L49+32
	str	r2, [r3]
	ldr	r3, [r7, #92]
	add	r3, r3, #1
	str	r3, [r7, #92]
.L46:
	ldr	r3, [r7, #92]
	cmp	r3, #9
	ble	.L47
	ldr	r2, [r7, #84]
	ldr	r3, .L49+40
	mov	r0, r2
	mov	r1, r3
	bl	uprints
	ldr	r3, .L49+32
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
	ldr	r2, [r7, #84]
	mov	r0, r2
	mov	r1, r3
	bl	uputc
	ldr	r3, .L49+32
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
	ldr	r2, [r7, #84]
	mov	r0, r2
	mov	r1, r3
	bl	uputc
	ldr	r2, [r7, #84]
	ldr	r3, .L49+28
	mov	r0, r2
	mov	r1, r3
	bl	uprints
	ldr	r2, [r7, #84]
	ldr	r3, .L49+44
	mov	r0, r2
	mov	r1, r3
	bl	uprints
	ldr	r3, [r7, #80]
	mov	r0, r3
	mov	r1, #10
	bl	__aeabi_uidiv
	mov	r3, r0
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	add	r3, r3, #48
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	ldr	r2, [r7, #84]
	mov	r0, r2
	mov	r1, r3
	bl	uputc
	ldr	r3, [r7, #80]
	mov	r0, r3
	mov	r1, #10
	bl	__aeabi_uidivmod
	mov	r3, r1
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	add	r3, r3, #48
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	ldr	r2, [r7, #84]
	mov	r0, r2
	mov	r1, r3
	bl	uputc
	ldr	r2, [r7, #84]
	ldr	r3, .L49+48
	mov	r0, r2
	mov	r1, r3
	bl	uprints
	ldr	r3, [r7, #76]
	mov	r0, r3
	mov	r1, #10
	bl	__aeabi_uidiv
	mov	r3, r0
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	add	r3, r3, #48
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	ldr	r2, [r7, #84]
	mov	r0, r2
	mov	r1, r3
	bl	uputc
	ldr	r3, [r7, #76]
	mov	r0, r3
	mov	r1, #10
	bl	__aeabi_uidivmod
	mov	r3, r1
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	add	r3, r3, #48
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	ldr	r2, [r7, #84]
	mov	r0, r2
	mov	r1, r3
	bl	uputc
	ldr	r2, [r7, #84]
	ldr	r3, .L49+52
	mov	r0, r2
	mov	r1, r3
	bl	uprints
	ldr	r3, [r7, #72]
	mov	r0, r3
	mov	r1, #10
	bl	__aeabi_uidiv
	mov	r3, r0
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	add	r3, r3, #48
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	ldr	r2, [r7, #84]
	mov	r0, r2
	mov	r1, r3
	bl	uputc
	ldr	r3, [r7, #72]
	mov	r0, r3
	mov	r1, #10
	bl	__aeabi_uidivmod
	mov	r3, r1
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	add	r3, r3, #48
	lsl	r3, r3, #24
	lsr	r3, r3, #24
	ldr	r2, [r7, #84]
	mov	r0, r2
	mov	r1, r3
	bl	uputc
	ldr	r2, [r7, #84]
	ldr	r3, .L49+56
	mov	r0, r2
	mov	r1, r3
	bl	uprints
	mov	r3, #0
	mov	r0, r3
	mov	sp, r7
	add	sp, sp, #96
	@ sp needed for prologue
	pop	{r7, pc}
.L50:
	.align	2
.L49:
	.word	timer
	.word	270409728
	.word	uart
	.word	.LC7
	.word	.LC9
	.word	.LC11
	.word	.LC13
	.word	.LC15
	.word	sum
	.word	v
	.word	.LC19
	.word	.LC21
	.word	.LC23
	.word	.LC25
	.word	.LC27
	.size	main, .-main
	.ident	"GCC: (Sourcery CodeBench Lite 2011.09-69) 4.6.1"
