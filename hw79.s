.text

    .globl relation_code
    .type relation_code, @function
relation_code:
    # TODO: Problem 1
    movq $0, %rax
    cmpq %rsi, %rdi
    jge skip_add_one
    addq $1, %rax
skip_add_one:
    cmpq %rsi, %rdi
    jae skip_add_two
    addq $2, %rax
skip_add_two:
    ret

    .globl clamp_long
    .type clamp_long, @function
clamp_long:
    # TODO: Problem 2
    movq %rdi, %rax
    cmpq %rsi, %rdi
    jge ge_than_low
    movq %rsi, %rax
    ret
ge_than_low:
    cmpq %rdx, %rdi
    jle le_than_high
    movq %rdx, %rax
le_than_high:
    ret

    .globl weighted_sum8
    .type weighted_sum8, @function
weighted_sum8:
    # TODO: Problem 3
    movq %rdi, %rax
    imulq $2, %rsi
    addq %rsi, %rax
    imulq $3, %rdx
    addq %rdx, %rax
    imulq $4, %rcx
    addq %rcx, %rax
    imulq $5, %r8
    addq %r8, %rax
    imulq $6, %r9
    addq %r9, %rax
    movq 8(%rsp), %r10
    imulq $7, %r10
    addq %r10, %rax
    movq 16(%rsp), %r11
    imulq $8, %r11
    addq %r11, %rax
    ret

    .globl alternating_sum
    .type alternating_sum, @function
alternating_sum:
    # TODO: Problem 4
    movq $0, %rax
    movq $1, %rcx
    movq $1, %rdx
sum_loop:
    cmpq %rdi, %rcx
    jg finished_sum
    movq %rcx, %r8
    imulq %rdx, %r8
    addq %r8, %rax
    imulq $-1, %rdx
    addq $1, %rcx
    jmp sum_loop
finished_sum:
    ret

    .globl recursive_power
    .type recursive_power, @function
recursive_power:
    # TODO: Problem 5
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    cmpq $0, %rsi
    jne rp_recurse
    movq $1, %rax
    leave
    ret
rp_recurse:
    movq %rdi, -8(%rbp)
    subq $1, %rsi
    call recursive_power
    imulq -8(%rbp), %rax
    leave
    ret

    .globl combine_helpers
    .type combine_helpers, @function
combine_helpers:
    # TODO: Problem 6
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq %rsi, -8(%rbp)
    call helper_square
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rdi
    call helper_affine
    addq -16(%rbp), %rax
    leave
    ret

    .section .note.GNU-stack,"",@progbits
