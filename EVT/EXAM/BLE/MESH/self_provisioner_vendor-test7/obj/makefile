################################################################################
# MRS Version: 1.9.0
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include StdPeriphDriver/subdir.mk
-include Startup/subdir.mk
-include RVMSIS/subdir.mk
-include HAL/subdir.mk
-include APP/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(ASM_UPPER_DEPS)),)
-include $(ASM_UPPER_DEPS)
endif
ifneq ($(strip $(ASM_DEPS)),)
-include $(ASM_DEPS)
endif
ifneq ($(strip $(S_DEPS)),)
-include $(S_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
SECONDARY_FLASH += \
self_provisioner_vendor.hex \

SECONDARY_LIST += \
self_provisioner_vendor.lst \

SECONDARY_SIZE += \
self_provisioner_vendor.siz \


# All Target
all: self_provisioner_vendor.elf secondary-outputs

# Tool invocations
self_provisioner_vendor.elf: $(OBJS) $(USER_OBJS)
	@	@	riscv-none-embed-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common  -g -T "C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\Ld\Link.ld" -nostartfiles -Xlinker --gc-sections -L"../" -L"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\MESH\MESH_LIB" -L"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\BLE\LIB" -L"C:\Users\DELL\Desktop\CH573EVT\EVT\EXAM\SRC\StdPeriphDriver" -Xlinker --print-memory-usage -Wl,-Map,"self_provisioner_vendor.map" --specs=nano.specs -u _printf_float --specs=nosys.specs -o "self_provisioner_vendor.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@	@
self_provisioner_vendor.hex: self_provisioner_vendor.elf
	@	riscv-none-embed-objcopy -O ihex "self_provisioner_vendor.elf"  "self_provisioner_vendor.hex"
	@	@
self_provisioner_vendor.lst: self_provisioner_vendor.elf
	@	riscv-none-embed-objdump --source --all-headers --demangle --line-numbers --wide "self_provisioner_vendor.elf" > "self_provisioner_vendor.lst"
	@	@
self_provisioner_vendor.siz: self_provisioner_vendor.elf
	@	riscv-none-embed-size --format=berkeley "self_provisioner_vendor.elf"
	@	@
# Other Targets
clean:
	-$(RM) $(ASM_UPPER_DEPS)$(OBJS)$(SECONDARY_FLASH)$(SECONDARY_LIST)$(SECONDARY_SIZE)$(ASM_DEPS)$(S_DEPS)$(S_UPPER_DEPS)$(C_DEPS) self_provisioner_vendor.elf
	-@
secondary-outputs: $(SECONDARY_FLASH) $(SECONDARY_LIST) $(SECONDARY_SIZE)

.PHONY: all clean dependents

-include ../makefile.targets
