
main.elf:     file format elf32-tradlittlemips
main.elf


Disassembly of section .text:

bfc00000 <_ftext>:
_ftext():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:24
bfc00000:	3c1bbfb0 	lui	k1,0xbfb0
bfc00004:	af608ffc 	sw	zero,-28676(k1)
bfc00008:	af608ffc 	sw	zero,-28676(k1)
bfc0000c:	af60fff8 	sw	zero,-8(k1)
bfc00010:	af608ffc 	sw	zero,-28676(k1)
bfc00014:	af608ffc 	sw	zero,-28676(k1)
bfc00018:	8f608ffc 	lw	zero,-28676(k1)
bfc0001c:	8f7bfff8 	lw	k1,-8(k1)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:25
bfc00020:	0bf00158 	j	bfc00560 <locate>
bfc00024:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:26
bfc00028:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:29
bfc0002c:	3c088000 	lui	t0,0x8000
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:30
bfc00030:	25290001 	addiu	t1,t1,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:31
bfc00034:	01005025 	move	t2,t0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:32
bfc00038:	01ae5821 	addu	t3,t5,t6
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:33
bfc0003c:	8d0c0000 	lw	t4,0(t0)
	...
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:39
bfc000e8:	3c088000 	lui	t0,0x8000
bfc000ec:	25290001 	addiu	t1,t1,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:40
bfc000f0:	01005025 	move	t2,t0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:41
bfc000f4:	01ae5821 	addu	t3,t5,t6
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:42
bfc000f8:	8d0c0000 	lw	t4,0(t0)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:43
bfc000fc:	00000000 	nop

bfc00100 <test_finish>:
test_finish():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:47
bfc00100:	1000ffff 	b	bfc00100 <test_finish>
bfc00104:	25080001 	addiu	t0,t0,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:48
bfc00108:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:50
bfc0010c:	3c088000 	lui	t0,0x8000
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:51
bfc00110:	25290001 	addiu	t1,t1,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:52
bfc00114:	01005025 	move	t2,t0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:53
bfc00118:	01ae5821 	addu	t3,t5,t6
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:54
bfc0011c:	8d0c0000 	lw	t4,0(t0)
	...

bfc00200 <tlb_refill>:
tlb_refill():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:60
bfc00200:	401a6800 	mfc0	k0,c0_cause
bfc00204:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:61
bfc00208:	335a007c 	andi	k0,k0,0x7c
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:62
bfc0020c:	241b0001 	li	k1,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:63
bfc00210:	125b000c 	beq	s2,k1,bfc00244 <load_refill_ex>
bfc00214:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:64
bfc00218:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:65
bfc0021c:	241b0002 	li	k1,2
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:66
bfc00220:	125b001d 	beq	s2,k1,bfc00298 <store_refill_ex>
bfc00224:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:67
bfc00228:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:68
bfc0022c:	241b0003 	li	k1,3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:69
bfc00230:	125b002e 	beq	s2,k1,bfc002ec <fetch_refill_ex>
bfc00234:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:71
bfc00238:	100000c4 	b	bfc0054c <tlb_fail>
bfc0023c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:72
bfc00240:	00000000 	nop

bfc00244 <load_refill_ex>:
load_refill_ex():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:74
bfc00244:	241b0008 	li	k1,8
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:75
bfc00248:	175b00c0 	bne	k0,k1,bfc0054c <tlb_fail>
bfc0024c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:76
bfc00250:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:77
bfc00254:	401a7000 	mfc0	k0,c0_epc
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:78
bfc00258:	3c1bbfc0 	lui	k1,0xbfc0
bfc0025c:	277b0c38 	addiu	k1,k1,3128
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:79
bfc00260:	175b00ba 	bne	k0,k1,bfc0054c <tlb_fail>
bfc00264:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:80
bfc00268:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:81
bfc0026c:	3c090023 	lui	t1,0x23
bfc00270:	35294500 	ori	t1,t1,0x4500
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:82
bfc00274:	40891000 	mtc0	t1,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:83
bfc00278:	3c0a0078 	lui	t2,0x78
bfc0027c:	354a9a00 	ori	t2,t2,0x9a00
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:84
bfc00280:	408a1800 	mtc0	t2,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:85
bfc00284:	240b0001 	li	t3,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:86
bfc00288:	408b0000 	mtc0	t3,c0_index
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:87
bfc0028c:	42000002 	tlbwi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:88
bfc00290:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:90
bfc00294:	42000018 	c0	0x18

bfc00298 <store_refill_ex>:
store_refill_ex():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:94
bfc00298:	241b000c 	li	k1,12
bfc0029c:	175b00ab 	bne	k0,k1,bfc0054c <tlb_fail>
bfc002a0:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:95
bfc002a4:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:96
bfc002a8:	401a7000 	mfc0	k0,c0_epc
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:97
bfc002ac:	3c1bbfc0 	lui	k1,0xbfc0
bfc002b0:	277b07a4 	addiu	k1,k1,1956
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:98
bfc002b4:	175b00a5 	bne	k0,k1,bfc0054c <tlb_fail>
bfc002b8:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:99
bfc002bc:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:100
bfc002c0:	3c090023 	lui	t1,0x23
bfc002c4:	35294500 	ori	t1,t1,0x4500
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:101
bfc002c8:	40891000 	mtc0	t1,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:102
bfc002cc:	3c0a0078 	lui	t2,0x78
bfc002d0:	354a9a00 	ori	t2,t2,0x9a00
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:103
bfc002d4:	408a1800 	mtc0	t2,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:104
bfc002d8:	240b0002 	li	t3,2
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:105
bfc002dc:	408b0000 	mtc0	t3,c0_index
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:106
bfc002e0:	42000002 	tlbwi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:107
bfc002e4:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:109
bfc002e8:	42000018 	c0	0x18

bfc002ec <fetch_refill_ex>:
fetch_refill_ex():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:113
bfc002ec:	241b0008 	li	k1,8
bfc002f0:	175b0096 	bne	k0,k1,bfc0054c <tlb_fail>
bfc002f4:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:114
bfc002f8:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:115
bfc002fc:	3c1bbfc0 	lui	k1,0xbfc0
bfc00300:	277b0b0c 	addiu	k1,k1,2828
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:116
bfc00304:	337b0fff 	andi	k1,k1,0xfff
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:117
bfc00308:	3c1a3333 	lui	k0,0x3333
bfc0030c:	375a3000 	ori	k0,k0,0x3000
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:118
bfc00310:	037ad825 	or	k1,k1,k0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:119
bfc00314:	401a7000 	mfc0	k0,c0_epc
bfc00318:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:120
bfc0031c:	175b008b 	bne	k0,k1,bfc0054c <tlb_fail>
bfc00320:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:121
bfc00324:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:122
bfc00328:	3c090023 	lui	t1,0x23
bfc0032c:	35294500 	ori	t1,t1,0x4500
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:123
bfc00330:	40891000 	mtc0	t1,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:124
bfc00334:	3c0a0078 	lui	t2,0x78
bfc00338:	354a9a00 	ori	t2,t2,0x9a00
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:126
bfc0033c:	408a1800 	mtc0	t2,$3
bfc00340:	240b0003 	li	t3,3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:127
bfc00344:	408b0000 	mtc0	t3,c0_index
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:128
bfc00348:	42000002 	tlbwi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:129
bfc0034c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:131
bfc00350:	42000018 	c0	0x18
	...
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:135
bfc00380:	401a6800 	mfc0	k0,c0_cause
bfc00384:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:136
bfc00388:	335a007c 	andi	k0,k0,0x7c
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:137
bfc0038c:	241b0001 	li	k1,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:138
bfc00390:	125b000c 	beq	s2,k1,bfc003c4 <load_inv_ex>
bfc00394:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:139
bfc00398:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:140
bfc0039c:	241b0002 	li	k1,2
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:141
bfc003a0:	125b0020 	beq	s2,k1,bfc00424 <store_inv_mod_ex>
bfc003a4:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:142
bfc003a8:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:143
bfc003ac:	241b0003 	li	k1,3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:144
bfc003b0:	125b0046 	beq	s2,k1,bfc004cc <fetch_inv_ex>
bfc003b4:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:146
bfc003b8:	10000064 	b	bfc0054c <tlb_fail>
bfc003bc:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:147
bfc003c0:	00000000 	nop

bfc003c4 <load_inv_ex>:
load_inv_ex():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:149
bfc003c4:	241b0008 	li	k1,8
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:150
bfc003c8:	135b0004 	beq	k0,k1,bfc003dc <load_tlb_invalid>
bfc003cc:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:152
bfc003d0:	1000005e 	b	bfc0054c <tlb_fail>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:153
bfc003d4:	00000000 	nop
bfc003d8:	00000000 	nop

bfc003dc <load_tlb_invalid>:
load_tlb_invalid():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:155
bfc003dc:	42000008 	tlbp
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:156
bfc003e0:	401a7000 	mfc0	k0,c0_epc
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:157
bfc003e4:	3c1bbfc0 	lui	k1,0xbfc0
bfc003e8:	277b0c38 	addiu	k1,k1,3128
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:158
bfc003ec:	175b0057 	bne	k0,k1,bfc0054c <tlb_fail>
bfc003f0:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:159
bfc003f4:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:160
bfc003f8:	275a0008 	addiu	k0,k0,8
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:161
bfc003fc:	409a7000 	mtc0	k0,c0_epc
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:162
bfc00400:	3c1a02ff 	lui	k0,0x2ff
bfc00404:	375a37c2 	ori	k0,k0,0x37c2
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:163
bfc00408:	409a1000 	mtc0	k0,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:164
bfc0040c:	3c1b02ff 	lui	k1,0x2ff
bfc00410:	377b3402 	ori	k1,k1,0x3402
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:165
bfc00414:	409b1800 	mtc0	k1,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:166
bfc00418:	42000002 	tlbwi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:167
bfc0041c:	24121111 	li	s2,4369
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:169
bfc00420:	42000018 	c0	0x18

bfc00424 <store_inv_mod_ex>:
store_inv_mod_ex():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:173
bfc00424:	241b000c 	li	k1,12
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:174
bfc00428:	135b0008 	beq	k0,k1,bfc0044c <store_tlb_invalid>
bfc0042c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:175
bfc00430:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:176
bfc00434:	241b0004 	li	k1,4
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:177
bfc00438:	135b0013 	beq	k0,k1,bfc00488 <store_tlb_modified>
bfc0043c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:179
bfc00440:	10000042 	b	bfc0054c <tlb_fail>
bfc00444:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:180
bfc00448:	00000000 	nop

bfc0044c <store_tlb_invalid>:
store_tlb_invalid():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:182
bfc0044c:	42000008 	tlbp
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:183
bfc00450:	401a7000 	mfc0	k0,c0_epc
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:184
bfc00454:	3c1bbfc0 	lui	k1,0xbfc0
bfc00458:	277b07a4 	addiu	k1,k1,1956
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:185
bfc0045c:	175b003b 	bne	k0,k1,bfc0054c <tlb_fail>
bfc00460:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:186
bfc00464:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:187
bfc00468:	3c1a02ff 	lui	k0,0x2ff
bfc0046c:	375a3442 	ori	k0,k0,0x3442
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:188
bfc00470:	409a1000 	mtc0	k0,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:189
bfc00474:	3c1b02ff 	lui	k1,0x2ff
bfc00478:	377b0802 	ori	k1,k1,0x802
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:190
bfc0047c:	409b1800 	mtc0	k1,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:191
bfc00480:	42000002 	tlbwi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:193
bfc00484:	42000018 	c0	0x18

bfc00488 <store_tlb_modified>:
store_tlb_modified():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:196
bfc00488:	401a7000 	mfc0	k0,c0_epc
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:197
bfc0048c:	3c1bbfc0 	lui	k1,0xbfc0
bfc00490:	277b07a4 	addiu	k1,k1,1956
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:198
bfc00494:	175b002d 	bne	k0,k1,bfc0054c <tlb_fail>
bfc00498:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:199
bfc0049c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:200
bfc004a0:	275a0008 	addiu	k0,k0,8
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:201
bfc004a4:	409a7000 	mtc0	k0,c0_epc
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:202
bfc004a8:	3c1a02ff 	lui	k0,0x2ff
bfc004ac:	375a3446 	ori	k0,k0,0x3446
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:203
bfc004b0:	409a1000 	mtc0	k0,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:204
bfc004b4:	3c1b02ff 	lui	k1,0x2ff
bfc004b8:	377b0802 	ori	k1,k1,0x802
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:205
bfc004bc:	409b1800 	mtc0	k1,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:206
bfc004c0:	42000002 	tlbwi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:207
bfc004c4:	24122222 	li	s2,8738
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:209
bfc004c8:	42000018 	c0	0x18

bfc004cc <fetch_inv_ex>:
fetch_inv_ex():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:213
bfc004cc:	241b0008 	li	k1,8
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:214
bfc004d0:	135b0004 	beq	k0,k1,bfc004e4 <fetch_tlb_invalid>
bfc004d4:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:216
bfc004d8:	1000001c 	b	bfc0054c <tlb_fail>
bfc004dc:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:217
bfc004e0:	00000000 	nop

bfc004e4 <fetch_tlb_invalid>:
fetch_tlb_invalid():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:219
bfc004e4:	42000008 	tlbp
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:220
bfc004e8:	3c1bbfc0 	lui	k1,0xbfc0
bfc004ec:	277b0b0c 	addiu	k1,k1,2828
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:221
bfc004f0:	337b0fff 	andi	k1,k1,0xfff
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:222
bfc004f4:	3c1a3333 	lui	k0,0x3333
bfc004f8:	375a3000 	ori	k0,k0,0x3000
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:223
bfc004fc:	037ad825 	or	k1,k1,k0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:224
bfc00500:	401a7000 	mfc0	k0,c0_epc
bfc00504:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:225
bfc00508:	175b0010 	bne	k0,k1,bfc0054c <tlb_fail>
bfc0050c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:226
bfc00510:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:227
bfc00514:	3c1a02ff 	lui	k0,0x2ff
bfc00518:	375a37c2 	ori	k0,k0,0x37c2
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:229
bfc0051c:	409a1000 	mtc0	k0,c0_entrylo
bfc00520:	3c1bbfc0 	lui	k1,0xbfc0
bfc00524:	277b0b0c 	addiu	k1,k1,2828
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:230
bfc00528:	001bdb02 	srl	k1,k1,0xc
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:231
bfc0052c:	001bd980 	sll	k1,k1,0x6
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:232
bfc00530:	377b0002 	ori	k1,k1,0x2
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:233
bfc00534:	409b1800 	mtc0	k1,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:234
bfc00538:	42000002 	tlbwi
	...
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:237
bfc00544:	24123333 	li	s2,13107
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:239
bfc00548:	42000018 	c0	0x18

bfc0054c <tlb_fail>:
tlb_fail():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:243
bfc0054c:	00104e00 	sll	t1,s0,0x18
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:244
bfc00550:	01334025 	or	t0,t1,s3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:246
bfc00554:	03e00008 	jr	ra
bfc00558:	ae280000 	sw	t0,0(s1)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:247
bfc0055c:	00000000 	nop

bfc00560 <locate>:
locate():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:252
bfc00560:	3c04bfb0 	lui	a0,0xbfb0
bfc00564:	2484f008 	addiu	a0,a0,-4088
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:253
bfc00568:	3c05bfb0 	lui	a1,0xbfb0
bfc0056c:	24a5f004 	addiu	a1,a1,-4092
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:254
bfc00570:	3c06bfb0 	lui	a2,0xbfb0
bfc00574:	24c6f000 	addiu	a2,a2,-4096
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:255
bfc00578:	3c11bfb0 	lui	s1,0xbfb0
bfc0057c:	2631f010 	addiu	s1,s1,-4080
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:257
bfc00580:	3c090000 	lui	t1,0x0
bfc00584:	25290002 	addiu	t1,t1,2
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:258
bfc00588:	3c0a0000 	lui	t2,0x0
bfc0058c:	254a0001 	addiu	t2,t2,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:259
bfc00590:	3c0b0001 	lui	t3,0x1
bfc00594:	256bffff 	addiu	t3,t3,-1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:260
bfc00598:	3c130000 	lui	s3,0x0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:262
bfc0059c:	ac890000 	sw	t1,0(a0)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:263
bfc005a0:	acaa0000 	sw	t2,0(a1)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:264
bfc005a4:	accb0000 	sw	t3,0(a2)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:265
bfc005a8:	ae330000 	sw	s3,0(s1)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:266
bfc005ac:	3c100000 	lui	s0,0x0

bfc005b0 <inst_test>:
inst_test():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:268
bfc005b0:	0ff001b4 	jal	bfc006d0 <n1_index_test>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:269
bfc005b4:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:270
bfc005b8:	0ff0019f 	jal	bfc0067c <wait_1s>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:271
bfc005bc:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:272
bfc005c0:	0ff00350 	jal	bfc00d40 <n2_entryhi_test>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:273
bfc005c4:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:274
bfc005c8:	0ff0019f 	jal	bfc0067c <wait_1s>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:275
bfc005cc:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:276
bfc005d0:	0ff002d4 	jal	bfc00b50 <n3_entrylo0_test>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:277
bfc005d4:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:278
bfc005d8:	0ff0019f 	jal	bfc0067c <wait_1s>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:279
bfc005dc:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:280
bfc005e0:	0ff00320 	jal	bfc00c80 <n4_entrylo1_test>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:281
bfc005e4:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:282
bfc005e8:	0ff0019f 	jal	bfc0067c <wait_1s>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:283
bfc005ec:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:284
bfc005f0:	0ff001fc 	jal	bfc007f0 <n5_tlbwi_tlbr_test>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:285
bfc005f4:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:286
bfc005f8:	0ff0019f 	jal	bfc0067c <wait_1s>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:287
bfc005fc:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:288
bfc00600:	0ff0028c 	jal	bfc00a30 <n6_tlbp_test>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:289
bfc00604:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:290
bfc00608:	0ff0019f 	jal	bfc0067c <wait_1s>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:291
bfc0060c:	00000000 	nop

bfc00610 <test_end>:
test_end():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:308
bfc00610:	3c100000 	lui	s0,0x0
bfc00614:	26100006 	addiu	s0,s0,6
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:309
bfc00618:	1213000e 	beq	s0,s3,bfc00654 <test_end+0x44>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:310
bfc0061c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:312
bfc00620:	3c04bfb0 	lui	a0,0xbfb0
bfc00624:	2484f000 	addiu	a0,a0,-4096
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:313
bfc00628:	3c05bfb0 	lui	a1,0xbfb0
bfc0062c:	24a5f008 	addiu	a1,a1,-4088
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:314
bfc00630:	3c06bfb0 	lui	a2,0xbfb0
bfc00634:	24c6f004 	addiu	a2,a2,-4092
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:316
bfc00638:	3c090000 	lui	t1,0x0
bfc0063c:	25290002 	addiu	t1,t1,2
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:318
bfc00640:	ac800000 	sw	zero,0(a0)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:319
bfc00644:	aca90000 	sw	t1,0(a1)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:320
bfc00648:	acc90000 	sw	t1,0(a2)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:321
bfc0064c:	10000009 	b	bfc00674 <test_end+0x64>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:322
bfc00650:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:324
bfc00654:	3c090000 	lui	t1,0x0
bfc00658:	25290001 	addiu	t1,t1,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:325
bfc0065c:	3c04bfb0 	lui	a0,0xbfb0
bfc00660:	2484f008 	addiu	a0,a0,-4088
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:326
bfc00664:	3c05bfb0 	lui	a1,0xbfb0
bfc00668:	24a5f004 	addiu	a1,a1,-4092
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:327
bfc0066c:	ac890000 	sw	t1,0(a0)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:328
bfc00670:	aca90000 	sw	t1,0(a1)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:331
bfc00674:	0bf00040 	j	bfc00100 <test_finish>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:332
bfc00678:	00000000 	nop

bfc0067c <wait_1s>:
wait_1s():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:335
bfc0067c:	3c09bfb0 	lui	t1,0xbfb0
bfc00680:	2529fff4 	addiu	t1,t1,-12
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:336
bfc00684:	3c080000 	lui	t0,0x0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:337
bfc00688:	8d2a0000 	lw	t2,0(t1)
bfc0068c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:338
bfc00690:	15400008 	bnez	t2,bfc006b4 <wait_1s+0x38>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:339
bfc00694:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:340
bfc00698:	3c08bfb0 	lui	t0,0xbfb0
bfc0069c:	2508f020 	addiu	t0,t0,-4064
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:341
bfc006a0:	8d080000 	lw	t0,0(t0)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:342
bfc006a4:	3c090000 	lui	t1,0x0
bfc006a8:	252900ff 	addiu	t1,t1,255
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:343
bfc006ac:	01094026 	xor	t0,t0,t1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:344
bfc006b0:	00084400 	sll	t0,t0,0x10
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:346
bfc006b4:	25080001 	addiu	t0,t0,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:348
bfc006b8:	2508ffff 	addiu	t0,t0,-1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:349
bfc006bc:	1500fffe 	bnez	t0,bfc006b8 <wait_1s+0x3c>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:350
bfc006c0:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:351
bfc006c4:	03e00008 	jr	ra
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/start.S:352
bfc006c8:	00000000 	nop
bfc006cc:	00000000 	nop

bfc006d0 <n1_index_test>:
n1_index_test():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:6
bfc006d0:	26100001 	addiu	s0,s0,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:7
bfc006d4:	24120000 	li	s2,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:8
bfc006d8:	3c0a0001 	lui	t2,0x1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:11
bfc006dc:	24090003 	li	t1,3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:12
bfc006e0:	240a0000 	li	t2,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:13
bfc006e4:	40890000 	mtc0	t1,c0_index
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:14
bfc006e8:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:15
bfc006ec:	400a0000 	mfc0	t2,c0_index
bfc006f0:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:16
bfc006f4:	152a001c 	bne	t1,t2,bfc00768 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:17
bfc006f8:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:18
bfc006fc:	2409001f 	li	t1,31
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:19
bfc00700:	240a0000 	li	t2,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:20
bfc00704:	40890000 	mtc0	t1,c0_index
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:21
bfc00708:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:22
bfc0070c:	400a0000 	mfc0	t2,c0_index
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:23
bfc00710:	2409000f 	li	t1,15
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:24
bfc00714:	152a0014 	bne	t1,t2,bfc00768 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:25
bfc00718:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:26
bfc0071c:	2409003a 	li	t1,58
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:27
bfc00720:	240a0000 	li	t2,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:28
bfc00724:	40890000 	mtc0	t1,c0_index
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:29
bfc00728:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:30
bfc0072c:	400a0000 	mfc0	t2,c0_index
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:31
bfc00730:	2409000a 	li	t1,10
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:32
bfc00734:	152a000c 	bne	t1,t2,bfc00768 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:33
bfc00738:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:34
bfc0073c:	2409fff0 	li	t1,-16
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:35
bfc00740:	240a000a 	li	t2,10
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:36
bfc00744:	40890000 	mtc0	t1,c0_index
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:37
bfc00748:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:38
bfc0074c:	400a0000 	mfc0	t2,c0_index
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:39
bfc00750:	24090000 	li	t1,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:40
bfc00754:	152a0004 	bne	t1,t2,bfc00768 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:42
bfc00758:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:44
bfc0075c:	16400002 	bnez	s2,bfc00768 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:45
bfc00760:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:47
bfc00764:	26730001 	addiu	s3,s3,1

bfc00768 <inst_error>:
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:50
bfc00768:	00104e00 	sll	t1,s0,0x18
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:51
bfc0076c:	01334025 	or	t0,t1,s3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:52
bfc00770:	ae280000 	sw	t0,0(s1)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:53
bfc00774:	03e00008 	jr	ra
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n1_index.S:54
bfc00778:	00000000 	nop
inst_error():
bfc0077c:	00000000 	nop

bfc00780 <n8_store_tlb_ex_test>:
n8_store_tlb_ex_test():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:6
bfc00780:	26100001 	addiu	s0,s0,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:7
bfc00784:	24120002 	li	s2,2
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:8
bfc00788:	3c0a0001 	lui	t2,0x1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:12
bfc0078c:	3c082345 	lui	t0,0x2345
bfc00790:	35086789 	ori	t0,t0,0x6789
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:13
bfc00794:	3c04bfcd 	lui	a0,0xbfcd
bfc00798:	34841040 	ori	a0,a0,0x1040
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:14
bfc0079c:	3c052222 	lui	a1,0x2222
bfc007a0:	34a52040 	ori	a1,a1,0x2040

bfc007a4 <store_tlb_pc_1>:
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:17
bfc007a4:	aca80000 	sw	t0,0(a1)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:18
bfc007a8:	1000000c 	b	bfc007dc <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:19
bfc007ac:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:20
bfc007b0:	aca80000 	sw	t0,0(a1)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:21
bfc007b4:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:22
bfc007b8:	8c890000 	lw	t1,0(a0)
bfc007bc:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:23
bfc007c0:	15280006 	bne	t1,t0,bfc007dc <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:24
bfc007c4:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:26
bfc007c8:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:28
bfc007cc:	24092222 	li	t1,8738
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:29
bfc007d0:	16490002 	bne	s2,t1,bfc007dc <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:30
bfc007d4:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:32
bfc007d8:	26730001 	addiu	s3,s3,1

bfc007dc <inst_error>:
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:35
bfc007dc:	00104e00 	sll	t1,s0,0x18
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:36
bfc007e0:	01334025 	or	t0,t1,s3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:37
bfc007e4:	ae280000 	sw	t0,0(s1)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:38
bfc007e8:	03e00008 	jr	ra
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n8_store_tlb_ex.S:39
bfc007ec:	00000000 	nop

bfc007f0 <n5_tlbwi_tlbr_test>:
n5_tlbwi_tlbr_test():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:6
bfc007f0:	26100001 	addiu	s0,s0,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:7
bfc007f4:	24120000 	li	s2,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:8
bfc007f8:	3c0a0001 	lui	t2,0x1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:11
bfc007fc:	3c090023 	lui	t1,0x23
bfc00800:	35294500 	ori	t1,t1,0x4500
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:12
bfc00804:	40891000 	mtc0	t1,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:13
bfc00808:	3c0a0078 	lui	t2,0x78
bfc0080c:	354a9a00 	ori	t2,t2,0x9a00
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:14
bfc00810:	408a1800 	mtc0	t2,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:15
bfc00814:	24020000 	li	v0,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:16
bfc00818:	2403000d 	li	v1,13
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:17
bfc0081c:	3c08bfc0 	lui	t0,0xbfc0
bfc00820:	35080010 	ori	t0,t0,0x10
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:20
bfc00824:	40885000 	mtc0	t0,c0_entryhi
bfc00828:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:21
bfc0082c:	40820000 	mtc0	v0,c0_index
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:22
bfc00830:	42000002 	tlbwi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:23
bfc00834:	240bffff 	li	t3,-1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:24
bfc00838:	408b5000 	mtc0	t3,c0_entryhi
bfc0083c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:25
bfc00840:	408b1000 	mtc0	t3,c0_entrylo
bfc00844:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:26
bfc00848:	408b1800 	mtc0	t3,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:27
bfc0084c:	42000001 	tlbr
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:28
bfc00850:	40045000 	mfc0	a0,c0_entryhi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:29
bfc00854:	40051000 	mfc0	a1,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:30
bfc00858:	40061800 	mfc0	a2,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:31
bfc0085c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:32
bfc00860:	1488006d 	bne	a0,t0,bfc00a18 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:33
bfc00864:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:34
bfc00868:	14a9006b 	bne	a1,t1,bfc00a18 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:35
bfc0086c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:36
bfc00870:	14ca0069 	bne	a2,t2,bfc00a18 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:37
bfc00874:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:38
bfc00878:	24420001 	addiu	v0,v0,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:39
bfc0087c:	25082000 	addiu	t0,t0,8192
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:40
bfc00880:	1443ffe8 	bne	v0,v1,bfc00824 <n5_tlbwi_tlbr_test+0x34>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:41
bfc00884:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:43
bfc00888:	3c090023 	lui	t1,0x23
bfc0088c:	35294500 	ori	t1,t1,0x4500
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:44
bfc00890:	40891000 	mtc0	t1,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:45
bfc00894:	3c0a0078 	lui	t2,0x78
bfc00898:	354a9a01 	ori	t2,t2,0x9a01
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:46
bfc0089c:	408a1800 	mtc0	t2,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:47
bfc008a0:	3c0a0078 	lui	t2,0x78
bfc008a4:	354a9a00 	ori	t2,t2,0x9a00
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:48
bfc008a8:	40885000 	mtc0	t0,c0_entryhi
bfc008ac:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:49
bfc008b0:	40820000 	mtc0	v0,c0_index
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:50
bfc008b4:	42000002 	tlbwi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:51
bfc008b8:	240bffff 	li	t3,-1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:52
bfc008bc:	408b5000 	mtc0	t3,c0_entryhi
bfc008c0:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:53
bfc008c4:	408b1000 	mtc0	t3,c0_entrylo
bfc008c8:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:54
bfc008cc:	408b1800 	mtc0	t3,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:55
bfc008d0:	42000001 	tlbr
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:56
bfc008d4:	40045000 	mfc0	a0,c0_entryhi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:57
bfc008d8:	40051000 	mfc0	a1,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:58
bfc008dc:	40061800 	mfc0	a2,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:59
bfc008e0:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:60
bfc008e4:	1488004c 	bne	a0,t0,bfc00a18 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:61
bfc008e8:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:62
bfc008ec:	14a9004a 	bne	a1,t1,bfc00a18 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:63
bfc008f0:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:64
bfc008f4:	14ca0048 	bne	a2,t2,bfc00a18 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:65
bfc008f8:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:66
bfc008fc:	24420001 	addiu	v0,v0,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:67
bfc00900:	25082000 	addiu	t0,t0,8192
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:68
bfc00904:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:70
bfc00908:	3c090023 	lui	t1,0x23
bfc0090c:	35294501 	ori	t1,t1,0x4501
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:71
bfc00910:	40891000 	mtc0	t1,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:72
bfc00914:	3c090023 	lui	t1,0x23
bfc00918:	35294500 	ori	t1,t1,0x4500
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:73
bfc0091c:	3c0a0078 	lui	t2,0x78
bfc00920:	354a9a1c 	ori	t2,t2,0x9a1c
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:74
bfc00924:	408a1800 	mtc0	t2,$3
bfc00928:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:75
bfc0092c:	40885000 	mtc0	t0,c0_entryhi
bfc00930:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:76
bfc00934:	40820000 	mtc0	v0,c0_index
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:77
bfc00938:	42000002 	tlbwi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:78
bfc0093c:	240bffff 	li	t3,-1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:79
bfc00940:	408b5000 	mtc0	t3,c0_entryhi
bfc00944:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:80
bfc00948:	408b1000 	mtc0	t3,c0_entrylo
bfc0094c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:81
bfc00950:	408b1800 	mtc0	t3,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:82
bfc00954:	42000001 	tlbr
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:83
bfc00958:	40045000 	mfc0	a0,c0_entryhi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:84
bfc0095c:	40051000 	mfc0	a1,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:85
bfc00960:	40061800 	mfc0	a2,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:86
bfc00964:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:87
bfc00968:	1488002b 	bne	a0,t0,bfc00a18 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:88
bfc0096c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:89
bfc00970:	14a90029 	bne	a1,t1,bfc00a18 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:90
bfc00974:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:91
bfc00978:	14ca0027 	bne	a2,t2,bfc00a18 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:92
bfc0097c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:93
bfc00980:	24420001 	addiu	v0,v0,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:94
bfc00984:	25082000 	addiu	t0,t0,8192
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:95
bfc00988:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:97
bfc0098c:	3c090023 	lui	t1,0x23
bfc00990:	35294505 	ori	t1,t1,0x4505
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:98
bfc00994:	40891000 	mtc0	t1,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:99
bfc00998:	3c0a0078 	lui	t2,0x78
bfc0099c:	354a9a11 	ori	t2,t2,0x9a11
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:100
bfc009a0:	408a1800 	mtc0	t2,$3
bfc009a4:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:101
bfc009a8:	40885000 	mtc0	t0,c0_entryhi
bfc009ac:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:102
bfc009b0:	40820000 	mtc0	v0,c0_index
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:103
bfc009b4:	42000002 	tlbwi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:104
bfc009b8:	240bffff 	li	t3,-1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:105
bfc009bc:	408b5000 	mtc0	t3,c0_entryhi
bfc009c0:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:106
bfc009c4:	408b1000 	mtc0	t3,c0_entrylo
bfc009c8:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:107
bfc009cc:	408b1800 	mtc0	t3,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:108
bfc009d0:	42000001 	tlbr
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:109
bfc009d4:	40045000 	mfc0	a0,c0_entryhi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:110
bfc009d8:	40051000 	mfc0	a1,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:111
bfc009dc:	40061800 	mfc0	a2,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:112
bfc009e0:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:113
bfc009e4:	1488000c 	bne	a0,t0,bfc00a18 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:114
bfc009e8:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:115
bfc009ec:	14a9000a 	bne	a1,t1,bfc00a18 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:116
bfc009f0:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:117
bfc009f4:	14ca0008 	bne	a2,t2,bfc00a18 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:118
bfc009f8:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:119
bfc009fc:	24420001 	addiu	v0,v0,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:120
bfc00a00:	25082000 	addiu	t0,t0,8192
	...
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:125
bfc00a0c:	16400002 	bnez	s2,bfc00a18 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:126
bfc00a10:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:128
bfc00a14:	26730001 	addiu	s3,s3,1

bfc00a18 <inst_error>:
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:131
bfc00a18:	00104e00 	sll	t1,s0,0x18
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:132
bfc00a1c:	01334025 	or	t0,t1,s3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:133
bfc00a20:	ae280000 	sw	t0,0(s1)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:134
bfc00a24:	03e00008 	jr	ra
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n5_tlbwi_tlbr.S:135
bfc00a28:	00000000 	nop
inst_error():
bfc00a2c:	00000000 	nop

bfc00a30 <n6_tlbp_test>:
n6_tlbp_test():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:6
bfc00a30:	26100001 	addiu	s0,s0,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:7
bfc00a34:	24120000 	li	s2,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:8
bfc00a38:	3c0a0001 	lui	t2,0x1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:12
bfc00a3c:	40800000 	mtc0	zero,c0_index
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:13
bfc00a40:	3c08bfc0 	lui	t0,0xbfc0
bfc00a44:	35084010 	ori	t0,t0,0x4010
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:14
bfc00a48:	40885000 	mtc0	t0,c0_entryhi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:15
bfc00a4c:	42000008 	tlbp
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:16
bfc00a50:	40040000 	mfc0	a0,c0_index
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:17
bfc00a54:	24080002 	li	t0,2
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:18
bfc00a58:	15040019 	bne	t0,a0,bfc00ac0 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:19
bfc00a5c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:21
bfc00a60:	40800000 	mtc0	zero,c0_index
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:22
bfc00a64:	3c08bfc1 	lui	t0,0xbfc1
bfc00a68:	3508e011 	ori	t0,t0,0xe011
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:23
bfc00a6c:	40885000 	mtc0	t0,c0_entryhi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:24
bfc00a70:	42000008 	tlbp
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:25
bfc00a74:	40040000 	mfc0	a0,c0_index
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:26
bfc00a78:	2408000f 	li	t0,15
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:27
bfc00a7c:	15040010 	bne	t0,a0,bfc00ac0 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:28
bfc00a80:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:30
bfc00a84:	40800000 	mtc0	zero,c0_index
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:31
bfc00a88:	3c08bfc3 	lui	t0,0xbfc3
bfc00a8c:	3508c013 	ori	t0,t0,0xc013
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:32
bfc00a90:	40885000 	mtc0	t0,c0_entryhi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:33
bfc00a94:	42000008 	tlbp
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:34
bfc00a98:	40040000 	mfc0	a0,c0_index
bfc00a9c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:35
bfc00aa0:	000427c2 	srl	a0,a0,0x1f
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:36
bfc00aa4:	24080001 	li	t0,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:37
bfc00aa8:	15040005 	bne	t0,a0,bfc00ac0 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:38
bfc00aac:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:40
bfc00ab0:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:42
bfc00ab4:	16400002 	bnez	s2,bfc00ac0 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:43
bfc00ab8:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:45
bfc00abc:	26730001 	addiu	s3,s3,1

bfc00ac0 <inst_error>:
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:48
bfc00ac0:	00104e00 	sll	t1,s0,0x18
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:49
bfc00ac4:	01334025 	or	t0,t1,s3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:50
bfc00ac8:	ae280000 	sw	t0,0(s1)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:51
bfc00acc:	03e00008 	jr	ra
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n6_tlbp.S:52
bfc00ad0:	00000000 	nop
	...

bfc00ae0 <n9_fetch_tlb_ex_test>:
n9_fetch_tlb_ex_test():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:6
bfc00ae0:	26100001 	addiu	s0,s0,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:7
bfc00ae4:	24120003 	li	s2,3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:8
bfc00ae8:	3c0a0001 	lui	t2,0x1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:12
bfc00aec:	3c08bfc0 	lui	t0,0xbfc0
bfc00af0:	25080b0c 	addiu	t0,t0,2828
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:13
bfc00af4:	31040fff 	andi	a0,t0,0xfff
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:14
bfc00af8:	3c053333 	lui	a1,0x3333
bfc00afc:	34a53000 	ori	a1,a1,0x3000
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:15
bfc00b00:	00a42825 	or	a1,a1,a0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:16
bfc00b04:	00a00008 	jr	a1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:17
bfc00b08:	00000000 	nop

bfc00b0c <fetch_tlb_pc_2>:
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:20
bfc00b0c:	3c09bfc0 	lui	t1,0xbfc0
bfc00b10:	25290b24 	addiu	t1,t1,2852
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:21
bfc00b14:	01200008 	jr	t1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:22
bfc00b18:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:23
bfc00b1c:	10000006 	b	bfc00b38 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:24
bfc00b20:	00000000 	nop

bfc00b24 <fetch_tlb_pc_3>:
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:27
bfc00b24:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:29
bfc00b28:	24093333 	li	t1,13107
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:30
bfc00b2c:	16490002 	bne	s2,t1,bfc00b38 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:31
bfc00b30:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:33
bfc00b34:	26730001 	addiu	s3,s3,1

bfc00b38 <inst_error>:
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:36
bfc00b38:	00104e00 	sll	t1,s0,0x18
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:37
bfc00b3c:	01334025 	or	t0,t1,s3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:38
bfc00b40:	ae280000 	sw	t0,0(s1)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:39
bfc00b44:	03e00008 	jr	ra
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n9_fetch_tlb_ex.S:40
bfc00b48:	00000000 	nop
inst_error():
bfc00b4c:	00000000 	nop

bfc00b50 <n3_entrylo0_test>:
n3_entrylo0_test():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:6
bfc00b50:	26100001 	addiu	s0,s0,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:7
bfc00b54:	24120000 	li	s2,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:8
bfc00b58:	3c0a0001 	lui	t2,0x1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:11
bfc00b5c:	3c0903ff 	lui	t1,0x3ff
bfc00b60:	3529ffff 	ori	t1,t1,0xffff
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:12
bfc00b64:	240a0000 	li	t2,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:13
bfc00b68:	40891000 	mtc0	t1,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:14
bfc00b6c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:15
bfc00b70:	400a1000 	mfc0	t2,c0_entrylo
bfc00b74:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:16
bfc00b78:	152a001d 	bne	t1,t2,bfc00bf0 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:17
bfc00b7c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:18
bfc00b80:	2409001f 	li	t1,31
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:19
bfc00b84:	240a0000 	li	t2,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:20
bfc00b88:	40891000 	mtc0	t1,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:21
bfc00b8c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:22
bfc00b90:	400a1000 	mfc0	t2,c0_entrylo
bfc00b94:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:23
bfc00b98:	152a0015 	bne	t1,t2,bfc00bf0 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:24
bfc00b9c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:25
bfc00ba0:	2409ffff 	li	t1,-1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:26
bfc00ba4:	240a0000 	li	t2,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:27
bfc00ba8:	40891000 	mtc0	t1,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:28
bfc00bac:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:29
bfc00bb0:	400a1000 	mfc0	t2,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:30
bfc00bb4:	3c0903ff 	lui	t1,0x3ff
bfc00bb8:	3529ffff 	ori	t1,t1,0xffff
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:31
bfc00bbc:	152a000c 	bne	t1,t2,bfc00bf0 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:32
bfc00bc0:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:33
bfc00bc4:	3c09fc00 	lui	t1,0xfc00
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:34
bfc00bc8:	240a0001 	li	t2,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:35
bfc00bcc:	40891000 	mtc0	t1,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:36
bfc00bd0:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:37
bfc00bd4:	400a1000 	mfc0	t2,c0_entrylo
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:38
bfc00bd8:	24090000 	li	t1,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:39
bfc00bdc:	152a0004 	bne	t1,t2,bfc00bf0 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:41
bfc00be0:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:43
bfc00be4:	16400002 	bnez	s2,bfc00bf0 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:44
bfc00be8:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:46
bfc00bec:	26730001 	addiu	s3,s3,1

bfc00bf0 <inst_error>:
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:49
bfc00bf0:	00104e00 	sll	t1,s0,0x18
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:50
bfc00bf4:	01334025 	or	t0,t1,s3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:51
bfc00bf8:	ae280000 	sw	t0,0(s1)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:52
bfc00bfc:	03e00008 	jr	ra
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n3_entrylo0.S:53
bfc00c00:	00000000 	nop
	...

bfc00c10 <n7_load_tlb_ex_test>:
n7_load_tlb_ex_test():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:6
bfc00c10:	26100001 	addiu	s0,s0,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:7
bfc00c14:	24120001 	li	s2,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:8
bfc00c18:	3c0a0001 	lui	t2,0x1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:12
bfc00c1c:	3c081234 	lui	t0,0x1234
bfc00c20:	35085678 	ori	t0,t0,0x5678
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:13
bfc00c24:	3c04bfcd 	lui	a0,0xbfcd
bfc00c28:	34840080 	ori	a0,a0,0x80
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:14
bfc00c2c:	3c051111 	lui	a1,0x1111
bfc00c30:	34a51080 	ori	a1,a1,0x1080
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:15
bfc00c34:	ac880000 	sw	t0,0(a0)

bfc00c38 <load_tlb_pc_1>:
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:18
bfc00c38:	8ca90000 	lw	t1,0(a1)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:19
bfc00c3c:	1000000a 	b	bfc00c68 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:20
bfc00c40:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:21
bfc00c44:	8ca90000 	lw	t1,0(a1)
bfc00c48:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:22
bfc00c4c:	15280006 	bne	t1,t0,bfc00c68 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:23
bfc00c50:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:25
bfc00c54:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:27
bfc00c58:	24091111 	li	t1,4369
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:28
bfc00c5c:	16490002 	bne	s2,t1,bfc00c68 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:29
bfc00c60:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:31
bfc00c64:	26730001 	addiu	s3,s3,1

bfc00c68 <inst_error>:
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:34
bfc00c68:	00104e00 	sll	t1,s0,0x18
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:35
bfc00c6c:	01334025 	or	t0,t1,s3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:36
bfc00c70:	ae280000 	sw	t0,0(s1)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:37
bfc00c74:	03e00008 	jr	ra
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n7_load_tlb_ex.S:38
bfc00c78:	00000000 	nop
inst_error():
bfc00c7c:	00000000 	nop

bfc00c80 <n4_entrylo1_test>:
n4_entrylo1_test():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:6
bfc00c80:	26100001 	addiu	s0,s0,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:7
bfc00c84:	24120000 	li	s2,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:8
bfc00c88:	3c0a0001 	lui	t2,0x1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:11
bfc00c8c:	3c0903ff 	lui	t1,0x3ff
bfc00c90:	3529ffff 	ori	t1,t1,0xffff
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:12
bfc00c94:	240a0000 	li	t2,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:13
bfc00c98:	40891800 	mtc0	t1,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:14
bfc00c9c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:15
bfc00ca0:	400a1800 	mfc0	t2,$3
bfc00ca4:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:16
bfc00ca8:	152a001d 	bne	t1,t2,bfc00d20 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:17
bfc00cac:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:18
bfc00cb0:	2409001f 	li	t1,31
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:19
bfc00cb4:	240a0000 	li	t2,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:20
bfc00cb8:	40891800 	mtc0	t1,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:21
bfc00cbc:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:22
bfc00cc0:	400a1800 	mfc0	t2,$3
bfc00cc4:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:23
bfc00cc8:	152a0015 	bne	t1,t2,bfc00d20 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:24
bfc00ccc:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:25
bfc00cd0:	2409ffff 	li	t1,-1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:26
bfc00cd4:	240a0000 	li	t2,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:27
bfc00cd8:	40891800 	mtc0	t1,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:28
bfc00cdc:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:29
bfc00ce0:	400a1800 	mfc0	t2,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:30
bfc00ce4:	3c0903ff 	lui	t1,0x3ff
bfc00ce8:	3529ffff 	ori	t1,t1,0xffff
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:31
bfc00cec:	152a000c 	bne	t1,t2,bfc00d20 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:32
bfc00cf0:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:33
bfc00cf4:	3c09fc00 	lui	t1,0xfc00
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:34
bfc00cf8:	240a0001 	li	t2,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:35
bfc00cfc:	40891800 	mtc0	t1,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:36
bfc00d00:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:37
bfc00d04:	400a1800 	mfc0	t2,$3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:38
bfc00d08:	24090000 	li	t1,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:39
bfc00d0c:	152a0004 	bne	t1,t2,bfc00d20 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:41
bfc00d10:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:43
bfc00d14:	16400002 	bnez	s2,bfc00d20 <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:44
bfc00d18:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:46
bfc00d1c:	26730001 	addiu	s3,s3,1

bfc00d20 <inst_error>:
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:49
bfc00d20:	00104e00 	sll	t1,s0,0x18
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:50
bfc00d24:	01334025 	or	t0,t1,s3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:51
bfc00d28:	ae280000 	sw	t0,0(s1)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:52
bfc00d2c:	03e00008 	jr	ra
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n4_entrylo1.S:53
bfc00d30:	00000000 	nop
	...

bfc00d40 <n2_entryhi_test>:
n2_entryhi_test():
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:6
bfc00d40:	26100001 	addiu	s0,s0,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:7
bfc00d44:	24120000 	li	s2,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:8
bfc00d48:	3c0a0001 	lui	t2,0x1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:11
bfc00d4c:	2409e0ff 	li	t1,-7937
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:12
bfc00d50:	240a0000 	li	t2,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:13
bfc00d54:	40895000 	mtc0	t1,c0_entryhi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:14
bfc00d58:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:15
bfc00d5c:	400a5000 	mfc0	t2,c0_entryhi
bfc00d60:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:16
bfc00d64:	152a001d 	bne	t1,t2,bfc00ddc <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:17
bfc00d68:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:18
bfc00d6c:	3c091000 	lui	t1,0x1000
bfc00d70:	35290001 	ori	t1,t1,0x1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:19
bfc00d74:	240a0000 	li	t2,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:20
bfc00d78:	40895000 	mtc0	t1,c0_entryhi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:21
bfc00d7c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:22
bfc00d80:	400a5000 	mfc0	t2,c0_entryhi
bfc00d84:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:23
bfc00d88:	152a0014 	bne	t1,t2,bfc00ddc <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:24
bfc00d8c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:25
bfc00d90:	2409ffff 	li	t1,-1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:26
bfc00d94:	240a0000 	li	t2,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:27
bfc00d98:	40895000 	mtc0	t1,c0_entryhi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:28
bfc00d9c:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:29
bfc00da0:	400a5000 	mfc0	t2,c0_entryhi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:30
bfc00da4:	2409e0ff 	li	t1,-7937
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:31
bfc00da8:	152a000c 	bne	t1,t2,bfc00ddc <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:32
bfc00dac:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:33
bfc00db0:	24091f00 	li	t1,7936
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:34
bfc00db4:	240a0001 	li	t2,1
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:35
bfc00db8:	40895000 	mtc0	t1,c0_entryhi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:36
bfc00dbc:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:37
bfc00dc0:	400a5000 	mfc0	t2,c0_entryhi
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:38
bfc00dc4:	24090000 	li	t1,0
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:39
bfc00dc8:	152a0004 	bne	t1,t2,bfc00ddc <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:41
bfc00dcc:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:43
bfc00dd0:	16400002 	bnez	s2,bfc00ddc <inst_error>
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:44
bfc00dd4:	00000000 	nop
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:46
bfc00dd8:	26730001 	addiu	s3,s3,1

bfc00ddc <inst_error>:
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:49
bfc00ddc:	00104e00 	sll	t1,s0,0x18
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:50
bfc00de0:	01334025 	or	t0,t1,s3
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:51
bfc00de4:	ae280000 	sw	t0,0(s1)
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:52
bfc00de8:	03e00008 	jr	ra
/home/jia-fan/work/jiafan_20191014/lab13-15/tlb_func/inst/n2_entryhi.S:53
bfc00dec:	00000000 	nop
inst_error():
bfc00df0:	9c0f7f70 	0x9c0f7f70
	...

Disassembly of section .data:

80000000 <__CTOR_LIST__>:
	...

80000008 <__CTOR_END__>:
	...

Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
   0:	0000001c 	0x1c
   4:	00000002 	srl	zero,zero,0x0
   8:	00040000 	sll	zero,a0,0x0
   c:	00000000 	nop
  10:	bfc00000 	0xbfc00000
  14:	000006cc 	syscall	0x1b
	...
  20:	0000001c 	0x1c
  24:	00630002 	0x630002
  28:	00040000 	sll	zero,a0,0x0
  2c:	00000000 	nop
  30:	bfc006d0 	0xbfc006d0
  34:	000000ac 	0xac
	...
  40:	0000001c 	0x1c
  44:	00ce0002 	0xce0002
  48:	00040000 	sll	zero,a0,0x0
  4c:	00000000 	nop
  50:	bfc00780 	0xbfc00780
  54:	00000070 	0x70
	...
  60:	0000001c 	0x1c
  64:	01400002 	0x1400002
  68:	00040000 	sll	zero,a0,0x0
  6c:	00000000 	nop
  70:	bfc007f0 	0xbfc007f0
  74:	0000023c 	0x23c
	...
  80:	0000001c 	0x1c
  84:	01b00002 	0x1b00002
  88:	00040000 	sll	zero,a0,0x0
  8c:	00000000 	nop
  90:	bfc00a30 	0xbfc00a30
  94:	000000a4 	0xa4
	...
  a0:	0000001c 	0x1c
  a4:	021a0002 	0x21a0002
  a8:	00040000 	sll	zero,a0,0x0
  ac:	00000000 	nop
  b0:	bfc00ae0 	0xbfc00ae0
  b4:	0000006c 	0x6c
	...
  c0:	0000001c 	0x1c
  c4:	028c0002 	0x28c0002
  c8:	00040000 	sll	zero,a0,0x0
  cc:	00000000 	nop
  d0:	bfc00b50 	0xbfc00b50
  d4:	000000b4 	0xb4
	...
  e0:	0000001c 	0x1c
  e4:	02fa0002 	0x2fa0002
  e8:	00040000 	sll	zero,a0,0x0
  ec:	00000000 	nop
  f0:	bfc00c10 	0xbfc00c10
  f4:	0000006c 	0x6c
	...
 100:	0000001c 	0x1c
 104:	036b0002 	0x36b0002
 108:	00040000 	sll	zero,a0,0x0
 10c:	00000000 	nop
 110:	bfc00c80 	0xbfc00c80
 114:	000000b4 	0xb4
	...
 120:	0000001c 	0x1c
 124:	03d90002 	0x3d90002
 128:	00040000 	sll	zero,a0,0x0
 12c:	00000000 	nop
 130:	bfc00d40 	0xbfc00d40
 134:	000000b0 	0xb0
	...

Disassembly of section .pdr:

00000000 <.pdr>:
   0:	bfc006d0 	0xbfc006d0
	...
  18:	0000001d 	0x1d
  1c:	0000001f 	0x1f
  20:	bfc00780 	0xbfc00780
	...
  38:	0000001d 	0x1d
  3c:	0000001f 	0x1f
  40:	bfc007f0 	0xbfc007f0
	...
  58:	0000001d 	0x1d
  5c:	0000001f 	0x1f
  60:	bfc00a30 	0xbfc00a30
	...
  78:	0000001d 	0x1d
  7c:	0000001f 	0x1f
  80:	bfc00ae0 	0xbfc00ae0
	...
  98:	0000001d 	0x1d
  9c:	0000001f 	0x1f
  a0:	bfc00b50 	0xbfc00b50
	...
  b8:	0000001d 	0x1d
  bc:	0000001f 	0x1f
  c0:	bfc00c10 	0xbfc00c10
	...
  d8:	0000001d 	0x1d
  dc:	0000001f 	0x1f
  e0:	bfc00c80 	0xbfc00c80
	...
  f8:	0000001d 	0x1d
  fc:	0000001f 	0x1f
 100:	bfc00d40 	0xbfc00d40
	...
 118:	0000001d 	0x1d
 11c:	0000001f 	0x1f

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	0000013a 	0x13a
   4:	001e0002 	srl	zero,s8,0x0
   8:	01010000 	0x1010000
   c:	000d0efb 	0xd0efb
  10:	01010101 	0x1010101
  14:	01000000 	0x1000000
  18:	00010000 	sll	zero,at,0x0
  1c:	72617473 	0x72617473
  20:	00532e74 	0x532e74
  24:	00000000 	nop
  28:	00020500 	sll	zero,v0,0x14
  2c:	03bfc000 	0x3bfc000
  30:	e5080117 	swc1	$f8,279(t0)
  34:	4b4b4d83 	c2	0x14b4d83
  38:	024b4b4b 	0x24b4b4b
  3c:	131601a8 	beq	t8,s6,6e0 <data_size+0x6d0>
  40:	4b4b4b83 	c2	0x14b4b83
  44:	4c83134d 	0x4c83134d
  48:	4b4b4b4b 	c2	0x14b4b4b
  4c:	1801e402 	0x1801e402
  50:	834b4b83 	lb	t3,19331(k0)
  54:	4b834b4b 	c2	0x1834b4b
  58:	8313834b 	lb	s3,-31925(t8)
  5c:	4b834b4c 	c2	0x1834b4c
  60:	4b83834b 	c2	0x183834b
  64:	4b834b83 	c2	0x1834b83
  68:	4c4b4b4b 	0x4c4b4b4b
  6c:	4bbb134d 	c2	0x1bb134d
  70:	4b83834b 	c2	0x183834b
  74:	4b834b83 	c2	0x1834b83
  78:	4c4b4b4b 	0x4c4b4b4b
  7c:	4bbb134d 	c2	0x1bb134d
  80:	4b834b83 	c2	0x1834b83
  84:	834b8383 	lb	t3,-31869(k0)
  88:	8313834b 	lb	s3,-31925(t8)
  8c:	024c4b4b 	0x24c4b4b
  90:	4b831630 	c2	0x1831630
  94:	4b4b834b 	c2	0x14b834b
  98:	834b4b83 	lb	t3,19331(k0)
  9c:	4b4c8313 	c2	0x14c8313
  a0:	844b1383 	lh	t3,4995(v0)
  a4:	83834b4b 	lb	v1,19275(gp)
  a8:	834b4b4b 	lb	t3,19275(k0)
  ac:	4b4b834b 	c2	0x14b834b
  b0:	834b4e4c 	lb	t3,20044(k0)
  b4:	13834b4b 	beq	gp,v1,12de4 <data_size+0x12dd4>
  b8:	4b4b4c83 	c2	0x14b4c83
  bc:	834b8383 	lb	t3,-31869(k0)
  c0:	4c4b834b 	0x4c4b834b
  c4:	83834b4d 	lb	v1,19277(gp)
  c8:	834b4b4b 	lb	t3,19275(k0)
  cc:	4b4b834b 	c2	0x14b834b
  d0:	834b4e4c 	lb	t3,20044(k0)
  d4:	4b4c8313 	c2	0x14c8313
  d8:	4b834b83 	c2	0x1834b83
  dc:	834b8383 	lb	t3,-31869(k0)
  e0:	4b4bbb13 	c2	0x14bbb13
  e4:	4b4b4b4b 	c2	0x14b4b4b
  e8:	4b4e4c4b 	c2	0x14e4c4b
  ec:	4f83134b 	c3	0x183134b
  f0:	84838383 	lh	v1,-31869(a0)
  f4:	4c838383 	0x4c838383
  f8:	4b4b4b4b 	c2	0x14b4b4b
  fc:	4b4b4b4c 	c2	0x14b4b4c
 100:	4b4b4b4b 	c2	0x14b4b4b
 104:	4b4b4b4b 	c2	0x14b4b4b
 108:	4b4b4b4b 	c2	0x14b4b4b
 10c:	4b4b4b4b 	c2	0x14b4b4b
 110:	4b4b4b4b 	c2	0x14b4b4b
 114:	834a1103 	lb	t2,4355(k0)
 118:	83834c4b 	lb	v1,19531(gp)
 11c:	4b4b8484 	c2	0x14b8484
 120:	834c4b4b 	lb	t4,19275(k0)
 124:	4d4b8383 	0x4d4b8383
 128:	4b834d4b 	c2	0x1834d4b
 12c:	834b4b83 	lb	t3,19331(k0)
 130:	4c4b834b 	0x4c4b834b
 134:	4b4b4b4c 	c2	0x14b4b4c
 138:	0004024b 	0x4024b
 13c:	005d0101 	0x5d0101
 140:	00020000 	sll	zero,v0,0x0
 144:	00000021 	move	zero,zero
 148:	0efb0101 	jal	bec0404 <data_size+0xbec03f4>
 14c:	0101000d 	break	0x101
 150:	00000101 	0x101
 154:	00000100 	sll	zero,zero,0x4
 158:	316e0001 	andi	t6,t3,0x1
 15c:	646e695f 	0x646e695f
 160:	532e7865 	0x532e7865
 164:	00000000 	nop
 168:	02050000 	0x2050000
 16c:	bfc006d0 	0xbfc006d0
 170:	4d4b4b17 	0x4d4b4b17
 174:	4b4b4b4b 	c2	0x14b4b4b
 178:	4b4b4b83 	c2	0x14b4b83
 17c:	4b4b4b4b 	c2	0x14b4b4b
 180:	4b4b4b4b 	c2	0x14b4b4b
 184:	4b4b4b4b 	c2	0x14b4b4b
 188:	4b4b4b4b 	c2	0x14b4b4b
 18c:	4b4b4b4b 	c2	0x14b4b4b
 190:	4b4c4c4b 	c2	0x14c4c4b
 194:	4b4b4d4c 	c2	0x14b4d4c
 198:	04024b4b 	0x4024b4b
 19c:	52010100 	0x52010100
 1a0:	02000000 	0x2000000
 1a4:	00002800 	sll	a1,zero,0x0
 1a8:	fb010100 	0xfb010100
 1ac:	01000d0e 	0x1000d0e
 1b0:	00010101 	0x10101
 1b4:	00010000 	sll	zero,at,0x0
 1b8:	6e000100 	0x6e000100
 1bc:	74735f38 	jalx	1cd7ce0 <data_size+0x1cd7cd0>
 1c0:	5f65726f 	0x5f65726f
 1c4:	5f626c74 	0x5f626c74
 1c8:	532e7865 	0x532e7865
 1cc:	00000000 	nop
 1d0:	02050000 	0x2050000
 1d4:	bfc00780 	0xbfc00780
 1d8:	4e4b4b17 	c3	0x4b4b17
 1dc:	4b858383 	c2	0x1858383
 1e0:	4b4b4b4b 	c2	0x14b4b4b
 1e4:	4c4c4b83 	0x4c4c4b83
 1e8:	4d4c4b4b 	0x4d4c4b4b
 1ec:	4b4b4b4b 	c2	0x14b4b4b
 1f0:	01000402 	0x1000402
 1f4:	0000ae01 	0xae01
 1f8:	26000200 	addiu	zero,s0,512
 1fc:	01000000 	0x1000000
 200:	0d0efb01 	jal	43bec04 <data_size+0x43bebf4>
 204:	01010100 	0x1010100
 208:	00000001 	0x1
 20c:	01000001 	0x1000001
 210:	5f356e00 	0x5f356e00
 214:	77626c74 	jalx	d89b1d0 <data_size+0xd89b1c0>
 218:	6c745f69 	0x6c745f69
 21c:	532e7262 	0x532e7262
 220:	00000000 	nop
 224:	02050000 	0x2050000
 228:	bfc007f0 	0xbfc007f0
 22c:	4d4b4b17 	0x4d4b4b17
 230:	4b834b83 	c2	0x1834b83
 234:	83854b4b 	lb	a1,19275(gp)
 238:	834b4b4b 	lb	t3,19275(k0)
 23c:	4b4b4b83 	c2	0x14b4b83
 240:	4b4b4b4b 	c2	0x14b4b4b
 244:	4b4b4b4b 	c2	0x14b4b4b
 248:	4b4b4b4b 	c2	0x14b4b4b
 24c:	834b834c 	lb	t3,-31924(k0)
 250:	4b83834b 	c2	0x183834b
 254:	83834b4b 	lb	v1,19275(gp)
 258:	4b4b4b4b 	c2	0x14b4b4b
 25c:	4b4b4b4b 	c2	0x14b4b4b
 260:	4b4b4b4b 	c2	0x14b4b4b
 264:	834c4b4b 	lb	t4,19275(k0)
 268:	8383834b 	lb	v1,-31925(gp)
 26c:	4b4b4b83 	c2	0x14b4b83
 270:	4b4b8383 	c2	0x14b8383
 274:	4b4b4b4b 	c2	0x14b4b4b
 278:	4b4b4b4b 	c2	0x14b4b4b
 27c:	4b4b4b4b 	c2	0x14b4b4b
 280:	834b834c 	lb	t3,-31924(k0)
 284:	4b4b8383 	c2	0x14b8383
 288:	4b83834b 	c2	0x183834b
 28c:	4b4b4b4b 	c2	0x14b4b4b
 290:	4b4b4b4b 	c2	0x14b4b4b
 294:	4b4b4b4b 	c2	0x14b4b4b
 298:	4b4c4c4b 	c2	0x14c4c4b
 29c:	4b4b4d4c 	c2	0x14b4d4c
 2a0:	04024b4b 	0x4024b4b
 2a4:	57010100 	0x57010100
 2a8:	02000000 	0x2000000
 2ac:	00002000 	sll	a0,zero,0x0
 2b0:	fb010100 	0xfb010100
 2b4:	01000d0e 	0x1000d0e
 2b8:	00010101 	0x10101
 2bc:	00010000 	sll	zero,at,0x0
 2c0:	6e000100 	0x6e000100
 2c4:	6c745f36 	0x6c745f36
 2c8:	532e7062 	0x532e7062
 2cc:	00000000 	nop
 2d0:	02050000 	0x2050000
 2d4:	bfc00a30 	0xbfc00a30
 2d8:	4e4b4b17 	c3	0x4b4b17
 2dc:	4b4b834b 	c2	0x14b834b
 2e0:	4c4b4b4b 	0x4c4b4b4b
 2e4:	4b4b834b 	c2	0x14b834b
 2e8:	4c4b4b4b 	0x4c4b4b4b
 2ec:	4b4b834b 	c2	0x14b834b
 2f0:	4b4b4b83 	c2	0x14b4b83
 2f4:	4c4b4c4c 	0x4c4b4c4c
 2f8:	4b4b4b4d 	c2	0x14b4b4d
 2fc:	0004024b 	0x4024b
 300:	00520101 	0x520101
 304:	00020000 	sll	zero,v0,0x0
 308:	00000028 	0x28
 30c:	0efb0101 	jal	bec0404 <data_size+0xbec03f4>
 310:	0101000d 	break	0x101
 314:	00000101 	0x101
 318:	00000100 	sll	zero,zero,0x4
 31c:	396e0001 	xori	t6,t3,0x1
 320:	7465665f 	jalx	195997c <data_size+0x195996c>
 324:	745f6863 	jalx	17da18c <data_size+0x17da17c>
 328:	655f626c 	0x655f626c
 32c:	00532e78 	0x532e78
 330:	00000000 	nop
 334:	e0020500 	swc0	c0_entrylo,1280(zero)
 338:	17bfc00a 	bne	sp,ra,ffff0364 <data_load_start+0x403ef55c>
 33c:	834e4b4b 	lb	t6,19275(k0)
 340:	4b4b834b 	c2	0x14b834b
 344:	4b4b834d 	c2	0x14b834d
 348:	4b4c4d4b 	c2	0x14c4d4b
 34c:	4b4d4c4b 	c2	0x14d4c4b
 350:	024b4b4b 	0x24b4b4b
 354:	01010004 	sllv	zero,at,t0
 358:	0000005f 	0x5f
 35c:	00240002 	0x240002
 360:	01010000 	0x1010000
 364:	000d0efb 	0xd0efb
 368:	01010101 	0x1010101
 36c:	01000000 	0x1000000
 370:	00010000 	sll	zero,at,0x0
 374:	655f336e 	0x655f336e
 378:	7972746e 	0x7972746e
 37c:	2e306f6c 	sltiu	s0,s1,28524
 380:	00000053 	0x53
 384:	05000000 	bltz	t0,388 <data_size+0x378>
 388:	c00b5002 	lwc0	$11,20482(zero)
 38c:	4b4b17bf 	c2	0x14b17bf
 390:	4b4b834d 	c2	0x14b834d
 394:	4b4b834b 	c2	0x14b834b
 398:	4b4b4b4b 	c2	0x14b4b4b
 39c:	4b4b4b83 	c2	0x14b4b83
 3a0:	4b4b4b4b 	c2	0x14b4b4b
 3a4:	4b4b4b83 	c2	0x14b4b83
 3a8:	4b4b4b4b 	c2	0x14b4b4b
 3ac:	4b4c4c4b 	c2	0x14c4c4b
 3b0:	4b4b4d4c 	c2	0x14b4d4c
 3b4:	04024b4b 	0x4024b4b
 3b8:	50010100 	0x50010100
 3bc:	02000000 	0x2000000
 3c0:	00002700 	sll	a0,zero,0x1c
 3c4:	fb010100 	0xfb010100
 3c8:	01000d0e 	0x1000d0e
 3cc:	00010101 	0x10101
 3d0:	00010000 	sll	zero,at,0x0
 3d4:	6e000100 	0x6e000100
 3d8:	6f6c5f37 	0x6f6c5f37
 3dc:	745f6461 	jalx	17d9184 <data_size+0x17d9174>
 3e0:	655f626c 	0x655f626c
 3e4:	00532e78 	0x532e78
 3e8:	00000000 	nop
 3ec:	10020500 	beq	zero,v0,17f0 <data_size+0x17e0>
 3f0:	17bfc00c 	bne	sp,ra,ffff0424 <data_load_start+0x403ef61c>
 3f4:	834e4b4b 	lb	t6,19275(k0)
 3f8:	4b4d8383 	c2	0x14d8383
 3fc:	4b834b4b 	c2	0x1834b4b
 400:	4b4b4c4c 	c2	0x14b4c4c
 404:	4b4b4d4c 	c2	0x14b4d4c
 408:	04024b4b 	0x4024b4b
 40c:	5f010100 	0x5f010100
 410:	02000000 	0x2000000
 414:	00002400 	sll	a0,zero,0x10
 418:	fb010100 	0xfb010100
 41c:	01000d0e 	0x1000d0e
 420:	00010101 	0x10101
 424:	00010000 	sll	zero,at,0x0
 428:	6e000100 	0x6e000100
 42c:	6e655f34 	0x6e655f34
 430:	6c797274 	0x6c797274
 434:	532e316f 	0x532e316f
 438:	00000000 	nop
 43c:	02050000 	0x2050000
 440:	bfc00c80 	0xbfc00c80
 444:	4d4b4b17 	0x4d4b4b17
 448:	4b4b4b83 	c2	0x14b4b83
 44c:	4b4b4b83 	c2	0x14b4b83
 450:	834b4b4b 	lb	t3,19275(k0)
 454:	4b4b4b4b 	c2	0x14b4b4b
 458:	834b4b4b 	lb	t3,19275(k0)
 45c:	4b4b4b4b 	c2	0x14b4b4b
 460:	4b4b4b4b 	c2	0x14b4b4b
 464:	4c4b4c4c 	0x4c4b4c4c
 468:	4b4b4b4d 	c2	0x14b4b4d
 46c:	0004024b 	0x4024b
 470:	005e0101 	0x5e0101
 474:	00020000 	sll	zero,v0,0x0
 478:	00000023 	negu	zero,zero
 47c:	0efb0101 	jal	bec0404 <data_size+0xbec03f4>
 480:	0101000d 	break	0x101
 484:	00000101 	0x101
 488:	00000100 	sll	zero,zero,0x4
 48c:	326e0001 	andi	t6,s3,0x1
 490:	746e655f 	jalx	1b9957c <data_size+0x1b9956c>
 494:	69687972 	0x69687972
 498:	0000532e 	0x532e
 49c:	00000000 	nop
 4a0:	0d400205 	jal	5000814 <data_size+0x5000804>
 4a4:	4b17bfc0 	c2	0x117bfc0
 4a8:	4b4b4d4b 	c2	0x14b4d4b
 4ac:	4b834b4b 	c2	0x1834b4b
 4b0:	4b4b834b 	c2	0x14b834b
 4b4:	4b4b834b 	c2	0x14b834b
 4b8:	4b4b4b4b 	c2	0x14b4b4b
 4bc:	4b4b4b4b 	c2	0x14b4b4b
 4c0:	4b4b4b4b 	c2	0x14b4b4b
 4c4:	4c4c4b4b 	0x4c4c4b4b
 4c8:	4b4d4c4b 	c2	0x14d4c4b
 4cc:	024b4b4b 	0x24b4b4b
 4d0:	01010004 	sllv	zero,at,t0

Disassembly of section .debug_info:

00000000 <.debug_info>:
   0:	0000005f 	0x5f
   4:	00000002 	srl	zero,zero,0x0
   8:	01040000 	0x1040000
   c:	00000000 	nop
  10:	bfc00000 	0xbfc00000
  14:	bfc006cc 	0xbfc006cc
  18:	72617473 	0x72617473
  1c:	00532e74 	0x532e74
  20:	6d6f682f 	0x6d6f682f
  24:	696a2f65 	0x696a2f65
  28:	61662d61 	0x61662d61
  2c:	6f772f6e 	0x6f772f6e
  30:	6a2f6b72 	0x6a2f6b72
  34:	61666169 	0x61666169
  38:	30325f6e 	andi	s2,at,0x5f6e
  3c:	30313931 	andi	s1,at,0x3931
  40:	6c2f3431 	0x6c2f3431
  44:	33316261 	andi	s1,t9,0x6261
  48:	2f35312d 	sltiu	s5,t9,12589
  4c:	5f626c74 	0x5f626c74
  50:	636e7566 	0x636e7566
  54:	554e4700 	0x554e4700
  58:	20534120 	addi	s3,v0,16672
  5c:	34322e32 	ori	s2,at,0x2e32
  60:	67800100 	0x67800100
  64:	02000000 	0x2000000
  68:	00001400 	sll	v0,zero,0x10
  6c:	3e010400 	0x3e010400
  70:	d0000001 	0xd0000001
  74:	7cbfc006 	0x7cbfc006
  78:	6ebfc007 	0x6ebfc007
  7c:	6e695f31 	0x6e695f31
  80:	2e786564 	sltiu	t8,s3,25956
  84:	682f0053 	0x682f0053
  88:	2f656d6f 	sltiu	a1,k1,28015
  8c:	2d61696a 	sltiu	at,t3,26986
  90:	2f6e6166 	sltiu	t6,k1,24934
  94:	6b726f77 	0x6b726f77
  98:	61696a2f 	0x61696a2f
  9c:	5f6e6166 	0x5f6e6166
  a0:	39313032 	xori	s1,t1,0x3032
  a4:	34313031 	ori	s1,at,0x3031
  a8:	62616c2f 	0x62616c2f
  ac:	312d3331 	andi	t5,t1,0x3331
  b0:	6c742f35 	0x6c742f35
  b4:	75665f62 	jalx	5997d88 <data_size+0x5997d78>
  b8:	692f636e 	0x692f636e
  bc:	0074736e 	0x74736e
  c0:	20554e47 	addi	s5,v0,20039
  c4:	32205341 	andi	zero,s1,0x5341
  c8:	0034322e 	0x34322e
  cc:	006e8001 	0x6e8001
  d0:	00020000 	sll	zero,v0,0x0
  d4:	00000028 	0x28
  d8:	019f0104 	0x19f0104
  dc:	07800000 	bltz	gp,e0 <data_size+0xd0>
  e0:	07f0bfc0 	bltzal	ra,fffeffe4 <data_load_start+0x403ef1dc>
  e4:	386ebfc0 	xori	t6,v1,0xbfc0
  e8:	6f74735f 	0x6f74735f
  ec:	745f6572 	jalx	17d95c8 <data_size+0x17d95b8>
  f0:	655f626c 	0x655f626c
  f4:	00532e78 	0x532e78
  f8:	6d6f682f 	0x6d6f682f
  fc:	696a2f65 	0x696a2f65
 100:	61662d61 	0x61662d61
 104:	6f772f6e 	0x6f772f6e
 108:	6a2f6b72 	0x6a2f6b72
 10c:	61666169 	0x61666169
 110:	30325f6e 	andi	s2,at,0x5f6e
 114:	30313931 	andi	s1,at,0x3931
 118:	6c2f3431 	0x6c2f3431
 11c:	33316261 	andi	s1,t9,0x6261
 120:	2f35312d 	sltiu	s5,t9,12589
 124:	5f626c74 	0x5f626c74
 128:	636e7566 	0x636e7566
 12c:	736e692f 	0x736e692f
 130:	4e470074 	c3	0x470074
 134:	53412055 	0x53412055
 138:	322e3220 	andi	t6,s1,0x3220
 13c:	80010034 	lb	at,52(zero)
 140:	0000006c 	0x6c
 144:	003c0002 	0x3c0002
 148:	01040000 	0x1040000
 14c:	000001f5 	0x1f5
 150:	bfc007f0 	0xbfc007f0
 154:	bfc00a2c 	0xbfc00a2c
 158:	745f356e 	jalx	17cd5b8 <data_size+0x17cd5a8>
 15c:	6977626c 	0x6977626c
 160:	626c745f 	0x626c745f
 164:	00532e72 	0x532e72
 168:	6d6f682f 	0x6d6f682f
 16c:	696a2f65 	0x696a2f65
 170:	61662d61 	0x61662d61
 174:	6f772f6e 	0x6f772f6e
 178:	6a2f6b72 	0x6a2f6b72
 17c:	61666169 	0x61666169
 180:	30325f6e 	andi	s2,at,0x5f6e
 184:	30313931 	andi	s1,at,0x3931
 188:	6c2f3431 	0x6c2f3431
 18c:	33316261 	andi	s1,t9,0x6261
 190:	2f35312d 	sltiu	s5,t9,12589
 194:	5f626c74 	0x5f626c74
 198:	636e7566 	0x636e7566
 19c:	736e692f 	0x736e692f
 1a0:	4e470074 	c3	0x470074
 1a4:	53412055 	0x53412055
 1a8:	322e3220 	andi	t6,s1,0x3220
 1ac:	80010034 	lb	at,52(zero)
 1b0:	00000066 	0x66
 1b4:	00500002 	0x500002
 1b8:	01040000 	0x1040000
 1bc:	000002a7 	0x2a7
 1c0:	bfc00a30 	0xbfc00a30
 1c4:	bfc00ad4 	0xbfc00ad4
 1c8:	745f366e 	jalx	17cd9b8 <data_size+0x17cd9a8>
 1cc:	2e70626c 	sltiu	s0,s3,25196
 1d0:	682f0053 	0x682f0053
 1d4:	2f656d6f 	sltiu	a1,k1,28015
 1d8:	2d61696a 	sltiu	at,t3,26986
 1dc:	2f6e6166 	sltiu	t6,k1,24934
 1e0:	6b726f77 	0x6b726f77
 1e4:	61696a2f 	0x61696a2f
 1e8:	5f6e6166 	0x5f6e6166
 1ec:	39313032 	xori	s1,t1,0x3032
 1f0:	34313031 	ori	s1,at,0x3031
 1f4:	62616c2f 	0x62616c2f
 1f8:	312d3331 	andi	t5,t1,0x3331
 1fc:	6c742f35 	0x6c742f35
 200:	75665f62 	jalx	5997d88 <data_size+0x5997d78>
 204:	692f636e 	0x692f636e
 208:	0074736e 	0x74736e
 20c:	20554e47 	addi	s5,v0,20039
 210:	32205341 	andi	zero,s1,0x5341
 214:	0034322e 	0x34322e
 218:	006e8001 	0x6e8001
 21c:	00020000 	sll	zero,v0,0x0
 220:	00000064 	0x64
 224:	03020104 	0x3020104
 228:	0ae00000 	j	b800000 <data_size+0xb7ffff0>
 22c:	0b4cbfc0 	j	d32ff00 <data_size+0xd32fef0>
 230:	396ebfc0 	xori	t6,t3,0xbfc0
 234:	7465665f 	jalx	195997c <data_size+0x195996c>
 238:	745f6863 	jalx	17da18c <data_size+0x17da17c>
 23c:	655f626c 	0x655f626c
 240:	00532e78 	0x532e78
 244:	6d6f682f 	0x6d6f682f
 248:	696a2f65 	0x696a2f65
 24c:	61662d61 	0x61662d61
 250:	6f772f6e 	0x6f772f6e
 254:	6a2f6b72 	0x6a2f6b72
 258:	61666169 	0x61666169
 25c:	30325f6e 	andi	s2,at,0x5f6e
 260:	30313931 	andi	s1,at,0x3931
 264:	6c2f3431 	0x6c2f3431
 268:	33316261 	andi	s1,t9,0x6261
 26c:	2f35312d 	sltiu	s5,t9,12589
 270:	5f626c74 	0x5f626c74
 274:	636e7566 	0x636e7566
 278:	736e692f 	0x736e692f
 27c:	4e470074 	c3	0x470074
 280:	53412055 	0x53412055
 284:	322e3220 	andi	t6,s1,0x3220
 288:	80010034 	lb	at,52(zero)
 28c:	0000006a 	0x6a
 290:	00780002 	0x780002
 294:	01040000 	0x1040000
 298:	00000358 	0x358
 29c:	bfc00b50 	0xbfc00b50
 2a0:	bfc00c04 	0xbfc00c04
 2a4:	655f336e 	0x655f336e
 2a8:	7972746e 	0x7972746e
 2ac:	2e306f6c 	sltiu	s0,s1,28524
 2b0:	682f0053 	0x682f0053
 2b4:	2f656d6f 	sltiu	a1,k1,28015
 2b8:	2d61696a 	sltiu	at,t3,26986
 2bc:	2f6e6166 	sltiu	t6,k1,24934
 2c0:	6b726f77 	0x6b726f77
 2c4:	61696a2f 	0x61696a2f
 2c8:	5f6e6166 	0x5f6e6166
 2cc:	39313032 	xori	s1,t1,0x3032
 2d0:	34313031 	ori	s1,at,0x3031
 2d4:	62616c2f 	0x62616c2f
 2d8:	312d3331 	andi	t5,t1,0x3331
 2dc:	6c742f35 	0x6c742f35
 2e0:	75665f62 	jalx	5997d88 <data_size+0x5997d78>
 2e4:	692f636e 	0x692f636e
 2e8:	0074736e 	0x74736e
 2ec:	20554e47 	addi	s5,v0,20039
 2f0:	32205341 	andi	zero,s1,0x5341
 2f4:	0034322e 	0x34322e
 2f8:	006d8001 	0x6d8001
 2fc:	00020000 	sll	zero,v0,0x0
 300:	0000008c 	syscall	0x2
 304:	03bb0104 	0x3bb0104
 308:	0c100000 	jal	400000 <data_size+0x3ffff0>
 30c:	0c7cbfc0 	jal	1f2ff00 <data_size+0x1f2fef0>
 310:	376ebfc0 	ori	t6,k1,0xbfc0
 314:	616f6c5f 	0x616f6c5f
 318:	6c745f64 	0x6c745f64
 31c:	78655f62 	0x78655f62
 320:	2f00532e 	sltiu	zero,t8,21294
 324:	656d6f68 	0x656d6f68
 328:	61696a2f 	0x61696a2f
 32c:	6e61662d 	0x6e61662d
 330:	726f772f 	0x726f772f
 334:	696a2f6b 	0x696a2f6b
 338:	6e616661 	0x6e616661
 33c:	3130325f 	andi	s0,t1,0x325f
 340:	31303139 	andi	s0,t1,0x3139
 344:	616c2f34 	0x616c2f34
 348:	2d333162 	sltiu	s3,t1,12642
 34c:	742f3531 	jalx	bcd4c4 <data_size+0xbcd4b4>
 350:	665f626c 	0x665f626c
 354:	2f636e75 	sltiu	v1,k1,28277
 358:	74736e69 	jalx	1cdb9a4 <data_size+0x1cdb994>
 35c:	554e4700 	0x554e4700
 360:	20534120 	addi	s3,v0,16672
 364:	34322e32 	ori	s2,at,0x2e32
 368:	6a800100 	0x6a800100
 36c:	02000000 	0x2000000
 370:	0000a000 	sll	s4,zero,0x0
 374:	0f010400 	jal	c041000 <data_size+0xc040ff0>
 378:	80000004 	lb	zero,4(zero)
 37c:	34bfc00c 	ori	ra,a1,0xc00c
 380:	6ebfc00d 	0x6ebfc00d
 384:	6e655f34 	0x6e655f34
 388:	6c797274 	0x6c797274
 38c:	532e316f 	0x532e316f
 390:	6f682f00 	0x6f682f00
 394:	6a2f656d 	0x6a2f656d
 398:	662d6169 	0x662d6169
 39c:	772f6e61 	jalx	cbdb984 <data_size+0xcbdb974>
 3a0:	2f6b726f 	sltiu	t3,k1,29295
 3a4:	6661696a 	0x6661696a
 3a8:	325f6e61 	andi	ra,s2,0x6e61
 3ac:	31393130 	andi	t9,t1,0x3130
 3b0:	2f343130 	sltiu	s4,t9,12592
 3b4:	3162616c 	andi	v0,t3,0x616c
 3b8:	35312d33 	ori	s1,t1,0x2d33
 3bc:	626c742f 	0x626c742f
 3c0:	6e75665f 	0x6e75665f
 3c4:	6e692f63 	0x6e692f63
 3c8:	47007473 	c1	0x1007473
 3cc:	4120554e 	0x4120554e
 3d0:	2e322053 	sltiu	s2,s1,8275
 3d4:	01003432 	0x1003432
 3d8:	00006980 	sll	t5,zero,0x6
 3dc:	b4000200 	0xb4000200
 3e0:	04000000 	bltz	zero,3e4 <data_size+0x3d4>
 3e4:	00047201 	0x47201
 3e8:	c00d4000 	lwc0	c0_cause,16384(zero)
 3ec:	c00df0bf 	lwc0	c0_cause,-3905(zero)
 3f0:	5f326ebf 	0x5f326ebf
 3f4:	72746e65 	0x72746e65
 3f8:	2e696879 	sltiu	t1,s3,26745
 3fc:	682f0053 	0x682f0053
 400:	2f656d6f 	sltiu	a1,k1,28015
 404:	2d61696a 	sltiu	at,t3,26986
 408:	2f6e6166 	sltiu	t6,k1,24934
 40c:	6b726f77 	0x6b726f77
 410:	61696a2f 	0x61696a2f
 414:	5f6e6166 	0x5f6e6166
 418:	39313032 	xori	s1,t1,0x3032
 41c:	34313031 	ori	s1,at,0x3031
 420:	62616c2f 	0x62616c2f
 424:	312d3331 	andi	t5,t1,0x3331
 428:	6c742f35 	0x6c742f35
 42c:	75665f62 	jalx	5997d88 <data_size+0x5997d78>
 430:	692f636e 	0x692f636e
 434:	0074736e 	0x74736e
 438:	20554e47 	addi	s5,v0,20039
 43c:	32205341 	andi	zero,s1,0x5341
 440:	0034322e 	0x34322e
 444:	Address 0x0000000000000444 is out of bounds.


Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	b	4408 <data_size+0x43f8>
   4:	12011106 	beq	s0,at,4420 <data_size+0x4410>
   8:	1b080301 	0x1b080301
   c:	13082508 	beq	t8,t0,9430 <data_size+0x9420>
  10:	00000005 	0x5
  14:	10001101 	b	441c <data_size+0x440c>
  18:	12011106 	beq	s0,at,4434 <data_size+0x4424>
  1c:	1b080301 	0x1b080301
  20:	13082508 	beq	t8,t0,9444 <data_size+0x9434>
  24:	00000005 	0x5
  28:	10001101 	b	4430 <data_size+0x4420>
  2c:	12011106 	beq	s0,at,4448 <data_size+0x4438>
  30:	1b080301 	0x1b080301
  34:	13082508 	beq	t8,t0,9458 <data_size+0x9448>
  38:	00000005 	0x5
  3c:	10001101 	b	4444 <data_size+0x4434>
  40:	12011106 	beq	s0,at,445c <data_size+0x444c>
  44:	1b080301 	0x1b080301
  48:	13082508 	beq	t8,t0,946c <data_size+0x945c>
  4c:	00000005 	0x5
  50:	10001101 	b	4458 <data_size+0x4448>
  54:	12011106 	beq	s0,at,4470 <data_size+0x4460>
  58:	1b080301 	0x1b080301
  5c:	13082508 	beq	t8,t0,9480 <data_size+0x9470>
  60:	00000005 	0x5
  64:	10001101 	b	446c <data_size+0x445c>
  68:	12011106 	beq	s0,at,4484 <data_size+0x4474>
  6c:	1b080301 	0x1b080301
  70:	13082508 	beq	t8,t0,9494 <data_size+0x9484>
  74:	00000005 	0x5
  78:	10001101 	b	4480 <data_size+0x4470>
  7c:	12011106 	beq	s0,at,4498 <data_size+0x4488>
  80:	1b080301 	0x1b080301
  84:	13082508 	beq	t8,t0,94a8 <data_size+0x9498>
  88:	00000005 	0x5
  8c:	10001101 	b	4494 <data_size+0x4484>
  90:	12011106 	beq	s0,at,44ac <data_size+0x449c>
  94:	1b080301 	0x1b080301
  98:	13082508 	beq	t8,t0,94bc <data_size+0x94ac>
  9c:	00000005 	0x5
  a0:	10001101 	b	44a8 <data_size+0x4498>
  a4:	12011106 	beq	s0,at,44c0 <data_size+0x44b0>
  a8:	1b080301 	0x1b080301
  ac:	13082508 	beq	t8,t0,94d0 <data_size+0x94c0>
  b0:	00000005 	0x5
  b4:	10001101 	b	44bc <data_size+0x44ac>
  b8:	12011106 	beq	s0,at,44d4 <data_size+0x44c4>
  bc:	1b080301 	0x1b080301
  c0:	13082508 	beq	t8,t0,94e4 <data_size+0x94d4>
  c4:	00000005 	0x5
