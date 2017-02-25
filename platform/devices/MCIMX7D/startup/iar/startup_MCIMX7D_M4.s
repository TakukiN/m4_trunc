; ---------------------------------------------------------------------------------------
;  @file:    startup_MCIMX7D_M4.s
;  @purpose: CMSIS Cortex-M4 Core Device Startup File
;            MCIMX7D_M4
;  @version: 1.0
;  @date:    2015-04-06
;  @build:   b150406
; ---------------------------------------------------------------------------------------
;
; Copyright (c) 2015 , Freescale Semiconductor, Inc.
; All rights reserved.
;
; Redistribution and use in source and binary forms, with or without modification,
; are permitted provided that the following conditions are met:
;
; o Redistributions of source code must retain the above copyright notice, this list
;   of conditions and the following disclaimer.
;
; o Redistributions in binary form must reproduce the above copyright notice, this
;   list of conditions and the following disclaimer in the documentation and/or
;   other materials provided with the distribution.
;
; o Neither the name of Freescale Semiconductor, Inc. nor the names of its
;   contributors may be used to endorse or promote products derived from this
;   software without specific prior written permission.
;
; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
; ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
; WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
; DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
; ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
; (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
; ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;
; The modules in this file are included in the libraries, and may be replaced
; by any user-defined modules that define the PUBLIC symbol _program_start or
; a user defined start symbol.
; To override the cstartup defined in the library, simply add your modified
; version to the workbench project.
;
; The vector table is normally located at address 0.
; When debugging in RAM, it can be located in RAM, aligned to at least 2^6.
; The name "__vector_table" has special meaning for C-SPY:
; it is where the SP start value is found, and the NVIC vector
; table register (VTOR) is initialized to this address if != 0.
;
; Cortex-M version
;

        MODULE  ?cstartup

        ; Forward declaration of sections.
        SECTION CSTACK:DATA:NOROOT(3)

        SECTION .intvec:CODE:NOROOT(2)

        EXTERN  __iar_program_start
        EXTERN  SystemInit
        PUBLIC  __vector_table

        DATA
__vector_table
        DCD     sfe(CSTACK)                                   ;Top of Stack
        DCD     Reset_Handler                                 ;Reset Handler
        DCD     NMI_Handler                                   ;NMI Handler
        DCD     HardFault_Handler                             ;Hard Fault Handler
        DCD     MemManage_Handler                             ;MPU Fault Handler
        DCD     BusFault_Handler                              ;Bus Fault Handler
        DCD     UsageFault_Handler                            ;Usage Fault Handler
        DCD     0                                             ;Reserved
        DCD     0                                             ;Reserved
        DCD     0                                             ;Reserved
        DCD     0                                             ;Reserved
        DCD     SVC_Handler                                   ;SVCall Handler
        DCD     DebugMon_Handler                              ;Debug Monitor Handler
        DCD     0                                             ;Reserved
        DCD     PendSV_Handler                                ;PendSV Handler
        DCD     SysTick_Handler                               ;SysTick Handler

                                                              ;External Interrupts
        DCD     GPR_Handler                                   ;GPR Interrupt
        DCD     DAP_Handler                                   ;DAP Interrupt
        DCD     SDMA_Handler                                  ;SDMA Interrupt
        DCD     DBGMON_Handler                                ;DBGMON Interrupt
        DCD     SNVS_Handler                                  ;SNVS Interrupt
        DCD     LCDIF_Handler                                 ;LCDIF Interrupt
        DCD     SIM2_Handler                                  ;SIM2 Interrupt
        DCD     CSI_Handler                                   ;CSI Interrupt
        DCD     PXP1_Handler                                  ;PXP1 Interrupt
        DCD     Reserved9_Handler                             ;Reserved interrupt 9
        DCD     WDOG3_Handler                                 ;WDOG3 Interrupt
        DCD     SEMA4_HS_M4_Handler                           ;SEMA4_HS_M4 Interrupt
        DCD     APBHDMA_Handler                               ;APBHDMA Interrupt
        DCD     EIM_Handler                                   ;EIM Interrupt
        DCD     BCH_Handler                                   ;BCH Interrupt
        DCD     GPMI_Handler                                  ;GPMI Interrupt
        DCD     UART6_Handler                                 ;UART6 Interrupt
        DCD     FTM1_Handler                                  ;FTM1 Interrupt
        DCD     FTM2_Handler                                  ;FTM2 Interrupt
        DCD     SNVS_CONSOLIDATED_Handler                     ;SNVS_CONSOLIDATED Interrupt
        DCD     SNVS_SECURITY_Handler                         ;SNVS_SECURITY Interrupt
        DCD     CSU_Handler                                   ;CSU Interrupt
        DCD     uSDHC1_Handler                                ;uSDHC1 Interrupt
        DCD     uSDHC2_Handler                                ;uSDHC2 Interrupt
        DCD     uSDHC3_Handler                                ;uSDHC3 Interrupt
        DCD     MIPI_CSI_Handler                              ;MIPI_CSI Interrupt
        DCD     UART1_Handler                                 ;UART1 Interrupt
        DCD     UART2_Handler                                 ;UART2 Interrupt
        DCD     UART3_Handler                                 ;UART3 Interrupt
        DCD     UART4_Handler                                 ;UART4 Interrupt
        DCD     UART5_Handler                                 ;UART5 Interrupt
        DCD     eCSPI1_Handler                                ;eCSPI1 Interrupt
        DCD     eCSPI2_Handler                                ;eCSPI2 Interrupt
        DCD     eCSPI3_Handler                                ;eCSPI3 Interrupt
        DCD     eCSPI4_Handler                                ;eCSPI4 Interrupt
        DCD     I2C1_Handler                                  ;I2C1 Interrupt
        DCD     I2C2_Handler                                  ;I2C2 Interrupt
        DCD     I2C3_Handler                                  ;I2C3 Interrupt
        DCD     I2C4_Handler                                  ;I2C4 Interrupt
        DCD     RDC_Handler                                   ;RDC Interrupt
        DCD     USB_OH3_OTG2_1_Handler                        ;USB_OH3_OTG2_1 Interrupt
        DCD     MIPI_DSI_Handler                              ;MIPI_DSI Interrupt
        DCD     USB_OH3_OTG2_2_Handler                        ;USB_OH3_OTG2_2 Interrupt
        DCD     USB_OH2_OTG_Handler                           ;USB_OH2_OTG Interrupt
        DCD     USB_OTG1_Handler                              ;USB_OTG1 Interrupt
        DCD     USB_OTG2_Handler                              ;USB_OTG2 Interrupt
        DCD     PXP2_Handler                                  ;PXP2 Interrupt
        DCD     SCTR1_Handler                                 ;SCTR1 Interrupt
        DCD     SCTR2_Handler                                 ;SCTR2 Interrupt
        DCD     Analog_TempSensor_Handler                     ;Analog_TempSensor Interrupt
        DCD     SAI3_Handler                                  ;SAI3 Interrupt
        DCD     Analog_brown_out_Handler                      ;Analog_brown_out Interrupt
        DCD     GPT4_Handler                                  ;GPT4 Interrupt
        DCD     GPT3_Handler                                  ;GPT3 Interrupt
        DCD     GPT2_Handler                                  ;GPT2 Interrupt
        DCD     GPT1_Handler                                  ;GPT1 Interrupt
        DCD     GPIO1_INT7_Handler                            ;GPIO1_INT7 Interrupt
        DCD     GPIO1_INT6_Handler                            ;GPIO1_INT6 Interrupt
        DCD     GPIO1_INT5_Handler                            ;GPIO1_INT5 Interrupt
        DCD     GPIO1_INT4_Handler                            ;GPIO1_INT4 Interrupt
        DCD     GPIO1_INT3_Handler                            ;GPIO1_INT3 Interrupt
        DCD     GPIO1_INT2_Handler                            ;GPIO1_INT2 Interrupt
        DCD     GPIO1_INT1_Handler                            ;GPIO1_INT1 Interrupt
        DCD     GPIO1_INT0_Handler                            ;GPIO1_INT0 Interrupt
        DCD     GPIO1_INT15_0_Handler                         ;GPIO1_INT15_0 Interrupt
        DCD     GPIO1_INT31_16_Handler                        ;GPIO1_INT31_16 Interrupt
        DCD     GPIO2_INT15_0_Handler                         ;GPIO2_INT15_0 Interrupt
        DCD     GPIO2_INT31_16_Handler                        ;GPIO2_INT31_16 Interrupt
        DCD     GPIO3_INT15_0_Handler                         ;GPIO3_INT15_0 Interrupt
        DCD     GPIO3_INT31_16_Handler                        ;GPIO3_INT31_16 Interrupt
        DCD     GPIO4_INT15_0_Handler                         ;GPIO4_INT15_0 Interrupt
        DCD     GPIO4_INT31_16_Handler                        ;GPIO4_INT31_16 Interrupt
        DCD     GPIO5_INT15_0_Handler                         ;GPIO5_INT15_0 Interrupt
        DCD     GPIO5_INT31_16_Handler                        ;GPIO5_INT31_16 Interrupt
        DCD     GPIO6_INT15_0_Handler                         ;GPIO6_INT15_0 Interrupt
        DCD     GPIO6_INT31_16_Handler                        ;GPIO6_INT31_16 Interrupt
        DCD     GPIO7_INT15_0_Handler                         ;GPIO7_INT15_0 Interrupt
        DCD     GPIO7_INT31_16_Handler                        ;GPIO7_INT31_16 Interrupt
        DCD     WDOG1_Handler                                 ;WDOG1 Interrupt
        DCD     WDOG2_Handler                                 ;WDOG2 Interrupt
        DCD     KPP_Handler                                   ;KPP Interrupt
        DCD     PWM1_Handler                                  ;PWM1 Interrupt
        DCD     PWM2_Handler                                  ;PWM2 Interrupt
        DCD     PWM3_Handler                                  ;PWM3 Interrupt
        DCD     PWM4_Handler                                  ;PWM4 Interrupt
        DCD     CCM1_Handler                                  ;CCM1 Interrupt
        DCD     CCM2_Handler                                  ;CCM2 Interrupt
        DCD     GPC_Handler                                   ;GPC Interrupt
        DCD     MU_A7_Handler                                 ;MU_A7 Interrupt
        DCD     SRC_Handler                                   ;SRC Interrupt
        DCD     SIM1_Handler                                  ;SIM1 Interrupt
        DCD     RTIC_Handler                                  ;RTIC Interrupt
        DCD     CPU_Handler                                   ;CPU Interrupt
        DCD     CPU_CTI_Handler                               ;CPU_CTI Interrupt
        DCD     CCM_SRC_GPC_Handler                           ;CCM_SRC_GPC Interrupt
        DCD     SAI1_Handler                                  ;SAI1 Interrupt
        DCD     SAI2_Handler                                  ;SAI2 Interrupt
        DCD     MU_M4_Handler                                 ;MU_M4 Interrupt
        DCD     ADC1_Handler                                  ;ADC1 Interrupt
        DCD     ADC2_Handler                                  ;ADC2 Interrupt
        DCD     ENET2_MAC0_TRANS1_Handler                     ;ENET2_MAC0_TRANS1 Interrupt
        DCD     ENET2_MAC0_TRANS2_Handler                     ;ENET2_MAC0_TRANS2 Interrupt
        DCD     ENET2_MAC0_IRQ_Handler                        ;ENET2_MAC0_IRQ Interrupt
        DCD     ENET2_1588_TIMER_IRQ_Handler                  ;ENET2_1588_TIMER_IRQ Interrupt
        DCD     TPR_Handler                                   ;TPR Interrupt
        DCD     CAAM_QUEUE_Handler                            ;CAAM_QUEUE Interrupt
        DCD     CAAM_ERROR_Handler                            ;CAAM_ERROR Interrupt
        DCD     QSPI_Handler                                  ;QSPI Interrupt
        DCD     TZASC1_Handler                                ;TZASC1 Interrupt
        DCD     WDOG4_Handler                                 ;WDOG4 Interrupt
        DCD     FLEXCAN1_Handler                              ;FLEXCAN1 Interrupt
        DCD     FLEXCAN2_Handler                              ;FLEXCAN2 Interrupt
        DCD     PERFMON1_Handler                              ;PERFMON1 Interrupt
        DCD     PERFMON2_Handler                              ;PERFMON2 Interrupt
        DCD     CAAM_WRAPPER1_Handler                         ;CAAM_WRAPPER1 Interrupt
        DCD     CAAM_WRAPPER2_Handler                         ;CAAM_WRAPPER2 Interrupt
        DCD     SEMA4_HS_A7_Handler                           ;SEMA4_HS_A7 Interrupt
        DCD     EPDC_Handler                                  ;EPDC Interrupt
        DCD     ENET1_MAC0_TRANS1_Handler                     ;ENET1_MAC0_TRANS1 Interrupt
        DCD     ENET1_MAC0_TRANS2_Handler                     ;ENET1_MAC0_TRANS2 Interrupt
        DCD     ENET1_MAC0_Handler                            ;ENET1_MAC0 Interrupt
        DCD     ENET1_1588_TIMER_Handler                      ;ENET1_1588_TIMER Interrupt
        DCD     PCIE_CTRL1_Handler                            ;PCIE_CTRL1 Interrupt
        DCD     PCIE_CTRL2_Handler                            ;PCIE_CTRL2 Interrupt
        DCD     PCIE_CTRL3_Handler                            ;PCIE_CTRL3 Interrupt
        DCD     PCIE_CTRL4_Handler                            ;PCIE_CTRL4 Interrupt
        DCD     UART7_Handler                                 ;UART7 Interrupt
        DCD     PCIE_CTRL_REQUEST_Handler                     ;PCIE_CTRL_REQUEST Interrupt

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Default interrupt handlers.
;;
        THUMB

        PUBWEAK Reset_Handler
        SECTION .text:CODE:REORDER:NOROOT(2)
Reset_Handler
        CPSID   I               ; Mask interrupts
        LDR     R0, =SystemInit
        BLX     R0
        CPSIE   I               ; Unmask interrupts
        LDR     R0, =__iar_program_start
        BX      R0

        PUBWEAK NMI_Handler
        SECTION .text:CODE:REORDER:NOROOT(1)
NMI_Handler
        B .

        PUBWEAK HardFault_Handler
        SECTION .text:CODE:REORDER:NOROOT(1)
HardFault_Handler
        B .

        PUBWEAK MemManage_Handler
        SECTION .text:CODE:REORDER:NOROOT(1)
MemManage_Handler
        B .

        PUBWEAK BusFault_Handler
        SECTION .text:CODE:REORDER:NOROOT(1)
BusFault_Handler
        B .

        PUBWEAK UsageFault_Handler
        SECTION .text:CODE:REORDER:NOROOT(1)
UsageFault_Handler
        B .

        PUBWEAK SVC_Handler
        SECTION .text:CODE:REORDER:NOROOT(1)
SVC_Handler
        B .

        PUBWEAK DebugMon_Handler
        SECTION .text:CODE:REORDER:NOROOT(1)
DebugMon_Handler
        B .

        PUBWEAK PendSV_Handler
        SECTION .text:CODE:REORDER:NOROOT(1)
PendSV_Handler
        B .

        PUBWEAK SysTick_Handler
        SECTION .text:CODE:REORDER:NOROOT(1)
SysTick_Handler
        B .

        PUBWEAK GPR_Handler
        PUBWEAK DAP_Handler
        PUBWEAK SDMA_Handler
        PUBWEAK DBGMON_Handler
        PUBWEAK SNVS_Handler
        PUBWEAK LCDIF_Handler
        PUBWEAK SIM2_Handler
        PUBWEAK CSI_Handler
        PUBWEAK PXP1_Handler
        PUBWEAK Reserved9_Handler
        PUBWEAK WDOG3_Handler
        PUBWEAK SEMA4_HS_M4_Handler
        PUBWEAK APBHDMA_Handler
        PUBWEAK EIM_Handler
        PUBWEAK BCH_Handler
        PUBWEAK GPMI_Handler
        PUBWEAK UART6_Handler
        PUBWEAK FTM1_Handler
        PUBWEAK FTM2_Handler
        PUBWEAK SNVS_CONSOLIDATED_Handler
        PUBWEAK SNVS_SECURITY_Handler
        PUBWEAK CSU_Handler
        PUBWEAK uSDHC1_Handler
        PUBWEAK uSDHC2_Handler
        PUBWEAK uSDHC3_Handler
        PUBWEAK MIPI_CSI_Handler
        PUBWEAK UART1_Handler
        PUBWEAK UART2_Handler
        PUBWEAK UART3_Handler
        PUBWEAK UART4_Handler
        PUBWEAK UART5_Handler
        PUBWEAK eCSPI1_Handler
        PUBWEAK eCSPI2_Handler
        PUBWEAK eCSPI3_Handler
        PUBWEAK eCSPI4_Handler
        PUBWEAK I2C1_Handler
        PUBWEAK I2C2_Handler
        PUBWEAK I2C3_Handler
        PUBWEAK I2C4_Handler
        PUBWEAK RDC_Handler
        PUBWEAK USB_OH3_OTG2_1_Handler
        PUBWEAK MIPI_DSI_Handler
        PUBWEAK USB_OH3_OTG2_2_Handler
        PUBWEAK USB_OH2_OTG_Handler
        PUBWEAK USB_OTG1_Handler
        PUBWEAK USB_OTG2_Handler
        PUBWEAK PXP2_Handler
        PUBWEAK SCTR1_Handler
        PUBWEAK SCTR2_Handler
        PUBWEAK Analog_TempSensor_Handler
        PUBWEAK SAI3_Handler
        PUBWEAK Analog_brown_out_Handler
        PUBWEAK GPT4_Handler
        PUBWEAK GPT3_Handler
        PUBWEAK GPT2_Handler
        PUBWEAK GPT1_Handler
        PUBWEAK GPIO1_INT7_Handler
        PUBWEAK GPIO1_INT6_Handler
        PUBWEAK GPIO1_INT5_Handler
        PUBWEAK GPIO1_INT4_Handler
        PUBWEAK GPIO1_INT3_Handler
        PUBWEAK GPIO1_INT2_Handler
        PUBWEAK GPIO1_INT1_Handler
        PUBWEAK GPIO1_INT0_Handler
        PUBWEAK GPIO1_INT15_0_Handler
        PUBWEAK GPIO1_INT31_16_Handler
        PUBWEAK GPIO2_INT15_0_Handler
        PUBWEAK GPIO2_INT31_16_Handler
        PUBWEAK GPIO3_INT15_0_Handler
        PUBWEAK GPIO3_INT31_16_Handler
        PUBWEAK GPIO4_INT15_0_Handler
        PUBWEAK GPIO4_INT31_16_Handler
        PUBWEAK GPIO5_INT15_0_Handler
        PUBWEAK GPIO5_INT31_16_Handler
        PUBWEAK GPIO6_INT15_0_Handler
        PUBWEAK GPIO6_INT31_16_Handler
        PUBWEAK GPIO7_INT15_0_Handler
        PUBWEAK GPIO7_INT31_16_Handler
        PUBWEAK WDOG1_Handler
        PUBWEAK WDOG2_Handler
        PUBWEAK KPP_Handler
        PUBWEAK PWM1_Handler
        PUBWEAK PWM2_Handler
        PUBWEAK PWM3_Handler
        PUBWEAK PWM4_Handler
        PUBWEAK CCM1_Handler
        PUBWEAK CCM2_Handler
        PUBWEAK GPC_Handler
        PUBWEAK MU_A7_Handler
        PUBWEAK SRC_Handler
        PUBWEAK SIM1_Handler
        PUBWEAK RTIC_Handler
        PUBWEAK CPU_Handler
        PUBWEAK CPU_CTI_Handler
        PUBWEAK CCM_SRC_GPC_Handler
        PUBWEAK SAI1_Handler
        PUBWEAK SAI2_Handler
        PUBWEAK MU_M4_Handler
        PUBWEAK ADC1_Handler
        PUBWEAK ADC2_Handler
        PUBWEAK ENET2_MAC0_TRANS1_Handler
        PUBWEAK ENET2_MAC0_TRANS2_Handler
        PUBWEAK ENET2_MAC0_IRQ_Handler
        PUBWEAK ENET2_1588_TIMER_IRQ_Handler
        PUBWEAK TPR_Handler
        PUBWEAK CAAM_QUEUE_Handler
        PUBWEAK CAAM_ERROR_Handler
        PUBWEAK QSPI_Handler
        PUBWEAK TZASC1_Handler
        PUBWEAK WDOG4_Handler
        PUBWEAK FLEXCAN1_Handler
        PUBWEAK FLEXCAN2_Handler
        PUBWEAK PERFMON1_Handler
        PUBWEAK PERFMON2_Handler
        PUBWEAK CAAM_WRAPPER1_Handler
        PUBWEAK CAAM_WRAPPER2_Handler
        PUBWEAK SEMA4_HS_A7_Handler
        PUBWEAK EPDC_Handler
        PUBWEAK ENET1_MAC0_TRANS1_Handler
        PUBWEAK ENET1_MAC0_TRANS2_Handler
        PUBWEAK ENET1_MAC0_Handler
        PUBWEAK ENET1_1588_TIMER_Handler
        PUBWEAK PCIE_CTRL1_Handler
        PUBWEAK PCIE_CTRL2_Handler
        PUBWEAK PCIE_CTRL3_Handler
        PUBWEAK PCIE_CTRL4_Handler
        PUBWEAK UART7_Handler
        PUBWEAK PCIE_CTRL_REQUEST_Handler
        PUBWEAK DefaultISR
        SECTION .text:CODE:REORDER:NOROOT(1)
GPR_Handler
DAP_Handler
SDMA_Handler
DBGMON_Handler
SNVS_Handler
LCDIF_Handler
SIM2_Handler
CSI_Handler
PXP1_Handler
Reserved9_Handler
WDOG3_Handler
SEMA4_HS_M4_Handler
APBHDMA_Handler
EIM_Handler
BCH_Handler
GPMI_Handler
UART6_Handler
FTM1_Handler
FTM2_Handler
SNVS_CONSOLIDATED_Handler
SNVS_SECURITY_Handler
CSU_Handler
uSDHC1_Handler
uSDHC2_Handler
uSDHC3_Handler
MIPI_CSI_Handler
UART1_Handler
UART2_Handler
UART3_Handler
UART4_Handler
UART5_Handler
eCSPI1_Handler
eCSPI2_Handler
eCSPI3_Handler
eCSPI4_Handler
I2C1_Handler
I2C2_Handler
I2C3_Handler
I2C4_Handler
RDC_Handler
USB_OH3_OTG2_1_Handler
MIPI_DSI_Handler
USB_OH3_OTG2_2_Handler
USB_OH2_OTG_Handler
USB_OTG1_Handler
USB_OTG2_Handler
PXP2_Handler
SCTR1_Handler
SCTR2_Handler
Analog_TempSensor_Handler
SAI3_Handler
Analog_brown_out_Handler
GPT4_Handler
GPT3_Handler
GPT2_Handler
GPT1_Handler
GPIO1_INT7_Handler
GPIO1_INT6_Handler
GPIO1_INT5_Handler
GPIO1_INT4_Handler
GPIO1_INT3_Handler
GPIO1_INT2_Handler
GPIO1_INT1_Handler
GPIO1_INT0_Handler
GPIO1_INT15_0_Handler
GPIO1_INT31_16_Handler
GPIO2_INT15_0_Handler
GPIO2_INT31_16_Handler
GPIO3_INT15_0_Handler
GPIO3_INT31_16_Handler
GPIO4_INT15_0_Handler
GPIO4_INT31_16_Handler
GPIO5_INT15_0_Handler
GPIO5_INT31_16_Handler
GPIO6_INT15_0_Handler
GPIO6_INT31_16_Handler
GPIO7_INT15_0_Handler
GPIO7_INT31_16_Handler
WDOG1_Handler
WDOG2_Handler
KPP_Handler
PWM1_Handler
PWM2_Handler
PWM3_Handler
PWM4_Handler
CCM1_Handler
CCM2_Handler
GPC_Handler
MU_A7_Handler
SRC_Handler
SIM1_Handler
RTIC_Handler
CPU_Handler
CPU_CTI_Handler
CCM_SRC_GPC_Handler
SAI1_Handler
SAI2_Handler
MU_M4_Handler
ADC1_Handler
ADC2_Handler
ENET2_MAC0_TRANS1_Handler
ENET2_MAC0_TRANS2_Handler
ENET2_MAC0_IRQ_Handler
ENET2_1588_TIMER_IRQ_Handler
TPR_Handler
CAAM_QUEUE_Handler
CAAM_ERROR_Handler
QSPI_Handler
TZASC1_Handler
WDOG4_Handler
FLEXCAN1_Handler
FLEXCAN2_Handler
PERFMON1_Handler
PERFMON2_Handler
CAAM_WRAPPER1_Handler
CAAM_WRAPPER2_Handler
SEMA4_HS_A7_Handler
EPDC_Handler
ENET1_MAC0_TRANS1_Handler
ENET1_MAC0_TRANS2_Handler
ENET1_MAC0_Handler
ENET1_1588_TIMER_Handler
PCIE_CTRL1_Handler
PCIE_CTRL2_Handler
PCIE_CTRL3_Handler
PCIE_CTRL4_Handler
UART7_Handler
PCIE_CTRL_REQUEST_Handler
DefaultISR
        B DefaultISR

        END
