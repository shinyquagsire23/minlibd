This file is about the minimum version of the libdruntime library from https://bitbucket.org/timosi/minlibd.

This package is the original libdruntime package that has been modified
such a way that it can be compiled and used without any support from
an operating system. The library has several version checks for
win/mac/linux. There is also some version checks for version NoSystem,
but not in every file. Many of the library files will not compile
and some files will give an error message.

The original library has many features that are provided by the
operating system. In a microcontroller system, there are no streams,
sockets, file systems or networking. There may be some kind of error
console, but this can not be assumed in library level. 

Instead, controllers may have very little memory. There are real 32 bit
controllers that have only 16 kbytes of memory. The programs have
to be as small as possible. A library with a full set of features may 
take all available memory. Library functions that call other library functions
may result to an executable where the whole library is included although
a very small part would be needed.

To make a minimum library, I modified the original sources this way:
I started with a simple test program 
and added library files until there were no undefined references.
On the way, everything that did not compile and that was not needed,
was commented out. 
Only the absolute necessary set of files is included in this library.

The compiles turns various D constructions to library calls.
Not all D constructions have been tested. So there may still be 
undefined references when compiling real programs.

Some missing files or functions may be added later. 
Also there are plans for making a set of different libraries: 
- A very small library where every function that is not needed by the
library is removed.
- A full library where every file will be included and all necessary
modifications are made to have all possible functions. 
Also files from phobos that would make sense may be included.

Some features that are known to work
- Exceptions are mostly working. Earlier versions had a memory leak
  but that should be fixed now.
  
Features that do no work
- String catenation allocates an intermediate space that is never
  freed. Works otherwise.
- Module level things are not implemented
- Associative arrays are not implemented
- Object.factory is not implemented
- Monitors and synchronized blocks are not implemented
