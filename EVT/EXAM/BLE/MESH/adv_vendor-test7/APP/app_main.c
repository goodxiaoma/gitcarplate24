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
/* 头文件包含 */
#include "CONFIG.h"
#include "MESH_LIB.h"
#include "HAL.h"
#include "app_mesh_config.h"
#include "app.h"

/* openmv收发数据定义区>>>>>start*/
#include "openmv.h"
#include "string.h"
//全局变量
//uint8_t rx1_buff[50];
//uint8_t rx1_pointer = 0;

char plate[9];//车牌
char platefirstmark[2];//车牌省份代号

uint8_t suma_check = 0;
uint8_t sumb_check = 0;
uint8_t plate_false[] = "This is check error\r\n";//将字符串存储为字符数组

/* openmv收发数据定义区>>>>>stop*/

char Rx1Buff[20];
char license[20];
u_int8_t flag=1;
void DebugInit(void)
{

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


//    /* 配置串口1：先配置IO口模式，再配置串口 */
//    GPIOB_SetBits(bTXD0);
//    GPIOB_ModeCfg(GPIO_Pin_4, GPIO_ModeIN_PU);      // RXD-配置上拉输入
//    GPIOB_ModeCfg(bTXD0, GPIO_ModeOut_PP_5mA);      // TXD-配置推挽输出，注意先让IO口输出高电平
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
// 超声波发送前需将该角置为1，每1s执行一次
#define TRIG_H  GPIOA_ResetBits(GPIO_Pin_15);
#define TRIG_L  GPIOA_SetBits(GPIO_Pin_15);

uint32_t cap_data;  // 频率捕获的值
float distant;      //测量距离
uint32_t high_time;   //超声波模块返回的高电平时间
// 频率捕获的配置，这里为了简便代码，直接使用双边沿捕获，将默认引脚拉低，捕获高电平时间
void Cap_Init(void)
{
    TMR3_CapInit( Edge_To_Edge );
    TMR3_CAPTimeoutCfg( 0xFFFFFFFF );    // 设置捕捉超时时间
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
            PRINT("\r\n----检测距离为    %.2f  cm----\r\n",distant);
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
 * @brief   主循环
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
 * @brief   mesh 库初始化
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
 * @brief   主函数
 *
 * @return  none
 */
int main(void)
{
    SetSysClock(CLK_SOURCE_PLL_60MHz);
    // Echo 初始化
    GPIOA_ModeCfg(GPIO_Pin_15, GPIO_ModeOut_PP_5mA);//PA5 推挽输出最大5mA
    // UART0 初始化
    DebugInit();
    // Trig 初始化
    GPIOB_ResetBits( GPIO_Pin_22 );             // 配置PA9
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
        TMR3_ClearITFlag( TMR0_3_IT_DATA_ACT );      // 清除中断标志
        cap_data = TMR3_CAPGetData();                // 获取频率捕获的值
        if(cap_data&(1<<25)){                        // 最高位为1表示高电平
            cap_data = cap_data&((1<<25)-1);            // 获取高电平的值
            high_time = cap_data/60;                    // 换算成高电平的时间
//            PRINT("H gap=%d us\r\n",high_time);
//            PRINT("\r\n----高电平时间    %d   us----\r\n",high_time);
            distant=(high_time*0.034)/2;                 // 换算成距离单位cm

            R32_TMR3_FIFO = 0;                       // 将频率捕获的值清0，不知道有没有用
            TMR3_ITCfg( DISABLE, TMR0_3_IT_DATA_ACT );  // 关闭频率捕获的中断
            PFIC_DisableIRQ( TMR3_IRQn );
        }
    }
}






//车牌接收发送区域 *车牌接收发送区域 *车牌接收发送区域 *车牌接收发送区域 *车牌接收发送区域 *车牌接收发送区域 *车牌接收发送区域 *车牌接收发送区域 *车牌接收发送区域 *车牌接收发送区域 *
//车牌接收发送区域 *车牌接收发送区域 *车牌接收发送区域 *车牌接收发送区域 *车牌接收发送区域 *车牌接收发送区域 *车牌接收发送区域 *车牌接收发送区域 *车牌接收发送区域 *车牌接收发送区域 *



/***************************************************************************************************************************
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

                if(pt_w1>15)                                            //当16个数据全部传完时候（4+8+2（sum） +2（plate_firstMark））
                {
                    pt_w1=0;

                    for(uint8_t i = 0; i <= 11;i++)                     // 和校验     0到11,(4个+8个)
                    {
                        suma_check += my_re_buf1[i];
                        suma_check = suma_check % 256;
                        sumb_check += suma_check;
                        sumb_check = sumb_check % 256;
                    }


                    if(suma_check == suma && sumb_check == sumb )       //和校验通过启动UART1中断函数并向上位机发送车牌信息
                    {
                        memcpy(platefirstmark,plate_firstMark,2);
                        memcpy(plate,openmvdata,9);


                        //省份代号转汉字


                        //UART1_SendString(plate, sizeof(plate));         //启动uart1的中断并发送plate中的所有信息
                    }
                    else if(suma_check != suma || sumb_check != sumb )  //如果和校验失败就向openmv发送错误代码“”
                    {
                        UART0_SendString(plate_false, sizeof(plate_false));
                    }

                    /*通过uart0再将数据发送给openmv
                                                            再在openmv端进行一个校验，校验成功后会在openmv终端打印车牌信息*/
                    UART0_SendString(my_re_buf1, sizeof(my_re_buf1));

                    //统一复位;再进行下一次接收
                    memset(my_re_buf1,0,sizeof(my_re_buf1));
                    memset(openmvdata,0,sizeof(openmvdata));
                    //这里需要将plate清空
                    //memset(plate,0,sizeof(plate));
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







//
//__attribute__((interrupt("WCH-Interrupt-fast")))
//__attribute__((section(".highcode")))
//void UART0_IRQHandler(void)
//{
//    volatile uint8_t i;
//    if(UART_II_RECV_TOUT) // 接收超时，暂时一帧数据接收完成
//    {
//        i = UART1_RecvString(Rx1Buff);   //接收数据并记录长度
//        UART1_SendString(Rx1Buff, i);    //将接收的数据串口发送
//        //自行数据解析
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
//    if(UART_II_RECV_TOUT) // 接收超时，暂时一帧数据接收完成
//    {
//        i = UART1_RecvString(Rx1Buff);   //接收数据并记录长度
//        UART1_SendString(Rx1Buff, i);    //将接收的数据串口发送
//        //自行数据解析
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
