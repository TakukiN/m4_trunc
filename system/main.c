/*
 * Copyright (c) 2015, Freescale Semiconductor, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * o Redistributions of source code must retain the above copyright notice, this list
 *   of conditions and the following disclaimer.
 *
 * o Redistributions in binary form must reproduce the above copyright notice, this
 *   list of conditions and the following disclaimer in the documentation and/or
 *   other materials provided with the distribution.
 *
 * o Neither the name of Freescale Semiconductor, Inc. nor the names of its
 *   contributors may be used to endorse or promote products derived from this
 *   software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

///////////////////////////////////////////////////////////////////////////////
//  Includes
///////////////////////////////////////////////////////////////////////////////
#include "rpmsg/rpmsg_rtos.h"
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#include "board.h"
#include "mu_imx.h"
#include "debug_console_imx.h"
#include "gpt.h"

////////////////////////////////////////////////////////////////////////////////
// Definitions
////////////////////////////////////////////////////////////////////////////////
#define APP_TASK_STACK_SIZE 256

/*
 * APP decided interrupt priority
 */
#define APP_MU_IRQ_PRIORITY 3

typedef struct the_message
{
   uint32_t  DATA;
} THE_MESSAGE, * THE_MESSAGE_PTR;

////////////////////////////////////////////////////////////////////////////////
// Code
////////////////////////////////////////////////////////////////////////////////

void SystemStateTask(void *pvParameters)
{
    /* Initial variables */
    int result;
    struct remote_device *rdev = NULL;
    struct rpmsg_channel *app_chnl = NULL;
    THE_MESSAGE msg = {0};
    int len;

    /* Print the initial banner */
    PRINTF("System State Task Start\r\n");

    result = rpmsg_rtos_init(0 /*REMOTE_CPU_ID*/, &rdev, RPMSG_MASTER, &app_chnl);
    assert(0 == result);

    PRINTF("Name service handshake is done, M4 has setup a rpmsg channel [%d ---> %d]\r\n", app_chnl->src, app_chnl->dst);

    
    while (true)
    {
        /* receive/send data to channel default ept */
        result = rpmsg_rtos_recv(app_chnl->rp_ept, &msg, &len, sizeof(THE_MESSAGE), NULL, 0xFFFFFFFF);
        assert(0 == result);
        
        //for debug
        PRINTF("Get Data From Master Side : %d\r\n", msg.DATA);
        msg.DATA++;

        //ack send
        result = rpmsg_rtos_send(app_chnl->rp_ept, &msg, sizeof(THE_MESSAGE), app_chnl->dst);
        assert(0 == result);
    }
}

/*
 * MU Interrrupt ISR
 */
void BOARD_MU_HANDLER(void)
{
    /*
     * calls into rpmsg_handler provided by middleware
     */
    rpmsg_handler();
}

/*!
 * @brief A basic user-defined task
 */
void HelloTask(void *pvParameters)
{
    uint8_t receiveBuff;

    // Print the initial banner
    PRINTF("\r\nHello World!\n\n\r");

    while(1)
    {
        // Main routine that simply echoes received characters forever

        // First, get character
        receiveBuff = GETCHAR();

        // Now echo the received character
        PUTCHAR(receiveBuff);
    }
}

void initInputCaptureGPT(void) 
{
    uint32_t freqA, freqB;
    gpt_init_config_t config = {
        .freeRun     = false,
        .waitEnable  = true,
        .stopEnable  = true,
        .dozeEnable  = true,
        .dbgEnable   = false,
        .enableMode  = true
    };

    /* Initialize GPT module */
    GPT_Init(BOARD_GPTB_BASEADDR, &config);

    /* Set GPT clock source, when use OSC as clock source, we need to make sure the OSC freq
     * after divided by OscPrescaler should be less than half of the peripheral clock set by
     * CCM */
    GPT_SetClockSource(BOARD_GPTB_BASEADDR, gptClockSourcePeriph);

    /* Divide GPTB clock source frequency by 2 inside GPT module */
    GPT_SetPrescaler(BOARD_GPTB_BASEADDR, 1);

    /* Get GPT clock frequency */
    freqB = get_gpt_clock_freq(BOARD_GPTB_BASEADDR); /* Get B peripheral clock freq */
    freqB /= 2;

    //Input Capture
    GPT_SetInputOperationMode(BOARD_GPTB_BASEADDR, gptInputCaptureChannel1, gptInputOperationBothEdge);
    GPT_SetInputOperationMode(BOARD_GPTB_BASEADDR, gptInputCaptureChannel2, gptInputOperationBothEdge);
    
    /* Set GPT interrupt priority to same value to avoid handler preemption */
    NVIC_SetPriority(BOARD_GPTB_IRQ_NUM, 3);

    /* Enable NVIC interrupt */
    NVIC_EnableIRQ(BOARD_GPTB_IRQ_NUM);

    /* Enable GPT Input Capture interrupt */
    GPT_SetIntCmd(BOARD_GPTB_BASEADDR, gptStatusFlagInputCapture1, true);
    GPT_SetIntCmd(BOARD_GPTB_BASEADDR, gptStatusFlagInputCapture2, true);

    PRINTF("GPT timer will now start\n\r");
    PRINTF("counter/freq ratio should be close to 0.0 or 1.0 ...\n\r");

    /* GPT start */
    GPT_Enable(BOARD_GPTB_BASEADDR);
}
    
void BOARD_GPTB_HANDLER()
{
    GPT_ClearStatusFlag(BOARD_GPTB_BASEADDR, gptStatusFlagInputCapture1);

    /* TBD Insert Your Processing */
}
    
/*!
 * @brief Main function
 */
int main(void)
{
    /* Initialize demo application pins setting and clock setting. */
    hardware_init();
    
    /* Init Input Capture GPT */
    initInputCaptureGPT();
    
    /*
     * Prepare for the MU Interrupt
     *  MU must be initialized before rpmsg init is called
     */
    MU_Init(BOARD_MU_BASE_ADDR);
    NVIC_SetPriority(BOARD_MU_IRQ_NUM, APP_MU_IRQ_PRIORITY);
    NVIC_EnableIRQ(BOARD_MU_IRQ_NUM);
    
    // Create a demo task which will print Hello world and echo user's input.
    xTaskCreate(HelloTask, "Print Task", configMINIMAL_STACK_SIZE, NULL, tskIDLE_PRIORITY+1, NULL);

    /* Create a system state task. */
    xTaskCreate(SystemStateTask, "System State Task", APP_TASK_STACK_SIZE, NULL, tskIDLE_PRIORITY + 2, NULL);
    
    // Start FreeRTOS scheduler.
    vTaskStartScheduler();

    // Should never reach this point.
    while (true);
}

/*******************************************************************************
 * EOF
 ******************************************************************************/
