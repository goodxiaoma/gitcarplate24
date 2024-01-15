/********************************** (C) COPYRIGHT *******************************
 * File Name          : Main.c
 * Author             : WCH
 * Version            : V1.0
 * Date               : 2020/08/06
 * Description        : 串口1收发演示
 *********************************************************************************
 * Copyright (c) 2021 Nanjing Qinheng Microelectronics Co., Ltd.
 * Attention: This software (modified or not) and binary are used for 
 * microcontroller manufactured by Nanjing Qinheng Microelectronics.
 *******************************************************************************/

#include "CH57x_common.h"

#include "openmv.h"

#include "iconv.h"

//全局变量
uint8_t rx1_buff[50];
uint8_t rx1_pointer = 0;

uint8_t plate[9]={0x00};
uint8_t platefirstmark[3]={0x00};//多给一个空间是为了存放终止位
uint8_t suma_check = 0;
uint8_t sumb_check = 0;
uint8_t plate_false[] = "This is check error\r\n";//将字符串存储为字符数组

/*********************************************************************
 * @fn      main
 *
 * @brief   主函数
 *
 * @return  none
 */
int main()
{

    SetSysClock(CLK_SOURCE_PLL_60MHz);

    /* 配置串口0：先配置IO口模式，再配置串口 */
    GPIOB_SetBits(GPIO_Pin_7);
    GPIOB_ModeCfg(GPIO_Pin_4, GPIO_ModeIN_PU);      // RXD0-配置上拉输入
    GPIOB_ModeCfg(GPIO_Pin_7, GPIO_ModeOut_PP_5mA); // TXD0-配置推挽输出，注意先让IO口输出高电
    UART0_DefInit();  //初始化默认配置，波特率115200

    /* 配置串口1：先配置IO口模式，再配置串口 */
    GPIOA_SetBits(GPIO_Pin_9);
    GPIOA_ModeCfg(GPIO_Pin_8, GPIO_ModeIN_PU);      // RXD-配置上拉输入
    GPIOA_ModeCfg(GPIO_Pin_9, GPIO_ModeOut_PP_5mA); // TXD-配置推挽输出，注意先让IO口输出高电平
    UART1_DefInit();

    UART0_ByteTrigCfg(UART_1BYTE_TRIG);                      //触发方式为 1BYTE_TRIG（1字节触发）
    UART0_INTCfg(ENABLE, RB_IER_RECV_RDY | RB_IER_LINE_STAT);//设置了接收就绪（RECV_RDY）和线路状态（LINE_STAT）中断，以便在接收到数据或线路状态发生变化时接收中断。
    PFIC_EnableIRQ(UART0_IRQn);

    UART1_ByteTrigCfg(UART_1BYTE_TRIG);
    UART1_INTCfg(ENABLE, RB_IER_RECV_RDY | RB_IER_LINE_STAT);
    PFIC_EnableIRQ(UART1_IRQn);

    while(1)
    {
//        if(plate)  //  检查plate是否为空字符串
//        {
//            UART1_SendString(plate, sizeof(plate));
//        }
    }


}



/*********************************************************************
 * @fn      UART0_IRQHandler
 *
 * @brief   UART0中断函数
 *
 * @return  none
 */
__attribute__((interrupt("WCH-Interrupt-fast")))
__attribute__((section(".highcode")))
void UART0_IRQHandler(void)
{
//    volatile uint8_t i;


    switch(UART0_GetITFlag())
    {
        case UART_II_LINE_STAT: // 线路状态错误
        {
            UART0_GetLinSTA();
            break;
        }


        // 数据达到设置触发点
        case UART_II_RECV_RDY:

            my_re_buf1[pt_w1] = UART0_RecvByte();
            if(my_re_buf1[0]==0xAA)                                     //如果第一帧接收到的是帧头，则继续下面的；不是帧头则将指针归位重新接收
            {
                OpmvDataGet(my_re_buf1[pt_w1]);
                pt_w1++;

                if(pt_w1>16)                                            //当16个数据全部传完时候（4+9+2（sum） +2（plate_firstMark））
                {
                    pt_w1=0;

                    for(uint8_t i = 0; i <= 12;i++)                     // 和校验     0到12,(4个+9个)
                    {
                        suma_check += my_re_buf1[i];
                        suma_check = suma_check % 256;
                        sumb_check += suma_check;
                        sumb_check = sumb_check % 256;
                    }
                    if(suma_check == suma && sumb_check == sumb )       //和校验通过启动UART1中断函数并向上位机发送车牌信息
                    {
                        memcpy(plate,openmvdata,9);
                        memcpy(platefirstmark,plate_firstMark,2);
                        UART1_SendString(plate, sizeof(plate));         //启动uart1的中断并发送plate中的所有信息
                    }
                    else if(suma_check != suma || sumb_check != sumb )  //如果和校验失败就向openmv发送错误代码“11”
                    {
                        UART0_SendString(plate_false, sizeof(plate_false));
                    }

                    /*通过uart0再将数据发送给openmv
                                                            再在openmv端进行一个校验，校验成功后会在openmv终端打印车牌信息*/
                    UART0_SendString(my_re_buf1, sizeof(my_re_buf1));

                    //统一复位;再进行下一次接收
                    memset(my_re_buf1,0,sizeof(my_re_buf1));
                    memset(openmvdata,0,sizeof(openmvdata));
                    memset(plate,0,sizeof(plate));
                    suma_check = 0;
                    sumb_check = 0;
                }

            }
            else//不是帧头
            {
                pt_w1=0;
                memset(my_re_buf1,0,sizeof(my_re_buf1));
                memset(openmvdata,0,sizeof(openmvdata));
                memset(plate,0,sizeof(plate));
                suma_check = 0;
                sumb_check = 0;

            }

            break;




        case UART_II_RECV_TOUT: // 接收超时，暂时一帧数据接收完成

            break;

        case UART_II_THR_EMPTY: // 发送缓存区空，可继续发送
            break;

        case UART_II_MODEM_CHG: // 只支持串口0
            break;

        default:
            break;
    }
}




/*********************************************************************
 * @fn      UART1_IRQHandler
 *
 * @brief   UART1中断函数
 *
 * @return  none
 */
__attribute__((interrupt("WCH-Interrupt-fast")))
__attribute__((section(".highcode")))
void UART1_IRQHandler(void)
{
//    volatile uint8_t i;

    switch(UART1_GetITFlag())
    {
        case UART_II_LINE_STAT: // 线路状态错误
        {
            UART1_GetLinSTA();
            break;
        }

        case UART_II_RECV_RDY: // 数据达到设置触发点
//            {

//                rx1_buff[i] = UART1_RecvByte();
//                UART1_SendByte(rx1_buff[i]);
//            }
            break;

        case UART_II_RECV_TOUT: // 接收超时，暂时一帧数据接收完成
//            UART1_SendString(rx1_buff,sizeof(rx1_buff));
            break;

        case UART_II_THR_EMPTY: // 发送缓存区空，可继续发送
            break;

        case UART_II_MODEM_CHG: // 只支持串口0
            break;

        default:
            break;
    }
}
