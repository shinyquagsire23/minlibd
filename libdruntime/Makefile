# This is a sample Makefile to compile the minimum D runtime library
# for ARM Cortex-m processors  (stm32)


ifeq ($(strip $(DEVKITPPC)),)
$(error "Please set DEVKITPPC in your environment. export DEVKITPPC=<path to>devkitPPC")
endif
ifeq ($(strip $(DEVKITPRO)),)
$(error "Please set DEVKITPRO in your environment. export DEVKITPRO=<path to>devkitPRO")
endif
export PATH			:=	$(DEVKITPPC)/bin:$(PORTLIBS)/bin:$(PATH)

# Choose your processor type
#STM32F0 := 1
#STM32F1 := 1
#STM32F2 := 1
#STM32F3 := 1
#STM32F4 := 1
#STM32L  := 1


# GCC settings

# The prefix of your cross tools (with the dash at the end)
gccprefix= powerpc-eabi-

# basic gcc flags 
cflags= -Wall -Wfatal-errors -O2 

# the name of your gcc
gcc = gcc


# GDC settings

# the name of the gdc compiler
gdc = gdc

# Basic d flags
dflags += -frelease        # required to make a minimum amount of library calls
dflags += -fversion=NoSystem  # required to compile
dflags += -fno-bounds-check   # optional, makes the code smaller
dflags += -Wa,-ahls=$@.l      # optional, generates a list file
dflags += -fd-verbose         # optional, just to have more dump
dflags += -fno-emit-moduleinfo  # required, no support for modules yet
#dflags += -fversion=GNU_ARM_EABI_Unwinder # required for arm targets

# PROCESSOR DEPENDENT

ifdef STM32F1
  flags    += -mcpu=cortex-m3 -mthumb
  dflags   += -fversion=STM32F1
else ifdef STM32F2
  flags    += -mcpu=cortex-m3 -mthumb
  dflags   += -fversion=STM32F2
else ifdef STM32L
  flags    += -mcpu=cortex-m3 -mthumb -mfloat-abi=soft
  dflags   += -fversion=STM32L
else ifdef STM32F4
  flags    += -mcpu=cortex-m4 -mthumb 
# uncomment the next line if your libgcc has been compiled for fpu
  flags   += -mfpu=fpv4-sp-d16 -mfloat-abi=hard
  dflags   += -fversion=STM32F4
else ifdef STM32F0
  flags    += -mcpu=cortex-m0 -mthumb -mfloat-abi=soft
  dflags   += -fversion=STM32F0
else ifdef STM32F3
  flags    += -mcpu=cortex-m4 -mthumb 
# uncomment the next line if your libgcc has been compiled for fpu
#  flags   += -mfpu=fpv4-sp-d16 -mfloat-abi=hard
  dflags   += -fversion=STM32F3
else
  #$(error Processor not selected)
endif


#Basic file patterns (not used in this directory)
#cobjects = $(patsubst %.c,%.o,$(wildcard *.c)) 
#dobjects = $(patsubst %.d,%.o,$(wildcard *.d)) 
#asmobjects = $(patsubst %.S,%.o,$(wildcard *.S)) 



# The object files

# These are required for the minimum library
dobjects += object.o
dobjects += rt/lifetime.o rt/config.o
dobjects += $(patsubst %d,%o,$(wildcard rt/typeinfo/*.d))
dobjects += rt/deh.o  gcc/deh.o
dobjects += rt/cast_.o
dobjects += rt/util/string.o  rt/util/hash.o
dobjects += rt/adi.o
dobjects += gcstub/gc.o
#dobjects += gcc/unwind/pe.o  gcc/unwind/arm.o
dobjects += core/exception.o
dobjects += rt/arraycast.o
dobjects += core/memory.o
dobjects += core/internal/convert.o core/internal/hash.o core/internal/traits.o
#dobjects += core/stdc/stdio.d

# The following are currently not needeed but can be compiled 
dobjects += core/atomic.o gcc/atomics.o gcc/builtins.o   

# The following files are optional. 
# They can be compiled into the library but they are not 
# included into executables unless there is code that calls them.
# Any of these that fails to compile can be omitted from the list.
# These are not tested and may contain calls to functions that
# do not exist. 
#dobjects += core/time.o    # Duration etc (does not work in 2.066)

dobjects += rt/switch_.o   # core/time.d requires this

#dobjects += rt/aApply.o  rt/aApplyR.o   # utf strings in foreach
#dobjects += rt/util/utf.o  # needed by aApply
dobjects += rt/aaA.o
dobjects += rt/arrayassign.o  # dynamic arrays
dobjectf += rt/arraycat.o  # array copy
dobjects += rt/obj.o       # class object comparison operators 
dobjects += rt/invariant.o
#dobjects += rt/util/container.o # does not exist any more

# put here any additional files that can be compiled into the library
#dobjects += 
#cobjects += 
#asmobjects +=

objects = $(cobjects) $(dobjects) $(asmobjects)

# The rules. Nothing to edit below this

all:  $(objects) $(deps)
	$(gccprefix)ar r libdruntime.a $(objects) 


.DELETE_ON_ERROR: %.o %.s
     
%.s:  %.c  $(deps)
	 $(gccprefix)$(gcc) $(cflags) $(flags) -S $(defines) $(includes) $<

$(cobjects): %.o:  %.s  
	 $(gccprefix)as $(flags) -a=$@.l $< -o $@ 

$(dobjects): %.o:  %.d $(deps)  
	 $(gccprefix)$(gdc) $(cflags) $(dflags) $(flags) -c $(includes) $< -o $@

$(asmobjects): %.o:  %.S $(deps)  
	 $(gccprefix)as $(flags) -a=$@.l $< -o $@ 

.PHONY: clean allclean
clean:
	 rm -f *.o *.se *.l *~ *.s *.a
	 
allclean: clean
	rm -f */*.o */*/*.o */*.o.l */*/*.o.l */*~ */*/*~ 
