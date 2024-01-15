################################################################################
# MRS Version: 1.9.1
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../APP/app.c \
../APP/app_main.c \
../APP/app_mesh_config.c \
../APP/app_vendor_model_srv.c \
../APP/openmv.c 

OBJS += \
./APP/app.o \
./APP/app_main.o \
./APP/app_mesh_config.o \
./APP/app_vendor_model_srv.o \
./APP/openmv.o 

C_DEPS += \
./APP/app.d \
./APP/app_main.d \
./APP/app_mesh_config.d \
./APP/app_vendor_model_srv.d \
./APP/openmv.d 


# Each subdirectory must supply rules for building sources it contributes
APP/%.o: ../APP/%.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\Startup" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\MESH\adv_vendor-test7\APP\include" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\MESH\adv_vendor-test7\Profile\include" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\HAL\include" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\Ld" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\LIB" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\SRC\RVMSIS" -I"E:\chelou\CH573\EVTEVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@

