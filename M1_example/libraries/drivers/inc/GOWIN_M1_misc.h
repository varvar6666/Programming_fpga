/*
 ****************************************************************************************************
 * @file      GOWIN_M1_misc.h
 * @author    GowinSemicoductor
 * @device    Gowin_EMPU_M1
 * @brief     This file contains all the functions prototypes for the miscellaneous firmware library.
 ****************************************************************************************************
 */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef GOWIN_M1_MISC_H
#define GOWIN_M1_MISC_H

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "GOWIN_M1.h"

/** @addtogroup GOWIN_M1_StdPeriph_Driver
  * @{
  */

/** @addtogroup MISC
  * @{
  */

/** @defgroup MISC_Exported_Types
  * @{
  */

/** 
  * @brief  NVIC Init Structure definition  
  */
typedef struct
{
  uint8_t NVIC_IRQChannel;                      /* the IRQ channel to be enabled or disabled
                                                   param : IRQn_Type */

  uint8_t NVIC_IRQChannelPreemptionPriority;    /* the pre-emption priority
                                                   param : 0~15 NVIC_Priority_Table */

  uint8_t NVIC_IRQChannelSubPriority;           /* the subpriority level
                                                   param : 0~15 in NVIC_Priority_Table */

  FunctionalState NVIC_IRQChannelCmd;           /* whether the IRQ channel defined in NVIC_IRQChannel 
                                                   param : enabled or disabled */   
}NVIC_InitTypeDef;

/**
  * @}
  */

/** @defgroup NVIC_Priority_Table 
  * @{
  */

/**
@code  
 The table below gives the allowed values of the pre-emption priority and subpriority according to the Priority Grouping configuration performed by NVIC_PriorityGroupConfig function
  ============================================================================================================================
    NVIC_PriorityGroup   | NVIC_IRQChannelPreemptionPriority | NVIC_IRQChannelSubPriority  | Description
  ============================================================================================================================
   NVIC_PriorityGroup_0  |                0                  |            0-7              |   0 bits for pre-emption priority
                         |                                   |                             |   3 bits for subpriority
  ----------------------------------------------------------------------------------------------------------------------------
   NVIC_PriorityGroup_1  |                0-1                |            0-3              |   1 bits for pre-emption priority
                         |                                   |                             |   2 bits for subpriority
  ----------------------------------------------------------------------------------------------------------------------------    
   NVIC_PriorityGroup_2  |                0-3                |            0-1              |   2 bits for pre-emption priority
                         |                                   |                             |   1 bits for subpriority
  ----------------------------------------------------------------------------------------------------------------------------    
   NVIC_PriorityGroup_3  |                0-7                |            0                |   3 bits for pre-emption priority
                         |                                   |                             |   0 bits for subpriority
  ============================================================================================================================
@endcode
*/

/**
  * @}
  */

/** @defgroup MISC_Exported_Macros
  * @{
  */

/** 
  * @brief Vector Table Base 
  */
#define NVIC_VectTab_RAM             SRAM_BASE
#define NVIC_VectTab_FLASH           FLASH_BASE

/**
  * @brief Preemption Priority Group
  */
#define NVIC_PriorityGroup_0         ((uint32_t)0x700) /*!< 0 bits for pre-emption priority
                                                            3 bits for subpriority */
#define NVIC_PriorityGroup_1         ((uint32_t)0x600) /*!< 1 bits for pre-emption priority
                                                            2 bits for subpriority */
#define NVIC_PriorityGroup_2         ((uint32_t)0x500) /*!< 2 bits for pre-emption priority
                                                            1 bits for subpriority */
#define NVIC_PriorityGroup_3         ((uint32_t)0x400) /*!< 3 bits for pre-emption priority
                                                            0 bits for subpriority */

/**
  * @brief SysTick clock source
  */
#define SysTick_CLKSource_HCLK       ((uint32_t) 0x00000004)	/* !< systick clock source from core clock */

/**
  * @}
  */

/** @defgroup MISC_Exported_Functions
  * @{
  */

/**
  * @brief System reset
  */
extern void nvic_system_reset(void);

/**
  * @brief Enable nvic irq
  */
extern void nvic_irq_enable(IRQn_Type irqn, uint32_t preempt_priority, uint32_t sub_priority);

/**
  * @brief Disable nvic irq number
  */
extern void nvic_irq_disable(IRQn_Type irqn);

/**
  * @brief Sets interrupt priority groups
  */
extern void nvic_priority_group_config(uint32_t priority_group);

/**
  * @brief Initial interrupt priority
  */
extern void nvic_init(NVIC_InitTypeDef* nvic_initstruct);

/**
  * @brief Sets systick clock source
  */
extern void SysTick_CLKSourceConfig(uint32_t SysTick_CLKSource);

/**
  * @}
  */


#ifdef __cplusplus
}
#endif

#endif /* GOWIN_M1_MISC_H */

/**
  * @}
  */

/**
  * @}
  */
