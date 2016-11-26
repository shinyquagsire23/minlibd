# This is a global definitions file for makefiles.
# Put all definitions here and include this file from every makefile
# in your project.
# This is made for stm32 but it is easy to add any processor type

# Choose the processor type
# Note that only f4 is currently supported and some of these may never
# be supported.
# It may also be necessary to specify the actual processor number.
# Currently the number is fixed below in processor specified section
#STM32F0 := 1
#STM32F1 := 1
#STM32F2 := 1
#STM32F3 := 1
STM32F4 := 1
#STM32F7 := 1
#STM32L0  := 1
#STM32L1  := 1
#STM32L4  := 1


# put here the ABSOLUTE PATH TO TOPDIR
# (it has ?= so you can give this also in shell)
prefix ?= /home/timo/arm/minlibd/tools


# PROJECT SETTINGS

# Put here any global dependencies like global config files
# Any change to these files will trig remake of all sources
deps += $(prefix)/defs.mak 


#COMPILER FLAGS
#Target prefix of your cross cmpiler (with the dash at the end)
gccprefix= arm-eabi-

#Any flags that should be passed to all of gcc, gdc and assembler
# ( only processor independent )
#flags =

#C SOURCES

#The name of your c compiler (without prefix)
gcc ?= gcc

# flags that are only for c compiler 
cflags = -Wall -Wfatal-errors -O2  

# Defines for c sources
#defines += -Dmyproject

# Include directories for c sources
includes += -I.    # for example: -I$(prefix)/utils



# D SOURCES

# The name of the d compiler (without prefix)
gdc ?= gdc

# flags for the d compiler
dflags += -Wall -Wfatal-errors -O2     # the compiler flags
dflags += -I$(prefix)/../libdruntime/  # the path to d runtime (where object.di is)

dflags += -frelease            # required for the minimum library
dflags += -Wa,-ahls=$@.l       # optional, generates the list files
dflags += -fno-emit-moduleinfo # required, no module support 


# PROCESSOR DEPENDENT 
# Add here settings for your own processor
# Only those settings that depends on the processor type
# You may add here your own processor
# These defaults may not be correct. Please check them before use.
# Note that f4 is currently the only supported target 

ifdef STM32F4
  targetdir = stm32f4
  flags    += -mcpu=cortex-m4 -mthumb 
# comment the next line out if your libgcc is compiled for soft fp
  flags    += -mfpu=fpv4-sp-d16 -mfloat-abi=hard
  defines  += -DSTM32F4XX -DSTM32F4  
  dflags   += -fversion=STM32F4
else ifdef STM32F0
  targetdir = stm32f0
  flags    += -mcpu=cortex-m0 -mthumb -mfloat-abi=soft
  defines  += -DSTM32F0XX_MD -DSTM32F0
  dflags   += -fversion=STM32F0
else ifdef STM32F3
  targetdir = stm32f3
  flags    += -mcpu=cortex-m4 -mthumb
  defines  += -DSTM32F37X -DSTM32FX  # the first one is for st's library
  dflags   += -fversion=STM32F3
#else ifdef STM32L4    # not tested yet
#  targetdir = stm32l4
#  flags    += -mcpu=cortex-m4 -mthumb -mfloat-abi=soft
#  defines  += -DSTM32L4
#  dflags   += -fversion=STM32L4
else
  $(error Set the right processor type in defs.mak)
endif

# Target dependent startup code 
subdirs += $(targetdir)/startup

# This is needed to compile c files
includes += -I$(prefix)/$(targetdir)/startup



# File patterns (do not edit)
# These would belong to rules.mak but they must be defined before
# the first rule.
# These patterns will find all source files in a directory. 
# No changes needed in makefiles when a new file is added.
# Do make clean if you remove a source file.
cobjects = $(patsubst %.c,%.o,$(wildcard *.c)) 
dobjects = $(patsubst %.d,%.o,$(wildcard *.d)) 
asmobjects = $(patsubst %.S,%.o,$(wildcard *.S)) 
objects = $(cobjects) $(dobjects) $(asmobjects)


