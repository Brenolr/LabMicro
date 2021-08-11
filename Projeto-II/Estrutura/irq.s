.global _start
.text

_start:
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

@ task atual (1->A, 2->B)
cur_task: .word 0
@ vetor de registradores da task atual
cur_vec: .word 0

_Reset:
  mrs r0, cpsr                @ salvando o modo corrente em R0
  msr cpsr_ctl, #0b11010010   @ alterando para modo interrupt
  ldr sp, =irq_stack_top  @ a pilha de interrupções de tempo é setada
  msr cpsr, r0                @ retorna para o modo anterior
  ldr sp, =stack_top          @ preparar a pilha do nanokernel

  @ usamos r2, r3 e r4 na inicialização
  stmfd sp!, {r2, r3, r4}

  @ inicializar task A
  ldr r2, =stack_a
  ldr r3, =linha_a
  ldr r4, =task_a
  bl task_init

  @ inicializar task B
  ldr r2, =stack_b
  ldr r3, =linha_b
  ldr r4, =task_b
  bl task_init

  @ preparar task inicial
  ldr r2, =cur_task
  mov r3, #1
  str r3, [r2]

  ldmfd sp!, {r2, r3, r4}

  bl main
  b .

undefined_instruction:
  b .

software_interrupt:
  b do_software_interrupt @vai para o handler de interrupções de software

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

do_software_interrupt: @Rotina de Interrupçãode software
  add r1, r2, r3 @r1 = r2 + r3
  mov pc, r14 @volta p/ o endereço armazenado em r14

do_irq_interrupt: @Rotina de interrupções IRQ
  stmfd sp!, {r0 - r3} @Empilha os registradores

  @ escolher o vetor certo
  ldr r1, =cur_task
  ldr r1, [r1]
  cmp r1, #1
  ldreq r3, =linha_a @ vetor de registradores da task A
  ldrne r3, =linha_b @ idem, B
  ldr r1, =cur_vec
  str r3, [r1]
  ldr r2, =0

  str r0, [r3, r2, lsl #2]
  add r2, r2, #4
  str r4, [r3, r2, lsl #2]
  add r2, r2, #1
  str r5, [r3, r2, lsl #2]
  add r2, r2, #1
  str r6, [r3, r2, lsl #2]
  add r2, r2, #1
  str r7, [r3, r2, lsl #2]
  add r2, r2, #1
  str r8, [r3, r2, lsl #2]
  add r2, r2, #1
  str r9, [r3, r2, lsl #2]
  add r2, r2, #1
  str r10, [r3, r2, lsl #2]
  add r2, r2, #1
  str r11, [r3, r2, lsl #2]
  add r2, r2, #1
  str r12, [r3, r2, lsl #2]

  @ guardar pc
  sub r0, lr, #4
  ldr r2, =15
  str r0, [r3,r2, lsl #2] @O PC do supervisor, seria o r15
  @ guardar cpsr
  mrs r0, spsr
  ldr r2, =16
  str r0, [r3,r2, lsl #2]
  @mudando estado para conseguir lr e sp em modo Supervisor
  mrs r0, cpsr
  orr r0, r0, #0x00C1
  msr cpsr_c,r0 @enabling interrupts in the cps

  @ guardar sp
  ldr r2, =13
  str sp, [r3,r2, lsl #2]
  @ guardar lr
  add r2, r2, #1
  str lr, [r3,r2, lsl #2]
  @voltando para estado de Interrupcao
  mrs r0, cpsr
  bic r0, r0, #0x1
  msr cpsr_c,r0
  @ guardar r2 e r3
  @ Recuperando os registradores sujos
  ldmfd sp!, {r0-r3}
  stmfd sp!, {r0-r3, LR} @Empilha os registradores
  @ldmfd sp!, {r2}
  ldr r0, =cur_vec
  ldr r0, [r0]
  add r0, r0, #12
  str r3, [r0]
  sub r0, r0, #4
  str r2,[r0]
  sub r0, r0, #4
  str r1,[r0]

  @stmfd r3!, {sp}
  @stmfd r3!, {lr}

  @stmfd sp!, {r2-r3, LR} @Empilha os registradores

  ldr r0, INTPND @ Carrega o registrador de status de interrupção
  ldr r0, [r0]
  tst r0, #0x0010 @ verifica se é uma interupção de timer
  stmfd sp!, {pc}         @ salva pc na pilha do modo de interrupções
  blne handler_timer @ vai para o rotina de tratamento da interupção de timer
  ldmfd sp!, {r0 - r3,lr} @retorna
  @ Recuperando tudo
  @ Recuperando r0 até r1
  ldr r3, =cur_vec
  ldr r3, [r3]
  ldr   r2, =0

  ldr   r0, [r3, r2, lsl #2]
  add   r2, r2, #1
  ldr   r1, [r3, r2, lsl #2]
  add   r2, r2, #3
  ldr   r4, [r3, r2, lsl #2]
  add   r2, r2, #1
  ldr   r5, [r3, r2, lsl #2]
  add   r2, r2, #1
  ldr   r6, [r3, r2, lsl #2]
  add   r2, r2, #1
  ldr   r7, [r3, r2, lsl #2]
  add   r2, r2, #1
  ldr   r8, [r3, r2, lsl #2]
  add   r2, r2, #1
  ldr   r9, [r3, r2, lsl #2]
  add   r2, r2, #1
  ldr   r10, [r3, r2, lsl #2]
  add   r2, r2, #1
  ldr   r11, [r3, r2, lsl #2]
  add   r2, r2, #1
  ldr   r12, [r3, r2, lsl #2]
  stmfd sp!, {r0-r12}
  @Mudar de modo
  ldr r3, =cur_vec
  ldr r3, [r3]
  ldr r2, =16
  ldr r0,[r3, r2, lsl #2]
  @Salvando sp em r4
  ldr r2, =13
  ldr r4,[r3, r2, lsl #2]
  @Salvando lr em r5
  ldr r2, =14
  ldr r5,[r3, r2, lsl #2]
  @Mudando de modo efetivamente
  msr cpsr,r0
  @Atualizando lr em Supervisor
  mov lr, r5
  @Atualizando sp em Supervisor
  mov sp, r4
  @ Voltando para modo interrupcao
  bic r0, r0, #1
  msr cpsr, r0
  @ Recuperando regs
  ldmfd sp!, {r0-r12}
  @Recuperando r2 e r3
  stmfd sp!, {r0-r1}
  ldr r0, =cur_vec
  ldr r0, [r0]
  ldr r1, =2
  ldr  r2, [r0, r1, lsl #2]
  add r1, r1, #1
  ldr  r3, [r0, r1, lsl #2]
  @sub lr, lr, #4  @ corrigindo o lr
  mov r1, #15
  ldr lr, [r0, r1, lsl #2]
  ldmfd sp!, {r0-r1}
  stmfd sp!, {lr}
  ldmfd sp!, {pc}^

handler_timer:
  stmfd sp!,{r0 - r12}

  ldr r0, TIMER0X
  mov r1, #0x0
  @ escrever no registrador TIMER0X para limpar o pedido de interrupção
  str r1, [r0]

  @ printar uma hashtag
  stmfd sp!, {lr}
  bl print_hashtag
  ldmfd sp!, {lr}

  @ mudar a task atual
  ldr r5, =cur_task
  ldr r6, [r5]
  cmp r6, #1
  moveq r6, #2
  movne r6, #1
  str r6, [r5]
  ldr r8, =cur_vec
  ldreq r3, =linha_b
  ldrne r3, =linha_a
  str r3, [r8]

  ldmfd sp!,{r0 - r12}
  ldmfd sp!, {pc}

  @ retorna para onde estávamos antes da interrupção
  mov pc, r14


timer_init:
  ldr r0, INTEN
  ldr r1,=0x10 @bit 4 for timer 0 interrupt enable
  str r1,[r0]
  ldr r0, TIMER0C
  ldr r1, [r0]
  mov r1, #0xA0 @enable timer module
  str r1, [r0]
  ldr r0, TIMER0V
  mov r1, #0x1 @setting timer value
  str r1,[r0]
  mrs r0, cpsr
  bic r0,r0,#0x80
  msr cpsr_c,r0 @enabling interrupts in the cpsr

  mov pc, lr
task_init:
  @ parâmetros: r2=endereço da pilha, r3=endereço da linha, r4=ponto de entrada
  @ guardar r1 e r8
  stmfd sp!, {r1, r8}
  @ inicializar sp
  mov r8, #13
  str r2, [r3, r8, lsl #2]
  @ inicializar pc
  mov r8, #15
  str r4, [r3, r8, lsl #2]
  @ inicializar cpsr com IRQ e FIQ ativados
  ldr r1, =0x207 @ 0b10110011
  mov r8, #16
  str r1, [r3, r8, lsl #2]
  @ puxar r1 e retornar
  ldmfd sp!, {r1}
  mov pc, lr
main:
  bl c_entry
  bl timer_init @initialize interrupts and timer 0
  bl task_a

stop:
  bl print_espaco
  b stop

