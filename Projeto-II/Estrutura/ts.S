    .global start, stack_top, label2
start:
    b _Reset @posição 0x00 - Reset
    ldr pc, _undefined_instruction @posição 0x04 - Intrução não-definida
    ldr pc, _software_interrupt @posição 0x08 - Interrupção de Software
    ldr pc, _prefetch_abort @posição 0x0C - Prefetch Abort
    ldr pc, _data_abort @posição 0x10 - Data Abort
    ldr pc, _not_used @posição 0x14 - Não utilizado
    ldr pc, _irq @posição 0x18 - Interrupção (IRQ)
    ldr pc, _fiq @posição 0x1C - Interrupção(FIQ)

    _undefined_instruction: .word undefined_instruction
    _software_interrupt: .word software_interrupt
    _prefetch_abort: .word prefetch_abort
    _data_abort: .word data_abort
    _not_used: .word not_used

    _irq: .word irq
    _fiq: .word fiq

    INTPND: .word 0x10140000 @Interrupt status register
    INTSEL: .word 0x1014000C @interrupt select register( 0 = irq, 1 = fiq)
    INTEN: .word 0x10140010 @interrupt enable register
    TIMER0L: .word 0x101E2000 @Timer 0 load register
    TIMER0V: .word 0x101E2004 @Timer 0 value registers
    TIMER0C: .word 0x101E2008 @timer 0 control register
    TIMER0X: .word 0x101E200c @timer 0 interrupt clear register
_Reset:
    ldr sp, =stack_top @ sp = &stack_top, as soon as we have the stack ready, we can call C function
    bl main
    b .
undefined_instruction:
  b .

software_interrupt:
  b . @vai para o handler de interrupções de software

prefetch_abort:
  b .

data_abort:
  b .

not_used:
  b .

irq:
  b do_irq_interrupt @vai para o handler de interrupções IRQ

fiq:
  b .

do_irq_interrupt: @Rotina de interrupções IRQ
  stmfd sp!, {r0 - r3} @Empilha os registradores

  ldr r0, INTPND @ Carrega o registrador de status de interrupção
  ldr r0, [r0]
  tst r0, #0x0010 @ verifica se é uma interupção de timer
  @stmfd sp!, {pc}         @ salva pc na pilha do modo de interrupções
  blne timer_handler @ vai para o rotina de tratamento da interupção de timer
  
