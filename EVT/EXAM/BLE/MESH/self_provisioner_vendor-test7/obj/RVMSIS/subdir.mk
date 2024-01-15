################################################################################
# MRS Version: 1.9.0
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/RVMSIS/core_riscv.c 

OBJS += \
./RVMSIS/core_riscv.o 

C_DEPS += \
./RVMSIS/core_riscv.d 


# Each subdirectory must supply rules for building sources it contributes
RVMSIS/core_riscv.o: C:/Users/DELL/Desktop/CH573EVT/EVT/EXAM/SRC/RVMSIS/core_riscv.c
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -DDEBUG=1 -DBLE_MEMHEAP_SIZE=4096 -DHAL_KEY=1 -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Startup" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\APP\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\self_provisioner_vendor-test7\Profile\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver\inc" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\HAL\include" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\RVMSIS" -I"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -std=gnu99 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@	@

