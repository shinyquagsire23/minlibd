/** This module contains the definition of an STM32 uart,
 * basic initialization and simple communication functions that are
 * useful in debugging.
 *
 * Copyright: 2013-2016 Timo Sintonen
 * License: GPL v3+
 * 
*/ 
module uart;

import volatil3;

// Addresses of the uarts.
// Now constant values are used but these are not same in all processors.
// These may also be defined in a processor dependent header file.
alias uarttype = uartreg*;
enum uarttype uart1=cast (uarttype)0x40011000; 
enum uarttype uart2=cast (uarttype)0x40004400; 
enum uarttype uart3=cast (uarttype)0x40004800; 
// uart4-6 the same way if needed

// A helper for the hardware that used to test the program.
// FIX THIS FOR YOUR HARDWARE
// This should actually be in a separate project config file.
version(STM32F41x) {
   alias console = uart1;
}
else version(STM32F4) {
   alias console = uart3;
}
else {
   alias console = uart1;
}


// NOTE: The user application needs to enable the uarts in rcc module 
// and configure i/o pins in gpio module before accessing the peripherals
 

   
extern (C) extern __gshared int SystemCoreClock;   // defined in startup file
                                  // and needed to calculate the baud divider
   

struct uartreg {
   // peripheral registers
   Volatile!uint sr;
   Volatile!uint dr;
   Volatile!uint brr;
   Volatile!uint cr1;
   Volatile!uint cr2;
   Volatile!uint cr3;
   Volatile!uint gtpr;
   
	
   /** Setting and getting the baud rate.
    These are made as property functions so we can call them like:
    uart.baud=9600;
    To get the correct divider we need to know the core frequency, the bus
    where the uart is located and the clock divider for that bus. 
    Now it is just assumed we have STM32F407 and use
    only uarts in apb1 with recommended frequency of SystemCoreClock/4 
    Then the uart may be programmed to divide the bus frequency by 8 or 16, 
    but only the default value 16 is used here.
   */
   
   @property int baud() { 
      return SystemCoreClock/4/brr;
   }
   
   @property int baud(int b) {        
      brr=SystemCoreClock/4/b; // f411  /1,  f407  /4 
      return b; 
   }
	
   /// uart initialization and mode settings
   void conf(int speed,int parity, int bits) {  

      cr1=0;
      cr2=0;
      cr3=0;
      gtpr=0; 
      baud=speed; 
      if (parity==1) cr1|=0x400;  // 0 or 1
      if (bits==8)   cr1|=0x1000; // 7 or 8
      
      sr=0; // clear status
      cr1 |= 0x200c; // uart enable
   }
   

   
   /// send a byte to the uart
   void send(int t) {
     while ((sr&0x80)==0) 
     {  }
     dr=t;
   }
   
 
   /// send a n-digit hex number to uart
   void sendhex(T) (T hexnum, int n=8) {
      if (n>1) {
	 sendhex(cast(int)hexnum>>4,n-1);  // recursive call
      }
      int t=( cast(int)hexnum & 0x0f)+0x30;
      if (t>0x39) t+=7;
      send(t);
   }

   /// send hex number and text after it
   void sendhex(T) (T hexnum, int n, string text) {
      sendhex(hexnum,n);
      sendtext(text);
   }
   
   /// send a text string or to the uart
   void sendtext(const char[] p) {
      
      foreach (c;p) {
	 if (c==0) {break;}
	 send(c);  
      }
      
   }
   
}  // struct uart



void memdump(int addr,int len=0x20) {
      
   for(int f=addr;f<addr+len;f++) {
      if ( ((f&0x0f)==0) || (f==addr)) {
	 console.send('\r');
	 console.sendhex(f,8,": ");
      }
      ubyte t=*(cast(ubyte *)f);
      console.sendhex(t,2," ");
   }
}

	
