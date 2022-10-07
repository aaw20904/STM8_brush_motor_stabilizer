   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.6 - 16 Dec 2021
   3                     ; Generator (Limited) V4.5.4 - 16 Dec 2021
   4                     ; Optimizer V4.5.4 - 16 Dec 2021
  47                     ; 53 void UART1_DeInit(void)
  47                     ; 54 {
  49                     	switch	.text
  50  0000               _UART1_DeInit:
  54                     ; 57   (void)UART1->SR;
  56  0000 c65230        	ld	a,21040
  57                     ; 58   (void)UART1->DR;
  59  0003 c65231        	ld	a,21041
  60                     ; 60   UART1->BRR2 = UART1_BRR2_RESET_VALUE;  /* Set UART1_BRR2 to reset value 0x00 */
  62  0006 725f5233      	clr	21043
  63                     ; 61   UART1->BRR1 = UART1_BRR1_RESET_VALUE;  /* Set UART1_BRR1 to reset value 0x00 */
  65  000a 725f5232      	clr	21042
  66                     ; 63   UART1->CR1 = UART1_CR1_RESET_VALUE;  /* Set UART1_CR1 to reset value 0x00 */
  68  000e 725f5234      	clr	21044
  69                     ; 64   UART1->CR2 = UART1_CR2_RESET_VALUE;  /* Set UART1_CR2 to reset value 0x00 */
  71  0012 725f5235      	clr	21045
  72                     ; 65   UART1->CR3 = UART1_CR3_RESET_VALUE;  /* Set UART1_CR3 to reset value 0x00 */
  74  0016 725f5236      	clr	21046
  75                     ; 66   UART1->CR4 = UART1_CR4_RESET_VALUE;  /* Set UART1_CR4 to reset value 0x00 */
  77  001a 725f5237      	clr	21047
  78                     ; 67   UART1->CR5 = UART1_CR5_RESET_VALUE;  /* Set UART1_CR5 to reset value 0x00 */
  80  001e 725f5238      	clr	21048
  81                     ; 69   UART1->GTR = UART1_GTR_RESET_VALUE;
  83  0022 725f5239      	clr	21049
  84                     ; 70   UART1->PSCR = UART1_PSCR_RESET_VALUE;
  86  0026 725f523a      	clr	21050
  87                     ; 71 }
  90  002a 81            	ret	
 387                     .const:	section	.text
 388  0000               L41:
 389  0000 00000064      	dc.l	100
 390                     ; 90 void UART1_Init(uint32_t BaudRate, UART1_WordLength_TypeDef WordLength, 
 390                     ; 91                 UART1_StopBits_TypeDef StopBits, UART1_Parity_TypeDef Parity, 
 390                     ; 92                 UART1_SyncMode_TypeDef SyncMode, UART1_Mode_TypeDef Mode)
 390                     ; 93 {
 391                     	switch	.text
 392  002b               _UART1_Init:
 394  002b 520c          	subw	sp,#12
 395       0000000c      OFST:	set	12
 398                     ; 94   uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 402                     ; 97   assert_param(IS_UART1_BAUDRATE_OK(BaudRate));
 404                     ; 98   assert_param(IS_UART1_WORDLENGTH_OK(WordLength));
 406                     ; 99   assert_param(IS_UART1_STOPBITS_OK(StopBits));
 408                     ; 100   assert_param(IS_UART1_PARITY_OK(Parity));
 410                     ; 101   assert_param(IS_UART1_MODE_OK((uint8_t)Mode));
 412                     ; 102   assert_param(IS_UART1_SYNCMODE_OK((uint8_t)SyncMode));
 414                     ; 105   UART1->CR1 &= (uint8_t)(~UART1_CR1_M);  
 416  002d 72195234      	bres	21044,#4
 417                     ; 108   UART1->CR1 |= (uint8_t)WordLength;
 419  0031 c65234        	ld	a,21044
 420  0034 1a13          	or	a,(OFST+7,sp)
 421  0036 c75234        	ld	21044,a
 422                     ; 111   UART1->CR3 &= (uint8_t)(~UART1_CR3_STOP);  
 424  0039 c65236        	ld	a,21046
 425  003c a4cf          	and	a,#207
 426  003e c75236        	ld	21046,a
 427                     ; 113   UART1->CR3 |= (uint8_t)StopBits;  
 429  0041 c65236        	ld	a,21046
 430  0044 1a14          	or	a,(OFST+8,sp)
 431  0046 c75236        	ld	21046,a
 432                     ; 116   UART1->CR1 &= (uint8_t)(~(UART1_CR1_PCEN | UART1_CR1_PS  ));  
 434  0049 c65234        	ld	a,21044
 435  004c a4f9          	and	a,#249
 436  004e c75234        	ld	21044,a
 437                     ; 118   UART1->CR1 |= (uint8_t)Parity;  
 439  0051 c65234        	ld	a,21044
 440  0054 1a15          	or	a,(OFST+9,sp)
 441  0056 c75234        	ld	21044,a
 442                     ; 121   UART1->BRR1 &= (uint8_t)(~UART1_BRR1_DIVM);  
 444  0059 725f5232      	clr	21042
 445                     ; 123   UART1->BRR2 &= (uint8_t)(~UART1_BRR2_DIVM);  
 447  005d c65233        	ld	a,21043
 448  0060 a40f          	and	a,#15
 449  0062 c75233        	ld	21043,a
 450                     ; 125   UART1->BRR2 &= (uint8_t)(~UART1_BRR2_DIVF);  
 452  0065 c65233        	ld	a,21043
 453  0068 a4f0          	and	a,#240
 454  006a c75233        	ld	21043,a
 455                     ; 128   BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 457  006d 96            	ldw	x,sp
 458  006e cd0138        	call	LC001
 460  0071 96            	ldw	x,sp
 461  0072 5c            	incw	x
 462  0073 cd0000        	call	c_rtol
 465  0076 cd0000        	call	_CLK_GetClockFreq
 467  0079 96            	ldw	x,sp
 468  007a 5c            	incw	x
 469  007b cd0000        	call	c_ludv
 471  007e 96            	ldw	x,sp
 472  007f 1c0009        	addw	x,#OFST-3
 473  0082 cd0000        	call	c_rtol
 476                     ; 129   BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 478  0085 96            	ldw	x,sp
 479  0086 cd0138        	call	LC001
 481  0089 96            	ldw	x,sp
 482  008a 5c            	incw	x
 483  008b cd0000        	call	c_rtol
 486  008e cd0000        	call	_CLK_GetClockFreq
 488  0091 a664          	ld	a,#100
 489  0093 cd0000        	call	c_smul
 491  0096 96            	ldw	x,sp
 492  0097 5c            	incw	x
 493  0098 cd0000        	call	c_ludv
 495  009b 96            	ldw	x,sp
 496  009c 1c0005        	addw	x,#OFST-7
 497  009f cd0000        	call	c_rtol
 500                     ; 131   UART1->BRR2 |= (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100)) << 4) / 100) & (uint8_t)0x0F); 
 502  00a2 96            	ldw	x,sp
 503  00a3 1c0009        	addw	x,#OFST-3
 504  00a6 cd0000        	call	c_ltor
 506  00a9 a664          	ld	a,#100
 507  00ab cd0000        	call	c_smul
 509  00ae 96            	ldw	x,sp
 510  00af 5c            	incw	x
 511  00b0 cd0000        	call	c_rtol
 514  00b3 96            	ldw	x,sp
 515  00b4 1c0005        	addw	x,#OFST-7
 516  00b7 cd0000        	call	c_ltor
 518  00ba 96            	ldw	x,sp
 519  00bb 5c            	incw	x
 520  00bc cd0000        	call	c_lsub
 522  00bf a604          	ld	a,#4
 523  00c1 cd0000        	call	c_llsh
 525  00c4 ae0000        	ldw	x,#L41
 526  00c7 cd0000        	call	c_ludv
 528  00ca b603          	ld	a,c_lreg+3
 529  00cc a40f          	and	a,#15
 530  00ce ca5233        	or	a,21043
 531  00d1 c75233        	ld	21043,a
 532                     ; 133   UART1->BRR2 |= (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0); 
 534  00d4 1e0b          	ldw	x,(OFST-1,sp)
 535  00d6 54            	srlw	x
 536  00d7 54            	srlw	x
 537  00d8 54            	srlw	x
 538  00d9 54            	srlw	x
 539  00da 01            	rrwa	x,a
 540  00db a4f0          	and	a,#240
 541  00dd ca5233        	or	a,21043
 542  00e0 c75233        	ld	21043,a
 543                     ; 135   UART1->BRR1 |= (uint8_t)BaudRate_Mantissa;           
 545  00e3 c65232        	ld	a,21042
 546  00e6 1a0c          	or	a,(OFST+0,sp)
 547  00e8 c75232        	ld	21042,a
 548                     ; 138   UART1->CR2 &= (uint8_t)~(UART1_CR2_TEN | UART1_CR2_REN); 
 550  00eb c65235        	ld	a,21045
 551  00ee a4f3          	and	a,#243
 552  00f0 c75235        	ld	21045,a
 553                     ; 140   UART1->CR3 &= (uint8_t)~(UART1_CR3_CPOL | UART1_CR3_CPHA | UART1_CR3_LBCL); 
 555  00f3 c65236        	ld	a,21046
 556  00f6 a4f8          	and	a,#248
 557  00f8 c75236        	ld	21046,a
 558                     ; 142   UART1->CR3 |= (uint8_t)((uint8_t)SyncMode & (uint8_t)(UART1_CR3_CPOL | 
 558                     ; 143                                                         UART1_CR3_CPHA | UART1_CR3_LBCL));  
 560  00fb 7b16          	ld	a,(OFST+10,sp)
 561  00fd a407          	and	a,#7
 562  00ff ca5236        	or	a,21046
 563  0102 c75236        	ld	21046,a
 564                     ; 145   if ((uint8_t)(Mode & UART1_MODE_TX_ENABLE))
 566  0105 7b17          	ld	a,(OFST+11,sp)
 567  0107 a504          	bcp	a,#4
 568  0109 2706          	jreq	L561
 569                     ; 148     UART1->CR2 |= (uint8_t)UART1_CR2_TEN;  
 571  010b 72165235      	bset	21045,#3
 573  010f 2004          	jra	L761
 574  0111               L561:
 575                     ; 153     UART1->CR2 &= (uint8_t)(~UART1_CR2_TEN);  
 577  0111 72175235      	bres	21045,#3
 578  0115               L761:
 579                     ; 155   if ((uint8_t)(Mode & UART1_MODE_RX_ENABLE))
 581  0115 a508          	bcp	a,#8
 582  0117 2706          	jreq	L171
 583                     ; 158     UART1->CR2 |= (uint8_t)UART1_CR2_REN;  
 585  0119 72145235      	bset	21045,#2
 587  011d 2004          	jra	L371
 588  011f               L171:
 589                     ; 163     UART1->CR2 &= (uint8_t)(~UART1_CR2_REN);  
 591  011f 72155235      	bres	21045,#2
 592  0123               L371:
 593                     ; 167   if ((uint8_t)(SyncMode & UART1_SYNCMODE_CLOCK_DISABLE))
 595  0123 7b16          	ld	a,(OFST+10,sp)
 596  0125 2a06          	jrpl	L571
 597                     ; 170     UART1->CR3 &= (uint8_t)(~UART1_CR3_CKEN); 
 599  0127 72175236      	bres	21046,#3
 601  012b 2008          	jra	L771
 602  012d               L571:
 603                     ; 174     UART1->CR3 |= (uint8_t)((uint8_t)SyncMode & UART1_CR3_CKEN);
 605  012d a408          	and	a,#8
 606  012f ca5236        	or	a,21046
 607  0132 c75236        	ld	21046,a
 608  0135               L771:
 609                     ; 176 }
 612  0135 5b0c          	addw	sp,#12
 613  0137 81            	ret	
 614  0138               LC001:
 615  0138 1c000f        	addw	x,#OFST+3
 616  013b cd0000        	call	c_ltor
 618  013e a604          	ld	a,#4
 619  0140 cc0000        	jp	c_llsh
 674                     ; 184 void UART1_Cmd(FunctionalState NewState)
 674                     ; 185 {
 675                     	switch	.text
 676  0143               _UART1_Cmd:
 680                     ; 186   if (NewState != DISABLE)
 682  0143 4d            	tnz	a
 683  0144 2705          	jreq	L722
 684                     ; 189     UART1->CR1 &= (uint8_t)(~UART1_CR1_UARTD); 
 686  0146 721b5234      	bres	21044,#5
 689  014a 81            	ret	
 690  014b               L722:
 691                     ; 194     UART1->CR1 |= UART1_CR1_UARTD;  
 693  014b 721a5234      	bset	21044,#5
 694                     ; 196 }
 697  014f 81            	ret	
 818                     ; 211 void UART1_ITConfig(UART1_IT_TypeDef UART1_IT, FunctionalState NewState)
 818                     ; 212 {
 819                     	switch	.text
 820  0150               _UART1_ITConfig:
 822  0150 89            	pushw	x
 823  0151 89            	pushw	x
 824       00000002      OFST:	set	2
 827                     ; 213   uint8_t uartreg = 0, itpos = 0x00;
 831                     ; 216   assert_param(IS_UART1_CONFIG_IT_OK(UART1_IT));
 833                     ; 217   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 835                     ; 220   uartreg = (uint8_t)((uint16_t)UART1_IT >> 0x08);
 837  0152 9e            	ld	a,xh
 838  0153 6b01          	ld	(OFST-1,sp),a
 840                     ; 222   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART1_IT & (uint8_t)0x0F));
 842  0155 9f            	ld	a,xl
 843  0156 a40f          	and	a,#15
 844  0158 5f            	clrw	x
 845  0159 97            	ld	xl,a
 846  015a a601          	ld	a,#1
 847  015c 5d            	tnzw	x
 848  015d 2704          	jreq	L22
 849  015f               L42:
 850  015f 48            	sll	a
 851  0160 5a            	decw	x
 852  0161 26fc          	jrne	L42
 853  0163               L22:
 854  0163 6b02          	ld	(OFST+0,sp),a
 856                     ; 224   if (NewState != DISABLE)
 858  0165 7b07          	ld	a,(OFST+5,sp)
 859  0167 271f          	jreq	L503
 860                     ; 227     if (uartreg == 0x01)
 862  0169 7b01          	ld	a,(OFST-1,sp)
 863  016b a101          	cp	a,#1
 864  016d 2607          	jrne	L703
 865                     ; 229       UART1->CR1 |= itpos;
 867  016f c65234        	ld	a,21044
 868  0172 1a02          	or	a,(OFST+0,sp)
 870  0174 201e          	jp	LC003
 871  0176               L703:
 872                     ; 231     else if (uartreg == 0x02)
 874  0176 a102          	cp	a,#2
 875  0178 2607          	jrne	L313
 876                     ; 233       UART1->CR2 |= itpos;
 878  017a c65235        	ld	a,21045
 879  017d 1a02          	or	a,(OFST+0,sp)
 881  017f 2022          	jp	LC004
 882  0181               L313:
 883                     ; 237       UART1->CR4 |= itpos;
 885  0181 c65237        	ld	a,21047
 886  0184 1a02          	or	a,(OFST+0,sp)
 887  0186 2026          	jp	LC002
 888  0188               L503:
 889                     ; 243     if (uartreg == 0x01)
 891  0188 7b01          	ld	a,(OFST-1,sp)
 892  018a a101          	cp	a,#1
 893  018c 260b          	jrne	L123
 894                     ; 245       UART1->CR1 &= (uint8_t)(~itpos);
 896  018e 7b02          	ld	a,(OFST+0,sp)
 897  0190 43            	cpl	a
 898  0191 c45234        	and	a,21044
 899  0194               LC003:
 900  0194 c75234        	ld	21044,a
 902  0197 2018          	jra	L713
 903  0199               L123:
 904                     ; 247     else if (uartreg == 0x02)
 906  0199 a102          	cp	a,#2
 907  019b 260b          	jrne	L523
 908                     ; 249       UART1->CR2 &= (uint8_t)(~itpos);
 910  019d 7b02          	ld	a,(OFST+0,sp)
 911  019f 43            	cpl	a
 912  01a0 c45235        	and	a,21045
 913  01a3               LC004:
 914  01a3 c75235        	ld	21045,a
 916  01a6 2009          	jra	L713
 917  01a8               L523:
 918                     ; 253       UART1->CR4 &= (uint8_t)(~itpos);
 920  01a8 7b02          	ld	a,(OFST+0,sp)
 921  01aa 43            	cpl	a
 922  01ab c45237        	and	a,21047
 923  01ae               LC002:
 924  01ae c75237        	ld	21047,a
 925  01b1               L713:
 926                     ; 257 }
 929  01b1 5b04          	addw	sp,#4
 930  01b3 81            	ret	
 966                     ; 265 void UART1_HalfDuplexCmd(FunctionalState NewState)
 966                     ; 266 {
 967                     	switch	.text
 968  01b4               _UART1_HalfDuplexCmd:
 972                     ; 267   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 974                     ; 269   if (NewState != DISABLE)
 976  01b4 4d            	tnz	a
 977  01b5 2705          	jreq	L743
 978                     ; 271     UART1->CR5 |= UART1_CR5_HDSEL;  /**< UART1 Half Duplex Enable  */
 980  01b7 72165238      	bset	21048,#3
 983  01bb 81            	ret	
 984  01bc               L743:
 985                     ; 275     UART1->CR5 &= (uint8_t)~UART1_CR5_HDSEL; /**< UART1 Half Duplex Disable */
 987  01bc 72175238      	bres	21048,#3
 988                     ; 277 }
 991  01c0 81            	ret	
1048                     ; 285 void UART1_IrDAConfig(UART1_IrDAMode_TypeDef UART1_IrDAMode)
1048                     ; 286 {
1049                     	switch	.text
1050  01c1               _UART1_IrDAConfig:
1054                     ; 287   assert_param(IS_UART1_IRDAMODE_OK(UART1_IrDAMode));
1056                     ; 289   if (UART1_IrDAMode != UART1_IRDAMODE_NORMAL)
1058  01c1 4d            	tnz	a
1059  01c2 2705          	jreq	L104
1060                     ; 291     UART1->CR5 |= UART1_CR5_IRLP;
1062  01c4 72145238      	bset	21048,#2
1065  01c8 81            	ret	
1066  01c9               L104:
1067                     ; 295     UART1->CR5 &= ((uint8_t)~UART1_CR5_IRLP);
1069  01c9 72155238      	bres	21048,#2
1070                     ; 297 }
1073  01cd 81            	ret	
1108                     ; 305 void UART1_IrDACmd(FunctionalState NewState)
1108                     ; 306 {
1109                     	switch	.text
1110  01ce               _UART1_IrDACmd:
1114                     ; 308   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1116                     ; 310   if (NewState != DISABLE)
1118  01ce 4d            	tnz	a
1119  01cf 2705          	jreq	L324
1120                     ; 313     UART1->CR5 |= UART1_CR5_IREN;
1122  01d1 72125238      	bset	21048,#1
1125  01d5 81            	ret	
1126  01d6               L324:
1127                     ; 318     UART1->CR5 &= ((uint8_t)~UART1_CR5_IREN);
1129  01d6 72135238      	bres	21048,#1
1130                     ; 320 }
1133  01da 81            	ret	
1192                     ; 329 void UART1_LINBreakDetectionConfig(UART1_LINBreakDetectionLength_TypeDef UART1_LINBreakDetectionLength)
1192                     ; 330 {
1193                     	switch	.text
1194  01db               _UART1_LINBreakDetectionConfig:
1198                     ; 331   assert_param(IS_UART1_LINBREAKDETECTIONLENGTH_OK(UART1_LINBreakDetectionLength));
1200                     ; 333   if (UART1_LINBreakDetectionLength != UART1_LINBREAKDETECTIONLENGTH_10BITS)
1202  01db 4d            	tnz	a
1203  01dc 2705          	jreq	L554
1204                     ; 335     UART1->CR4 |= UART1_CR4_LBDL;
1206  01de 721a5237      	bset	21047,#5
1209  01e2 81            	ret	
1210  01e3               L554:
1211                     ; 339     UART1->CR4 &= ((uint8_t)~UART1_CR4_LBDL);
1213  01e3 721b5237      	bres	21047,#5
1214                     ; 341 }
1217  01e7 81            	ret	
1252                     ; 349 void UART1_LINCmd(FunctionalState NewState)
1252                     ; 350 {
1253                     	switch	.text
1254  01e8               _UART1_LINCmd:
1258                     ; 351   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1260                     ; 353   if (NewState != DISABLE)
1262  01e8 4d            	tnz	a
1263  01e9 2705          	jreq	L774
1264                     ; 356     UART1->CR3 |= UART1_CR3_LINEN;
1266  01eb 721c5236      	bset	21046,#6
1269  01ef 81            	ret	
1270  01f0               L774:
1271                     ; 361     UART1->CR3 &= ((uint8_t)~UART1_CR3_LINEN);
1273  01f0 721d5236      	bres	21046,#6
1274                     ; 363 }
1277  01f4 81            	ret	
1312                     ; 371 void UART1_SmartCardCmd(FunctionalState NewState)
1312                     ; 372 {
1313                     	switch	.text
1314  01f5               _UART1_SmartCardCmd:
1318                     ; 373   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1320                     ; 375   if (NewState != DISABLE)
1322  01f5 4d            	tnz	a
1323  01f6 2705          	jreq	L125
1324                     ; 378     UART1->CR5 |= UART1_CR5_SCEN;
1326  01f8 721a5238      	bset	21048,#5
1329  01fc 81            	ret	
1330  01fd               L125:
1331                     ; 383     UART1->CR5 &= ((uint8_t)(~UART1_CR5_SCEN));
1333  01fd 721b5238      	bres	21048,#5
1334                     ; 385 }
1337  0201 81            	ret	
1373                     ; 394 void UART1_SmartCardNACKCmd(FunctionalState NewState)
1373                     ; 395 {
1374                     	switch	.text
1375  0202               _UART1_SmartCardNACKCmd:
1379                     ; 396   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1381                     ; 398   if (NewState != DISABLE)
1383  0202 4d            	tnz	a
1384  0203 2705          	jreq	L345
1385                     ; 401     UART1->CR5 |= UART1_CR5_NACK;
1387  0205 72185238      	bset	21048,#4
1390  0209 81            	ret	
1391  020a               L345:
1392                     ; 406     UART1->CR5 &= ((uint8_t)~(UART1_CR5_NACK));
1394  020a 72195238      	bres	21048,#4
1395                     ; 408 }
1398  020e 81            	ret	
1455                     ; 416 void UART1_WakeUpConfig(UART1_WakeUp_TypeDef UART1_WakeUp)
1455                     ; 417 {
1456                     	switch	.text
1457  020f               _UART1_WakeUpConfig:
1461                     ; 418   assert_param(IS_UART1_WAKEUP_OK(UART1_WakeUp));
1463                     ; 420   UART1->CR1 &= ((uint8_t)~UART1_CR1_WAKE);
1465  020f 72175234      	bres	21044,#3
1466                     ; 421   UART1->CR1 |= (uint8_t)UART1_WakeUp;
1468  0213 ca5234        	or	a,21044
1469  0216 c75234        	ld	21044,a
1470                     ; 422 }
1473  0219 81            	ret	
1509                     ; 430 void UART1_ReceiverWakeUpCmd(FunctionalState NewState)
1509                     ; 431 {
1510                     	switch	.text
1511  021a               _UART1_ReceiverWakeUpCmd:
1515                     ; 432   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1517                     ; 434   if (NewState != DISABLE)
1519  021a 4d            	tnz	a
1520  021b 2705          	jreq	L316
1521                     ; 437     UART1->CR2 |= UART1_CR2_RWU;
1523  021d 72125235      	bset	21045,#1
1526  0221 81            	ret	
1527  0222               L316:
1528                     ; 442     UART1->CR2 &= ((uint8_t)~UART1_CR2_RWU);
1530  0222 72135235      	bres	21045,#1
1531                     ; 444 }
1534  0226 81            	ret	
1557                     ; 451 uint8_t UART1_ReceiveData8(void)
1557                     ; 452 {
1558                     	switch	.text
1559  0227               _UART1_ReceiveData8:
1563                     ; 453   return ((uint8_t)UART1->DR);
1565  0227 c65231        	ld	a,21041
1568  022a 81            	ret	
1600                     ; 461 uint16_t UART1_ReceiveData9(void)
1600                     ; 462 {
1601                     	switch	.text
1602  022b               _UART1_ReceiveData9:
1604  022b 89            	pushw	x
1605       00000002      OFST:	set	2
1608                     ; 463   uint16_t temp = 0;
1610                     ; 465   temp = (uint16_t)(((uint16_t)( (uint16_t)UART1->CR1 & (uint16_t)UART1_CR1_R8)) << 1);
1612  022c c65234        	ld	a,21044
1613  022f a480          	and	a,#128
1614  0231 5f            	clrw	x
1615  0232 02            	rlwa	x,a
1616  0233 58            	sllw	x
1617  0234 1f01          	ldw	(OFST-1,sp),x
1619                     ; 466   return (uint16_t)( (((uint16_t) UART1->DR) | temp ) & ((uint16_t)0x01FF));
1621  0236 c65231        	ld	a,21041
1622  0239 5f            	clrw	x
1623  023a 97            	ld	xl,a
1624  023b 01            	rrwa	x,a
1625  023c 1a02          	or	a,(OFST+0,sp)
1626  023e 01            	rrwa	x,a
1627  023f 1a01          	or	a,(OFST-1,sp)
1628  0241 a401          	and	a,#1
1629  0243 01            	rrwa	x,a
1632  0244 5b02          	addw	sp,#2
1633  0246 81            	ret	
1665                     ; 474 void UART1_SendData8(uint8_t Data)
1665                     ; 475 {
1666                     	switch	.text
1667  0247               _UART1_SendData8:
1671                     ; 477   UART1->DR = Data;
1673  0247 c75231        	ld	21041,a
1674                     ; 478 }
1677  024a 81            	ret	
1709                     ; 486 void UART1_SendData9(uint16_t Data)
1709                     ; 487 {
1710                     	switch	.text
1711  024b               _UART1_SendData9:
1713  024b 89            	pushw	x
1714       00000000      OFST:	set	0
1717                     ; 489   UART1->CR1 &= ((uint8_t)~UART1_CR1_T8);
1719  024c 721d5234      	bres	21044,#6
1720                     ; 491   UART1->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART1_CR1_T8);
1722  0250 54            	srlw	x
1723  0251 54            	srlw	x
1724  0252 9f            	ld	a,xl
1725  0253 a440          	and	a,#64
1726  0255 ca5234        	or	a,21044
1727  0258 c75234        	ld	21044,a
1728                     ; 493   UART1->DR   = (uint8_t)(Data);
1730  025b 7b02          	ld	a,(OFST+2,sp)
1731  025d c75231        	ld	21041,a
1732                     ; 494 }
1735  0260 85            	popw	x
1736  0261 81            	ret	
1759                     ; 501 void UART1_SendBreak(void)
1759                     ; 502 {
1760                     	switch	.text
1761  0262               _UART1_SendBreak:
1765                     ; 503   UART1->CR2 |= UART1_CR2_SBK;
1767  0262 72105235      	bset	21045,#0
1768                     ; 504 }
1771  0266 81            	ret	
1803                     ; 511 void UART1_SetAddress(uint8_t UART1_Address)
1803                     ; 512 {
1804                     	switch	.text
1805  0267               _UART1_SetAddress:
1807  0267 88            	push	a
1808       00000000      OFST:	set	0
1811                     ; 514   assert_param(IS_UART1_ADDRESS_OK(UART1_Address));
1813                     ; 517   UART1->CR4 &= ((uint8_t)~UART1_CR4_ADD);
1815  0268 c65237        	ld	a,21047
1816  026b a4f0          	and	a,#240
1817  026d c75237        	ld	21047,a
1818                     ; 519   UART1->CR4 |= UART1_Address;
1820  0270 c65237        	ld	a,21047
1821  0273 1a01          	or	a,(OFST+1,sp)
1822  0275 c75237        	ld	21047,a
1823                     ; 520 }
1826  0278 84            	pop	a
1827  0279 81            	ret	
1859                     ; 528 void UART1_SetGuardTime(uint8_t UART1_GuardTime)
1859                     ; 529 {
1860                     	switch	.text
1861  027a               _UART1_SetGuardTime:
1865                     ; 531   UART1->GTR = UART1_GuardTime;
1867  027a c75239        	ld	21049,a
1868                     ; 532 }
1871  027d 81            	ret	
1903                     ; 556 void UART1_SetPrescaler(uint8_t UART1_Prescaler)
1903                     ; 557 {
1904                     	switch	.text
1905  027e               _UART1_SetPrescaler:
1909                     ; 559   UART1->PSCR = UART1_Prescaler;
1911  027e c7523a        	ld	21050,a
1912                     ; 560 }
1915  0281 81            	ret	
2058                     ; 568 FlagStatus UART1_GetFlagStatus(UART1_Flag_TypeDef UART1_FLAG)
2058                     ; 569 {
2059                     	switch	.text
2060  0282               _UART1_GetFlagStatus:
2062  0282 89            	pushw	x
2063  0283 88            	push	a
2064       00000001      OFST:	set	1
2067                     ; 570   FlagStatus status = RESET;
2069                     ; 573   assert_param(IS_UART1_FLAG_OK(UART1_FLAG));
2071                     ; 577   if (UART1_FLAG == UART1_FLAG_LBDF)
2073  0284 a30210        	cpw	x,#528
2074  0287 2608          	jrne	L1301
2075                     ; 579     if ((UART1->CR4 & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2077  0289 9f            	ld	a,xl
2078  028a c45237        	and	a,21047
2079  028d 271c          	jreq	L7301
2080                     ; 582       status = SET;
2082  028f 2015          	jp	LC007
2083                     ; 587       status = RESET;
2084  0291               L1301:
2085                     ; 590   else if (UART1_FLAG == UART1_FLAG_SBK)
2087  0291 a30101        	cpw	x,#257
2088  0294 2609          	jrne	L1401
2089                     ; 592     if ((UART1->CR2 & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2091  0296 c65235        	ld	a,21045
2092  0299 1503          	bcp	a,(OFST+2,sp)
2093  029b 270d          	jreq	L1501
2094                     ; 595       status = SET;
2096  029d 2007          	jp	LC007
2097                     ; 600       status = RESET;
2098  029f               L1401:
2099                     ; 605     if ((UART1->SR & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2101  029f c65230        	ld	a,21040
2102  02a2 1503          	bcp	a,(OFST+2,sp)
2103  02a4 2704          	jreq	L1501
2104                     ; 608       status = SET;
2106  02a6               LC007:
2109  02a6 a601          	ld	a,#1
2113  02a8 2001          	jra	L7301
2114  02aa               L1501:
2115                     ; 613       status = RESET;
2118  02aa 4f            	clr	a
2120  02ab               L7301:
2121                     ; 617   return status;
2125  02ab 5b03          	addw	sp,#3
2126  02ad 81            	ret	
2161                     ; 646 void UART1_ClearFlag(UART1_Flag_TypeDef UART1_FLAG)
2161                     ; 647 {
2162                     	switch	.text
2163  02ae               _UART1_ClearFlag:
2167                     ; 648   assert_param(IS_UART1_CLEAR_FLAG_OK(UART1_FLAG));
2169                     ; 651   if (UART1_FLAG == UART1_FLAG_RXNE)
2171  02ae a30020        	cpw	x,#32
2172  02b1 2605          	jrne	L3701
2173                     ; 653     UART1->SR = (uint8_t)~(UART1_SR_RXNE);
2175  02b3 35df5230      	mov	21040,#223
2178  02b7 81            	ret	
2179  02b8               L3701:
2180                     ; 658     UART1->CR4 &= (uint8_t)~(UART1_CR4_LBDF);
2182  02b8 72195237      	bres	21047,#4
2183                     ; 660 }
2186  02bc 81            	ret	
2260                     ; 675 ITStatus UART1_GetITStatus(UART1_IT_TypeDef UART1_IT)
2260                     ; 676 {
2261                     	switch	.text
2262  02bd               _UART1_GetITStatus:
2264  02bd 89            	pushw	x
2265  02be 89            	pushw	x
2266       00000002      OFST:	set	2
2269                     ; 677   ITStatus pendingbitstatus = RESET;
2271                     ; 678   uint8_t itpos = 0;
2273                     ; 679   uint8_t itmask1 = 0;
2275                     ; 680   uint8_t itmask2 = 0;
2277                     ; 681   uint8_t enablestatus = 0;
2279                     ; 684   assert_param(IS_UART1_GET_IT_OK(UART1_IT));
2281                     ; 687   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART1_IT & (uint8_t)0x0F));
2283  02bf 9f            	ld	a,xl
2284  02c0 a40f          	and	a,#15
2285  02c2 5f            	clrw	x
2286  02c3 97            	ld	xl,a
2287  02c4 a601          	ld	a,#1
2288  02c6 5d            	tnzw	x
2289  02c7 2704          	jreq	L67
2290  02c9               L001:
2291  02c9 48            	sll	a
2292  02ca 5a            	decw	x
2293  02cb 26fc          	jrne	L001
2294  02cd               L67:
2295  02cd 6b01          	ld	(OFST-1,sp),a
2297                     ; 689   itmask1 = (uint8_t)((uint8_t)UART1_IT >> (uint8_t)4);
2299  02cf 7b04          	ld	a,(OFST+2,sp)
2300  02d1 4e            	swap	a
2301  02d2 a40f          	and	a,#15
2302  02d4 6b02          	ld	(OFST+0,sp),a
2304                     ; 691   itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2306  02d6 5f            	clrw	x
2307  02d7 97            	ld	xl,a
2308  02d8 a601          	ld	a,#1
2309  02da 5d            	tnzw	x
2310  02db 2704          	jreq	L201
2311  02dd               L401:
2312  02dd 48            	sll	a
2313  02de 5a            	decw	x
2314  02df 26fc          	jrne	L401
2315  02e1               L201:
2316  02e1 6b02          	ld	(OFST+0,sp),a
2318                     ; 695   if (UART1_IT == UART1_IT_PE)
2320  02e3 1e03          	ldw	x,(OFST+1,sp)
2321  02e5 a30100        	cpw	x,#256
2322  02e8 260c          	jrne	L1311
2323                     ; 698     enablestatus = (uint8_t)((uint8_t)UART1->CR1 & itmask2);
2325  02ea c65234        	ld	a,21044
2326  02ed 1402          	and	a,(OFST+0,sp)
2327  02ef 6b02          	ld	(OFST+0,sp),a
2329                     ; 701     if (((UART1->SR & itpos) != (uint8_t)0x00) && enablestatus)
2331  02f1 c65230        	ld	a,21040
2333                     ; 704       pendingbitstatus = SET;
2335  02f4 200f          	jp	LC010
2336                     ; 709       pendingbitstatus = RESET;
2337  02f6               L1311:
2338                     ; 713   else if (UART1_IT == UART1_IT_LBDF)
2340  02f6 a30346        	cpw	x,#838
2341  02f9 2616          	jrne	L1411
2342                     ; 716     enablestatus = (uint8_t)((uint8_t)UART1->CR4 & itmask2);
2344  02fb c65237        	ld	a,21047
2345  02fe 1402          	and	a,(OFST+0,sp)
2346  0300 6b02          	ld	(OFST+0,sp),a
2348                     ; 718     if (((UART1->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2350  0302 c65237        	ld	a,21047
2352  0305               LC010:
2353  0305 1501          	bcp	a,(OFST-1,sp)
2354  0307 271a          	jreq	L1511
2355  0309 7b02          	ld	a,(OFST+0,sp)
2356  030b 2716          	jreq	L1511
2357                     ; 721       pendingbitstatus = SET;
2359  030d               LC009:
2362  030d a601          	ld	a,#1
2365  030f 2013          	jra	L7311
2366                     ; 726       pendingbitstatus = RESET;
2367  0311               L1411:
2368                     ; 732     enablestatus = (uint8_t)((uint8_t)UART1->CR2 & itmask2);
2370  0311 c65235        	ld	a,21045
2371  0314 1402          	and	a,(OFST+0,sp)
2372  0316 6b02          	ld	(OFST+0,sp),a
2374                     ; 734     if (((UART1->SR & itpos) != (uint8_t)0x00) && enablestatus)
2376  0318 c65230        	ld	a,21040
2377  031b 1501          	bcp	a,(OFST-1,sp)
2378  031d 2704          	jreq	L1511
2380  031f 7b02          	ld	a,(OFST+0,sp)
2381                     ; 737       pendingbitstatus = SET;
2383  0321 26ea          	jrne	LC009
2384  0323               L1511:
2385                     ; 742       pendingbitstatus = RESET;
2389  0323 4f            	clr	a
2391  0324               L7311:
2392                     ; 747   return  pendingbitstatus;
2396  0324 5b04          	addw	sp,#4
2397  0326 81            	ret	
2433                     ; 775 void UART1_ClearITPendingBit(UART1_IT_TypeDef UART1_IT)
2433                     ; 776 {
2434                     	switch	.text
2435  0327               _UART1_ClearITPendingBit:
2439                     ; 777   assert_param(IS_UART1_CLEAR_IT_OK(UART1_IT));
2441                     ; 780   if (UART1_IT == UART1_IT_RXNE)
2443  0327 a30255        	cpw	x,#597
2444  032a 2605          	jrne	L3711
2445                     ; 782     UART1->SR = (uint8_t)~(UART1_SR_RXNE);
2447  032c 35df5230      	mov	21040,#223
2450  0330 81            	ret	
2451  0331               L3711:
2452                     ; 787     UART1->CR4 &= (uint8_t)~(UART1_CR4_LBDF);
2454  0331 72195237      	bres	21047,#4
2455                     ; 789 }
2458  0335 81            	ret	
2471                     	xdef	_UART1_ClearITPendingBit
2472                     	xdef	_UART1_GetITStatus
2473                     	xdef	_UART1_ClearFlag
2474                     	xdef	_UART1_GetFlagStatus
2475                     	xdef	_UART1_SetPrescaler
2476                     	xdef	_UART1_SetGuardTime
2477                     	xdef	_UART1_SetAddress
2478                     	xdef	_UART1_SendBreak
2479                     	xdef	_UART1_SendData9
2480                     	xdef	_UART1_SendData8
2481                     	xdef	_UART1_ReceiveData9
2482                     	xdef	_UART1_ReceiveData8
2483                     	xdef	_UART1_ReceiverWakeUpCmd
2484                     	xdef	_UART1_WakeUpConfig
2485                     	xdef	_UART1_SmartCardNACKCmd
2486                     	xdef	_UART1_SmartCardCmd
2487                     	xdef	_UART1_LINCmd
2488                     	xdef	_UART1_LINBreakDetectionConfig
2489                     	xdef	_UART1_IrDACmd
2490                     	xdef	_UART1_IrDAConfig
2491                     	xdef	_UART1_HalfDuplexCmd
2492                     	xdef	_UART1_ITConfig
2493                     	xdef	_UART1_Cmd
2494                     	xdef	_UART1_Init
2495                     	xdef	_UART1_DeInit
2496                     	xref	_CLK_GetClockFreq
2497                     	xref.b	c_lreg
2498                     	xref.b	c_x
2517                     	xref	c_lsub
2518                     	xref	c_smul
2519                     	xref	c_ludv
2520                     	xref	c_rtol
2521                     	xref	c_llsh
2522                     	xref	c_ltor
2523                     	end
