
build/main.elf:     file format elf32-littleriscv


Disassembly of section .text:

00001000 <main-0x4>:
    1000:	0000                	.insn	2, 0x
    1002:	4000                	.insn	2, 0x4000

00001004 <main>:
    1004:	fe010113          	addi	sp,sp,-32
    1008:	00812e23          	sw	s0,28(sp)
    100c:	02010413          	addi	s0,sp,32
    1010:	00200793          	li	a5,2
    1014:	fef42623          	sw	a5,-20(s0)
    1018:	000017b7          	lui	a5,0x1
    101c:	0007a787          	flw	fa5,0(a5) # 1000 <CSR_MEPC+0xcbf>
    1020:	fef42427          	fsw	fa5,-24(s0)
    1024:	fe842787          	flw	fa5,-24(s0)
    1028:	fef42227          	fsw	fa5,-28(s0)
    102c:	00000793          	li	a5,0
    1030:	00078513          	mv	a0,a5
    1034:	01c12403          	lw	s0,28(sp)
    1038:	02010113          	addi	sp,sp,32
    103c:	00008067          	ret
    1040:	00000013          	.word	0x00000013
    1044:	0b80006f          	j	10fc <reset_handler>
    1048:	00000013          	nop
    104c:	00000013          	nop
    1050:	00000013          	nop
    1054:	00000013          	nop
    1058:	00000013          	nop
    105c:	00000013          	nop
    1060:	00000013          	nop
    1064:	00000013          	nop
    1068:	00000013          	nop
    106c:	00000013          	nop
    1070:	00000013          	nop
    1074:	00000013          	nop
    1078:	00000013          	nop
    107c:	00000013          	nop

00001080 <vtable>:
    1080:	0b80006f 00000000 00000000 0a80006f     o...........o...
	...
    109c:	0980006f 00000000 00000000 00000000     o...............
    10ac:	0880006f 00000000 00000000 00000000     o...............
    10bc:	00000000 0740006f 00000000 00000000     ....o.@.........
	...

000010fc <reset_handler>:
    10fc:	00800293          	li	t0,8
    1100:	3002a073          	csrs	mstatus,t0
    1104:	000012b7          	lui	t0,0x1
    1108:	80028293          	addi	t0,t0,-2048 # 800 <CSR_MEPC+0x4bf>
    110c:	3042a073          	csrs	mie,t0
    1110:	80000117          	auipc	sp,0x80000
    1114:	ef010113          	addi	sp,sp,-272 # 80001000 <_sp>
    1118:	00000517          	auipc	a0,0x0
    111c:	f6850513          	addi	a0,a0,-152 # 1080 <vtable>
    1120:	00150513          	addi	a0,a0,1
    1124:	30551073          	csrw	mtvec,a0

00001128 <call_main>:
    1128:	00000513          	li	a0,0
    112c:	00000593          	li	a1,0
    1130:	ed5ff0ef          	jal	1004 <main>

00001134 <meip_handler>:
    1134:	0000006f          	j	1134 <meip_handler>

00001138 <mexc_handler>:
    1138:	0000006f          	j	1138 <mexc_handler>
