#include "openmv.h"

uint8_t my_re_buf1[20]={0x00};      //缓冲区
uint8_t openmvdata[9]={0x00};       //小球位置 只用到前两位
uint8_t pt_w1=0;                    //缓冲区计数指针
uint8_t suma=0;
uint8_t sumb=0;
uint8_t state=0;
uint8_t plate_firstMark[2]={0x00};

void OpmvDataGet(uint8_t data)
{
    if(state==0 && data == 0xAA)                // 有bug,不能判断下一个data就是oxff
    {
        my_re_buf1[0] = 0xAA;
        state =1;
    }
    else if (state==1 && data == 0xFF)
    {
        state=2;
    }
    else if (state==2 && data == 0xF1)
    {
        state=3;
    }
    else if (state==3 && data == 17)
    {
        state=4;
    }
    else if (state==4 && data != 17)
    {
        state=5;
        openmvdata[0]=data;//省份（1）一个中文字符占3个字节
    }
    else if (state==5 && data != 17)
    {
        state=6;
        openmvdata[1]=data;//省份（2）
    }
    else if (state==6 && data != 17)
    {
        state=7;
        openmvdata[2]=data;//省份（3）
    }
    else if (state==7 && data != 17)
    {
        state=8;
        openmvdata[3]=data;//1
    }
    else if (state==8 && data != 17)
    {
        state=9;
        openmvdata[4]=data;//2
    }
    else if (state==9 && data != 17)
    {
        state=10;
        openmvdata[5]=data;//3
    }
        else if (state==10 && data != 17)
    {
        state=11;
        openmvdata[6]=data;//4
    }
        else if (state==11 && data != 17)
    {
        state=12;
        openmvdata[7]=data;//5
    }
        else if (state==12 && data != 17)
    {
        state=13;
        openmvdata[8]=data;//6
    }
        else if (state==13 && data != 17)
    {
        state=14;
        suma=data;
    }
        else if (state==14 && data != 17)
    {
        state=15;
        sumb=data;
    }
        else if (state==15 && data != 17)
    {
        state=16;
        plate_firstMark[0]=data;
    }
        else if (state==16 && data != 17)
    {
        state=0;
        plate_firstMark[1]=data;

    }
}


//void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart)     //opmv-receive
//{
//
//  if(huart == &huart2)
//  {
//      HAL_UART_AbortReceive_IT(&huart2);
//      HAL_UART_Receive_IT(&huart2,&my_re_buf1[pt_w1++],1);

//      OpmvDataGet(my_re_buf1[pt_w1]);
//      if(pt_w1>20) pt_w1=0;
//  }
//
//  HAL_GPIO_WritePin(GPIOC,GPIO_PIN_13,GPIO_PIN_RESET);

//}
