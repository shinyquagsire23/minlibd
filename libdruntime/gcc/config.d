/* GDC -- D front-end for GCC
   Copyright (C) 2015 Free Software Foundation, Inc.

   GCC is free software; you can redistribute it and/or modify it under
   the terms of the GNU General Public License as published by the Free
   Software Foundation; either version 3, or (at your option) any later
   version.

   GCC is distributed in the hope that it will be useful, but WITHOUT ANY
   WARRANTY; without even the implied warranty of MERCHANTABILITY or
   FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
   for more details.

   You should have received a copy of the GNU General Public License
   along with GCC; see the file COPYING3.  If not see
   <http://www.gnu.org/licenses/>.
*/

module gcc.config;

// Does platform define __ARM_EABI_UNWINDER__
enum GNU_ARM_EABI_Unwinder = 1;

// Map from thread model to thread interface.
enum ThreadModel
{
    Single,
    Posix,
    Win32,
}

enum ThreadModel GNU_Thread_Model = ThreadModel.Single;
