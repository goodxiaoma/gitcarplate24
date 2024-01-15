################################################################################
# MRS Version: 1.9.1
# 自动生成的文件。不要编辑！
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
E:/chelou/CH573/EVTEVT/EVT/EXAM/BLE/HAL/MCU.c \
E:/chelou/CH573/EVTEVT/EVT/EXAM/BLE/HAL/RTC.c \
E:/chelou/CH573/EVTEVT/EVT/EXAM/BLE/HAL/SLEEP.c 

OBJS += \
./HAL/MCU.o \
./HAL/RTC.o \
./HAL/SLEEP.o 

C_DEPS += \
./HAL/MCU.d \
./HAL/RTC.d \
./HAL/SLEEP.d 


# Each subdirectory must supply rules for building sources it contributes
HAL/MCU.o: E:/chelou/CH573/EVTEVT/EVT/EXAM/BLE/HAL/MCU.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\Startup" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\Broadcaster\APP\include" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\Broadcaster\Profile\include" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\HAL\include" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\Ld" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\LIB" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
HAL/RTC.o: E:/chelou/CH573/EVTEVT/EVT/EXAM/BLE/HAL/RTC.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\Startup" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\Broadcaster\APP\include" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\Broadcaster\Profile\include" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\HAL\include" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\Ld" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\LIB" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
HAL/SLEEP.o: E:/chelou/CH573/EVTEVT/EVT/EXAM/BLE/HAL/SLEEP.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\Startup" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\Broadcaster\APP\include" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\Broadcaster\Profile\include" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\HAL\include" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\Ld" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\LIB" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@

