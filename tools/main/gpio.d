/** STM32 gpio configuration and basic i/o
   Copyright: 2013-2016 Timo Sintonen
   Licence: gpl v3+
*/
/** This file defines the gpio register structure. There are also functions 
 * to configure i/o pins and sinple read and write.
 * Before using any gpio port, its clock has to be enabled in rcc nmodule.

*/ 
import rccm;
import volatil3;

// These are the gpio addresses in stm32f407
// In other stm32 processors gpio may be in different address
enum gpioreg * gpioa= cast(gpioreg *)0x40020000;
enum gpioreg * gpiob= cast(gpioreg *)0x40020400;
enum gpioreg * gpioc= cast(gpioreg *)0x40020800;
enum gpioreg * gpiod= cast(gpioreg *)0x40020c00;
enum gpioreg * gpioe= cast(gpioreg *)0x40021000;
// same way gpiof...gpioi if needed


/** Helper function for gpio configuration bits   
* for every bit set in bits, set the 2 or 4 bit bitfield to n
* Return value is the bitfield and mask is the corresponding
* bit mask.
*/
private uint shift2 (int bits, int n, out uint mask) {
   uint result=0;
   mask=0;
   for (int f=0x8000; f>0; f>>=1) {
      mask<<=2;
      result<<=2;
      if ((bits&f)>0) { 
	 result|=n;
	 mask|=3;
      }
   }
   return result;
}

/// Ditto
private uint shift4 (int bits, int n, out uint mask) {
   uint result=0;
   mask=0;
   for (int f=0x8000; f>0; f>>=1) {
      mask<<=4;
      result<<=4;
      if ((bits&f)>0) {
	 result|=n;
	 mask|=15;
      }
   }
   return result;
}

// pin configuration values
enum MODE   : int { i=0, o, a, n }
enum OTYPE  : int { pp=0, od }
enum OSPEED : int { low=0, med, fast, high }
enum PULL   : int { no=0, up, down }

   
struct gpioreg {
   Volatile!uint moder;
   Volatile!uint otyper;
   Volatile!uint ospeedr;
   Volatile!uint pupdr;
   Volatile!uint idr;
   Volatile!uint odr;
   Volatile!uint bsrr;
   Volatile!uint lockr;
   Volatile!uint afrl;
   Volatile!uint afrh;
   
   /** Configure pins in a gpio port.
   * Pins is a bitmask
   * For example: 0x0130 configures pins 4,5,and 8
   */
   void pinconf(int pins, MODE mode, OTYPE otype, OSPEED speed, 
		PULL pull=PULL.no, int af=0)  {
      
      uint mask=void;
      
      // mode
      uint r=shift2(pins,mode,mask);
      moder&=~mask;
      moder|=r;
      // otype
      if (otype) otyper|=pins;
      else       otyper&=~pins;
      // ospeed
      r=shift2(pins,speed,mask);
      ospeedr&=~mask;
      ospeedr|=r;
      // pull
      r=shift2(pins,pull,mask);
      pupdr&=~mask;
      pupdr|=r;
      // af
      r=shift4(pins,af,mask);
      afrl&=~mask;
      afrl|=r;
      r=shift4(pins>>8,af,mask);
      afrh&=~mask;
      afrh|=r;
      
   }
   
   /// helper functions to configure one pin to the most common states.
   // pin is 0..15
   void pinconfI (int pin) {
      pinconf (1<<pin, MODE.i, OTYPE.pp, OSPEED.low, PULL.down);
   }
   
   void pinconfO (int pin) {
      pinconf(1<<pin, MODE.o, OTYPE.pp, OSPEED.med, PULL.no);
   }
   
   void pinconfAF (int pin, int af) {
      pinconf(1<<pin, MODE.a, OTYPE.pp, OSPEED.med, PULL.no, af);
   }
   
   void pinconfAN (int pin) {
      pinconf(1<<pin, MODE.n, OTYPE.pp, OSPEED.low, PULL.no);
   }
   
   ///getter and setter functions for the whole port
   void write(int data) {
      odr=data;
   }
   
   int read() {
      return idr;
   }
   
   int readout() {
      return odr;
   }
   
   /// Atomic bit set and reset
   void bitset(uint bits) {
      bsrr=bits;
   }
   /// Ditto
   void bitreset(uint bits) {
      bsrr=bits<<16;
   }
   
   
}  // struct
   

/** Basic initialization of the gpio pins for the test hardware.
* After power on reset all pins are inputs but this may not be the case
* in "warm start". Wrong mode of pins may cause damage to 
* the processor or other hardware.
* This should set all pins to some meaningful state.
*
* This is called at the beginning of C main 
* The runtime system may not be fully initialized at this point.
* This should not call anything that depends on that.
*/    
void gpioinit() {
   rcc.cr=0;
   version(STM32F41x) {
     rcc.ahb1enr |= 3;   // enable gpio a-b clocks only
   } else {
     rcc.ahb1enr |= 0x1ff;  // enable all gpio clocks in 407
   }
   
   
   // The test hardware has debug port in UART3 in pins B10-B11 if f407 processor.
   // In f411 uart1 is used.
   // Uart pins are configured here so we can get debug info out
   // as soon as possible
   // (uart3 can also be mapped to c10-c11)
   version (STM32F41x) {
      rcc.apb2enr |= 0x10; // enable uart1 clock
      
      gpioa.pinconfAF(9,7);  // a9-a10 are uart1 pins
      gpioa.pinconfAF(10,7);
   } else {
   
      rcc.apb1enr |= 0x00060000u;  // enable uart 2 and 3 clocks
      
      // configure b10-11 and c10-11 as af and uart3
      // The general way:
      //gpioc.pinconf(0x0c00, MODE.a,OTYPE.pp,OSPEED.med,PULL.no,7);
      //gpiob.pinconf(0x0c00, MODE.a,OTYPE.pp,OSPEED.med,PULL.no,7);
      // Using helper functions:
      gpiob.pinconfAF(10,7);
      gpiob.pinconfAF(11,7);
      gpioc.pinconfAF(10,7);
      gpioc.pinconfAF(11,7);
   }

   // the test device has led in gpioa0
   // it is configured here
   gpioa.pinconfO(0);
   gpioa.odr|=1;  // led on
}

