/* 
 * A simple main program. 
 * Copyright: 2013-2016 Timo Sintonen
 * Licence:   GPL v3+
 * 
 * This file contains the C main routine and a simple D main program.
 * 
*/

// D imports
import tls;   // tls initialization and tls pointer   
import uart;  // using stm32 uart for debug
import core.memory; // free
import gpio;

extern (C) {
// imported C functions


void SystemCoreClockUpdate(); // this is in startup directory

void meminit();

// The c main program. This is called from the startup file.   
// Before entering main, the processor clock, memory
// controller (if any) and global data memory should have been initialized
// so that it is possible to run a C program.
// Main should at least initialize the tls memory so that we can call the
// D main routine. Main may also initialize hardware and system modules like
// interrupt controller.  

int main() {
   SystemCoreClockUpdate(); // gets the clock value
   gpioinit();     // i/o pin configuration

   meminit();     // initializes the malloc table
   tlsinit();     // tls for this thread
   //  ready to call the D main routine
   dmain(); 

   return 0; 
} // main

} // extern c



// global variables in module level
int t1=0x12345678;  // this goes to tdata
int t2;             // this goes to tbss
__gshared int t3=5; // this goes to data  
__gshared int t4;   // this goes to bss

testclass c1,c2,c3; // class pointers are in tbss

// The D main routine

void dmain() {
   
   uart3.conf(115200,1,8);
   // NOTE: the uart is configured to 8 bits _plus_ parity because this is
   // what the stm32 bootloader uses
   uart3.send(0x0d);  // just some debug dump
   uart3.send(0x55);

   uart3.sendhex(0x1234,4);
   uart3.sendtext(" abcdefg ");
   
   testclass.n=0x41;  // static variable
   uart3.sendhex(cast(int)&testclass.n,8); // the address of it
   testclass.testi(0x35);  // static function

   c1=new testclass();  

   c1.n2=0x42;

   c1.Test(0x4c);

   int a=0,b=0; // some test variables
   
   while (a>-1){  // this should be while(true) but it has to be
   // something that changes inside the loop. Otherwise it is just
   // optimized away and the program does not work
      if (b<10000000){ 
	 b++;             // a delay loop
	 continue;  
      }
      
      // Exception test. NOTE: this will fail after running
      // a while because of memory leak in throw.
 
      try {  
	 exctest(a); // generates an exception every 4th time
      }  catch  (Exception e) {
	 uart3.sendtext("catch :");
	 uart3.sendtext(e.msg);
	 // Do not use e.toString. This allocates several times and
	 // those are never freed.
	 GC.free(&e); // this must be freed manually 
      }
      
      uart3.send(0x0d);
      c1.Test(a);
      a++;  
      b=0;
      
   }

 
} // dmain


class testclass {

// a static variable goes to tls
public static int n;
// an instance variable
public int n2;

   
this() {
   n=1234;
   n2=0x74;
}

// static function can access only static data   
static int testi(int m) {
 uart3.send(n);
 uart3.send(m);
 return m;
 }
   
int Test(int m) {  // just some test
 
   uart3.send(n2);
   uart3.sendhex(m,4);
  return m; 
}   

}

void exctest(int t) { // testing exceptions
   if ((t&3)==3) { 
      uart3.sendtext("throw ");
   //   throw new Exception("My error ");
   // currently exceptions are not working
   }
}


