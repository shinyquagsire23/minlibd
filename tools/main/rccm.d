/** STM32F4 rcc module definition
 * copyright: 2016 Timo Sintonen
 * license: gpl v3+
 * 
 * The rcc module has two parts.
 * The first set of registers are used to configure the clock oscillators
 * and the second set are used to enable clocks to individual peripherals.
 * 
 * 
 */
module rcc1;

import volatil3;

enum rccregs * rcc=cast(rccregs *)0x40023800;

 // This register set is valid only for STM32F405/407/415/417
struct rccregs {
   @disable this();
   @disable this(this);
   
   Volatile!uint cr;
   Volatile!uint pllgfgr;
   Volatile!uint cfgr;
   Volatile!uint cir;
   Volatile!uint ahb1rstr; // 0x10  peripheral reset
   Volatile!uint ahb2rstr;
   Volatile!uint ahb3rstr;
   int dummy1;
   Volatile!uint apb1rstr;  
   Volatile!uint apb2rstr;
   int dummy2;
   int dummy3;
   Volatile!uint ahb1enr;  // 0x30 peripheral enable
   Volatile!uint ahb2enr;
   Volatile!uint ahb3enr;
   int dummy4;
   Volatile!uint apb1enr;
   Volatile!uint apb2enr;
   int dummy5;
   int dummy6;
   Volatile!uint ahb1lpenr; //  0x50 peripheral enable in low power mode
   Volatile!uint ahb2lpenr;
   Volatile!uint ahb3lpenr;
   int dummy7;
   Volatile!uint apb1lpenr;
   Volatile!uint apb2lpenr;
   int dummy8;
   int dummy9;
   Volatile!uint bdcr; // 0x70
   Volatile!uint csr;
   Volatile!uint sscgr;
   Volatile!uint plli2scfgr;
}

