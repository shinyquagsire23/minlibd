/** A simple malloc
 * 
   Copyright: 2013-2016 TImo Sintonen
   License:   GPL v3+
   
This is a very simple memory allocation program. This may be very stupid but
I wrote this from scratch and so I can copyright it and give it whatever 
license I want.

This file has the minimum set gdc needs: malloc, calloc, realloc and free.
They work just like those in the standard c library. 
 
  
How this works.
 
There is a table that holds the addresses of the allocated blocks.
All blocks are 4 byte aligned, so the 2 smallest bits are not used.
The smallest bit is used to mark the entry reserved. The last used entry in
the table (initially the first one) always keeps the start of free space.
  
When a new block is allocated with malloc, the table is scanned for a free
item that has the smallest bit cleared. When one is found, its size is
checked by fetching the next table item. If that one has an address, the
biggest possible size is calculated and compared to the requested size.
If the block fit, the current item is marked reserved by setting the smallest
bit and the address is returned. If the block does not fit, scan continues.

If, on the other hand, the next item is zero this means that this item is the
last and the whole memory after this address is free. This address
is reserved and returned. The first free address after this block is put to
the next table entry.

 
*/

// The region of memory that is available
// These default values work in stm32f407
#define MEMSTART 0x20010000
#define MEMEND   0x2001C000
/* It is easier to debug when these values are fixed. 
 * This could be made so that the heap starts just after stack (_estack ) and
 * the end is the actual end of ram, which can be set in processor definition
 * file or fetched at runtime.
*/


// how many entries there is in the allcation table
#define TABLESIZE 256
// the biggest block that is possible to allocate
#define MAXBLOCK 4096
// 

int memtable[TABLESIZE];  // allocation table
static int count;         // number of allocated blocks (only for debug) 
static int memptr;   // pointer to the end of allocated area (only for debug) 

int getmptr() { // only for debug
   return memptr;
}

void meminit(){
   int f;
   for (f=0;f<TABLESIZE;f++) memtable[f]=0;  // zero the table 
   count=0; // only for debug
   memtable[0]=memptr=MEMSTART;    
}


void *malloc(unsigned int n) {
   int f;
   int p1,p2;
   
   if (n&3) n=(n|3)+1;  // align 4
   if ( (n<1) || (n>MAXBLOCK) ) return 0;  
   

   for (f=0;f<TABLESIZE-1;f++) {  // scan the table for a free item
      p1=memtable[f];
      if (p1&1) continue;  //  Reserved if bit 0 =1
      // else the table item is free
      p2=memtable[f+1];   // The next item in the table
      if ( (p2==0) || (p2-p1)>=n) { // If the next item is zero this is the
	 // last one and everything after this is free. Otherwise check 
	 // how much there is space before next block.
	 
	 // A free space found. Check if there is enough memory left.
	 if ((p1+n)>MEMEND) return 0;  
	 memtable[f] |=1; // Mark this block reserved
	 if (p2==0) memtable[f+1] = p1+n; // If this was the last block 
	 // put the end address of this block to the next table item.
 
	 return (void *)p1; // Return the pointer to the allocated block.
      }

   }  //for

    // if the program gets here, the table was full or there was no
    // free block that is big enough
   return 0;
}


void free( void *p) {
   if ( ((int)p<MEMSTART) || ((int)p>=MEMEND) ) return;
   int f;
   for (f=0;f<TABLESIZE;f++) 
     if ((int)p==(memtable[f]&0xfffffffe)) 
       memtable[f] &=0xfffffffe; // mark the item free by zeroing bit 0
}

void *realloc ( void *p, unsigned int n) {
   int f;
   for (f=0;f<TABLESIZE;f++) { // try to find the pointer in the table
      int p1=memtable[f]&0xfffffffe; // 
      if ( p1==(int)p) {                    // found the place? 
	 int p2=memtable[f+1]&0xfffffffe; // The address of next block
	 int siz=p2-p1; // The size of the area(next-this)
	              // (The gap between the pointers may not be the same
		      // than the allocated length)
	 if (siz<=n) return (void *)p1;  // If current block is big enough
	                         // for the new size, do nothing,
	 void *p3 =malloc(n);    // else try to allocate a new one
	 if (p3==0) return 0;    // Alloction failed?
	 memcpy((void *)p3,(const void *)p1,siz);// Move data to the new block
	 memtable[f]&=0xfffffffe; // Free the old block
	 return p3;              // Return the new pointer
      }
   }
   return 0; 
}

void *calloc( unsigned int n, unsigned int s) {
   if ((n<=0) || (s<=0) ) return 0;
   void *t=malloc(n*s);
   if (t) memset(t,0,n*s);
   return t;
}
