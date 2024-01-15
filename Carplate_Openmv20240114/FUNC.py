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


#utf-8转gb2312*********************************************************

class gb2312(object):
    def __init__(self):
        self.f = open('utf2gb2312.bin', 'r', encoding='utf-8')

    def b2i(self, byte):  # bytes转int
        r = 0
        for i in range(len(byte)):
            r = (r << 8) + byte[i]
        return r

    def i2b(self, num):  # int转bytes
        num = int(num, 16)
        return num.to_bytes(2, 'big')

    def one_char(self, char):  # 将一个字符转化成gb2312
        utf_byte = char.encode('utf-8')
        r = self.B_S(0, 7296, self.b2i(utf_byte))
        gb2312_byte = self.i2b(r)
        # print(gb2312_byte)
        return gb2312_byte

    def strs(self, st):  # 将字符串转化成gb2312
        r = b''
        for s in st:
            # print(s.encode('utf-8'))
            if len(s.encode('utf-8')) <= 1:
                r += s.encode('utf-8')
            else:
                r += self.one_char(s)
        return r

    def B_S(self, low, high, m):  # 二分查找
        if 0 <= low <= high <= 7296:
            mid = (low + high) // 2
            self.f.seek(mid * 12)
            data = self.f.read(12)
            utf = data[0:6]
            if int(utf, 16) < m:
                return self.B_S(mid + 1, high, m)
            elif int(utf, 16) > m:
                return self.B_S(low, mid - 1, m)
            else:
                return data[7:-1]

    def __del__(self):
        self.f.close()

    Re = None

#一 初始化并导入模版************************************************************************************

def init_plate_recognition():


    global uart,library_province,library_alphanumeric,clock,KEY,plate_cascade,blue_led,licence_number,province_template,province_similarity, alphanumeric_template,img_GRAYSCALE,img_GRAYSCALE_2
    global img_targets,invert,licence0,blobs,h_average,spacing_average, y_difference_average,target_blob_max,img,formatted_data,suma_check,sumb_check,RE_data,ProvenceMark,carplate_str,Recv_buff,Recv_sta



    # 1.1 串口设置
    uart = UART(3, 115200)
    uart.init(115200, bits=8, parity=None, stop=1)  #8位数据位，无校验位，1位停止位、

    # 1.2 导入车牌字符模版
    library_province = listdir('/library_province')#读取省份模板文件名
    library_province.sort()#排序
    province_template = []  #省份模板图片
    province_similarity = []    #每次识别后所有模板的相似度########
    for n in range(len(library_province)):
        province_template.append(image.Image('/library_province/'+library_province[n]))#存入省份模板图
        province_template[n].invert()
        province_similarity.append(0)    #每次识别后所有模板的相似度

    library_alphanumeric = listdir('/library_alphanumeric')#读取数字字母模板文件名
    library_alphanumeric.sort()#排序
    alphanumeric_template = []  #数字字母模板图片
    alphanumeric_similarity = []    #每次识别后所有模板的相似度
    for n in range(len(library_alphanumeric)):
        alphanumeric_template.append(image.Image('/library_alphanumeric/'+library_alphanumeric[n]))#存入数字字母模板图
        alphanumeric_template[n].invert()
        alphanumeric_similarity.append(0)    #每次识别后所有模板的相似度

    # 1.3 创建储存车牌字符的变量
    licence_number = []#存储识别到的结果
    licence0 = "   " #这个是省份数字代号
    for n in range(7):
        licence_number.append(' ')# 预分配空间，预留出7个位置用于存储识别结果 # 将预留位置初始化为空格

    # 1.4 Sensor settings
    sensor.reset()
    sensor.set_framesize(sensor.QVGA)#320*240
    sensor.set_windowing(320,160) #自定义设置识别窗口大小为320*160 即使设置了帧大小为QVGA（320*240），由于使用了窗口设置，识别将在设置的窗口尺寸内进行，而不是在整个帧上进行。
    sensor.set_pixformat(sensor.RGB565)
    sensor.set_auto_gain(True)
    sensor.set_auto_whitebal(True)#自动白平衡
    sensor.set_auto_exposure(True)

    # 1.5  Load Haar Cascade
    # By default this will use all stages, lower satges is faster but less accurate.
    plate_cascade = image.HaarCascade("cascade.cascade", stages=25) # 可以自己进行调节

    # 1.6 自动对焦初始化
    sensor.skip_frames(time = 1)# 跳过一段时间的帧，这个时间由参数time决定。在这个例子中，时间被设置为1
    blue_led = LED(1)# 创建blue_led
    KEY = Pin('C13',Pin.IN,Pin.PULL_DOWN)# 创建一个名为KEY的变量，它是一个Pin对象实例，Pin对象用于控制硬件设备，如电子线路。这个例子中，Pin对象连接到了编号为C13的引脚，类型为输入（Pin.IN），并且引脚被设置为下拉状态（Pin.PULL_DOWN）。
    lcd.init(type=2,refresh=120)# 初始化一个LCD显示屏，类型被设置为2（可能表示某种特定的LCD类型），刷新频率被设置为120Hz

    # 1.7 创建画板
    clock = time.clock()
    img_GRAYSCALE = sensor.alloc_extra_fb(160,80,sensor.GRAYSCALE) # 创建一个灰度图像帧缓冲区，大小为160*80像素
    img_GRAYSCALE_2 = sensor.alloc_extra_fb(160,80,sensor.GRAYSCALE) # 创建一个复用的灰度图像帧缓冲区，大小为160*80像素，第二个缓冲区可以用来保存预处理后的灰度图像，用于后续的模板匹配等操作
    img_targets = [] #这段代码就是在创建一些特定大小和模式的帧缓冲区，这些缓冲区将用于存储从传感器获取的图像数据。
    img_targets.append(sensor.alloc_extra_fb(35,55,sensor.GRAYSCALE))
    for n in range(6):
        img_targets.append(sensor.alloc_extra_fb(28,45,sensor.GRAYSCALE))

    invert = False#是否反转颜色，以适应黑色字符的车牌如（警车车牌为白底黑字） 默认为False（不反转颜色）



# 二 处理图像并寻找元素块********************************************************************************

def process_image_and_find_elements():
    global uart,library_province,library_alphanumeric,clock,KEY,plate_cascade,blue_led,licence_number,province_template,province_similarity, alphanumeric_template,img_GRAYSCALE,img_GRAYSCALE_2
    global img_targets,invert,licence0,blobs,h_average,spacing_average, y_difference_average,target_blob_max,img,formatted_data,suma_check,sumb_check,RE_data,ProvenceMark,carplate_str,Recv_buff,Recv_sta



    # 2.0 自动对焦
    clock.tick()
    if  KEY.value()  ==  1:#  检测到  KEY  键被按下
         sensor.ioctl(sensor.IOCTL_TRIGGER_AUTO_FOCUS) #  开启自动对焦
         blue_led.on()#  点亮蓝色LED
         sleep(0.05)#  延时0.05秒

    # 2.1 Capture snapshot
    img = sensor.snapshot()#镜头捕捉画面

    # 2.2 用Harr算子寻找车牌整体并用白色矩形框将其显示在img上
    objects = img.find_features(plate_cascade, threshold=0.75, scale_factor=1.25)
    if  len(objects)  ==  0:
             img_GRAYSCALE.clear()
             img_GRAYSCALE_2.clear()#清除帧缓冲区上的字符
             blue_led.off()   #关闭蓝色LED
             lcd.clear()   #清除LCD显示屏

    for r in objects:
        img.draw_rectangle(r[0]-10, r[1]-10, r[2]+20, r[3]+20, thickness=3)
        #画出第一张灰度图 便于后续在灰度图寻找筛选车牌各个字符位置
        img_GRAYSCALE.draw_image(img,  0,  0,  x_scale=round(150/r[2],  3),  y_scale=round(150/r[2], 3)
                                 , roi = (r[0]-10, r[1]-10, r[2]+20, r[3]+20))
    if invert: #如果 'invert' 为真则执行下面语句
       img_GRAYSCALE.invert() #那么第一张灰度图像会变为黑白，反之则会变为彩色
    img_GRAYSCALE_2.draw_image(img_GRAYSCALE,0,0) #在第一份灰度图上复制第二份灰度图(这里由于还没开始处理第一张灰度图，所以这个灰度图是很干净的)，用于后续识别模版匹配

    # 2.3 下面进行画布img_GRAYSCALE的色彩调节
    img_GRAYSCALE.laplacian(2)  #通过拉普拉斯变换，突出色彩分界线（数值越大效果越好，但越慢。所以用最小值，再提高画面亮度）
    img_GRAYSCALE.gamma_corr(gamma=4,contrast=25) #提高画面伽马值、对比度、亮度

    # 2.4 在第一个画板寻找元素块(找浅色，灰白色，黑色直接过滤)
    blobs = img_GRAYSCALE.find_blobs([(2,255)], x_stride=4,y_stride=2, pixels_threshold=70, area_threshold=70, margin=8 )#(2,255)]这里是代表（2,2，2）、（3,3,3）、...（225,225,225,）




#三、通过设置条件判断，筛选出符合车牌号特征的区域集，并排序，待模板匹配使用*****************************************

def Filter_Elementblock():
    global uart,library_province,library_alphanumeric,clock,KEY,plate_cascade,blue_led,licence_number,province_template,province_similarity, alphanumeric_template,img_GRAYSCALE,img_GRAYSCALE_2
    global img_targets,invert,licence0,blobs,h_average,spacing_average, y_difference_average,target_blob_max,img,formatted_data,suma_check,sumb_check,RE_data,ProvenceMark,carplate_str,Recv_buff,Recv_sta



    # 3.1 遍历筛选所有识别结果,筛选条件：自己和其他4个以上元素 高度 和 y坐标 相互相似的目标
    target_blobs=[]
    for n1 in range(len(blobs)):
        find_out_times = 0
        for n2 in range(len(blobs)):
            #判断高度差、Y轴差异度 其实就是寻找所拍摄的优质目标，并放到target_blobs = []
            if abs(blobs[n1].h() - blobs[n2].h()) < (blobs[n1].h() * 0.2) and \
                abs(blobs[n1].cy() - blobs[n2].cy())  < (blobs[n1].h() * 0.3):
                find_out_times += 1
                if find_out_times > 4:#超过5次符合，记录
                    target_blobs.append(blobs[n1])
                    break
    # 3.2 结果按y轴排序
    target_blobs.sort(key = lambda b: b.y())#按选择框y排序

    # 3.3 在结果中记录每行的结束序号  准确地确定哪些区域属于同一行
    line_ending = []#记录每一行目标区域最后一项的序号
    #print(line_ending)
    for n in range(0,len(target_blobs)-1):
        if  abs(target_blobs[n].cy() - target_blobs[n+1].cy()) > target_blobs[n].h()*0.3:#两个Y差大于40%（）,那就说明是不同行。
            line_ending.append(n)
        line_ending.append(len(target_blobs))#上述方法不能记录最后一行，在此加入最后一行结束点。如果target_blobs没有内容，会加入0

    # 3.4 分割每行，并排序、淘汰每行少于6个的元素
    target_blob_lines = []#存储以行为单位，完成排序的目标坐标结果
    if line_ending and line_ending != [0]:#如果有目标
        for n in range(len(line_ending)):#循环遍历
            if n == 0: #首行
                if line_ending[n] - 0 > 5:    #如果大于5个元素至少6个，存储内容，否则抛弃内容
                    target_blob_lines.append(target_blobs[ : line_ending[n]])#转存内容
                    target_blob_lines[-1].sort(key = lambda b: b[0])#按选择框x坐标排序非首行。
            elif line_ending[n] - line_ending[n-1] > 5: #
                target_blob_lines.append(target_blobs[line_ending[n-1] + 1 : line_ending[n]])#转存内容
                target_blob_lines[-1].sort(key = lambda b: b[0])#按选择框x坐标排序

    # 3.5 进一步筛选掉每行，前后出现的，间距不符的元素。删除当前行除最后6个元素之外的所有元素
    n = 0
    while True:
        for n in range(len(target_blob_lines)):#行遍历，如果最后一位与倒数第二位间距，不符合倒数第二、第三位间距，则删除最后一位，正常就是说不可能前面的间距乘以一个小于零的又乘以一个大于零的数，都是比后一个间距小
            if  (target_blob_lines[n][-2].cx() - target_blob_lines[n][-3].cx())*0.8 <\
                (target_blob_lines[n][-1].cx() - target_blob_lines[n][-2].cx()) > \
                (target_blob_lines[n][-2].cx() - target_blob_lines[n][-3].cx())*1.2:
                del target_blob_lines[n][-1]
                break
        if n >= len(target_blob_lines)-1:
            break
    for n in range(len(target_blob_lines)):#行遍历
        if len(target_blob_lines[n]) > 6:
            del target_blob_lines[n][0 : len(target_blob_lines[n]) - 6]#删除当前行除最后6个元素之外的所有元素

    # 3.6 只保留像素最大的一行
    h_average =0 #平均高度
    spacing_average = 0  #平均间距(后段相邻部分)
    y_difference_average = 0 #平均y坐标差(后段相邻部分)

    target_blob_max = None #初始化最优车牌“行”
    if target_blob_lines:#如果有目标
        target_blob_max = max(target_blob_lines, key = lambda b: b[0][4])#每行第一位面积为判断，保留最大的一行

     # 3.7 补充省位选择框
        length = len(target_blob_max)
        for n in range(length):
            h_average += target_blob_max[n].h()
            if n > 1:#从2开始也可以说是从1开始
                spacing_average += target_blob_max[n].cx() - target_blob_max[n-1].cx()
                y_difference_average += target_blob_max[n].cy() - target_blob_max[n-1].cy()
        h_average = round(h_average / length)
        w_average = round(h_average / 2)
        spacing_average = round(spacing_average / (length - 2 ))
        y_difference_average = round(y_difference_average / (length - 2))
        #  插入省位选择框
        target_blob_max.insert(0, [round(target_blob_max[0].x() - (spacing_average * 1.2)),\
                                   round(target_blob_max[0].y() - (y_difference_average * 1.1)-2),\
                                   round(w_average * 1.4),\
                                   round(h_average * 1.2)])
    else:   #没找到目标
        invert = not invert #通知反转画面，以待识别黑色字符




#四、处理待匹配区域画板并进行模版匹配***********************************************************************

def ProcessMatchingSpace_and_PerformTemplateMatching():
    global uart,library_province,library_alphanumeric,clock,KEY,plate_cascade,blue_led,licence_number,province_template,province_similarity, alphanumeric_template,img_GRAYSCALE,img_GRAYSCALE_2
    global img_targets,invert,licence0,blobs,h_average,spacing_average, y_difference_average,target_blob_max,img,formatted_data,suma_check,sumb_check,RE_data,ProvenceMark,carplate_str,Recv_buff,Recv_sta


    # 4.1 下面使用第2张灰度图，将第二张灰度图上的各个字符区域进行等比例放大或者缩小到模版的高度（h），并适当的扩大了点区域，然后将其一个个添加到灰度图img_targets上。
    if target_blob_max:
        for n in range(len(target_blob_max)):
            img_targets[n].clear()#初始化
            if n == 0:
                img_targets[n].draw_image(img_GRAYSCALE_2, 0, 0, x_scale = 40 / h_average, y_scale = 40 / h_average,\
                                       roi = (target_blob_max[n][0] - 2,\
                                              target_blob_max[n][1] - 1,\
                                              target_blob_max[n][2] + 5,\
                                              target_blob_max[n][3] + 5))
            else:
                img_targets[n].draw_image(img_GRAYSCALE_2, 0, 0, x_scale = 40 / target_blob_max[n][3], y_scale = 40 / target_blob_max[n][3],\
                                       roi = (target_blob_max[n][0] - 1,\
                                              target_blob_max[n][1] - 1,\
                                              target_blob_max[n][2] + 5,\
                                              target_blob_max[n][3] + 5))
            #img_GRAYSCALE.draw_rectangle(target_blob_max[n][:4], color=(255,225,225))#将各个字符的矩形框画在了第一张灰度图上。
            #img.draw_rectangle(target_blob_max[n][:4], color=(255,0,0))


        # 4.2 进行模版匹配
        n=0
        for n in range(len(target_blob_max)):
            if n == 0:#省份匹配
                matching_rate = 0.8 #初始匹配率
                result = None   #识别结果
                while True:
                    blob_num = 0    #识别到的目标数量
                    for n1 in range(len(library_province)):
                        blob = img_targets[n].find_template(province_template[n1], matching_rate, step=3, search = image.SEARCH_EX)
                        if blob:    #如果识别到目标
                            blob_num += 1   #目标数量+1
                            result = n1 #保存结果
                    # 定义匹配结果和车牌号码的映射关系
                    mapping = { '01': '琼',  '02': '陕',  '03': '使',
                                '04': '苏',  '05': '皖',  '06': '湘',
                                '07': '新',  '08': '学',  '09': '渝',
                                '10': '豫', '11': '鄂', '12': '云',
                                '13': '浙', '14': '澳', '15': '藏',
                                '16': '川', '17': '鄂', '18': '甘',
                                '19': '赣', '20': '港', '21': '贵',
                                '22': '桂', '23': '黑', '24': '沪',
                                '25': '吉', '26': '冀', '27': '津',
                                '28': '晋', '29': '京', '30': '警',
                                '31': '辽', '32': '领', '33': '鲁',
                                '34': '蒙', '35': '闽', '36': '宁',
                                '37': '青',
                               }
                    licence0  =  " "
                    if blob_num == 1:   #如果唯一目标
                        licence0 = result_key = library_province[result][:-4]#车牌代号# 获取匹配结果
                        if result_key in mapping:  # 如果匹配结果在映射中
                            licence_number[n] = mapping[result_key]  # 获取对应的车牌号码
                        #print('成功匹配，匹配率：'+str(matching_rate))
                        break   #结束循环
                    elif blob_num == 0 and matching_rate > 0.4: #如果匹配率>0.4 且 没找到目标
                        matching_rate -= 0.1 #匹配率降低
                        #print('降低匹配率'+str(matching_rate))
                    else:   #多个结果（小概率事件）
                        break   #结束循环
            else:#字母匹配
                matching_rate = 0.8 #初始匹配率
                result = None   #识别结果
                #print('开始匹配第'+str(n)+'位')
                while True:
                    if target_blob_max[n][3] / target_blob_max[n][2] > 5:   #round(40/7, 3) : #窄体，"I"的模版是7*40的像素
                        licence_number[n] = 'I' #这里首先对"I"一次筛选,下面就不进行匹配了
                        break
                    blob_num = 0
                    for n1 in range(len(library_alphanumeric)):
                        blob = img_targets[n].find_template(alphanumeric_template[n1],matching_rate, step=2, search = image.SEARCH_EX)
                        if blob:
                            blob_num += 1   #目标数量+1
                            result = n1 #保存结果
                    if blob_num == 1:   #如果唯一目标
                        licence_number[n] = library_alphanumeric[result][:-4]   #保存结果
                        #print('成功匹配，匹配率：'+str(matching_rate))
                        break   #结束循环
                    elif blob_num == 0 and matching_rate > 0.4: #如果匹配率>0.4 且 没找到目标
                        matching_rate -= 0.1    #匹配率降低
                        #print('降低匹配率'+str(matching_rate))
                    else:   #多个结果（小概率事件）
                        break   #结束循环



#五、发送车牌字符***********************************************************************************

def Send_receive_carplate():
    global uart,library_province,library_alphanumeric,clock,KEY,plate_cascade,blue_led,licence_number,province_template,province_similarity, alphanumeric_template,img_GRAYSCALE,img_GRAYSCALE_2
    global img_targets,invert,licence0,blobs,h_average,spacing_average, y_difference_average,target_blob_max,img,formatted_data,suma_check,sumb_check,RE_data,ProvenceMark,carplate_str,Recv_buff,Recv_sta

    #data  =  [None]  *  16#初始化需要发送的数据

    #r  =  [None]  *  3#初始化需要发送的数据

    if target_blob_max:
        # 5.1 打包数据
        licence_str =  licence_number[1] + licence_number[2] + licence_number[3] + licence_number[4] + licence_number[5] + licence_number[6] + licence0

        data  =  bytearray(16)
        data[0]  =  0xAA
        data[1]  =  0xFF
        data[2]  =  0xF1
        data[3]  =  16
        #因为micropython只有utf-8编码；但是本项目需要使用gb2312编码，固在此转换（车牌省份）
        #if  licence_number[0]  is  not  None:
        try:
            fontbyte = gb2312()
            r = fontbyte.strs(licence_number[0])
            data[4]=r[0]
            data[5]=r[1]
            #print(r)
        except:
            print("转译error")


        _tmp = struct.pack("8s", licence_str.encode())  # 使用 .encode() 来将字符串编码为字节串     9：（省份占3个字节+后6个车牌） +2：两位是用来存放车牌省份代号数字（两位数字）
        data[6:12] = _tmp[:6]  # 将整个前9字节的字节串赋值给data   #_tmp[:9]是获取_tmp数组的前9个元素  data[4]到data[12]，不包括data[13]

        suma = 0#前11位数据和校验
        sumb = 0
        for i in range(12):
            suma += data[i]
            suma = suma % 256
            sumb += suma
            sumb = sumb % 256
        data[12] = suma
        data[13] = sumb
        data[14] = _tmp[6] #这最后两位是用来存放车牌省份代号数字（两位数字）
        data[15] = _tmp[7]
        #print(data[6:12])
        print(data)
        #print(r)
        # 5.2 发送数据
        uart.write(data)
        #print(data)

        # 5.3 接收数据
        Recv_buff=[]
        Recv_sta=0

        formatted_data  = []
        suma_check=0
        sumb_check=0

        if uart.any() > 0:
            RE_data = uart.read()
            RE_data = RE_data[:16]#截取前17个数据
            if len(RE_data) >= 16:
                #print(RE_data)
                formatted_data = [byte for byte in RE_data]#使用列表推导式将字节数据转换为整数列表
                for i in range(12):#0--11
                        suma_check += formatted_data[i]
                        suma_check = suma_check % 256
                        sumb_check += suma_check
                        sumb_check = sumb_check % 256
                        # 0到11,(6个+6个)
                if suma_check == formatted_data[12] and sumb_check == formatted_data[13] :
                    #省份代号
                    ProvenceMark=""
                    ProvenceMark  +=  chr(formatted_data[14])
                    ProvenceMark  +=  chr(formatted_data[15])
                    #print(ProvenceMark)
                    #车牌
                    carplate_str  =  ""
                    #这里循环不包括12
                    for  i  in  range(6,  12):
                         carplate_str  +=  chr(formatted_data[i])
                    print("re_Carplate:",   ProvenceMark, carplate_str)




#六、显示车牌号码**************************************************************************************

def Display_carplate():

    global uart,library_province,library_alphanumeric,clock,KEY,plate_cascade,blue_led,licence_number,province_template,province_similarity, alphanumeric_template,img_GRAYSCALE,img_GRAYSCALE_2
    global img_targets,invert,licence0,blobs,h_average,spacing_average, y_difference_average,target_blob_max,img,formatted_data,suma_check,sumb_check,RE_data,ProvenceMark,carplate_str,Recv_buff,Recv_sta


    # 6. 1 在显示屏上显示识别到的车牌（经过各种处理后的黑白图img_GRAYSCALE）&& 在缓冲区显示车牌号码
    if target_blob_max:
        lcd.display(img_GRAYSCALE)
        img.draw_string(5, 0,licence0 +" "+ licence_number[1] + licence_number[2]  + licence_number[3] + licence_number[4] + licence_number[5] + licence_number[6], color=(0,0,255), scale=3)#其中scale可以调节字体的粗细
        # 6.2 打印帧数和车牌
        ex_carplate = licence_number[0] + licence_number[1] + licence_number[2] + licence_number[3] + licence_number[4] + licence_number[5] + licence_number[6]
        print("车牌：", ex_carplate)
        print(clock.fps())




