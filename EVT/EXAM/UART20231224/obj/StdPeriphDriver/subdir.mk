################################################################################
# MRS Version: 1.9.1
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
E:/chelou/CH573/EVTEVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_adc.c \
E:/chelou/CH573/EVTEVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_clk.c \
E:/chelou/CH573/EVTEVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_flash.c \
E:/chelou/CH573/EVTEVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_gpio.c \
E:/chelou/CH573/EVTEVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_pwr.c \
E:/chelou/CH573/EVTEVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_sys.c \
E:/chelou/CH573/EVTEVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_uart0.c \
E:/chelou/CH573/EVTEVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_uart1.c 

OBJS += \
./StdPeriphDriver/CH57x_adc.o \
./StdPeriphDriver/CH57x_clk.o \
./StdPeriphDriver/CH57x_flash.o \
./StdPeriphDriver/CH57x_gpio.o \
./StdPeriphDriver/CH57x_pwr.o \
./StdPeriphDriver/CH57x_sys.o \
./StdPeriphDriver/CH57x_uart0.o \
./StdPeriphDriver/CH57x_uart1.o 

C_DEPS += \
./StdPeriphDriver/CH57x_adc.d \
./StdPeriphDriver/CH57x_clk.d \
./StdPeriphDriver/CH57x_flash.d \
./StdPeriphDriver/CH57x_gpio.d \
./StdPeriphDriver/CH57x_pwr.d \
./StdPeriphDriver/CH57x_sys.d \
./StdPeriphDriver/CH57x_uart0.d \
./StdPeriphDriver/CH57x_uart1.d 


# Each subdirectory must supply rules for building sources it contributes
StdPeriphDriver/CH57x_adc.o: E:/chelou/CH573/EVTEVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_adc.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common -Wunused  -g -DDEBUG=1 -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_clk.o: E:/chelou/CH573/EVTEVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_clk.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common -Wunused  -g -DDEBUG=1 -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_flash.o: E:/chelou/CH573/EVTEVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_flash.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common -Wunused  -g -DDEBUG=1 -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_gpio.o: E:/chelou/CH573/EVTEVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_gpio.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common -Wunused  -g -DDEBUG=1 -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_pwr.o: E:/chelou/CH573/EVTEVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_pwr.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common -Wunused  -g -DDEBUG=1 -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_sys.o: E:/chelou/CH573/EVTEVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_sys.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common -Wunused  -g -DDEBUG=1 -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_uart0.o: E:/chelou/CH573/EVTEVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_uart0.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common -Wunused  -g -DDEBUG=1 -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@
StdPeriphDriver/CH57x_uart1.o: E:/chelou/CH573/EVTEVT/EVT/EXAM/SRC/StdPeriphDriver/CH57x_uart1.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common -Wunused  -g -DDEBUG=1 -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\RVMSIS" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@

