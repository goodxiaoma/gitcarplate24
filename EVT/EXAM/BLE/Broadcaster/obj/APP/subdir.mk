################################################################################
# MRS Version: 1.9.1
# �Զ����ɵ��ļ�����Ҫ�༭��
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../APP/broadcaster.c \
../APP/broadcaster_main.c 

OBJS += \
./APP/broadcaster.o \
./APP/broadcaster_main.o 

C_DEPS += \
./APP/broadcaster.d \
./APP/broadcaster_main.d 


# Each subdirectory must supply rules for building sources it contributes
APP/%.o: ../APP/%.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\Startup" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\Broadcaster\APP\include" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\Broadcaster\Profile\include" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\HAL\include" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\Ld" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\LIB" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@

