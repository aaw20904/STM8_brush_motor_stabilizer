   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.6 - 16 Dec 2021
   3                     ; Generator (Limited) V4.5.4 - 16 Dec 2021
   4                     ; Optimizer V4.5.4 - 16 Dec 2021
  79                     ; 87 void FLASH_Unlock(FLASH_MemType_TypeDef FLASH_MemType)
  79                     ; 88 {
  81                     	switch	.text
  82  0000               _FLASH_Unlock:
  86                     ; 90   assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
  88                     ; 93   if(FLASH_MemType == FLASH_MEMTYPE_PROG)
  90  0000 a1fd          	cp	a,#253
  91  0002 2609          	jrne	L73
  92                     ; 95     FLASH->PUKR = FLASH_RASS_KEY1;
  94  0004 35565062      	mov	20578,#86
  95                     ; 96     FLASH->PUKR = FLASH_RASS_KEY2;
  97  0008 35ae5062      	mov	20578,#174
 100  000c 81            	ret	
 101  000d               L73:
 102                     ; 101     FLASH->DUKR = FLASH_RASS_KEY2; /* Warning: keys are reversed on data memory !!! */
 104  000d 35ae5064      	mov	20580,#174
 105                     ; 102     FLASH->DUKR = FLASH_RASS_KEY1;
 107  0011 35565064      	mov	20580,#86
 108                     ; 104 }
 111  0015 81            	ret	
 146                     ; 112 void FLASH_Lock(FLASH_MemType_TypeDef FLASH_MemType)
 146                     ; 113 {
 147                     	switch	.text
 148  0016               _FLASH_Lock:
 152                     ; 115   assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
 154                     ; 118   FLASH->IAPSR &= (uint8_t)FLASH_MemType;
 156  0016 c4505f        	and	a,20575
 157  0019 c7505f        	ld	20575,a
 158                     ; 119 }
 161  001c 81            	ret	
 184                     ; 126 void FLASH_DeInit(void)
 184                     ; 127 {
 185                     	switch	.text
 186  001d               _FLASH_DeInit:
 190                     ; 128   FLASH->CR1 = FLASH_CR1_RESET_VALUE;
 192  001d 725f505a      	clr	20570
 193                     ; 129   FLASH->CR2 = FLASH_CR2_RESET_VALUE;
 195  0021 725f505b      	clr	20571
 196                     ; 130   FLASH->NCR2 = FLASH_NCR2_RESET_VALUE;
 198  0025 35ff505c      	mov	20572,#255
 199                     ; 131   FLASH->IAPSR &= (uint8_t)(~FLASH_IAPSR_DUL);
 201  0029 7217505f      	bres	20575,#3
 202                     ; 132   FLASH->IAPSR &= (uint8_t)(~FLASH_IAPSR_PUL);
 204  002d 7213505f      	bres	20575,#1
 205                     ; 133   (void) FLASH->IAPSR; /* Reading of this register causes the clearing of status flags */
 207  0031 c6505f        	ld	a,20575
 208                     ; 134 }
 211  0034 81            	ret	
 266                     ; 142 void FLASH_ITConfig(FunctionalState NewState)
 266                     ; 143 {
 267                     	switch	.text
 268  0035               _FLASH_ITConfig:
 272                     ; 145   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 274                     ; 147   if(NewState != DISABLE)
 276  0035 4d            	tnz	a
 277  0036 2705          	jreq	L711
 278                     ; 149     FLASH->CR1 |= FLASH_CR1_IE; /* Enables the interrupt sources */
 280  0038 7212505a      	bset	20570,#1
 283  003c 81            	ret	
 284  003d               L711:
 285                     ; 153     FLASH->CR1 &= (uint8_t)(~FLASH_CR1_IE); /* Disables the interrupt sources */
 287  003d 7213505a      	bres	20570,#1
 288                     ; 155 }
 291  0041 81            	ret	
 323                     ; 164 void FLASH_EraseByte(uint32_t Address)
 323                     ; 165 {
 324                     	switch	.text
 325  0042               _FLASH_EraseByte:
 327       00000000      OFST:	set	0
 330                     ; 167   assert_param(IS_FLASH_ADDRESS_OK(Address));
 332                     ; 170   *(PointerAttr uint8_t*) (MemoryAddressCast)Address = FLASH_CLEAR_BYTE; 
 334  0042 1e05          	ldw	x,(OFST+5,sp)
 335  0044 7f            	clr	(x)
 336                     ; 171 }
 339  0045 81            	ret	
 378                     ; 181 void FLASH_ProgramByte(uint32_t Address, uint8_t Data)
 378                     ; 182 {
 379                     	switch	.text
 380  0046               _FLASH_ProgramByte:
 382       00000000      OFST:	set	0
 385                     ; 184   assert_param(IS_FLASH_ADDRESS_OK(Address));
 387                     ; 185   *(PointerAttr uint8_t*) (MemoryAddressCast)Address = Data;
 389  0046 1e05          	ldw	x,(OFST+5,sp)
 390  0048 7b07          	ld	a,(OFST+7,sp)
 391  004a f7            	ld	(x),a
 392                     ; 186 }
 395  004b 81            	ret	
 427                     ; 195 uint8_t FLASH_ReadByte(uint32_t Address)
 427                     ; 196 {
 428                     	switch	.text
 429  004c               _FLASH_ReadByte:
 431       00000000      OFST:	set	0
 434                     ; 198   assert_param(IS_FLASH_ADDRESS_OK(Address));
 436                     ; 201   return(*(PointerAttr uint8_t *) (MemoryAddressCast)Address); 
 438  004c 1e05          	ldw	x,(OFST+5,sp)
 439  004e f6            	ld	a,(x)
 442  004f 81            	ret	
 481                     ; 212 void FLASH_ProgramWord(uint32_t Address, uint32_t Data)
 481                     ; 213 {
 482                     	switch	.text
 483  0050               _FLASH_ProgramWord:
 485       00000000      OFST:	set	0
 488                     ; 215   assert_param(IS_FLASH_ADDRESS_OK(Address));
 490                     ; 218   FLASH->CR2 |= FLASH_CR2_WPRG;
 492  0050 721c505b      	bset	20571,#6
 493                     ; 219   FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
 495  0054 721d505c      	bres	20572,#6
 496                     ; 222   *((PointerAttr uint8_t*)(MemoryAddressCast)Address)       = *((uint8_t*)(&Data));
 498  0058 1e05          	ldw	x,(OFST+5,sp)
 499  005a 7b07          	ld	a,(OFST+7,sp)
 500  005c f7            	ld	(x),a
 501                     ; 224   *(((PointerAttr uint8_t*)(MemoryAddressCast)Address) + 1) = *((uint8_t*)(&Data)+1); 
 503  005d 7b08          	ld	a,(OFST+8,sp)
 504  005f e701          	ld	(1,x),a
 505                     ; 226   *(((PointerAttr uint8_t*)(MemoryAddressCast)Address) + 2) = *((uint8_t*)(&Data)+2); 
 507  0061 7b09          	ld	a,(OFST+9,sp)
 508  0063 e702          	ld	(2,x),a
 509                     ; 228   *(((PointerAttr uint8_t*)(MemoryAddressCast)Address) + 3) = *((uint8_t*)(&Data)+3); 
 511  0065 7b0a          	ld	a,(OFST+10,sp)
 512  0067 e703          	ld	(3,x),a
 513                     ; 229 }
 516  0069 81            	ret	
 557                     ; 237 void FLASH_ProgramOptionByte(uint16_t Address, uint8_t Data)
 557                     ; 238 {
 558                     	switch	.text
 559  006a               _FLASH_ProgramOptionByte:
 561  006a 89            	pushw	x
 562       00000000      OFST:	set	0
 565                     ; 240   assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 567                     ; 243   FLASH->CR2 |= FLASH_CR2_OPT;
 569  006b 721e505b      	bset	20571,#7
 570                     ; 244   FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
 572  006f 721f505c      	bres	20572,#7
 573                     ; 247   if(Address == 0x4800)
 575  0073 a34800        	cpw	x,#18432
 576  0076 2605          	jrne	L522
 577                     ; 250     *((NEAR uint8_t*)Address) = Data;
 579  0078 7b05          	ld	a,(OFST+5,sp)
 580  007a f7            	ld	(x),a
 582  007b 2006          	jra	L722
 583  007d               L522:
 584                     ; 255     *((NEAR uint8_t*)Address) = Data;
 586  007d 7b05          	ld	a,(OFST+5,sp)
 587  007f f7            	ld	(x),a
 588                     ; 256     *((NEAR uint8_t*)((uint16_t)(Address + 1))) = (uint8_t)(~Data);
 590  0080 43            	cpl	a
 591  0081 e701          	ld	(1,x),a
 592  0083               L722:
 593                     ; 258   FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 595  0083 a6fd          	ld	a,#253
 596  0085 cd014a        	call	_FLASH_WaitForLastOperation
 598                     ; 261   FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 600  0088 721f505b      	bres	20571,#7
 601                     ; 262   FLASH->NCR2 |= FLASH_NCR2_NOPT;
 603  008c 721e505c      	bset	20572,#7
 604                     ; 263 }
 607  0090 85            	popw	x
 608  0091 81            	ret	
 642                     ; 270 void FLASH_EraseOptionByte(uint16_t Address)
 642                     ; 271 {
 643                     	switch	.text
 644  0092               _FLASH_EraseOptionByte:
 646  0092 89            	pushw	x
 647       00000000      OFST:	set	0
 650                     ; 273   assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 652                     ; 276   FLASH->CR2 |= FLASH_CR2_OPT;
 654  0093 721e505b      	bset	20571,#7
 655                     ; 277   FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
 657  0097 721f505c      	bres	20572,#7
 658                     ; 280   if(Address == 0x4800)
 660  009b a34800        	cpw	x,#18432
 661  009e 2603          	jrne	L542
 662                     ; 283     *((NEAR uint8_t*)Address) = FLASH_CLEAR_BYTE;
 664  00a0 7f            	clr	(x)
 666  00a1 2005          	jra	L742
 667  00a3               L542:
 668                     ; 288     *((NEAR uint8_t*)Address) = FLASH_CLEAR_BYTE;
 670  00a3 7f            	clr	(x)
 671                     ; 289     *((NEAR uint8_t*)((uint16_t)(Address + (uint16_t)1 ))) = FLASH_SET_BYTE;
 673  00a4 a6ff          	ld	a,#255
 674  00a6 e701          	ld	(1,x),a
 675  00a8               L742:
 676                     ; 291   FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 678  00a8 a6fd          	ld	a,#253
 679  00aa cd014a        	call	_FLASH_WaitForLastOperation
 681                     ; 294   FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 683  00ad 721f505b      	bres	20571,#7
 684                     ; 295   FLASH->NCR2 |= FLASH_NCR2_NOPT;
 686  00b1 721e505c      	bset	20572,#7
 687                     ; 296 }
 690  00b5 85            	popw	x
 691  00b6 81            	ret	
 746                     ; 303 uint16_t FLASH_ReadOptionByte(uint16_t Address)
 746                     ; 304 {
 747                     	switch	.text
 748  00b7               _FLASH_ReadOptionByte:
 750  00b7 5204          	subw	sp,#4
 751       00000004      OFST:	set	4
 754                     ; 305   uint8_t value_optbyte, value_optbyte_complement = 0;
 756                     ; 306   uint16_t res_value = 0;
 758                     ; 309   assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 760                     ; 311   value_optbyte = *((NEAR uint8_t*)Address); /* Read option byte */
 762  00b9 f6            	ld	a,(x)
 763  00ba 6b01          	ld	(OFST-3,sp),a
 765                     ; 312   value_optbyte_complement = *(((NEAR uint8_t*)Address) + 1); /* Read option byte complement */
 767  00bc e601          	ld	a,(1,x)
 768  00be 6b02          	ld	(OFST-2,sp),a
 770                     ; 315   if(Address == 0x4800)	 
 772  00c0 a34800        	cpw	x,#18432
 773  00c3 2606          	jrne	L372
 774                     ; 317     res_value =	 value_optbyte;
 776  00c5 7b01          	ld	a,(OFST-3,sp)
 777  00c7 5f            	clrw	x
 778  00c8 97            	ld	xl,a
 781  00c9 201c          	jra	L572
 782  00cb               L372:
 783                     ; 321     if(value_optbyte == (uint8_t)(~value_optbyte_complement))
 785  00cb 43            	cpl	a
 786  00cc 1101          	cp	a,(OFST-3,sp)
 787  00ce 2614          	jrne	L772
 788                     ; 323       res_value = (uint16_t)((uint16_t)value_optbyte << 8);
 790  00d0 7b01          	ld	a,(OFST-3,sp)
 791  00d2 97            	ld	xl,a
 792  00d3 4f            	clr	a
 793  00d4 02            	rlwa	x,a
 794  00d5 1f03          	ldw	(OFST-1,sp),x
 796                     ; 324       res_value = res_value | (uint16_t)value_optbyte_complement;
 798  00d7 5f            	clrw	x
 799  00d8 7b02          	ld	a,(OFST-2,sp)
 800  00da 97            	ld	xl,a
 801  00db 01            	rrwa	x,a
 802  00dc 1a04          	or	a,(OFST+0,sp)
 803  00de 01            	rrwa	x,a
 804  00df 1a03          	or	a,(OFST-1,sp)
 805  00e1 01            	rrwa	x,a
 808  00e2 2003          	jra	L572
 809  00e4               L772:
 810                     ; 328       res_value = FLASH_OPTIONBYTE_ERROR;
 812  00e4 ae5555        	ldw	x,#21845
 814  00e7               L572:
 815                     ; 331   return(res_value);
 819  00e7 5b04          	addw	sp,#4
 820  00e9 81            	ret	
 894                     ; 340 void FLASH_SetLowPowerMode(FLASH_LPMode_TypeDef FLASH_LPMode)
 894                     ; 341 {
 895                     	switch	.text
 896  00ea               _FLASH_SetLowPowerMode:
 898  00ea 88            	push	a
 899       00000000      OFST:	set	0
 902                     ; 343   assert_param(IS_FLASH_LOW_POWER_MODE_OK(FLASH_LPMode));
 904                     ; 346   FLASH->CR1 &= (uint8_t)(~(FLASH_CR1_HALT | FLASH_CR1_AHALT)); 
 906  00eb c6505a        	ld	a,20570
 907  00ee a4f3          	and	a,#243
 908  00f0 c7505a        	ld	20570,a
 909                     ; 349   FLASH->CR1 |= (uint8_t)FLASH_LPMode; 
 911  00f3 c6505a        	ld	a,20570
 912  00f6 1a01          	or	a,(OFST+1,sp)
 913  00f8 c7505a        	ld	20570,a
 914                     ; 350 }
 917  00fb 84            	pop	a
 918  00fc 81            	ret	
 976                     ; 358 void FLASH_SetProgrammingTime(FLASH_ProgramTime_TypeDef FLASH_ProgTime)
 976                     ; 359 {
 977                     	switch	.text
 978  00fd               _FLASH_SetProgrammingTime:
 982                     ; 361   assert_param(IS_FLASH_PROGRAM_TIME_OK(FLASH_ProgTime));
 984                     ; 363   FLASH->CR1 &= (uint8_t)(~FLASH_CR1_FIX);
 986  00fd 7211505a      	bres	20570,#0
 987                     ; 364   FLASH->CR1 |= (uint8_t)FLASH_ProgTime;
 989  0101 ca505a        	or	a,20570
 990  0104 c7505a        	ld	20570,a
 991                     ; 365 }
 994  0107 81            	ret	
1019                     ; 372 FLASH_LPMode_TypeDef FLASH_GetLowPowerMode(void)
1019                     ; 373 {
1020                     	switch	.text
1021  0108               _FLASH_GetLowPowerMode:
1025                     ; 374   return((FLASH_LPMode_TypeDef)(FLASH->CR1 & (uint8_t)(FLASH_CR1_HALT | FLASH_CR1_AHALT)));
1027  0108 c6505a        	ld	a,20570
1028  010b a40c          	and	a,#12
1031  010d 81            	ret	
1056                     ; 382 FLASH_ProgramTime_TypeDef FLASH_GetProgrammingTime(void)
1056                     ; 383 {
1057                     	switch	.text
1058  010e               _FLASH_GetProgrammingTime:
1062                     ; 384   return((FLASH_ProgramTime_TypeDef)(FLASH->CR1 & FLASH_CR1_FIX));
1064  010e c6505a        	ld	a,20570
1065  0111 a401          	and	a,#1
1068  0113 81            	ret	
1100                     ; 392 uint32_t FLASH_GetBootSize(void)
1100                     ; 393 {
1101                     	switch	.text
1102  0114               _FLASH_GetBootSize:
1104  0114 5204          	subw	sp,#4
1105       00000004      OFST:	set	4
1108                     ; 394   uint32_t temp = 0;
1110                     ; 397   temp = (uint32_t)((uint32_t)FLASH->FPR * (uint32_t)512);
1112  0116 c6505d        	ld	a,20573
1113  0119 5f            	clrw	x
1114  011a 97            	ld	xl,a
1115  011b 90ae0200      	ldw	y,#512
1116  011f cd0000        	call	c_umul
1118  0122 96            	ldw	x,sp
1119  0123 5c            	incw	x
1120  0124 cd0000        	call	c_rtol
1123                     ; 400   if(FLASH->FPR == 0xFF)
1125  0127 c6505d        	ld	a,20573
1126  012a 4c            	inc	a
1127  012b 260d          	jrne	L714
1128                     ; 402     temp += 512;
1130  012d ae0200        	ldw	x,#512
1131  0130 bf02          	ldw	c_lreg+2,x
1132  0132 5f            	clrw	x
1133  0133 bf00          	ldw	c_lreg,x
1134  0135 96            	ldw	x,sp
1135  0136 5c            	incw	x
1136  0137 cd0000        	call	c_lgadd
1139  013a               L714:
1140                     ; 406   return(temp);
1142  013a 96            	ldw	x,sp
1143  013b 5c            	incw	x
1144  013c cd0000        	call	c_ltor
1148  013f 5b04          	addw	sp,#4
1149  0141 81            	ret	
1251                     ; 417 FlagStatus FLASH_GetFlagStatus(FLASH_Flag_TypeDef FLASH_FLAG)
1251                     ; 418 {
1252                     	switch	.text
1253  0142               _FLASH_GetFlagStatus:
1255       00000001      OFST:	set	1
1258                     ; 419   FlagStatus status = RESET;
1260                     ; 421   assert_param(IS_FLASH_FLAGS_OK(FLASH_FLAG));
1262                     ; 424   if((FLASH->IAPSR & (uint8_t)FLASH_FLAG) != (uint8_t)RESET)
1264  0142 c4505f        	and	a,20575
1265  0145 2702          	jreq	L764
1266                     ; 426     status = SET; /* FLASH_FLAG is set */
1268  0147 a601          	ld	a,#1
1271  0149               L764:
1272                     ; 430     status = RESET; /* FLASH_FLAG is reset*/
1275                     ; 434   return status;
1279  0149 81            	ret	
1360                     ; 549 IN_RAM(FLASH_Status_TypeDef FLASH_WaitForLastOperation(FLASH_MemType_TypeDef FLASH_MemType)) 
1360                     ; 550 {
1361                     	switch	.text
1362  014a               _FLASH_WaitForLastOperation:
1364  014a 5203          	subw	sp,#3
1365       00000003      OFST:	set	3
1368                     ; 551   uint8_t flagstatus = 0x00;
1370  014c 0f03          	clr	(OFST+0,sp)
1372                     ; 552   uint16_t timeout = OPERATION_TIMEOUT;
1374  014e aeffff        	ldw	x,#65535
1375                     ; 576   UNUSED(FLASH_MemType);
1378  0151 2008          	jra	L135
1379  0153               L725:
1380                     ; 579     flagstatus = (uint8_t)(FLASH->IAPSR & (FLASH_IAPSR_EOP | FLASH_IAPSR_WR_PG_DIS));
1382  0153 c6505f        	ld	a,20575
1383  0156 a405          	and	a,#5
1384  0158 6b03          	ld	(OFST+0,sp),a
1386                     ; 580     timeout--;
1388  015a 5a            	decw	x
1389  015b               L135:
1390  015b 1f01          	ldw	(OFST-2,sp),x
1392                     ; 577   while((flagstatus == 0x00) && (timeout != 0x00))
1394  015d 7b03          	ld	a,(OFST+0,sp)
1395  015f 2603          	jrne	L535
1397  0161 5d            	tnzw	x
1398  0162 26ef          	jrne	L725
1399  0164               L535:
1400                     ; 584   if(timeout == 0x00 )
1402  0164 1e01          	ldw	x,(OFST-2,sp)
1403  0166 2602          	jrne	L735
1404                     ; 586     flagstatus = FLASH_STATUS_TIMEOUT;
1406  0168 a602          	ld	a,#2
1408  016a               L735:
1409                     ; 589   return((FLASH_Status_TypeDef)flagstatus);
1413  016a 5b03          	addw	sp,#3
1414  016c 81            	ret	
1473                     ; 599 IN_RAM(void FLASH_EraseBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType))
1473                     ; 600 {
1474                     	switch	.text
1475  016d               _FLASH_EraseBlock:
1477  016d 89            	pushw	x
1478  016e 5206          	subw	sp,#6
1479       00000006      OFST:	set	6
1482                     ; 601   uint32_t startaddress = 0;
1484                     ; 611   assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
1486                     ; 612   if(FLASH_MemType == FLASH_MEMTYPE_PROG)
1488  0170 7b0b          	ld	a,(OFST+5,sp)
1489  0172 a1fd          	cp	a,#253
1490  0174 2605          	jrne	L765
1491                     ; 614     assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
1493                     ; 615     startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
1495  0176 ae8000        	ldw	x,#32768
1497  0179 2003          	jra	L175
1498  017b               L765:
1499                     ; 619     assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
1501                     ; 620     startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
1503  017b ae4000        	ldw	x,#16384
1504  017e               L175:
1505  017e 1f05          	ldw	(OFST-1,sp),x
1506  0180 5f            	clrw	x
1507  0181 1f03          	ldw	(OFST-3,sp),x
1509                     ; 628     pwFlash = (PointerAttr uint32_t *)(MemoryAddressCast)(startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE));
1511  0183 a640          	ld	a,#64
1512  0185 1e07          	ldw	x,(OFST+1,sp)
1513  0187 cd0000        	call	c_cmulx
1515  018a 96            	ldw	x,sp
1516  018b 1c0003        	addw	x,#OFST-3
1517  018e cd0000        	call	c_ladd
1519  0191 be02          	ldw	x,c_lreg+2
1520  0193 1f01          	ldw	(OFST-5,sp),x
1522                     ; 632   FLASH->CR2 |= FLASH_CR2_ERASE;
1524  0195 721a505b      	bset	20571,#5
1525                     ; 633   FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NERASE);
1527  0199 721b505c      	bres	20572,#5
1528                     ; 637     *pwFlash = (uint32_t)0;
1530  019d 4f            	clr	a
1531  019e e703          	ld	(3,x),a
1532  01a0 e702          	ld	(2,x),a
1533  01a2 e701          	ld	(1,x),a
1534  01a4 f7            	ld	(x),a
1535                     ; 645 }
1538  01a5 5b08          	addw	sp,#8
1539  01a7 81            	ret	
1637                     ; 656 IN_RAM(void FLASH_ProgramBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType, 
1637                     ; 657                         FLASH_ProgramMode_TypeDef FLASH_ProgMode, uint8_t *Buffer))
1637                     ; 658 {
1638                     	switch	.text
1639  01a8               _FLASH_ProgramBlock:
1641  01a8 89            	pushw	x
1642  01a9 5206          	subw	sp,#6
1643       00000006      OFST:	set	6
1646                     ; 659   uint16_t Count = 0;
1648                     ; 660   uint32_t startaddress = 0;
1650                     ; 663   assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
1652                     ; 664   assert_param(IS_FLASH_PROGRAM_MODE_OK(FLASH_ProgMode));
1654                     ; 665   if(FLASH_MemType == FLASH_MEMTYPE_PROG)
1656  01ab 7b0b          	ld	a,(OFST+5,sp)
1657  01ad a1fd          	cp	a,#253
1658  01af 2605          	jrne	L736
1659                     ; 667     assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
1661                     ; 668     startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
1663  01b1 ae8000        	ldw	x,#32768
1665  01b4 2003          	jra	L146
1666  01b6               L736:
1667                     ; 672     assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
1669                     ; 673     startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
1671  01b6 ae4000        	ldw	x,#16384
1672  01b9               L146:
1673  01b9 1f03          	ldw	(OFST-3,sp),x
1674  01bb 5f            	clrw	x
1675  01bc 1f01          	ldw	(OFST-5,sp),x
1677                     ; 677   startaddress = startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE);
1679  01be a640          	ld	a,#64
1680  01c0 1e07          	ldw	x,(OFST+1,sp)
1681  01c2 cd0000        	call	c_cmulx
1683  01c5 96            	ldw	x,sp
1684  01c6 5c            	incw	x
1685  01c7 cd0000        	call	c_lgadd
1688                     ; 680   if(FLASH_ProgMode == FLASH_PROGRAMMODE_STANDARD)
1690  01ca 7b0c          	ld	a,(OFST+6,sp)
1691  01cc 260a          	jrne	L346
1692                     ; 683     FLASH->CR2 |= FLASH_CR2_PRG;
1694  01ce 7210505b      	bset	20571,#0
1695                     ; 684     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NPRG);
1697  01d2 7211505c      	bres	20572,#0
1699  01d6 2008          	jra	L546
1700  01d8               L346:
1701                     ; 689     FLASH->CR2 |= FLASH_CR2_FPRG;
1703  01d8 7218505b      	bset	20571,#4
1704                     ; 690     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NFPRG);
1706  01dc 7219505c      	bres	20572,#4
1707  01e0               L546:
1708                     ; 694   for(Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
1710  01e0 5f            	clrw	x
1711  01e1 1f05          	ldw	(OFST-1,sp),x
1713  01e3               L746:
1714                     ; 696     *((PointerAttr uint8_t*) (MemoryAddressCast)startaddress + Count) = ((uint8_t)(Buffer[Count]));
1716  01e3 1e0d          	ldw	x,(OFST+7,sp)
1717  01e5 72fb05        	addw	x,(OFST-1,sp)
1718  01e8 f6            	ld	a,(x)
1719  01e9 1e03          	ldw	x,(OFST-3,sp)
1720  01eb 72fb05        	addw	x,(OFST-1,sp)
1721  01ee f7            	ld	(x),a
1722                     ; 694   for(Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
1724  01ef 1e05          	ldw	x,(OFST-1,sp)
1725  01f1 5c            	incw	x
1726  01f2 1f05          	ldw	(OFST-1,sp),x
1730  01f4 a30040        	cpw	x,#64
1731  01f7 25ea          	jrult	L746
1732                     ; 698 }
1735  01f9 5b08          	addw	sp,#8
1736  01fb 81            	ret	
1749                     	xdef	_FLASH_WaitForLastOperation
1750                     	xdef	_FLASH_ProgramBlock
1751                     	xdef	_FLASH_EraseBlock
1752                     	xdef	_FLASH_GetFlagStatus
1753                     	xdef	_FLASH_GetBootSize
1754                     	xdef	_FLASH_GetProgrammingTime
1755                     	xdef	_FLASH_GetLowPowerMode
1756                     	xdef	_FLASH_SetProgrammingTime
1757                     	xdef	_FLASH_SetLowPowerMode
1758                     	xdef	_FLASH_EraseOptionByte
1759                     	xdef	_FLASH_ProgramOptionByte
1760                     	xdef	_FLASH_ReadOptionByte
1761                     	xdef	_FLASH_ProgramWord
1762                     	xdef	_FLASH_ReadByte
1763                     	xdef	_FLASH_ProgramByte
1764                     	xdef	_FLASH_EraseByte
1765                     	xdef	_FLASH_ITConfig
1766                     	xdef	_FLASH_DeInit
1767                     	xdef	_FLASH_Lock
1768                     	xdef	_FLASH_Unlock
1769                     	xref.b	c_lreg
1770                     	xref.b	c_x
1771                     	xref.b	c_y
1790                     	xref	c_ladd
1791                     	xref	c_cmulx
1792                     	xref	c_ltor
1793                     	xref	c_lgadd
1794                     	xref	c_rtol
1795                     	xref	c_umul
1796                     	end
