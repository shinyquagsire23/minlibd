/**
 * D header file for C99.
 *
 * $(C_HEADER_DESCRIPTION pubs.opengroup.org/onlinepubs/009695399/basedefs/_stddef.h.html, _stddef.h)
 *
 * Copyright: Copyright Sean Kelly 2005 - 2009.
 * License: Distributed under the
 *      $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost Software License 1.0).
 *    (See accompanying file LICENSE)
 * Authors:   Sean Kelly
 * Source:    $(DRUNTIMESRC core/stdc/_stddef.d)
 * Standards: ISO/IEC 9899:1999 (E)
 */

module core.stdc.stddef;

extern (C):
@trusted: // Types only.
nothrow:
@nogc:

// size_t and ptrdiff_t are defined in the object module.

version( Windows )
{
    ///
    alias wchar wchar_t;
}
else version( Posix )
{
    ///
    alias dchar wchar_t;
}
alias dchar wchar_t;