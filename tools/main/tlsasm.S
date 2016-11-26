/* tlsasm.S
  processor depended part of tls handling
*/  

      .syntax unified

/* GCC for ARM generates calls to this function to get the address
   of current tls. This is a special function in gcc:
   normal register save is not done and only r0 can be used without
   saving.
   User application should not call this.
*/   
      .global __aeabi_read_tp

      .text
      .thumb
      .thumb_func
      
__aeabi_read_tp:
      ldr r0, =tlsptr
      ldr r0,[r0]
      bx lr
      
