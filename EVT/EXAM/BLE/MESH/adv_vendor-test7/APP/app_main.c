/********************************** (C) COPYRIGHT *******************************
 * File Name          : main.c
 * Author             : WCH
 * Version            : V1.1
 * Date               : 2022/01/18
 * Description        :
 *********************************************************************************
 * Copyright (c) 2021 Nanjing Qinheng Microelectronics Co., Ltd.
 * Attention: This software (modified or not) and binary are used for 
 * microcontroller manufactured by Nanjing Qinheng Microelectronics.
 *******************************************************************************/

/******************************************************************************/
/* ͷ�ļ����� */
#include "CONFIG.h"
#include "MESH_LIB.h"
#include "HAL.h"
#include "app_mesh_config.h"
#include "app.h"

/* openmv�շ����ݶ�����>>>>>start*/
#include "openmv.h"
#include "string.h"
//ȫ�ֱ���
//uint8_t rx1_buff[50];
//uint8_t rx1_pointer = 0;

char plate[9];//����
char platefirstmark[2];//����ʡ�ݴ���

uint8_t suma_check = 0;
uint8_t sumb_check = 0;
uint8_t plate_false[] = "This is check error\r\n";//���ַ����洢Ϊ�ַ�����

/* openmv�շ����ݶ�����>>>>>stop*/

char Rx1Buff[20];
char license[20];
u_int8_t flag=1;
void DebugInit(void)
{

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


//    /* ���ô���1��������IO��ģʽ�������ô��� */
//    GPIOB_SetBits(bTXD0);
//    GPIOB_ModeCfg(GPIO_Pin_4, GPIO_ModeIN_PU);      // RXD-������������
//    GPIOB_ModeCfg(bTXD0, GPIO_ModeOut_PP_5mA);      // TXD-�������������ע������IO������ߵ�ƽ
//    UART0_DefInit();
//
//    GPIOA_SetBits(bTXD1);
//    GPIOA_ModeCfg(GPIO_Pin_8, GPIO_ModeIN_PU);
//    GPIOA_ModeCfg(bTXD1, GPIO_ModeOut_PP_5mA);
//    UART1_DefInit();
//
//    UART1_ByteTrigCfg(UART_7BYTE_TRIG);
//    UART1_INTCfg(ENABLE, RB_IER_RECV_RDY | RB_IER_LINE_STAT);
//    PFIC_EnableIRQ(UART1_IRQn);
}
// ����������ǰ�轫�ý���Ϊ1��ÿ1sִ��һ��
#define TRIG_H  GPIOA_ResetBits(GPIO_Pin_15);
#define TRIG_L  GPIOA_SetBits(GPIO_Pin_15);

uint32_t cap_data;  // Ƶ�ʲ����ֵ
float distant;      //��������
uint32_t high_time;   //������ģ�鷵�صĸߵ�ƽʱ��
// Ƶ�ʲ�������ã�����Ϊ�˼����룬ֱ��ʹ��˫���ز��񣬽�Ĭ���������ͣ�����ߵ�ƽʱ��
void Cap_Init(void)
{
    TMR3_CapInit( Edge_To_Edge );
    TMR3_CAPTimeoutCfg( 0xFFFFFFFF );    // ���ò�׽��ʱʱ��
    TMR3_ITCfg( ENABLE, TMR0_3_IT_DATA_ACT );
    PFIC_EnableIRQ( TMR3_IRQn );
}
void SR04_GetData(void)
{
        TRIG_H;
        DelayUs(30);
        TRIG_L;
        Cap_Init();
        if(distant)
        {
            PRINT("\r\n----������Ϊ    %.2f  cm----\r\n",distant);
        }
}
/**
/*********************************************************************
 * GLOBAL TYPEDEFS
 */
__attribute__((aligned(4))) uint32_t MEM_BUF[BLE_MEMHEAP_SIZE / 4];

#if(defined(BLE_MAC)) && (BLE_MAC == TRUE)
const uint8_t MacAddr[6] = {0x84, 0xC2, 0xE4, 0x03, 0x02, 0x02};
#endif

/*********************************************************************
 * @fn      Main_Circulation
 *
 * @brief   ��ѭ��
 *
 * @return  none
 */
__attribute__((section(".highcode")))
__attribute__((noinline))
void Main_Circulation()
{
    int i=0;
    while(1)
    {
        if((i++)==600000)
        { SR04_GetData();i=0;}
        TMOS_SystemProcess();
    }
}

/*********************************************************************
 * @fn      bt_mesh_lib_init
 *
 * @brief   mesh ���ʼ��
 *
 * @return  state
 */
uint8_t bt_mesh_lib_init(void)
{
    uint8_t ret;

    if(tmos_memcmp(VER_MESH_LIB, VER_MESH_FILE, strlen(VER_MESH_FILE)) == FALSE)
    {
        PRINT("mesh head file error...\n");
        while(1);
    }

    ret = RF_RoleInit();

#if((CONFIG_BLE_MESH_PROXY) ||   \
    (CONFIG_BLE_MESH_PB_GATT) || \
    (CONFIG_BLE_MESH_OTA))
    ret = GAPRole_PeripheralInit();
#endif /* PROXY || PB-GATT || OTA */

#if(CONFIG_BLE_MESH_PROXY_CLI)
    ret = GAPRole_CentralInit();
#endif /* CONFIG_BLE_MESH_PROXY_CLI */

    MeshTimer_Init();
    MeshDeamon_Init();
    ble_sm_alg_ecc_init();

#if(CONFIG_BLE_MESH_IV_UPDATE_TEST)
    bt_mesh_iv_update_test(TRUE);
#endif
    return ret;
}

/*********************************************************************
 * @fn      main
 *
 * @brief   ������
 *
 * @return  none
 */
int main(void)
{
    SetSysClock(CLK_SOURCE_PLL_60MHz);
    // Echo ��ʼ��
    GPIOA_ModeCfg(GPIO_Pin_15, GPIO_ModeOut_PP_5mA);//PA5 ����������5mA
    // UART0 ��ʼ��
    DebugInit();
    // Trig ��ʼ��
    GPIOB_ResetBits( GPIO_Pin_22 );             // ����PA9
    GPIOB_ModeCfg( GPIO_Pin_22, GPIO_ModeIN_PD );

    PRINT("%s\n", VER_LIB);
    PRINT("%s\n", VER_MESH_LIB);
    CH57X_BLEInit();
    HAL_Init();
    bt_mesh_lib_init();
    App_Init();
    Cap_Init();
    Main_Circulation();
}
__attribute__((interrupt("WCH-Interrupt-fast")))
__attribute__((section(".highcode")))
void TMR3_IRQHandler( void )
{
    if ( TMR3_GetITFlag( TMR0_3_IT_DATA_ACT ) )
    {
        TMR3_ClearITFlag( TMR0_3_IT_DATA_ACT );      // ����жϱ�־
        cap_data = TMR3_CAPGetData();                // ��ȡƵ�ʲ����ֵ
        if(cap_data&(1<<25)){                        // ���λΪ1��ʾ�ߵ�ƽ
            cap_data = cap_data&((1<<25)-1);            // ��ȡ�ߵ�ƽ��ֵ
            high_time = cap_data/60;                    // ����ɸߵ�ƽ��ʱ��
//            PRINT("H gap=%d us\r\n",high_time);
//            PRINT("\r\n----�ߵ�ƽʱ��    %d   us----\r\n",high_time);
            distant=(high_time*0.034)/2;                 // ����ɾ��뵥λcm

            R32_TMR3_FIFO = 0;                       // ��Ƶ�ʲ����ֵ��0����֪����û����
            TMR3_ITCfg( DISABLE, TMR0_3_IT_DATA_ACT );  // �ر�Ƶ�ʲ�����ж�
            PFIC_DisableIRQ( TMR3_IRQn );
        }
    }
}






//���ƽ��շ������� *���ƽ��շ������� *���ƽ��շ������� *���ƽ��շ������� *���ƽ��շ������� *���ƽ��շ������� *���ƽ��շ������� *���ƽ��շ������� *���ƽ��շ������� *���ƽ��շ������� *
//���ƽ��շ������� *���ƽ��շ������� *���ƽ��շ������� *���ƽ��շ������� *���ƽ��շ������� *���ƽ��շ������� *���ƽ��շ������� *���ƽ��շ������� *���ƽ��շ������� *���ƽ��շ������� *



/***************************************************************************************************************************
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

                if(pt_w1>15)                                            //��16������ȫ������ʱ��4+8+2��sum�� +2��plate_firstMark����
                {
                    pt_w1=0;

                    for(uint8_t i = 0; i <= 11;i++)                     // ��У��     0��11,(4��+8��)
                    {
                        suma_check += my_re_buf1[i];
                        suma_check = suma_check % 256;
                        sumb_check += suma_check;
                        sumb_check = sumb_check % 256;
                    }


                    if(suma_check == suma && sumb_check == sumb )       //��У��ͨ������UART1�жϺ���������λ�����ͳ�����Ϣ
                    {
                        memcpy(platefirstmark,plate_firstMark,2);
                        memcpy(plate,openmvdata,9);


                        //ʡ�ݴ���ת����


                        //UART1_SendString(plate, sizeof(plate));         //����uart1���жϲ�����plate�е�������Ϣ
                    }
                    else if(suma_check != suma || sumb_check != sumb )  //�����У��ʧ�ܾ���openmv���ʹ�����롰��
                    {
                        UART0_SendString(plate_false, sizeof(plate_false));
                    }

                    /*ͨ��uart0�ٽ����ݷ��͸�openmv
                                                            ����openmv�˽���һ��У�飬У��ɹ������openmv�ն˴�ӡ������Ϣ*/
                    UART0_SendString(my_re_buf1, sizeof(my_re_buf1));

                    //ͳһ��λ;�ٽ�����һ�ν���
                    memset(my_re_buf1,0,sizeof(my_re_buf1));
                    memset(openmvdata,0,sizeof(openmvdata));
                    //������Ҫ��plate���
                    //memset(plate,0,sizeof(plate));
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







//
//__attribute__((interrupt("WCH-Interrupt-fast")))
//__attribute__((section(".highcode")))
//void UART0_IRQHandler(void)
//{
//    volatile uint8_t i;
//    if(UART_II_RECV_TOUT) // ���ճ�ʱ����ʱһ֡���ݽ������
//    {
//        i = UART1_RecvString(Rx1Buff);   //�������ݲ���¼����
//        UART1_SendString(Rx1Buff, i);    //�����յ����ݴ��ڷ���
//        //�������ݽ���
//        switch(flag)
//            {
//        case 1:sprintf(license, "%s", Rx1Buff);break;
//
//        case 2:strcat(license,Rx1Buff);flag=1;break;
//            }
//        if(i>=7)
//        {
//            flag=2;
//        }
//        memset(Rx1Buff, 0, sizeof(Rx1Buff));
//    }
//}





//__attribute__((interrupt("WCH-Interrupt-fast")))
//__attribute__((section(".highcode")))
//void UART1_IRQHandler(void)
//{
//    volatile uint8_t i;
//    if(UART_II_RECV_TOUT) // ���ճ�ʱ����ʱһ֡���ݽ������
//    {
//        i = UART1_RecvString(Rx1Buff);   //�������ݲ���¼����
//        UART1_SendString(Rx1Buff, i);    //�����յ����ݴ��ڷ���
//        //�������ݽ���
//        switch(flag)
//            {
//        case 1:sprintf(license, "%s", Rx1Buff);break;
//
//        case 2:strcat(license,Rx1Buff);flag=1;break;
//            }
//        if(i>=7)
//        {
//            flag=2;
//        }
//        memset(Rx1Buff, 0, sizeof(Rx1Buff));
//    }
//}

/******************************** endfile @ main ******************************/
