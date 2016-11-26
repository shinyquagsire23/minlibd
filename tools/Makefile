# Makefile for the sample project.

# All global settings are in defs.mak
# Put here things that are related to build the top directory

include defs.mak

# The directories that contain the source code of the project.
# Do not put library directories here
subdirs += main

# Add the project specific libraries here
#libs += -lutils

# This will pick all object files from all source directories
files  = $(patsubst %,%/*.o,$(subdirs))

# Add here the files that have been compiled separately 
# or any other special files.
#files += $(targetdir)/startup/startup.o


# The druntime library 
libs += -l:$(prefix)/../libdruntime/libdruntime.a

# LIBGCC
# Libgcc.a is not included automatically when we have our own linker script.
# This command should tell what is the right library for this target.
gcclib = $(shell $(gccprefix)$(gcc) $(flags) -print-libgcc-file-name)

#If for some reason gcc picks a wrong one, the right path should be
#given manually like this in older gcc:
#gcclib = /usr/local/lib/gcc/arm-eabi/5.0.0/thumb/thumb2/libgcc.a # cortex-m3
#gcclib = /usr/local/lib/gcc/arm-eabi/5.0.0/cortex-m4/libgcc.a  # cortex-m4

# This should always be the last one in libs  
libs += -l:$(gcclib) 

# Something has changed in binutils and absolute path does not work
# any more. This is a terrible hack.
libdirs += -L/


.PHONY: all libs $(subdirs) clean subdirclean

all: $(subdirs)
	$(gccprefix)ld -M -EL --cref -Map mapfile --no-undefined --verbose\
     -static $(libdirs) -T$(targetdir)/ldscript $(files) $(libs)
 

$(subdirs):
	  $(MAKE) -C $@
	  
subdirclean:
	  list="$(subdirs)"; for f in $$list; do $(MAKE) -C $$f clean; done

clean:
	  rm -f a.out *~ mapfile  

allclean: clean subdirclean

      
      

