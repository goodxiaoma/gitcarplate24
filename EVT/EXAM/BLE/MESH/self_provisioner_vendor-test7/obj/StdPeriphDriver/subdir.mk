################################################################################
# MRS Version: 1.9.0
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_adc.c \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_clk.c \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_flash.c \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_gpio.c \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_pwm.c \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_pwr.c \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_spi0.c \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_sys.c \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_timer0.c \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_timer1.c \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_timer2.c \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_timer3.c \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_uart0.c \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_uart1.c \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_uart2.c \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_uart3.c \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_usbdev.c \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_usbhostBase.c \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_usbhostClass.c 

OBJS += \
./StdPeriphDriver/CH57x_adc.o \
./StdPeriphDriver/CH57x_clk.o \
./StdPeriphDriver/CH57x_flash.o \
./StdPeriphDriver/CH57x_gpio.o \
./StdPeriphDriver/CH57x_pwm.o \
./StdPeriphDriver/CH57x_pwr.o \
./StdPeriphDriver/CH57x_spi0.o \
./StdPeriphDriver/CH57x_sys.o \
./StdPeriphDriver/CH57x_timer0.o \
./StdPeriphDriver/CH57x_timer1.o \
./StdPeriphDriver/CH57x_timer2.o \
./StdPeriphDriver/CH57x_timer3.o \
./StdPeriphDriver/CH57x_uart0.o \
./StdPeriphDriver/CH57x_uart1.o \
./StdPeriphDriver/CH57x_uart2.o \
./StdPeriphDriver/CH57x_uart3.o \
./StdPeriphDriver/CH57x_usbdev.o \
./StdPeriphDriver/CH57x_usbhostBase.o \
./StdPeriphDriver/CH57x_usbhostClass.o 

C_DEPS += \
./StdPeriphDriver/CH57x_adc.d \
./StdPeriphDriver/CH57x_clk.d \
./StdPeriphDriver/CH57x_flash.d \
./StdPeriphDriver/CH57x_gpio.d \
./StdPeriphDriver/CH57x_pwm.d \
./StdPeriphDriver/CH57x_pwr.d \
./StdPeriphDriver/CH57x_spi0.d \
./StdPeriphDriver/CH57x_sys.d \
./StdPeriphDriver/CH57x_timer0.d \
./StdPeriphDriver/CH57x_timer1.d \
./StdPeriphDriver/CH57x_timer2.d \
./StdPeriphDriver/CH57x_timer3.d \
./StdPeriphDriver/CH57x_uart0.d \
./StdPeriphDriver/CH57x_uart1.d \
./StdPeriphDriver/CH57x_uart2.d \
./StdPeriphDriver/CH57x_uart3.d \
./StdPeriphDriver/CH57x_usbdev.d \
./StdPeriphDriver/CH57x_usbhostBase.d \
./StdPeriphDriver/CH57x_usbhostClass.d 


# Each subdirectory must supply rules for building sources it contributes
StdPeriphDriver/CH57x_adc.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_adc.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_clk.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_clk.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_flash.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_flash.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_gpio.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_gpio.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_pwm.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_pwm.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_pwr.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_pwr.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_spi0.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_spi0.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_sys.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_sys.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_timer0.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_timer0.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_timer1.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_timer1.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_timer2.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_timer2.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_timer3.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_timer3.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_uart0.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_uart0.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_uart1.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_uart1.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_uart2.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_uart2.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_uart3.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_uart3.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_usbdev.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_usbdev.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_usbhostBase.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_usbhostBase.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_usbhostClass.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_usbhostClass.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@

