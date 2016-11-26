// GDC -- D front-end for GCC
// Copyright (C) 2011, 2012, 2014 Free Software Foundation, Inc.

// GCC is free software; you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free
// Software Foundation; either version 3, or (at your option) any later
// version.

// GCC is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
// for more details.

// You should have received a copy of the GNU General Public License
// along with GCC; see the file COPYING3.  If not see
// <http://www.gnu.org/licenses/>.

// This code is based on the libstdc++ exception handling routines.

module gcc.deh;

import gcc.unwind;
//import gcc.unwind.pe;
import gcc.builtins;
import gcc.config;

extern(C)
{
  int _d_isbaseof(ClassInfo, ClassInfo);
  void _d_createTrace(Object *, void *);
}

// Perform a throw, D style. Throw will unwind through this call,
// so there better not be any handlers or exception thrown here.

extern(C) void
_d_throw(Object o)
{
}

extern(C) void __gdc_begin_catch()
{
}
