/** Basic memory and string functions
*
* copyright: 2013-2016 Timo Sintonen
* licence: gpl v3+
* 
* These routines are usually in the c library
* These may be built-in functions in gcc, but for many targets they are not
* Remove these if your gcc version has them.
*/  
typedef unsigned char u8;
typedef unsigned int  size_t;

void *memcpy(void *dest, const void *src, size_t n) 
{
   int f;
   u8 g;
   u8 *d,*s;
   d=(u8 *)dest,s=(u8 *)src;
   for (f=0;f<n;f++) 
     {  g=*s; 
        *d=g;
	d++; s++;
     }
   return dest;
}

void * memmove(void *dest, const void *src, size_t n) {
   if ( (dest < src) || (dest > (src+n)) ) // check that areas do not overlap
     return memcpy(dest,src,n);

   unsigned int f;
   u8 g;
   u8 *d,*s;
   d=(u8 *)dest,s=(u8 *)src;
   for (f=n-1;f>=0;f--) 
     {  g=*s; 
        *d=g;
	d++; s++;
     }
   return dest;

   
}

void *memset(void *dest, int c, size_t n) {
   unsigned int f;
   u8 *d; 
   d=(u8*)dest;
   for (f=0;f<n;f++) 
     {  d[f]=c;  
     }
   return dest;
}

int memcmp(const void *p1, const void *p2, size_t n) {
   int f;
   u8 *pp1=(u8 *)p1,*pp2=(u8 *)p2;
   for (f=0;f<n;f++) {
      if ((*pp1)==(*pp2)) continue;
      if ((*pp1)<(*pp2)) return -1;
      return 1;
   }
   return 0;
}


size_t strlen (const char *src) {
   char *s=(char *)src;
   char m;
   while (1) {
      m=*s; 
      if (m==0) break;
      s++;
   }
   return (size_t)(s-src);
}

char *strncpy(char *dest, const char *src, size_t n) 
{
   size_t i;
   
   for (i=0; i<n && src[i] != '\0' ; i++)  
	dest[i]=src[i];
   for (; i<n ; i++)
     dest[i]= '\0';
   dest[n]=0;
   return dest;
}

char *strcpy(char *dest, const char *src )
{
   size_t i;
   
   for (i=0; src[i] != '\0' ; i++)  
	dest[i]=src[i];
   
   dest[i]= '\0';
   return dest;
}

char * strchr (s, c)
register const char *s;
int c; {
   do 
     {
	if (*s == c)
	  return (char*)s;
	
     }
   while (*s++);
   return (0);
}


int strncmp(const char *s1, const char *s2, size_t n)
{
   
   if (n == 0)
     return (0);
   do
     {
	if (*s1 != *s2++)
	  return (*(const unsigned char *)s1 - *(const unsigned char *)(s2 - 1));
	if (*s1++ == 0)
	  break;
     }
   while (--n != 0);
   return (0);
}


int strcmp(const char *s1, const char *s2)
{
   
   do
     {
	if (*s1 != *s2++)
	  return (*(const unsigned char *)s1 - *(const unsigned char *)(s2 - 1));
	if (*s1++ == 0)
	  break;
     }
   while (1);
   return (0);
}

  
char *strstr (const char * str1,const char * str2)  {
   char *cp = (char *) str1;
   char *s1, *s2;
   
   if ( !*str2 )
     return((char *)str1);
   while (*cp) 
     {
	
	s1 = cp;
	s2 = (char *) str2;
	
	while ( *s1 && *s2 && !(*s1-*s2) )
	  s1++, s2++;
	
	if (!*s2)
	  return(cp);
	
	cp++;
     }
   return(0);
}

 

