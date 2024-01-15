import sensor# 导入sensor库，这个库可能用于获取传感器的数据
import time# 导入time库，用于处理时间相关的操作
from time import sleep  # 从time库中导入sleep函数，用于暂停程序的执行一段时间
import image# 导入image库，可能用于处理图像数据
import lcd# 导入lcd库，可能用于控制LCD显示屏
import os
#from text import font # 导入text模块中的font类，这个类可能包含一些文本相关的字体信息
from pyb import LED, Pin  # 从pyb库中导入LED和Pin，可能用于控制LED灯和GPIO引脚
from os import listdir# 导入os库，用于操作系统相关的操作，如文件和目录管理
import  struct
from pyb import UART
from FUNC import gb2312

#导入函数
from FUNC import init_plate_recognition
from FUNC import process_image_and_find_elements
from FUNC import Filter_Elementblock
from FUNC import ProcessMatchingSpace_and_PerformTemplateMatching
from FUNC import Send_receive_carplate
from FUNC import Display_carplate



#一 初始化并导入模版
init_plate_recognition()

while True:
    #二、处理图像 并 寻找元素块**********************************************************************************************************************************
    process_image_and_find_elements()
    #三、通过设置条件判断，筛选出符合车牌号特征的区域集，并排序，待模板匹配使用*************************************************************************

    Filter_Elementblock()
    #四、处理待匹配区域画板并进行模版匹配******************************************************************************************
    ProcessMatchingSpace_and_PerformTemplateMatching()
    #五、发送车牌字符***********************************************************************************
    Send_receive_carplate()
    #六、显示车牌号码************************************************************************
    Display_carplate()


