# 项目汇总


采用OPENMV+CH573+超声波检测；当超声波探测车牌距离小于15cm时候将openmv识别到的数据传输mesh网络  
将openmv与573连接完毕后，运行 EVT/EXAM/BLE/MESH/adv_vendor-test7/adv_vendor.wvproj

## OPENMV
### openmvuart端口  

openmv可直接通过usb接口与电脑上位机通信  
openmv与CH573进行数据传输  
  openmv使用uart3端口： TX-PB10 ;RX-PB11  
  CH543使用uart0端口：  TX-PB7 ;RX-PB4  
  如图（CH573）  
  <div align=center>
  <img src="https://github.com/goodxiaoma/gitcarplate24/blob/main/%E5%AE%9E%E7%89%A9%E5%9B%BE/391f2266ab31f367d303541c73024d8.jpg" width="200"> 
  </div>
  
### openmv识别代码

代码见 Carplate_Openmv20240114/main.py （附有详细注释）  Carplate_Openmv20240114/FUNC.py  （有详细注释）  
若需要运行openmv只需运行main  

## CH573
### 
