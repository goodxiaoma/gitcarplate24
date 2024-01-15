/********************************** (C) COPYRIGHT *******************************
 * File Name          : Main.c
 * Author             : WCH
 * Version            : V1.0
 * Date               : 2020/08/06
 * Description        : ����1�շ���ʾ
 *********************************************************************************
 * Copyright (c) 2021 Nanjing Qinheng Microelectronics Co., Ltd.
 * Attention: This software (modified or not) and binary are used for 
 * microcontroller manufactured by Nanjing Qinheng Microelectronics.
 *******************************************************************************/

#include "CH57x_common.h"

#include "openmv.h"

#include "iconv.h"

//ȫ�ֱ���
uint8_t rx1_buff[50];
uint8_t rx1_pointer = 0;

uint8_t plate[9]={0x00};
uint8_t platefirstmark[3]={0x00};//���һ���ռ���Ϊ�˴����ֹλ
uint8_t suma_check = 0;
uint8_t sumb_check = 0;
uint8_t plate_false[] = "This is check error\r\n";//���ַ����洢Ϊ�ַ�����

/*********************************************************************
 * @fn      main
 *
 * @brief   ������
 *
 * @return  none
 */
int main()
{

    SetSysClock(CLK_SOURCE_PLL_60MHz);

    /* ���ô���0��������IO��ģʽ�������ô��� */
    GPIOB_SetBits(GPIO_Pin_7);
    GPIOB_ModeCfg(GPIO_Pin_4, GPIO_ModeIN_PU);      // RXD0-������������
    GPIOB_ModeCfg(GPIO_Pin_7, GPIO_ModeOut_PP_5mA); // TXD0-�������������ע������IO������ߵ�
    UART0_DefInit();  //��ʼ��Ĭ�����ã�������115200

    /* ���ô���1��������IO��ģʽ�������ô��� */
    GPIOA_SetBits(GPIO_Pin_9);
    GPIOA_ModeCfg(GPIO_Pin_8, GPIO_ModeIN_PU);      // RXD-������������
    GPIOA_ModeCfg(GPIO_Pin_9, GPIO_ModeOut_PP_5mA); // TXD-�������������ע������IO������ߵ�ƽ
    UART1_DefInit();

    UART0_ByteTrigCfg(UART_1BYTE_TRIG);                      //������ʽΪ 1BYTE_TRIG��1�ֽڴ�����
    UART0_INTCfg(ENABLE, RB_IER_RECV_RDY | RB_IER_LINE_STAT);//�����˽��վ�����RECV_RDY������·״̬��LINE_STAT���жϣ��Ա��ڽ��յ����ݻ���·״̬�����仯ʱ�����жϡ�
    PFIC_EnableIRQ(UART0_IRQn);

    UART1_ByteTrigCfg(UART_1BYTE_TRIG);
    UART1_INTCfg(ENABLE, RB_IER_RECV_RDY | RB_IER_LINE_STAT);
    PFIC_EnableIRQ(UART1_IRQn);

    while(1)
    {
//        if(plate)  //  ���plate�Ƿ�Ϊ���ַ���
//        {
//            UART1_SendString(plate, sizeof(plate));
//        }
    }


}



/*********************************************************************
 * @fn      UART0_IRQHandler
 *
 * @brief   UART0�жϺ���
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
        case UART_II_LINE_STAT: // ��·״̬����
        {
            UART0_GetLinSTA();
            break;
        }


        // ���ݴﵽ���ô�����
        case UART_II_RECV_RDY:

            my_re_buf1[pt_w1] = UART0_RecvByte();
            if(my_re_buf1[0]==0xAA)                                     //�����һ֡���յ�����֡ͷ�����������ģ�����֡ͷ��ָ���λ���½���
            {
                OpmvDataGet(my_re_buf1[pt_w1]);
                pt_w1++;

                if(pt_w1>16)                                            //��16������ȫ������ʱ��4+9+2��sum�� +2��plate_firstMark����
                {
                    pt_w1=0;

                    for(uint8_t i = 0; i <= 12;i++)                     // ��У��     0��12,(4��+9��)
                    {
                        suma_check += my_re_buf1[i];
                        suma_check = suma_check % 256;
                        sumb_check += suma_check;
                        sumb_check = sumb_check % 256;
                    }
                    if(suma_check == suma && sumb_check == sumb )       //��У��ͨ������UART1�жϺ���������λ�����ͳ�����Ϣ
                    {
                        memcpy(plate,openmvdata,9);
                        memcpy(platefirstmark,plate_firstMark,2);
                        UART1_SendString(plate, sizeof(plate));         //����uart1���жϲ�����plate�е�������Ϣ
                    }
                    else if(suma_check != suma || sumb_check != sumb )  //�����У��ʧ�ܾ���openmv���ʹ�����롰11��
                    {
                        UART0_SendString(plate_false, sizeof(plate_false));
                    }

                    /*ͨ��uart0�ٽ����ݷ��͸�openmv
                                                            ����openmv�˽���һ��У�飬У��ɹ������openmv�ն˴�ӡ������Ϣ*/
                    UART0_SendString(my_re_buf1, sizeof(my_re_buf1));

                    //ͳһ��λ;�ٽ�����һ�ν���
                    memset(my_re_buf1,0,sizeof(my_re_buf1));
                    memset(openmvdata,0,sizeof(openmvdata));
                    memset(plate,0,sizeof(plate));
                    suma_check = 0;
                    sumb_check = 0;
                }

            }
            else//����֡ͷ
            {
                pt_w1=0;
                memset(my_re_buf1,0,sizeof(my_re_buf1));
                memset(openmvdata,0,sizeof(openmvdata));
                memset(plate,0,sizeof(plate));
                suma_check = 0;
                sumb_check = 0;

            }

            break;




        case UART_II_RECV_TOUT: // ���ճ�ʱ����ʱһ֡���ݽ������

            break;

        case UART_II_THR_EMPTY: // ���ͻ������գ��ɼ�������
            break;

        case UART_II_MODEM_CHG: // ֻ֧�ִ���0
            break;

        default:
            break;
    }
}




/*********************************************************************
 * @fn      UART1_IRQHandler
 *
 * @brief   UART1�жϺ���
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
        case UART_II_LINE_STAT: // ��·״̬����
        {
            UART1_GetLinSTA();
            break;
        }

        case UART_II_RECV_RDY: // ���ݴﵽ���ô�����
//            {

//                rx1_buff[i] = UART1_RecvByte();
//                UART1_SendByte(rx1_buff[i]);
//            }
            break;

        case UART_II_RECV_TOUT: // ���ճ�ʱ����ʱһ֡���ݽ������
//            UART1_SendString(rx1_buff,sizeof(rx1_buff));
            break;

        case UART_II_THR_EMPTY: // ���ͻ������գ��ɼ�������
            break;

        case UART_II_MODEM_CHG: // ֻ֧�ִ���0
            break;

        default:
            break;
    }
}
