   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.6 - 16 Dec 2021
   3                     ; Generator (Limited) V4.5.4 - 16 Dec 2021
   4                     ; Optimizer V4.5.4 - 16 Dec 2021
  47                     ; 70 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  47                     ; 71 {
  48                     	switch	.text
  49  0000               f_TRAP_IRQHandler:
  53                     ; 75 }
  56  0000 80            	iret	
  78                     ; 81 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
  78                     ; 82 {
  79                     	switch	.text
  80  0001               f_TLI_IRQHandler:
  84                     ; 86 }
  87  0001 80            	iret	
 109                     ; 93 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 109                     ; 94 {
 110                     	switch	.text
 111  0002               f_AWU_IRQHandler:
 115                     ; 98 }
 118  0002 80            	iret	
 140                     ; 105 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 140                     ; 106 {
 141                     	switch	.text
 142  0003               f_CLK_IRQHandler:
 146                     ; 110 }
 149  0003 80            	iret	
 172                     ; 117 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 172                     ; 118 {
 173                     	switch	.text
 174  0004               f_EXTI_PORTA_IRQHandler:
 178                     ; 122 }
 181  0004 80            	iret	
 204                     ; 129 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 204                     ; 130 {
 205                     	switch	.text
 206  0005               f_EXTI_PORTB_IRQHandler:
 210                     ; 134 }
 213  0005 80            	iret	
 236                     ; 141 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 236                     ; 142 {
 237                     	switch	.text
 238  0006               f_EXTI_PORTC_IRQHandler:
 242                     ; 147 }
 245  0006 80            	iret	
 268                     ; 154 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 268                     ; 155 {
 269                     	switch	.text
 270  0007               f_EXTI_PORTD_IRQHandler:
 274                     ; 159 }
 277  0007 80            	iret	
 300                     ; 166 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 300                     ; 167 {
 301                     	switch	.text
 302  0008               f_EXTI_PORTE_IRQHandler:
 306                     ; 171 }
 309  0008 80            	iret	
 331                     ; 217 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 331                     ; 218 {
 332                     	switch	.text
 333  0009               f_SPI_IRQHandler:
 337                     ; 222 }
 340  0009 80            	iret	
 363                     ; 229 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 363                     ; 230 {
 364                     	switch	.text
 365  000a               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 369                     ; 234 }
 372  000a 80            	iret	
 395                     ; 241 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 395                     ; 242 {
 396                     	switch	.text
 397  000b               f_TIM1_CAP_COM_IRQHandler:
 401                     ; 246 }
 404  000b 80            	iret	
 427                     ; 278  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 427                     ; 279 {
 428                     	switch	.text
 429  000c               f_TIM2_UPD_OVF_BRK_IRQHandler:
 433                     ; 283 }
 436  000c 80            	iret	
 459                     ; 290  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 459                     ; 291 {
 460                     	switch	.text
 461  000d               f_TIM2_CAP_COM_IRQHandler:
 465                     ; 295 }
 468  000d 80            	iret	
 491                     ; 332  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 491                     ; 333 {
 492                     	switch	.text
 493  000e               f_UART1_TX_IRQHandler:
 497                     ; 337 	UART1->SR &= ~UART1_FLAG_TC;
 499  000e 721d5230      	bres	21040,#6
 500                     ; 339 }
 503  0012 80            	iret	
 526                     ; 346  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 526                     ; 347 {
 527                     	switch	.text
 528  0013               f_UART1_RX_IRQHandler:
 532                     ; 354 	UART1->SR &= ~UART1_FLAG_RXNE;
 534  0013 721b5230      	bres	21040,#5
 535                     ; 355 	UART1->SR &= ~UART1_FLAG_NF;
 537  0017 72155230      	bres	21040,#2
 538                     ; 359 }
 541  001b 80            	iret	
 563                     ; 367 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 563                     ; 368 {
 564                     	switch	.text
 565  001c               f_I2C_IRQHandler:
 569                     ; 372 }
 572  001c 80            	iret	
 608                     ; 447  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 608                     ; 448 {
 609                     	switch	.text
 610  001d               f_ADC1_IRQHandler:
 612  001d 8a            	push	cc
 613  001e 84            	pop	a
 614  001f a4bf          	and	a,#191
 615  0021 88            	push	a
 616  0022 86            	pop	cc
 617       00000002      OFST:	set	2
 618  0023 3b0002        	push	c_x+2
 619  0026 be00          	ldw	x,c_x
 620  0028 89            	pushw	x
 621  0029 3b0002        	push	c_y+2
 622  002c be00          	ldw	x,c_y
 623  002e 89            	pushw	x
 624  002f be02          	ldw	x,c_lreg+2
 625  0031 89            	pushw	x
 626  0032 be00          	ldw	x,c_lreg
 627  0034 89            	pushw	x
 628  0035 89            	pushw	x
 631                     ; 450 	GPIO_WriteReverse(GPIOB,GPIO_PIN_5);
 633  0036 4b20          	push	#32
 634  0038 ae5005        	ldw	x,#20485
 635  003b cd0000        	call	_GPIO_WriteReverse
 637  003e 84            	pop	a
 638                     ; 452 	portd_2_adc_value =  lowPassFilterPortD2( (ADC1->DB3RH<<8)|ADC1->DB3RL );
 640  003f c653e6        	ld	a,21478
 641  0042 97            	ld	xl,a
 642  0043 c653e7        	ld	a,21479
 643  0046 02            	rlwa	x,a
 644  0047 cd0000        	call	c_uitolx
 646  004a be02          	ldw	x,c_lreg+2
 647  004c 89            	pushw	x
 648  004d be00          	ldw	x,c_lreg
 649  004f 89            	pushw	x
 650  0050 cd0000        	call	_lowPassFilterPortD2
 652  0053 5b04          	addw	sp,#4
 653  0055 cf0000        	ldw	_portd_2_adc_value,x
 654                     ; 453 	portd_3_adc_value =  lowPassFilterPortD3( (ADC1->DB4RH<<8)|ADC1->DB4RL );
 656  0058 c653e8        	ld	a,21480
 657  005b 97            	ld	xl,a
 658  005c c653e9        	ld	a,21481
 659  005f 02            	rlwa	x,a
 660  0060 cd0000        	call	c_uitolx
 662  0063 be02          	ldw	x,c_lreg+2
 663  0065 89            	pushw	x
 664  0066 be00          	ldw	x,c_lreg
 665  0068 89            	pushw	x
 666  0069 cd0000        	call	_lowPassFilterPortD3
 668  006c cf0000        	ldw	_portd_3_adc_value,x
 669  006f 5b04          	addw	sp,#4
 670                     ; 454 	voltage = portd_2_adc_value - portd_3_adc_value;
 672  0071 ce0000        	ldw	x,_portd_2_adc_value
 673  0074 72b00000      	subw	x,_portd_3_adc_value
 674  0078 cf0000        	ldw	_voltage,x
 675                     ; 455 	current = portd_3_adc_value;
 677  007b ce0000        	ldw	x,_portd_3_adc_value
 678  007e cf0000        	ldw	_current,x
 679                     ; 456 	 ADC1_ClearFlag(ADC1_FLAG_EOC);
 681  0081 a680          	ld	a,#128
 682  0083 cd0000        	call	_ADC1_ClearFlag
 684                     ; 458 	 if (calibrationFlag == '@') {
 686  0086 c60000        	ld	a,_calibrationFlag
 687  0089 a140          	cp	a,#64
 688  008b 2613          	jrne	L132
 689                     ; 460 		 TIM1_SetCompare4(256);
 691  008d ae0100        	ldw	x,#256
 692  0090 cd0000        	call	_TIM1_SetCompare4
 694                     ; 462 		 resistance = voltage / current;
 696  0093 ce0000        	ldw	x,_voltage
 697  0096 90ce0000      	ldw	y,_current
 698  009a 65            	divw	x,y
 699  009b cf0000        	ldw	_resistance,x
 701  009e 2038          	jra	L332
 702  00a0               L132:
 703                     ; 463 	 } else if (calibrationFlag == 'R'){
 705  00a0 a152          	cp	a,#82
 706  00a2 2634          	jrne	L332
 707                     ; 466 		 emf_voltage = voltage - (current * resistance);
 709  00a4 ce0000        	ldw	x,_current
 710  00a7 90ce0000      	ldw	y,_resistance
 711  00ab cd0000        	call	c_imul
 713  00ae 1f01          	ldw	(OFST-1,sp),x
 715  00b0 ce0000        	ldw	x,_voltage
 716  00b3 72f001        	subw	x,(OFST-1,sp)
 717  00b6 cf0000        	ldw	_emf_voltage,x
 718                     ; 467 		 if((emf_voltage < stabilizationTask)&(emf_voltage < 1022)){
 720  00b9 c30000        	cpw	x,_stabilizationTask
 721  00bc 240b          	jruge	L732
 723  00be a303fe        	cpw	x,#1022
 724  00c1 2406          	jruge	L732
 725                     ; 468 			 pwm_variable++;
 727  00c3 ce0000        	ldw	x,_pwm_variable
 728  00c6 5c            	incw	x
 730  00c7 2009          	jpf	LC001
 731  00c9               L732:
 732                     ; 469 		 } else if (pwm_variable > 1) {
 734  00c9 ce0000        	ldw	x,_pwm_variable
 735  00cc a30002        	cpw	x,#2
 736  00cf 2504          	jrult	L142
 737                     ; 470 		   pwm_variable--;
 739  00d1 5a            	decw	x
 740  00d2               LC001:
 741  00d2 cf0000        	ldw	_pwm_variable,x
 742  00d5               L142:
 743                     ; 472 		 		 TIM1_SetCompare4(pwm_variable);
 745  00d5 cd0000        	call	_TIM1_SetCompare4
 747  00d8               L332:
 748                     ; 475 	GPIO_WriteReverse(GPIOB,GPIO_PIN_5);
 750  00d8 4b20          	push	#32
 751  00da ae5005        	ldw	x,#20485
 752  00dd cd0000        	call	_GPIO_WriteReverse
 754  00e0 84            	pop	a
 755                     ; 479     return;
 758  00e1 5b02          	addw	sp,#2
 759  00e3 85            	popw	x
 760  00e4 bf00          	ldw	c_lreg,x
 761  00e6 85            	popw	x
 762  00e7 bf02          	ldw	c_lreg+2,x
 763  00e9 85            	popw	x
 764  00ea bf00          	ldw	c_y,x
 765  00ec 320002        	pop	c_y+2
 766  00ef 85            	popw	x
 767  00f0 bf00          	ldw	c_x,x
 768  00f2 320002        	pop	c_x+2
 769  00f5 80            	iret	
 794                     ; 502  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 794                     ; 503 {	
 795                     	switch	.text
 796  00f6               f_TIM4_UPD_OVF_IRQHandler:
 798  00f6 8a            	push	cc
 799  00f7 84            	pop	a
 800  00f8 a4bf          	and	a,#191
 801  00fa 88            	push	a
 802  00fb 86            	pop	cc
 803  00fc 3b0002        	push	c_x+2
 804  00ff be00          	ldw	x,c_x
 805  0101 89            	pushw	x
 806  0102 3b0002        	push	c_y+2
 807  0105 be00          	ldw	x,c_y
 808  0107 89            	pushw	x
 811                     ; 508 	ADC1_Cmd(ENABLE);
 813  0108 a601          	ld	a,#1
 814  010a cd0000        	call	_ADC1_Cmd
 816                     ; 510 	 TIM4_ClearFlag(TIM4_FLAG_UPDATE); 
 818  010d a601          	ld	a,#1
 819  010f cd0000        	call	_TIM4_ClearFlag
 821                     ; 516 }
 824  0112 85            	popw	x
 825  0113 bf00          	ldw	c_y,x
 826  0115 320002        	pop	c_y+2
 827  0118 85            	popw	x
 828  0119 bf00          	ldw	c_x,x
 829  011b 320002        	pop	c_x+2
 830  011e 80            	iret	
 853                     ; 524 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 853                     ; 525 {
 854                     	switch	.text
 855  011f               f_EEPROM_EEC_IRQHandler:
 859                     ; 529 }
 862  011f 80            	iret	
 874                     	xref	_calibrationFlag
 875                     	xref	_stabilizationTask
 876                     	xref	_emf_voltage
 877                     	xref	_resistance
 878                     	xref	_current
 879                     	xref	_voltage
 880                     	xref	_pwm_variable
 881                     	xref	_portd_3_adc_value
 882                     	xref	_portd_2_adc_value
 883                     	xref	_lowPassFilterPortD3
 884                     	xref	_lowPassFilterPortD2
 885                     	xdef	f_EEPROM_EEC_IRQHandler
 886                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 887                     	xdef	f_ADC1_IRQHandler
 888                     	xdef	f_I2C_IRQHandler
 889                     	xdef	f_UART1_RX_IRQHandler
 890                     	xdef	f_UART1_TX_IRQHandler
 891                     	xdef	f_TIM2_CAP_COM_IRQHandler
 892                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 893                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 894                     	xdef	f_TIM1_CAP_COM_IRQHandler
 895                     	xdef	f_SPI_IRQHandler
 896                     	xdef	f_EXTI_PORTE_IRQHandler
 897                     	xdef	f_EXTI_PORTD_IRQHandler
 898                     	xdef	f_EXTI_PORTC_IRQHandler
 899                     	xdef	f_EXTI_PORTB_IRQHandler
 900                     	xdef	f_EXTI_PORTA_IRQHandler
 901                     	xdef	f_CLK_IRQHandler
 902                     	xdef	f_AWU_IRQHandler
 903                     	xdef	f_TLI_IRQHandler
 904                     	xdef	f_TRAP_IRQHandler
 905                     	xref	_TIM4_ClearFlag
 906                     	xref	_TIM1_SetCompare4
 907                     	xref	_GPIO_WriteReverse
 908                     	xref	_ADC1_ClearFlag
 909                     	xref	_ADC1_Cmd
 910                     	xref.b	c_lreg
 911                     	xref.b	c_x
 912                     	xref.b	c_y
 931                     	xref	c_imul
 932                     	xref	c_uitolx
 933                     	end
