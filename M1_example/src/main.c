/*
 *********************************************************************************************
 * @file      main.c
 * @author    GowinSemicoductor
 * @device    Gowin_EMPU_M1
 * @brief     Main function.
 *********************************************************************************************
 */

/* Includes ------------------------------------------------------------------*/
#include "GOWIN_M1.h"
#include "GOWIN_M1_gpio.h"

/* Definitions ---------------------------------------------------------------*/


//Application entry function
int main(void)
{
	SystemInit();

GPIO_InitTypeDef GPIO_InitType;
	
	//Initializes GPIO pin 0~3 as output
	GPIO_InitType.GPIO_Pin = GPIO_Pin_0 |
	                         GPIO_Pin_1 |
	                         GPIO_Pin_2 |
	                         GPIO_Pin_3;			//Pin 0~3
	GPIO_InitType.GPIO_Mode = GPIO_Mode_OUT;	//As output
	GPIO_Init(GPIO0,&GPIO_InitType);					//Initialized
	
	//Initializes GPIO pin 4~7 as input
	GPIO_InitType.GPIO_Pin = GPIO_Pin_4 |
													 GPIO_Pin_5 |
													 GPIO_Pin_6 |
													 GPIO_Pin_7;			//Pin 4~7
	GPIO_InitType.GPIO_Mode = GPIO_Mode_IN;		//As input
	GPIO_Init(GPIO0,&GPIO_InitType);					//Initialized
	
	//Initializes output value
	//on:0; 1:off on some boards
	//on:1; 0:off on some boards
	//Customized
	GPIO_SetBit(GPIO0,GPIO_Pin_0|GPIO_Pin_1|GPIO_Pin_2|GPIO_Pin_3);

	uint32_t delay;
	uint32_t delay_value = 1000000;
	while(1)
	{
		GPIO_WriteBits(GPIO0,0xE);
		for(delay = 0; delay < delay_value; delay++);
		GPIO_WriteBits(GPIO0,0xD);
		for(delay = 0; delay < delay_value; delay++);
		GPIO_WriteBits(GPIO0,0xB);
		for(delay = 0; delay < delay_value; delay++);
		GPIO_WriteBits(GPIO0,0x7);
		for(delay = 0; delay < delay_value; delay++);
		
	}
}
