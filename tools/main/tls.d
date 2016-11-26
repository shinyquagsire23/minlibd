/** Basic tls handling
 * Copyright: 2013-2016 Timo Sintonen
 * License: gpl v3+
 *
 * For now this support only one thread.
 * may be fixed some day...
 */
module tls;

// This file should only be imported by the file that has C main.


extern (C) 
{

__gshared void * tlsptr; // pointer to tls of the current thread

void * __aeabi_read_tp();  // debug only, do not use

   
private {
   // external c library functions
   void* memcpy(void* dest, void* src, uint len);
   void* malloc(uint size);
   
   // These are defined in the linker script
   extern __gshared int _tlsstart, _tlsend;

}
   
   
/** GCC for ARM uses this system call to get the current tls pointer.
* This is usually found in libc. What it does depends on processor and system.
* We do not have any thread library so we must implement this ourselves.
* This should not be called from user program.
* This function is a special case in gcc. The registers are not saved
* and r0 is the only register that can be used without saving.
* It is not possible to use a c function here and this has been moved
* to tlsasm.S
*/
/*
  void * __aeabi_read_tp() {
    return tlsptr; 
  }
*/
   
} // extern c

   
/** This allocates and initializes a tls area and puts its address
 * in the tls pointer of the current thread.
 * In the linker script of this project tdata and tbss are together 
 * in one block. This may not be true in other systems.
 * Now there is only one thread and the address is put directly into tlsptr.
*/
 void tlsinit() {
   
   // For some reason, the variables in tls have offset of 8 bytes
   // I do not know what the 8 bytes are for, 
   // but this is why the address and size are +8.

   int size=cast(int)&_tlsend - cast(int)&_tlsstart;
   tlsptr=malloc(size+8);
  
   memcpy(tlsptr+8, &_tlsstart, size); 
}


