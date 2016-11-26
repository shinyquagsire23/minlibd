/** These funtions deal with fatal errors.
 * Copyright: 2013-2016 Timo Sintonen
 * License: gpl v3+
 * 
 */

/** This function is usually found in standard c library. 
 * The program call this when a fatal error has occurred, like and error or
 * an uncaught exception is thrown. Also asserts ends here. (asserts are 
 * ignored when the program is compiled with -release flag)
 * In desktop programs this just ends the program and returns to the system,
 * but it is not possible here. The options usually are to stop here or 
 * restart the program. It is possible to print some debug info. It has to be 
 * remembered that at this point the program may be in totally invalid state
 * and may not be able to do anything.
 * You can add here what you want to do in this situation.
 * Note that this function can not return.
 */

void abort() {
   while (1);  // stop
}


/** All interrupts in this project are by default aliases to Default_Handler.
 * These are weak aliases. To use an interrupt, all that is needed is to define
 * a function with correct name and this will override the weak alias.
 * Default_Handler is defined in the startup file like the interrupt vectors.
 * Currently the hander just stops there. By putting a jump to this handler
 * it is possible to add code to get information why the interrupt occurred.
 * However, the program may be in an invalid state at this point.
 * Currently this is not used by default.
 * Note that there is no message if an interrupt handler does not have correct
 * name. It just does not override the alias and default hadler is called.
 */
/*
void default_handler()
 {
 
 }

 */
