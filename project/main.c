/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
/*Author: Andrii Androsovych**/
#include "stm8s.h"
#include "stm8s_flash.h"

//values of PortD 2, 3 after filtering
//*****PORTD 2 - VOLTAGE  PORTD 3 - CURRENT**********************************
volatile unsigned short portd_2_adc_value, portd_3_adc_value;
volatile unsigned short pwm_variable, voltage, current, resistance, emf_voltage, stabilizationTask;
/*
pwm_variable, - a parameter which will be send into PWM channel
voltage, - DC voltage on the motor
current, - current of the DC motor
resistance, - resistance of the motor
emf_voltage, - a back EMF voltage on the motor 
stabilizationTask; - an stabilized parameter (back EMF of the motor)

*/
char calibrationFlag = 'R'; //means RUN, '@' means CALIBRATION
/***moving average filters - for current and voltage of */
unsigned short lowPassFilterPortD2 (  long new_sample) {
  static long avg = 0;
	 
	 //to increase acuracy of filter - multiply an input signal
	  new_sample  <<= 11;
	 	/*ATTENTION! the number of bits to shift depending
		on mechanical characteristics of motor*/
    avg -= avg >> 3;
    avg += new_sample >> 3;
		
		
		//restore an input amplitude
    return  avg >> 11;
}

 
unsigned short lowPassFilterPortD3 (  long new_sample) {
  static long avg = 0;
	 
	 //to increase acuracy of the filter - multiply an input signal
	  new_sample  <<= 11;
	 	/*ATTENTION! the number of bits to shift depending
		on mechanical characteristics of motor - i.e. LPF cutoff frequency*/
    avg -= avg >> 3;
    avg += new_sample >> 3;
		
		//restore an input amplitude
    return  avg >> 11;
}


void clockInit (void) {
 //CLK_HSIPrescalerConfig ( CLK_PRESCALER_HSIDIV8);//1MHz
 CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1); // set 16 MHz for CPU

	 CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
	 CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
	 CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);
	 CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);
	
}
 
 

void gpioPeripherialInit (void) {
	 
	GPIO_DeInit(GPIOB);
	GPIO_Init(GPIOB,GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_FAST);//LED
	GPIO_DeInit(GPIOC);
	GPIO_Init(GPIOC,GPIO_PIN_4,GPIO_MODE_OUT_PP_LOW_FAST );//pwm
	GPIO_Init(GPIOC,GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7|GPIO_PIN_3 ,GPIO_MODE_IN_PU_NO_IT);//buttons
	GPIO_DeInit(GPIOD);
	GPIO_Init(GPIOD, GPIO_PIN_2|GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//ADC - D2, D3
	GPIO_Init(GPIOD, GPIO_PIN_4 ,GPIO_MODE_OUT_PP_LOW_FAST); //LED
}



void dummy_delay (unsigned int period) {
	while (period) {
		period--;
	}
	
}

/*********A D C***********/
void adc_scan_to_4_init (void) {
	 ADC1_DeInit();
	 
	ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, ADC1_CHANNEL_4,
			ADC1_PRESSEL_FCPU_D2 , ADC1_EXTTRIG_GPIO,
			DISABLE, ADC1_ALIGN_RIGHT,
			ADC1_SCHMITTTRIG_ALL, DISABLE);
	//allow scan mode
	ADC1_ScanModeCmd(ENABLE);
	//it
	//allow storing data in ADC_DBxRH / ADC_DBxRL buffer rewgisters
 //when scan mode	
	ADC1_DataBufferCmd(ENABLE);	
	ADC1_ITConfig(  ADC1_IT_EOCIE, ENABLE);
}
/***********T I M - 1**/
void tim1_pwm_ch1_init(void) {
  TIM1_DeInit();
    /// 11bit resolution pwm
  TIM1_TimeBaseInit(0, TIM1_COUNTERMODE_UP, 1024, 0); 
 
  TIM1_OC4Init(TIM1_OCMODE_PWM1, TIM1_OUTPUTSTATE_ENABLE, 0x00ff, TIM1_OCPOLARITY_HIGH, TIM1_OCIDLESTATE_SET);

  /* TIM1 counter enable */
  TIM1_Cmd(ENABLE);

  /* TIM1 Main Output Enable */
  TIM1_CtrlPWMOutputs(ENABLE);
		
}
/***8 bit T I M  4***/
void tim4_init(void) {
	
	TIM4_TimeBaseInit (TIM4_PRESCALER_64,0xF6);//2500Hz
	TIM4_ARRPreloadConfig(DISABLE);
//it
	TIM4_ITConfig(TIM4_IT_UPDATE ,ENABLE);
	TIM4_Cmd(ENABLE);
	
}



/******M A I N**********/
main()
{
	char sw =0;
	uint32_t start_add = 0x4010;
	clockInit();
		/*Define FLASH programming time*/
    FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
		/**restore values from the flash*/
		/* Unlock Data memory */
		FLASH_Unlock(FLASH_MEMTYPE_DATA);
		//high byte
		 stabilizationTask =  FLASH_ReadByte(start_add + 1);
		 stabilizationTask <<= 8;
		 //low byte
		 stabilizationTask |= FLASH_ReadByte(start_add);
		 //high byte
		 resistance =  FLASH_ReadByte(start_add + 3);
		 resistance <<= 8;
		 //low byte
		 resistance |= FLASH_ReadByte(start_add + 2);
		 FLASH_Lock(FLASH_MEMTYPE_DATA);
		 
				
	 gpioPeripherialInit();
	 adc_scan_to_4_init();
	 tim4_init();
	 tim1_pwm_ch1_init();
	 /*set default parameters*/
	 /*stabilizationTask = 200; 
	 pwm_variable = 200;
	 resistance = 5;*/
	 enableInterrupts();
   ADC1_StartConversion ();
	 TIM1_SetCompare4(256);
		//infinite loop
		while (1){
			//reading portC input bits
		 unsigned char bits = GPIO_ReadInputData(GPIOC);
		 //only 5,6,7 bits
		 bits  &= 0b11101000;
		 //GPIOC 7 scan -CALIBRATION
		 if(! (bits & (1 << 7))) {
		 TIM1_SetCompare4(256);
		 //when GPIOC7 clear - a button push
				calibrationFlag = '@';
				GPIO_WriteReverse(GPIOD,GPIO_PIN_4);
				dummy_delay(20000);
				GPIO_WriteReverse(GPIOD,GPIO_PIN_4);
				dummy_delay(60000);
				dummy_delay(60000);
				dummy_delay(60000);
				dummy_delay(60000);
				dummy_delay(60000);
			} else {
				calibrationFlag = 'R';
			}
			//GPIOC 6 scan - speed up
			if(! (bits & (1 << 6))) {
				GPIO_WriteReverse(GPIOD,GPIO_PIN_4);
				dummy_delay(10000);
				GPIO_WriteReverse(GPIOD,GPIO_PIN_4);
				dummy_delay(60000);
				if(stabilizationTask < 1024){
					stabilizationTask +=5;
				}
			}
			//GPIOC 5 scan - speed down
			if(! (bits & (1 << 5))) {
				GPIO_WriteReverse(GPIOD,GPIO_PIN_4);
				dummy_delay(10000);
				GPIO_WriteReverse(GPIOD,GPIO_PIN_4);
				dummy_delay(60000);
				if(stabilizationTask > 80){
					stabilizationTask -=2;
				}
			}
			
				//GPIOC 3 scan - save to EEPROM
			if(! (bits & (1 << 3))) {
				GPIO_WriteReverse(GPIOD,GPIO_PIN_4);
				dummy_delay(60000);
				GPIO_WriteReverse(GPIOD,GPIO_PIN_4);
			
				/* Unlock Data memory */
				FLASH_Unlock(FLASH_MEMTYPE_DATA);
				//erease old values
				 
				FLASH_EraseByte(start_add );
				FLASH_EraseByte(start_add + 1);
				FLASH_EraseByte(start_add + 2);
				FLASH_EraseByte(start_add + 3);
				//write new values
				FLASH_ProgramByte(start_add, (stabilizationTask & 0x00ff));
				FLASH_ProgramByte(start_add + 1, ((stabilizationTask & 0x0f00) >> 8));
				FLASH_ProgramByte(start_add + 2, (resistance & 0x00ff));
				FLASH_ProgramByte(start_add + 3, ((resistance & 0x0f00) >> 8));
				//lock data memory
				FLASH_Lock(FLASH_MEMTYPE_DATA);
				dummy_delay(60000);
				dummy_delay(60000);
				dummy_delay(60000);
				dummy_delay(60000);
				dummy_delay(60000); 
				dummy_delay(60000);
				dummy_delay(60000);
				dummy_delay(60000);
				dummy_delay(60000);
				dummy_delay(60000);
				dummy_delay(60000);
			}
	
		
		}
}



