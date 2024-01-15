import sensor, image, time # 导入sensor模块，它提供了对摄像头硬件的访问
from pyb import millis # 导入pyb库中的millis函数，该函数用于获取当前系统时间
from os import listdir # 导入os库中的listdir函数，该函数用于获取目录中的文件列表
from text import font # 导入text模块中的font类，这个类可能包含一些文本相关的字体信息

#有屏幕库则加载、显示。没有屏幕库也能正常运行 当`try`块中的代码执行时，Python会尝试执行其中的代码。如果这些代码引发了异常，那么Python会跳转到`except`块，并执行其中的代码。
try:
    import screen
    screen.init()
    screen_exist = True # 判断是否加载了屏幕库
except:
    screen_exist = False # 如果没有加载屏幕库，将screen_exist设为False

# 1、对“省份”文字图像模版进行导入并处理
library_province = listdir('/library_province')#读取省份模板文件名
library_province.sort()#排序  对读取到的文件列表进行排序，是为了后面的代码需要用到，确保模板图片的顺序是按照某种规则（如字母或数字的顺序）排列的。
province_template = []  #存放省份模板图片
province_similarity = [] #存放每次识别后所有模板的相似度的列表
for n in range(len(library_province)): #'for n in range(len(library_province)):'是一个循环结构，它遍历名为'library_province'的列表或数组中的每一个元素。'range(len(library_province))'会生成一个序列，其中包含从0到'library_province'长度减1的所有整数。'n'是一个变量，它在这个循环中被用来代表当前的索引值，所以对于列表或数组中的每一个元素，都可以用变量'n'来表示。这样，就可以在循环中对列表或数组中的每一个元素进行操作。
    province_template.append(image.Image('/library_province/'+library_province[n]))#存入省份模板图    具体来说，这个函数的作用是从指定的路径加载图像文件。在这里，它从路径'/library_province/'下加载名为library_province[n]的图像文件。然后，它把这个图像对象添加到列表province_template中。列表append方法的功能是在列表的末尾添加一个元素。因此，这段代码的功能是在province_template列表中添加一个新的图像对象。这样，province_template列表将包含所有从指定的库加载的图像对象
    province_template[n].invert()    #对每个省份模板图片进行反色处理
    province_similarity.append(0)    #每次识别后所有模板的相似度

# 2、对车牌各单独“数字”文字图像模版进行导入并处理
library_alphanumeric = listdir('/library_alphanumeric')#读取数字字母模板文件名
library_alphanumeric.sort()     #排序
alphanumeric_template = []      #存放数字字母模板图片
alphanumeric_similarity = []    #存放每次识别后所有模板的相似度

for n in range(len(library_alphanumeric)):
    alphanumeric_template.append(image.Image('/library_alphanumeric/'+library_alphanumeric[n]))#存入数字字母模板图（这里存放省份）
    alphanumeric_template[n].invert()
    alphanumeric_similarity.append(0)    #每次识别后所有模板的相似度

#先初始化licence_number。为后面的程序执行做好准备，license_number 用来放车牌的7个文本信息 如：（鄂A 67876）
license_number = []  # 存放识别结果的列表，存储格式为空格分隔的字符串，用于表示车牌号码的各个部分
for n in range(7):  # 预分配空间，预留出7个位置用于存储识别结果
    license_number.append(' ')  # 将预留位置初始化为空格

sensor.reset() # Initialize the camera sensor.
sensor.set_pixformat(sensor.RGB565) # or sensor.RGB565
sensor.set_framesize(sensor.QVGA) # or sensor.QVGA (or others)
sensor.set_windowing(320,172) #自定义设置识别窗口大小为320*172
sensor.set_contrast(2)
clock = time.clock() # Tracks FPS.

img_GRAYSCALE = sensor.alloc_extra_fb(320,172,sensor.GRAYSCALE) # 创建一个灰度图像帧缓冲区，大小为320x172像素
img_GRAYSCALE_2 = sensor.alloc_extra_fb(320,172,sensor.GRAYSCALE) # 创建一个复用的灰度图像帧缓冲区，大小为320x172像素，第二个缓冲区可以用来保存预处理后的灰度图像，用于后续的模板匹配等操作
img_targets = [] ## 存放待匹配的目标图像的列表，通常用于保存经过预处理后的车牌图像，以便后续的模板匹配等操作
img_targets.append(sensor.alloc_extra_fb(35,55,sensor.GRAYSCALE)) # 如“（鄂）” 。这行代码向`img_targets`列表中添加了一个新的帧缓冲区，大小为35x55像素，并且是灰度图像。这个帧缓冲区通常用于保存经过预处理后的车牌图像。
for n in range(6):
    img_targets.append(sensor.alloc_extra_fb(28,45,sensor.GRAYSCALE))# 如“（A 67328）”将预留位置初始化为大小为35x55像素的目标图像帧缓冲区，通常用于保存经过预处理后的车牌图像的一部分，以便后续的模板匹配等操作

invert = False#是否反转颜色，以适应黑色字符的车牌如（警车车牌为白底黑字） 默认为False（不反转颜色）

while(True): #大循环
    clock.tick()
    target_blob_max = None
    img = sensor.snapshot().lens_corr(1.6)  # 获取当前图像的快照，并调整焦距  。strength 是一个浮点数，该值确定了对图像进行去鱼眼效果的程度。在默认情况下，首先试用取值1.8，然后调整这一数值使图像显示最佳效果。

    #一、处理图像并选中数字字母区域********************************************************************************************************************************************************************************************************************************************************************
    img_GRAYSCALE.draw_image(img,0,0) #原图绘制到（第一张）灰度画布上，用于定位字符 把img绘制到img_GRAYSCALE上。 \\ * `draw_image`：这是PIL库中的一个方法，用于在图像上绘制另一个图像， `0, 0`：这是绘制新图像的位置，第一个数字代表在 `img_GRAYSCALE` 的x轴方向上的位置（从左到右），第二个数字代表在y轴方向上的位置（从上到下）。

    if invert: #如果 'invert' 为真则执行下面语句（但是第54行已经给了false，所以下面的不执行）
        img_GRAYSCALE.invert() #那么第一张灰度图像会变为黑白，反之则会变为彩色

    img_GRAYSCALE_2.draw_image(img_GRAYSCALE,0,0) #复制第二份灰度图，用于识别

    # 下面进行色彩调节
    #img_GRAYSCALE_2.binary([(10,255)]) #按阈值二值化  这里传递的参数是(10, 255)，这可能是一个逻辑阈值，意味着只有像素值大于或等于10和小于或等于255的像素才会被视为前景（通常是白色）像素，其他像素则被视为背景（通常是黑色）像素。这个过程通常用于图像处理和计算机视觉中，以提高图像的可读性和清晰度。
    img_GRAYSCALE.laplacian(1)  #通过拉普拉斯变换，突出色彩分界线（数值越大效果越好，但越慢。所以用最小值，再提高画面亮度）
    img_GRAYSCALE.gamma_corr(gamma=1.2,contrast=25) #提高画面伽马值、对比度、亮度
    #识别浅色区域，加上尺寸、连续度的限制
    blobs = img_GRAYSCALE.find_blobs([(2,255)], x_stride=4,y_stride=2,pixels_threshold=80, area_threshold=80, margin=10) #[(2,255)] 灰度图像是由纯黑和纯白来过渡得到的，在黑色中加入白色就得到灰色，纯黑和纯白按不同的比例来混合就得到不同的灰度值。R=G=B=255为白色，R=G=B=0为黑色，R=G=B=小于255的某个整数时，此时就为某个灰度值。 灰度是表明图像明暗的数值，即黑白图像中点的颜色深度，范围一般从0到255，白色为255 ，黑色为0，故黑白图片也称灰度图像。灰度值指的是单个像素点的亮度。灰度值越大表示越亮。在这个代码中，它被用来识别灰度图像中颜色为(2,255)的区域。这些区域被视为“blobs”。x_stride和y_stride: 这两个参数控制了blobs检测时相邻像素之间的步长。在此代码中，它们都被设置为4和2。pixels_threshold: 这是一个阈值参数，用于确定一个像素是否被认为是blob的一部分。在此代码中，只有亮度超过80的像素才会被考虑。area_threshold: 这是另一个阈值参数，用于确定一个blob是否足够大而被提取出来。在此代码中，只有面积超过80且周围至少有10个像素的颜色接近其中心颜色(2,255)的区域才会被识别为一个blob。margin: 这个参数是用于控制检测到的blob的边界和图像边缘之间的距离。在此代码中，这个距离被设置为10个像素。
    print(blobs)
    #二、通过设置条件判断，筛选出符合车牌号特征的区域集，并排序，待模板匹配使用
    timer = millis()   #用于计这段消耗的时间，如果耗时过长，需要优化或移植到底层（C语言）
    #1.遍历筛选所有识别结果,筛选条件：自己和其他4个以上元素 高度 和 y坐标 相互相似的目标
    target_blobs=[]
    for n1 in range(len(blobs)): # 比如 a=("123","456","789") for i in range(len(a)):   print(i,a)  运行结果：0 ('123', '456', '789')  ............
        find_out_times = 0
        for n2 in range(len(blobs)):
            #判断高度差、Y轴差异度 其实就是寻找所拍摄的优质目标，并放到target_blobs = []
                #abs(blobs[n1].h() - blobs[n2].h()) < (blobs[n1].h() * 0.2)      它的目的是要求blob之间的高度差不能太大。因此，blobs[n1].h() - blobs[n2].h()表示两个blob的高度差  值得注意的是，因为是遍历所有可能的组合，所以n1和n2可能是相等的。在这种情况下，blobs[n1].h() - blobs[n2].h()确实等于0，但是也会考虑到不同的n1和n2的情况。因此，这个条件可以有效地筛选出那些高度相似并且y坐标接近的目标区域。
                # abs(blobs[n1].cy() - blobs[n2].cy())  < (blobs[n1].h() * 0.3)  如果第`n1`个目标区域的中心点的纵坐标减去第`n2`个目标区域的中心点的纵坐标小于等于第`n1`个目标区域的高度乘以0.3，那么认为这两个目标区域在纵坐标方向上的差异度较小。
            if abs(blobs[n1].h() - blobs[n2].h()) < (blobs[n1].h() * 0.2) and \
                abs(blobs[n1].cy() - blobs[n2].cy())  < (blobs[n1].h() * 0.3):
                find_out_times += 1
                if find_out_times > 4:#超过5次符合，记录
                    target_blobs.append(blobs[n1])
                    break
    #2.结果按y轴排序
   # print(target_blobs)
    target_blobs.sort(key = lambda b: b.y())#按选择框cy排序

    #3.在结果中记录每行的结束序号  准确地确定哪些区域属于同一行
    line_ending = []#记录每一行目标区域最后一项的序号
    #print(line_ending)
    for n in range(0,len(target_blobs)-1):
        if  abs(target_blobs[n].cy() - target_blobs[n+1].cy()) > target_blobs[n].h()*0.3:#两个Y差大于40%（）
            line_ending.append(n)
        line_ending.append(len(target_blobs))#上述方法不能记录最后一行，在此加入最后一行结束点。如果target_blobs没有内容，会加入0

    #4.分割每行，并排序、淘汰每行少于5个的元素
    target_blob_lines = []#存储以行为单位，完成排序的目标坐标结果
    if line_ending and line_ending != [0]:#如果有目标
        for n in range(len(line_ending)):#循环遍历
            if n == 0: #首行
                if line_ending[n] - 0 > 5:    #如果大于5个元素，存储内容，否则抛弃内容
                    target_blob_lines.append(target_blobs[ : line_ending[n]])#转存内容
                    target_blob_lines[-1].sort(key = lambda b: b[0])#按选择框x坐标排序非首行。如果大于5个元素，存储内容，否则抛弃内容
            elif line_ending[n] - line_ending[n-1] > 5: #
                target_blob_lines.append(target_blobs[line_ending[n-1] + 1 : line_ending[n]])#转存内容
                target_blob_lines[-1].sort(key = lambda b: b[0])#按选择框x坐标排序
    #5.进一步筛选掉每行，前后出现的，间距不符的元素
    n = 0
    while True:
        for n in range(len(target_blob_lines)):#行遍历，如果最后一位与倒数第二位间距，不符合倒数第二、第三位间距，则删除最后一位
            if  (target_blob_lines[n][-2].cx() - target_blob_lines[n][-3].cx())*0.8 <\
                (target_blob_lines[n][-1].cx() - target_blob_lines[n][-2].cx()) > \
                (target_blob_lines[n][-2].cx() - target_blob_lines[n][-3].cx())*1.2:
                del target_blob_lines[n][-1]
                break
        if n >= len(target_blob_lines)-1:
            break
    for n in range(len(target_blob_lines)):#行遍历，
        if len(target_blob_lines[n]) > 6:
            del target_blob_lines[n][0 : len(target_blob_lines[n]) - 6]#删除当前行除最后6个元素之外的所有元素

    #6.只保留像素最大的一行
    if target_blob_lines:#如果有目标
        target_blob_max = max(target_blob_lines, key = lambda b: b[0][4])#每行第一位面积为判断，保留最大的一行

        #7.补充省位选择框
        h_average = 0   #平均高度
        spacing_average = 0 #平均间距(后段相邻部分)
        y_difference_average = 0 #平均y坐标差(后段相邻部分)
        length = len(target_blob_max)
        for n in range(length):
            h_average += target_blob_max[n].h()
            if n > 1:
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

    if target_blob_max:
        try:    #此处常遇报错，用try跳过报错
            for n in range(len(target_blob_max)):
                img_targets[n].clear()
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

                img.draw_rectangle(target_blob_max[n][:4], color=(255,0,0))
                #img.draw_image(img_targets[n], n*40, 0,)   #将剪切结果绘制到主画布上，以观察效果
        except:
            continue

        for n in range(len(target_blob_max)):
            if n == 0:
                matching_rate = 0.75 #初始匹配率
                result = None   #识别结果
                while True:
                    blob_num = 0    #识别到的目标数量
                    for n1 in range(len(library_province)):
                        blob = img_targets[n].find_template(province_template[n1], matching_rate, step=2, search = image.SEARCH_EX)
                        if blob:    #如果识别到目标
                            blob_num += 1   #目标数量+1
                            result = n1 #保存结果
                    if blob_num == 1:   #如果唯一目标
                        license_number[n] = library_province[result][:-4]   #保存结果
                        #print('成功匹配，匹配率：'+str(matching_rate))
                        break   #结束循环
                    elif blob_num == 0 and matching_rate > 0.4: #如果匹配率>0.4 且 没找到目标
                        matching_rate -= 0.1    #匹配率降低
                        #print('降低匹配率'+str(matching_rate))
                    else:   #多个结果（小概率事件），0个结果 或 匹配率降低到0.4
                        break   #结束循环
            else:
                matching_rate = 0.75 #初始匹配率
                result = None   #识别结果
                #print('开始匹配第'+str(n)+'位')
                while True:
                    if target_blob_max[n][3] / target_blob_max[n][2] > 3:   #窄体，只有1
                        license_number[n] = '1'
                        break
                    blob_num = 0
                    for n1 in range(len(library_alphanumeric)):
                        blob = img_targets[n].find_template(alphanumeric_template[n1],0.75, step=2, search = image.SEARCH_EX)
                        if blob and library_alphanumeric[n1][:-4] != 'I' and library_alphanumeric[n1][:-4] != 'O':
                            blob_num += 1   #目标数量+1
                            result = n1 #保存结果
                    if blob_num == 1:   #如果唯一目标
                        license_number[n] = library_alphanumeric[result][:-4]   #保存结果
                        #print('成功匹配，匹配率：'+str(matching_rate))
                        break   #结束循环
                    elif blob_num == 0 and matching_rate > 0.4: #如果匹配率>0.4 且 没找到目标
                        matching_rate -= 0.2    #匹配率降低
                        #print('降低匹配率'+str(matching_rate))
                    else:   #多个结果（小概率事件），0个结果 或 匹配率降低到0.4
                        break   #结束循环


    print(clock.fps())
    if screen_exist:
        screen.display(img)

    print(license_number[0] + license_number[1] +"  "+ license_number[2]  + license_number[3] + license_number[4] + license_number[5] + license_number[6])





"""
    print(clock.fps())

       # img.draw_text(font, target_blob_max[0][0], target_blob_max[0][1]-34, license_number[0]+license_number[1]+license_number[2]+\
        #    license_number[3]+license_number[4]+license_number[5]+license_number[6],scale=2,GB=True,color=(255,0,0))
    if screen_exist:
        screen.display(img)

"""
