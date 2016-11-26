# Basic rules for compiling object files from sources
# These should work with any target processor or system.

# This file should be included from makefile of any directory which contains
# source files.

# DO NOT EDIT THIS. Edit defs.mak for your needs

# These rules compiles c programs first to assembler (.s files) and then
# to object files. D files are compiled directly to object files.
# Both c and d objects generate list files which have name like file.o.l
# It is also possible to make a preprocessed file from c sources.
# Command like: make file.e  makes proprocessed file from file.c
# ASSEMBLER FILES SHOULD HAVE SUFFIX .S (make clean removes all .s files)

.DELETE_ON_ERROR: %.o %.s
     
%.s:  %.c  $(deps)
	 $(gccprefix)$(gcc) $(cflags) $(flags) -S $(defines) $(includes) $<

%.e: %.c $(deps)
	 $(gccprefix)$(gcc) $(cflags) -E -H $(defines) $(includes) $< -o $@

$(cobjects): %.o:  %.s  
	 $(gccprefix)as $(flags) -a=$@.l $< -o $@ 

$(dobjects): %.o:  %.d $(deps)  
	 $(gccprefix)$(gdc) $(dflags) $(flags) -c $(includes) $< -o $@

$(asmobjects): %.o:  %.S $(deps)  
	 $(gccprefix)as $(flags) -a=$@.l $< -o $@ 

.PHONY: clean
clean:
	 rm -f *.o *.se *.l *~ *.s *.a
	 
      
      
