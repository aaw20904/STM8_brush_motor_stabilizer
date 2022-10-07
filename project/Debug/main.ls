   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.6 - 16 Dec 2021
   3                     ; Generator (Limited) V4.5.4 - 16 Dec 2021
   4                     ; Optimizer V4.5.4 - 16 Dec 2021
  19                     	switch	.data
  20  0000               _calibrationFlag:
  21  0000 52            	dc.b	82
  22  0001               L3_avg:
  23  0001 00000000      	dc.l	0
  69                     ; 24 unsigned short lowPassFilterPortD2 (  long new_sample) {
  71                     	switch	.text
  72  0000               _lowPassFilterPortD2:
  74       00000000      OFST:	set	0
  77                     ; 28 	  new_sample  <<= 11;
  79  0000 96            	ldw	x,sp
  80  0001 1c0003        	addw	x,#OFST+3
  81  0004 a60b          	ld	a,#11
  82  0006 cd0000        	call	c_lglsh
  84                     ; 31     avg -= avg >> 3;
  86  0009 ae0001        	ldw	x,#L3_avg
  87  000c cd0000        	call	c_ltor
  89  000f a603          	ld	a,#3
  90  0011 cd0000        	call	c_lrsh
  92  0014 cd0000        	call	c_lgsub
  94                     ; 32     avg += new_sample >> 3;
  96  0017 96            	ldw	x,sp
  97  0018 1c0003        	addw	x,#OFST+3
  98  001b cd0000        	call	c_ltor
 100  001e a603          	ld	a,#3
 101  0020 cd0000        	call	c_lrsh
 103  0023 ae0001        	ldw	x,#L3_avg
 104  0026 cd0000        	call	c_lgadd
 106                     ; 36     return  avg >> 11;
 108  0029 cd0000        	call	c_ltor
 110  002c a60b          	ld	a,#11
 111  002e cd0000        	call	c_lrsh
 113  0031 be02          	ldw	x,c_lreg+2
 116  0033 81            	ret	
 119                     	switch	.data
 120  0005               L13_avg:
 121  0005 00000000      	dc.l	0
 159                     ; 40 unsigned short lowPassFilterPortD3 (  long new_sample) {
 160                     	switch	.text
 161  0034               _lowPassFilterPortD3:
 163       00000000      OFST:	set	0
 166                     ; 44 	  new_sample  <<= 11;
 168  0034 96            	ldw	x,sp
 169  0035 1c0003        	addw	x,#OFST+3
 170  0038 a60b          	ld	a,#11
 171  003a cd0000        	call	c_lglsh
 173                     ; 47     avg -= avg >> 3;
 175  003d ae0005        	ldw	x,#L13_avg
 176  0040 cd0000        	call	c_ltor
 178  0043 a603          	ld	a,#3
 179  0045 cd0000        	call	c_lrsh
 181  0048 cd0000        	call	c_lgsub
 183                     ; 48     avg += new_sample >> 3;
 185  004b 96            	ldw	x,sp
 186  004c 1c0003        	addw	x,#OFST+3
 187  004f cd0000        	call	c_ltor
 189  0052 a603          	ld	a,#3
 190  0054 cd0000        	call	c_lrsh
 192  0057 ae0005        	ldw	x,#L13_avg
 193  005a cd0000        	call	c_lgadd
 195                     ; 51     return  avg >> 11;
 197  005d cd0000        	call	c_ltor
 199  0060 a60b          	ld	a,#11
 200  0062 cd0000        	call	c_lrsh
 202  0065 be02          	ldw	x,c_lreg+2
 205  0067 81            	ret	
 230                     ; 55 void clockInit (void) {
 231                     	switch	.text
 232  0068               _clockInit:
 236                     ; 57  CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1); // set 16 MHz for CPU
 238  0068 4f            	clr	a
 239  0069 cd0000        	call	_CLK_SYSCLKConfig
 241                     ; 59 	 CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 243  006c ae1301        	ldw	x,#4865
 244  006f cd0000        	call	_CLK_PeripheralClockConfig
 246                     ; 60 	 CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 248  0072 ae0401        	ldw	x,#1025
 249  0075 cd0000        	call	_CLK_PeripheralClockConfig
 251                     ; 61 	 CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);
 253  0078 ae0701        	ldw	x,#1793
 254  007b cd0000        	call	_CLK_PeripheralClockConfig
 256                     ; 62 	 CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);
 258  007e ae0301        	ldw	x,#769
 260                     ; 64 }
 263  0081 cc0000        	jp	_CLK_PeripheralClockConfig
 289                     ; 68 void gpioPeripherialInit (void) {
 290                     	switch	.text
 291  0084               _gpioPeripherialInit:
 295                     ; 70 	GPIO_DeInit(GPIOB);
 297  0084 ae5005        	ldw	x,#20485
 298  0087 cd0000        	call	_GPIO_DeInit
 300                     ; 71 	GPIO_Init(GPIOB,GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_FAST);//LED
 302  008a 4be0          	push	#224
 303  008c 4b20          	push	#32
 304  008e ae5005        	ldw	x,#20485
 305  0091 cd0000        	call	_GPIO_Init
 307  0094 85            	popw	x
 308                     ; 72 	GPIO_DeInit(GPIOC);
 310  0095 ae500a        	ldw	x,#20490
 311  0098 cd0000        	call	_GPIO_DeInit
 313                     ; 73 	GPIO_Init(GPIOC,GPIO_PIN_4,GPIO_MODE_OUT_PP_LOW_FAST );//pwm
 315  009b 4be0          	push	#224
 316  009d 4b10          	push	#16
 317  009f ae500a        	ldw	x,#20490
 318  00a2 cd0000        	call	_GPIO_Init
 320  00a5 85            	popw	x
 321                     ; 74 	GPIO_Init(GPIOC,GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7|GPIO_PIN_3 ,GPIO_MODE_IN_PU_NO_IT);//buttons
 323  00a6 4b40          	push	#64
 324  00a8 4be8          	push	#232
 325  00aa ae500a        	ldw	x,#20490
 326  00ad cd0000        	call	_GPIO_Init
 328  00b0 85            	popw	x
 329                     ; 75 	GPIO_DeInit(GPIOD);
 331  00b1 ae500f        	ldw	x,#20495
 332  00b4 cd0000        	call	_GPIO_DeInit
 334                     ; 76 	GPIO_Init(GPIOD, GPIO_PIN_2|GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//ADC - D2, D3
 336  00b7 4b00          	push	#0
 337  00b9 4b0c          	push	#12
 338  00bb ae500f        	ldw	x,#20495
 339  00be cd0000        	call	_GPIO_Init
 341  00c1 85            	popw	x
 342                     ; 77 	GPIO_Init(GPIOD, GPIO_PIN_4 ,GPIO_MODE_OUT_PP_LOW_FAST); //LED
 344  00c2 4be0          	push	#224
 345  00c4 4b10          	push	#16
 346  00c6 ae500f        	ldw	x,#20495
 347  00c9 cd0000        	call	_GPIO_Init
 349  00cc 85            	popw	x
 350                     ; 78 }
 353  00cd 81            	ret	
 385                     ; 82 void dummy_delay (unsigned int period) {
 386                     	switch	.text
 387  00ce               _dummy_delay:
 389  00ce 89            	pushw	x
 390       00000000      OFST:	set	0
 393  00cf 2003          	jra	L701
 394  00d1               L501:
 395                     ; 84 		period--;
 397  00d1 5a            	decw	x
 398  00d2 1f01          	ldw	(OFST+1,sp),x
 399  00d4               L701:
 400                     ; 83 	while (period) {
 402  00d4 1e01          	ldw	x,(OFST+1,sp)
 403  00d6 26f9          	jrne	L501
 404                     ; 87 }
 407  00d8 85            	popw	x
 408  00d9 81            	ret	
 436                     ; 90 void adc_scan_to_4_init (void) {
 437                     	switch	.text
 438  00da               _adc_scan_to_4_init:
 442                     ; 91 	 ADC1_DeInit();
 444  00da cd0000        	call	_ADC1_DeInit
 446                     ; 93 	ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, ADC1_CHANNEL_4,
 446                     ; 94 			ADC1_PRESSEL_FCPU_D2 , ADC1_EXTTRIG_GPIO,
 446                     ; 95 			DISABLE, ADC1_ALIGN_RIGHT,
 446                     ; 96 			ADC1_SCHMITTTRIG_ALL, DISABLE);
 448  00dd 4b00          	push	#0
 449  00df 4bff          	push	#255
 450  00e1 4b08          	push	#8
 451  00e3 4b00          	push	#0
 452  00e5 4b10          	push	#16
 453  00e7 4b00          	push	#0
 454  00e9 ae0004        	ldw	x,#4
 455  00ec cd0000        	call	_ADC1_Init
 457  00ef 5b06          	addw	sp,#6
 458                     ; 98 	ADC1_ScanModeCmd(ENABLE);
 460  00f1 a601          	ld	a,#1
 461  00f3 cd0000        	call	_ADC1_ScanModeCmd
 463                     ; 102 	ADC1_DataBufferCmd(ENABLE);	
 465  00f6 a601          	ld	a,#1
 466  00f8 cd0000        	call	_ADC1_DataBufferCmd
 468                     ; 103 	ADC1_ITConfig(  ADC1_IT_EOCIE, ENABLE);
 470  00fb 4b01          	push	#1
 471  00fd ae0020        	ldw	x,#32
 472  0100 cd0000        	call	_ADC1_ITConfig
 474  0103 84            	pop	a
 475                     ; 104 }
 478  0104 81            	ret	
 506                     ; 106 void tim1_pwm_ch1_init(void) {
 507                     	switch	.text
 508  0105               _tim1_pwm_ch1_init:
 512                     ; 107   TIM1_DeInit();
 514  0105 cd0000        	call	_TIM1_DeInit
 516                     ; 109   TIM1_TimeBaseInit(0, TIM1_COUNTERMODE_UP, 1024, 0); 
 518  0108 4b00          	push	#0
 519  010a ae0400        	ldw	x,#1024
 520  010d 89            	pushw	x
 521  010e 4b00          	push	#0
 522  0110 5f            	clrw	x
 523  0111 cd0000        	call	_TIM1_TimeBaseInit
 525  0114 5b04          	addw	sp,#4
 526                     ; 111   TIM1_OC4Init(TIM1_OCMODE_PWM1, TIM1_OUTPUTSTATE_ENABLE, 0x00ff, TIM1_OCPOLARITY_HIGH, TIM1_OCIDLESTATE_SET);
 528  0116 4b55          	push	#85
 529  0118 4b00          	push	#0
 530  011a ae00ff        	ldw	x,#255
 531  011d 89            	pushw	x
 532  011e ae6011        	ldw	x,#24593
 533  0121 cd0000        	call	_TIM1_OC4Init
 535  0124 5b04          	addw	sp,#4
 536                     ; 114   TIM1_Cmd(ENABLE);
 538  0126 a601          	ld	a,#1
 539  0128 cd0000        	call	_TIM1_Cmd
 541                     ; 117   TIM1_CtrlPWMOutputs(ENABLE);
 543  012b a601          	ld	a,#1
 545                     ; 119 }
 548  012d cc0000        	jp	_TIM1_CtrlPWMOutputs
 575                     ; 121 void tim4_init(void) {
 576                     	switch	.text
 577  0130               _tim4_init:
 581                     ; 123 	TIM4_TimeBaseInit (TIM4_PRESCALER_64,0xF6);//2500Hz
 583  0130 ae06f6        	ldw	x,#1782
 584  0133 cd0000        	call	_TIM4_TimeBaseInit
 586                     ; 124 	TIM4_ARRPreloadConfig(DISABLE);
 588  0136 4f            	clr	a
 589  0137 cd0000        	call	_TIM4_ARRPreloadConfig
 591                     ; 126 	TIM4_ITConfig(TIM4_IT_UPDATE ,ENABLE);
 593  013a ae0101        	ldw	x,#257
 594  013d cd0000        	call	_TIM4_ITConfig
 596                     ; 127 	TIM4_Cmd(ENABLE);
 598  0140 a601          	ld	a,#1
 600                     ; 129 }
 603  0142 cc0000        	jp	_TIM4_Cmd
 669                     ; 134 main()
 669                     ; 135 {
 670                     	switch	.text
 671  0145               _main:
 673  0145 5207          	subw	sp,#7
 674       00000007      OFST:	set	7
 677                     ; 136 	char sw =0;
 679                     ; 137 	uint32_t start_add = 0x4010;
 681  0147 ae4010        	ldw	x,#16400
 682  014a 1f06          	ldw	(OFST-1,sp),x
 683  014c 5f            	clrw	x
 684  014d 1f04          	ldw	(OFST-3,sp),x
 686                     ; 138 	clockInit();
 688  014f cd0068        	call	_clockInit
 690                     ; 140     FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
 692  0152 4f            	clr	a
 693  0153 cd0000        	call	_FLASH_SetProgrammingTime
 695                     ; 143 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
 697  0156 a6f7          	ld	a,#247
 698  0158 cd0000        	call	_FLASH_Unlock
 700                     ; 145 		 stabilizationTask =  FLASH_ReadByte(start_add + 1);
 702  015b 96            	ldw	x,sp
 703  015c 1c0004        	addw	x,#OFST-3
 704  015f cd034f        	call	LC005
 705  0162 89            	pushw	x
 706  0163 be00          	ldw	x,c_lreg
 707  0165 89            	pushw	x
 708  0166 cd0000        	call	_FLASH_ReadByte
 710  0169 5b04          	addw	sp,#4
 711  016b 5f            	clrw	x
 712  016c 97            	ld	xl,a
 713  016d cf0000        	ldw	_stabilizationTask,x
 714                     ; 146 		 stabilizationTask <<= 8;
 716  0170 ce0000        	ldw	x,_stabilizationTask
 717  0173 4f            	clr	a
 718  0174 02            	rlwa	x,a
 719  0175 cf0000        	ldw	_stabilizationTask,x
 720                     ; 148 		 stabilizationTask |= FLASH_ReadByte(start_add);
 722  0178 1e06          	ldw	x,(OFST-1,sp)
 723  017a 89            	pushw	x
 724  017b 1e06          	ldw	x,(OFST-1,sp)
 725  017d 89            	pushw	x
 726  017e cd0000        	call	_FLASH_ReadByte
 728  0181 5b04          	addw	sp,#4
 729  0183 6b01          	ld	(OFST-6,sp),a
 731  0185 c60000        	ld	a,_stabilizationTask
 732  0188 97            	ld	xl,a
 733  0189 c60001        	ld	a,_stabilizationTask+1
 734  018c 1a01          	or	a,(OFST-6,sp)
 735  018e c70001        	ld	_stabilizationTask+1,a
 736  0191 9f            	ld	a,xl
 737  0192 c70000        	ld	_stabilizationTask,a
 738                     ; 150 		 resistance =  FLASH_ReadByte(start_add + 3);
 740  0195 96            	ldw	x,sp
 741  0196 1c0004        	addw	x,#OFST-3
 742  0199 cd0339        	call	LC003
 743  019c 89            	pushw	x
 744  019d be00          	ldw	x,c_lreg
 745  019f 89            	pushw	x
 746  01a0 cd0000        	call	_FLASH_ReadByte
 748  01a3 5b04          	addw	sp,#4
 749  01a5 5f            	clrw	x
 750  01a6 97            	ld	xl,a
 751  01a7 cf0004        	ldw	_resistance,x
 752                     ; 151 		 resistance <<= 8;
 754  01aa ce0004        	ldw	x,_resistance
 755  01ad 4f            	clr	a
 756  01ae 02            	rlwa	x,a
 757  01af cf0004        	ldw	_resistance,x
 758                     ; 153 		 resistance |= FLASH_ReadByte(start_add + 2);
 760  01b2 96            	ldw	x,sp
 761  01b3 1c0004        	addw	x,#OFST-3
 762  01b6 cd0344        	call	LC004
 763  01b9 89            	pushw	x
 764  01ba be00          	ldw	x,c_lreg
 765  01bc 89            	pushw	x
 766  01bd cd0000        	call	_FLASH_ReadByte
 768  01c0 5b04          	addw	sp,#4
 769  01c2 6b01          	ld	(OFST-6,sp),a
 771  01c4 c60004        	ld	a,_resistance
 772  01c7 97            	ld	xl,a
 773  01c8 c60005        	ld	a,_resistance+1
 774  01cb 1a01          	or	a,(OFST-6,sp)
 775  01cd c70005        	ld	_resistance+1,a
 776  01d0 9f            	ld	a,xl
 777  01d1 c70004        	ld	_resistance,a
 778                     ; 154 		 FLASH_Lock(FLASH_MEMTYPE_DATA);
 780  01d4 a6f7          	ld	a,#247
 781  01d6 cd0000        	call	_FLASH_Lock
 783                     ; 157 	 gpioPeripherialInit();
 785  01d9 cd0084        	call	_gpioPeripherialInit
 787                     ; 158 	 adc_scan_to_4_init();
 789  01dc cd00da        	call	_adc_scan_to_4_init
 791                     ; 159 	 tim4_init();
 793  01df cd0130        	call	_tim4_init
 795                     ; 160 	 tim1_pwm_ch1_init();
 797  01e2 cd0105        	call	_tim1_pwm_ch1_init
 799                     ; 165 	 enableInterrupts();
 802  01e5 9a            	rim	
 804                     ; 166    ADC1_StartConversion ();
 807  01e6 cd0000        	call	_ADC1_StartConversion
 809                     ; 167 	 		 TIM1_SetCompare4(256);
 811  01e9 ae0100        	ldw	x,#256
 812  01ec cd0000        	call	_TIM1_SetCompare4
 814  01ef               L361:
 815                     ; 171 		 unsigned char bits = GPIO_ReadInputData(GPIOC);
 817  01ef ae500a        	ldw	x,#20490
 818  01f2 cd0000        	call	_GPIO_ReadInputData
 821                     ; 173 		 bits  &= 0b11101000;
 823  01f5 a4e8          	and	a,#232
 824  01f7 6b02          	ld	(OFST-5,sp),a
 826                     ; 175 		 if(! (bits & (1 << 7))) {
 828  01f9 2b27          	jrmi	L761
 829                     ; 176 		 TIM1_SetCompare4(256);
 831  01fb ae0100        	ldw	x,#256
 832  01fe cd0000        	call	_TIM1_SetCompare4
 834                     ; 178 				calibrationFlag = '@';
 836  0201 35400000      	mov	_calibrationFlag,#64
 837                     ; 179 				GPIO_WriteReverse(GPIOD,GPIO_PIN_4);
 839  0205 4b10          	push	#16
 840  0207 ae500f        	ldw	x,#20495
 841  020a cd0000        	call	_GPIO_WriteReverse
 843  020d ae4e20        	ldw	x,#20000
 844  0210 84            	pop	a
 845                     ; 180 				dummy_delay(20000);
 847  0211 cd00ce        	call	_dummy_delay
 849                     ; 181 				GPIO_WriteReverse(GPIOD,GPIO_PIN_4);
 851  0214 cd032c        	call	LC002
 852                     ; 182 				dummy_delay(60000);
 854  0217 cd031f        	call	LC001
 855  021a cd031f        	call	LC001
 856  021d cd00ce        	call	_dummy_delay
 858                     ; 186 				dummy_delay(60000);
 859  0220 2004          	jra	L171
 860  0222               L761:
 861                     ; 188 				calibrationFlag = 'R';
 863  0222 35520000      	mov	_calibrationFlag,#82
 864  0226               L171:
 865                     ; 191 			if(! (bits & (1 << 6))) {
 867  0226 7b02          	ld	a,(OFST-5,sp)
 868  0228 a540          	bcp	a,#64
 869  022a 261a          	jrne	L371
 870                     ; 192 				GPIO_WriteReverse(GPIOD,GPIO_PIN_4);
 872  022c cd035a        	call	LC006
 874                     ; 194 				GPIO_WriteReverse(GPIOD,GPIO_PIN_4);
 876  022f cd032c        	call	LC002
 877                     ; 195 				dummy_delay(60000);
 879  0232 cd00ce        	call	_dummy_delay
 881                     ; 196 				if(stabilizationTask < 1024){
 883  0235 ce0000        	ldw	x,_stabilizationTask
 884  0238 a30400        	cpw	x,#1024
 885  023b 2409          	jruge	L371
 886                     ; 197 					stabilizationTask +=5;
 888  023d ce0000        	ldw	x,_stabilizationTask
 889  0240 1c0005        	addw	x,#5
 890  0243 cf0000        	ldw	_stabilizationTask,x
 891  0246               L371:
 892                     ; 201 			if(! (bits & (1 << 5))) {
 894  0246 7b02          	ld	a,(OFST-5,sp)
 895  0248 a520          	bcp	a,#32
 896  024a 261a          	jrne	L771
 897                     ; 202 				GPIO_WriteReverse(GPIOD,GPIO_PIN_4);
 899  024c cd035a        	call	LC006
 901                     ; 204 				GPIO_WriteReverse(GPIOD,GPIO_PIN_4);
 903  024f cd032c        	call	LC002
 904                     ; 205 				dummy_delay(60000);
 906  0252 cd00ce        	call	_dummy_delay
 908                     ; 206 				if(stabilizationTask > 80){
 910  0255 ce0000        	ldw	x,_stabilizationTask
 911  0258 a30051        	cpw	x,#81
 912  025b 2509          	jrult	L771
 913                     ; 207 					stabilizationTask -=2;
 915  025d ce0000        	ldw	x,_stabilizationTask
 916  0260 1d0002        	subw	x,#2
 917  0263 cf0000        	ldw	_stabilizationTask,x
 918  0266               L771:
 919                     ; 212 			if(! (bits & (1 << 3))) {
 921  0266 7b02          	ld	a,(OFST-5,sp)
 922  0268 a508          	bcp	a,#8
 923  026a 2683          	jrne	L361
 924                     ; 213 				GPIO_WriteReverse(GPIOD,GPIO_PIN_4);
 926  026c cd032c        	call	LC002
 927                     ; 214 				dummy_delay(60000);
 929  026f cd00ce        	call	_dummy_delay
 931                     ; 215 				GPIO_WriteReverse(GPIOD,GPIO_PIN_4);
 933  0272 4b10          	push	#16
 934  0274 ae500f        	ldw	x,#20495
 935  0277 cd0000        	call	_GPIO_WriteReverse
 937  027a 84            	pop	a
 938                     ; 218 				FLASH_Unlock(FLASH_MEMTYPE_DATA);
 940  027b a6f7          	ld	a,#247
 941  027d cd0000        	call	_FLASH_Unlock
 943                     ; 221 				FLASH_EraseByte(start_add );
 945  0280 1e06          	ldw	x,(OFST-1,sp)
 946  0282 89            	pushw	x
 947  0283 1e06          	ldw	x,(OFST-1,sp)
 948  0285 89            	pushw	x
 949  0286 cd0000        	call	_FLASH_EraseByte
 951  0289 5b04          	addw	sp,#4
 952                     ; 222 				FLASH_EraseByte(start_add + 1);
 954  028b 96            	ldw	x,sp
 955  028c 1c0004        	addw	x,#OFST-3
 956  028f cd034f        	call	LC005
 957  0292 89            	pushw	x
 958  0293 be00          	ldw	x,c_lreg
 959  0295 89            	pushw	x
 960  0296 cd0000        	call	_FLASH_EraseByte
 962  0299 5b04          	addw	sp,#4
 963                     ; 223 				FLASH_EraseByte(start_add + 2);
 965  029b 96            	ldw	x,sp
 966  029c 1c0004        	addw	x,#OFST-3
 967  029f cd0344        	call	LC004
 968  02a2 89            	pushw	x
 969  02a3 be00          	ldw	x,c_lreg
 970  02a5 89            	pushw	x
 971  02a6 cd0000        	call	_FLASH_EraseByte
 973  02a9 5b04          	addw	sp,#4
 974                     ; 224 				FLASH_EraseByte(start_add + 3);
 976  02ab 96            	ldw	x,sp
 977  02ac 1c0004        	addw	x,#OFST-3
 978  02af cd0339        	call	LC003
 979  02b2 89            	pushw	x
 980  02b3 be00          	ldw	x,c_lreg
 981  02b5 89            	pushw	x
 982  02b6 cd0000        	call	_FLASH_EraseByte
 984  02b9 5b04          	addw	sp,#4
 985                     ; 226 				FLASH_ProgramByte(start_add, (stabilizationTask & 0x00ff));
 987  02bb c60001        	ld	a,_stabilizationTask+1
 988  02be 88            	push	a
 989  02bf 1e07          	ldw	x,(OFST+0,sp)
 990  02c1 89            	pushw	x
 991  02c2 1e07          	ldw	x,(OFST+0,sp)
 992  02c4 89            	pushw	x
 993  02c5 cd0000        	call	_FLASH_ProgramByte
 995  02c8 5b05          	addw	sp,#5
 996                     ; 227 				FLASH_ProgramByte(start_add + 1, ((stabilizationTask & 0x0f00) >> 8));
 998  02ca c60000        	ld	a,_stabilizationTask
 999  02cd a40f          	and	a,#15
1000  02cf 88            	push	a
1001  02d0 96            	ldw	x,sp
1002  02d1 1c0005        	addw	x,#OFST-2
1003  02d4 ad79          	call	LC005
1004  02d6 89            	pushw	x
1005  02d7 be00          	ldw	x,c_lreg
1006  02d9 89            	pushw	x
1007  02da cd0000        	call	_FLASH_ProgramByte
1009  02dd 5b05          	addw	sp,#5
1010                     ; 228 				FLASH_ProgramByte(start_add + 2, (resistance & 0x00ff));
1012  02df c60005        	ld	a,_resistance+1
1013  02e2 88            	push	a
1014  02e3 96            	ldw	x,sp
1015  02e4 1c0005        	addw	x,#OFST-2
1016  02e7 ad5b          	call	LC004
1017  02e9 89            	pushw	x
1018  02ea be00          	ldw	x,c_lreg
1019  02ec 89            	pushw	x
1020  02ed cd0000        	call	_FLASH_ProgramByte
1022  02f0 5b05          	addw	sp,#5
1023                     ; 229 				FLASH_ProgramByte(start_add + 3, ((resistance & 0x0f00) >> 8));
1025  02f2 c60004        	ld	a,_resistance
1026  02f5 a40f          	and	a,#15
1027  02f7 88            	push	a
1028  02f8 96            	ldw	x,sp
1029  02f9 1c0005        	addw	x,#OFST-2
1030  02fc ad3b          	call	LC003
1031  02fe 89            	pushw	x
1032  02ff be00          	ldw	x,c_lreg
1033  0301 89            	pushw	x
1034  0302 cd0000        	call	_FLASH_ProgramByte
1036  0305 5b05          	addw	sp,#5
1037                     ; 231 				FLASH_Lock(FLASH_MEMTYPE_DATA);
1039  0307 a6f7          	ld	a,#247
1040  0309 cd0000        	call	_FLASH_Lock
1042                     ; 232 				dummy_delay(60000);
1044  030c aeea60        	ldw	x,#60000
1045  030f ad0e          	call	LC001
1046  0311 ad0c          	call	LC001
1047  0313 ad0a          	call	LC001
1048  0315 ad08          	call	LC001
1049  0317 ad06          	call	LC001
1050  0319 cd00ce        	call	_dummy_delay
1052  031c cc01ef        	jra	L361
1053  031f               LC001:
1054  031f cd00ce        	call	_dummy_delay
1056                     ; 183 				dummy_delay(60000);
1058  0322 aeea60        	ldw	x,#60000
1059  0325 cd00ce        	call	_dummy_delay
1061                     ; 184 				dummy_delay(60000);
1063  0328 aeea60        	ldw	x,#60000
1064  032b 81            	ret	
1065  032c               LC002:
1066  032c 4b10          	push	#16
1067  032e ae500f        	ldw	x,#20495
1068  0331 cd0000        	call	_GPIO_WriteReverse
1070  0334 aeea60        	ldw	x,#60000
1071  0337 84            	pop	a
1072  0338 81            	ret	
1073  0339               LC003:
1074  0339 cd0000        	call	c_ltor
1076  033c a603          	ld	a,#3
1077  033e cd0000        	call	c_ladc
1079  0341 be02          	ldw	x,c_lreg+2
1080  0343 81            	ret	
1081  0344               LC004:
1082  0344 cd0000        	call	c_ltor
1084  0347 a602          	ld	a,#2
1085  0349 cd0000        	call	c_ladc
1087  034c be02          	ldw	x,c_lreg+2
1088  034e 81            	ret	
1089  034f               LC005:
1090  034f cd0000        	call	c_ltor
1092  0352 a601          	ld	a,#1
1093  0354 cd0000        	call	c_ladc
1095  0357 be02          	ldw	x,c_lreg+2
1096  0359 81            	ret	
1097  035a               LC006:
1098  035a 4b10          	push	#16
1099  035c ae500f        	ldw	x,#20495
1100  035f cd0000        	call	_GPIO_WriteReverse
1102  0362 ae2710        	ldw	x,#10000
1103  0365 84            	pop	a
1104                     ; 193 				dummy_delay(10000);
1106  0366 cc00ce        	jp	_dummy_delay
1200                     	xdef	_main
1201                     	xdef	_tim4_init
1202                     	xdef	_tim1_pwm_ch1_init
1203                     	xdef	_adc_scan_to_4_init
1204                     	xdef	_dummy_delay
1205                     	xdef	_gpioPeripherialInit
1206                     	xdef	_clockInit
1207                     	xdef	_lowPassFilterPortD3
1208                     	xdef	_lowPassFilterPortD2
1209                     	xdef	_calibrationFlag
1210                     	switch	.bss
1211  0000               _stabilizationTask:
1212  0000 0000          	ds.b	2
1213                     	xdef	_stabilizationTask
1214  0002               _emf_voltage:
1215  0002 0000          	ds.b	2
1216                     	xdef	_emf_voltage
1217  0004               _resistance:
1218  0004 0000          	ds.b	2
1219                     	xdef	_resistance
1220  0006               _current:
1221  0006 0000          	ds.b	2
1222                     	xdef	_current
1223  0008               _voltage:
1224  0008 0000          	ds.b	2
1225                     	xdef	_voltage
1226  000a               _pwm_variable:
1227  000a 0000          	ds.b	2
1228                     	xdef	_pwm_variable
1229  000c               _portd_3_adc_value:
1230  000c 0000          	ds.b	2
1231                     	xdef	_portd_3_adc_value
1232  000e               _portd_2_adc_value:
1233  000e 0000          	ds.b	2
1234                     	xdef	_portd_2_adc_value
1235                     	xref	_FLASH_SetProgrammingTime
1236                     	xref	_FLASH_ReadByte
1237                     	xref	_FLASH_ProgramByte
1238                     	xref	_FLASH_EraseByte
1239                     	xref	_FLASH_Lock
1240                     	xref	_FLASH_Unlock
1241                     	xref	_TIM4_ARRPreloadConfig
1242                     	xref	_TIM4_ITConfig
1243                     	xref	_TIM4_Cmd
1244                     	xref	_TIM4_TimeBaseInit
1245                     	xref	_TIM1_SetCompare4
1246                     	xref	_TIM1_CtrlPWMOutputs
1247                     	xref	_TIM1_Cmd
1248                     	xref	_TIM1_OC4Init
1249                     	xref	_TIM1_TimeBaseInit
1250                     	xref	_TIM1_DeInit
1251                     	xref	_GPIO_ReadInputData
1252                     	xref	_GPIO_WriteReverse
1253                     	xref	_GPIO_Init
1254                     	xref	_GPIO_DeInit
1255                     	xref	_CLK_SYSCLKConfig
1256                     	xref	_CLK_PeripheralClockConfig
1257                     	xref	_ADC1_StartConversion
1258                     	xref	_ADC1_ITConfig
1259                     	xref	_ADC1_DataBufferCmd
1260                     	xref	_ADC1_ScanModeCmd
1261                     	xref	_ADC1_Init
1262                     	xref	_ADC1_DeInit
1263                     	xref.b	c_lreg
1283                     	xref	c_ladc
1284                     	xref	c_lgadd
1285                     	xref	c_lgsub
1286                     	xref	c_lrsh
1287                     	xref	c_ltor
1288                     	xref	c_lglsh
1289                     	end
