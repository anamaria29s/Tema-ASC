.data
	n: .space 4
	nrcerinta: .space 4
	aux: .space 4
	v: .space 500
	x: .space 4
	nrleg: .space 4
	coloana: .space 4
	linie: .space 4
	stanga: .space 4
	dreapta: .space 4
	matrix: .space 500
	y: .long 0
	fstring: .asciz "%ld"
	fstring1: .asciz "%ld"
	fstring2: .asciz "%ld"
	newLine: .asciz "\n"
.text
.globl main
main:
	pusha
	pushl $nrcerinta
	pushl $fstring
	call scanf
	popl %ebx
	popl %ebx
	popa
	
	pusha
	pushl $n  #nr de noduri din graf
	pushl $fstring
	call scanf
	popl %ebx
	popl %ebx
	popa
	
        lea v,%esi
	mov $0,%ecx
	
citire_loop:
	cmp n,%ecx
	je program
	
	pusha
	pushl $aux
	pushl $fstring1
	call scanf
	popl %ebx
	popl %ebx
	popa
	
	movl aux, %eax
	movl %eax, (%esi,%ecx,4)
	
	add $1,%ecx
	jmp citire_loop
	
program:
	mov $0,%ecx #pt nr noduri
	jmp noduri_loop
	
incr:
	add $1,%ecx
	jmp noduri_loop
	
noduri_loop:
	cmp n,%ecx
	jg afisare_matr
	
	movl $0,nrleg
	movl (%esi,%ecx,4),%ebx
	mov %ecx,stanga
	
	jmp legaturi_loop
	
	legaturi_loop:
		cmp nrleg,%ebx
		je incr
		
		pusha
		pushl $x
		pushl $fstring1
		call scanf
		popl %ebx
		popl %ebx
		popa
		
		mov x,%eax
		mov %eax,dreapta
		mov stanga,%eax
		mov $0,%edx
		mull n
		
		addl dreapta,%eax
		
		lea matrix, %edi
		movl $1,(%edi,%eax,4)
		
		incl nrleg
		
		jmp legaturi_loop

afisare_matr:
	movl $0, linie
	for_linii:
		movl linie, %ecx
	cmp %ecx, n
	je exit
	
	movl $0, coloana
	
	for_coloane:
		movl coloana, %ecx
		cmp %ecx, n
		je cont
		
		movl linie, %eax
		movl $0, %edx
		mull n
		addl coloana, %eax
		
		lea matrix, %edi
		movl (%edi, %eax, 4), %ebx
		
		pusha
		pushl %ebx
		pushl $fstring2
		call printf
		popl %ebx
		popl %ebx
		popa
		
		pushl $0
		call fflush
		popl %ebx
		
		incl coloana
		jmp for_coloane
	cont:
		movl $4, %eax

		movl $1, %ebx
		movl $newLine, %ecx
		movl $2, %edx
		int $0x80
		incl linie
		jmp for_linii	
		
	
exit:
	mov $1,%eax
	mov $0,%ebx
	int $0x80
