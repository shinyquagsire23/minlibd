/** This module defines the Volatile data type which is used to access
 * peripheral registers
 * Copyright: 2016 Timo Sintonen
 * License:   gpl v3+
 * It has been decicided that all volatile related will be placed to file
 * volatile.d when the keyword comes available.
 * The name of this module will change then.
 */

module volatil3;

import core.bitop;  // current location of volatile stuff
  
struct Volatile(T) {
     T raw;
     nothrow: 

     A opAssign(A)(A a) { volatileStore(&raw, a); return a; }
     T load() @property { return volatileLoad(&raw); }
     alias load this;
     void opOpAssign(string OP)(const T rhs) {
          auto v = volatileLoad(&raw);
          mixin("v " ~ OP ~ "= rhs;");
          volatileStore(&raw, v);
     }
}
