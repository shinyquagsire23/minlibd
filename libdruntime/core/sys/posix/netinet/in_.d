/**
 * D header file for POSIX.
 *
 * Copyright: Copyright Sean Kelly 2005 - 2009.
 * License:   $(WEB www.boost.org/LICENSE_1_0.txt, Boost License 1.0).
 * Authors:   Sean Kelly
 * Standards: The Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition
 */

/*          Copyright Sean Kelly 2005 - 2009.
 * Distributed under the Boost Software License, Version 1.0.
 *    (See accompanying file LICENSE or copy at
 *          http://www.boost.org/LICENSE_1_0.txt)
 */
module core.sys.posix.netinet.in_;

private import core.sys.posix.config;
public import core.stdc.inttypes; // for uint32_t, uint16_t, uint8_t
public import core.sys.posix.arpa.inet;
public import core.sys.posix.sys.socket; // for sa_family_t

version (Posix):
extern (C) nothrow @nogc:

//
// Required
//
/*
NOTE: The following must must be defined in core.sys.posix.arpa.inet to break
      a circular import: in_port_t, in_addr_t, struct in_addr, INET_ADDRSTRLEN.

in_port_t
in_addr_t

sa_family_t // from core.sys.posix.sys.socket
uint8_t     // from core.stdc.inttypes
uint32_t    // from core.stdc.inttypes

struct in_addr
{
    in_addr_t   s_addr;
}

struct sockaddr_in
{
    sa_family_t sin_family;
    in_port_t   sin_port;
    in_addr     sin_addr;
}

IPPROTO_IP
IPPROTO_ICMP
IPPROTO_TCP
IPPROTO_UDP

INADDR_ANY
INADDR_BROADCAST

INET_ADDRSTRLEN

htonl() // from core.sys.posix.arpa.inet
htons() // from core.sys.posix.arpa.inet
ntohl() // from core.sys.posix.arpa.inet
ntohs() // from core.sys.posix.arpa.inet
*/

version( CRuntime_Glibc )
{
    // Some networking constants are subtly different for glibc, linux kernel
    // constants are also provided below.

    //alias uint16_t in_port_t;
    //alias uint32_t in_addr_t;

    //struct in_addr
    //{
    //    in_addr_t s_addr;
    //}

    private enum __SOCK_SIZE__ = 16;

    struct sockaddr_in
    {
        sa_family_t sin_family;
        in_port_t   sin_port;
        in_addr     sin_addr;

        /* Pad to size of `struct sockaddr'. */
        ubyte[__SOCK_SIZE__ - sa_family_t.sizeof -
              in_port_t.sizeof - in_addr.sizeof] __pad;
    }

    enum
    {
        IPPROTO_IP   = 0,
        IPPROTO_ICMP = 1,
        IPPROTO_IGMP = 2,
        IPPROTO_GGP  = 3,
        IPPROTO_TCP  = 6,
        IPPROTO_PUP  = 12,
        IPPROTO_UDP  = 17,
        IPPROTO_IDP  = 22,
        IPPROTO_ND   = 77,
        IPPROTO_MAX  = 256
    }

    enum : uint
    {
        INADDR_ANY       = 0x00000000,
        INADDR_BROADCAST = 0xffffffff,
        INADDR_LOOPBACK  = 0x7F000001,
        INADDR_NONE      = 0xFFFFFFFF
    }

    //enum INET_ADDRSTRLEN       = 16;
}
else version( OSX )
{
    //alias uint16_t in_port_t;
    //alias uint32_t in_addr_t;

    //struct in_addr
    //{
    //    in_addr_t s_addr;
    //}

    private enum __SOCK_SIZE__ = 16;

    struct sockaddr_in
    {
        ubyte       sin_len;
        sa_family_t sin_family;
        in_port_t   sin_port;
        in_addr     sin_addr;
        ubyte[8]    sin_zero;
    }

    enum
    {
        IPPROTO_IP   = 0,
        IPPROTO_ICMP = 1,
        IPPROTO_IGMP = 2,
        IPPROTO_GGP  = 3,
        IPPROTO_TCP  = 6,
        IPPROTO_PUP  = 12,
        IPPROTO_UDP  = 17,
        IPPROTO_IDP  = 22,
        IPPROTO_ND   = 77,
        IPPROTO_MAX  = 256
    }

    enum : uint
    {
        INADDR_ANY       = 0x00000000,
        INADDR_BROADCAST = 0xffffffff,
        INADDR_LOOPBACK  = 0x7F000001,
        INADDR_NONE      = 0xFFFFFFFF
    }

    //enum INET_ADDRSTRLEN       = 16;
}
else version( FreeBSD )
{
    //alias uint16_t in_port_t;
    //alias uint32_t in_addr_t;

    //struct in_addr
    //{
    //    in_addr_t s_addr;
    //}

    struct sockaddr_in
    {
        ubyte       sin_len;
        sa_family_t sin_family;
        in_port_t   sin_port;
        in_addr     sin_addr;
        ubyte[8]    sin_zero;
    }

    enum
    {
        IPPROTO_IP   = 0,
        IPPROTO_ICMP = 1,
        IPPROTO_IGMP = 2,
        IPPROTO_GGP  = 3,
        IPPROTO_TCP  = 6,
        IPPROTO_PUP  = 12,
        IPPROTO_UDP  = 17,
        IPPROTO_IDP  = 22,
        IPPROTO_ND   = 77,
        IPPROTO_MAX  = 256
    }

    enum : uint
    {
        INADDR_ANY       = 0x00000000,
        INADDR_BROADCAST = 0xffffffff,
        INADDR_LOOPBACK  = 0x7f000001,
        INADDR_NONE      = 0xffffffff
    }

    //enum INET_ADDRSTRLEN       = 16;
}
else version( Solaris )
{
    struct sockaddr_in
    {
        sa_family_t sin_family;
        in_port_t   sin_port;
        in_addr     sin_addr;
        ubyte[8]    sin_zero;
    }

    enum
    {
        IPPROTO_IP   = 0,
        IPPROTO_ICMP = 1,
        IPPROTO_IGMP = 2,
        IPPROTO_GGP  = 3,
        IPPROTO_TCP  = 6,
        IPPROTO_PUP  = 12,
        IPPROTO_UDP  = 17,
        IPPROTO_IDP  = 22,
        IPPROTO_ND   = 77,
        IPPROTO_MAX  = 256
    }

    enum : uint
    {
        INADDR_ANY       = 0x00000000,
        INADDR_BROADCAST = 0xffffffff,
        INADDR_LOOPBACK  = 0x7f000001,
        INADDR_NONE      = 0xffffffff
    }
}
else version( linux )
{
    private enum __SOCK_SIZE__ = 16;

    struct sockaddr_in
    {
        sa_family_t sin_family;
        ushort      sin_port;
        in_addr     sin_addr;

        /* Pad to size of `struct sockaddr'. */
        ubyte[__SOCK_SIZE__ - sa_family_t.sizeof -
              ushort.sizeof - in_addr.sizeof] __pad;
    }

    enum
    {
        IPPROTO_IP   = 0,
        IPPROTO_ICMP = 1,
        IPPROTO_IGMP = 2,
        IPPROTO_GGP  = 3,
        IPPROTO_TCP  = 6,
        IPPROTO_PUP  = 12,
        IPPROTO_UDP  = 17,
        IPPROTO_IDP  = 22
    }

    enum : c_ulong
    {
        INADDR_ANY       = 0x00000000,
        INADDR_BROADCAST = 0xffffffff,
        INADDR_NONE      = 0xFFFFFFFF
    }
}


//
// IPV6 (IP6)
//
/*
NOTE: The following must must be defined in core.sys.posix.arpa.inet to break
      a circular import: INET6_ADDRSTRLEN.

struct in6_addr
{
    uint8_t[16] s6_addr;
}

struct sockaddr_in6
{
    sa_family_t sin6_family;
    in_port_t   sin6_port;
    uint32_t    sin6_flowinfo;
    in6_addr    sin6_addr;
    uint32_t    sin6_scope_id;
}

extern in6_addr in6addr_any;
extern in6_addr in6addr_loopback;

struct ipv6_mreq
{
    in6_addr    ipv6mr_multiaddr;
    uint        ipv6mr_interface;
}

IPPROTO_IPV6

INET6_ADDRSTRLEN

IPV6_JOIN_GROUP
IPV6_LEAVE_GROUP
IPV6_MULTICAST_HOPS
IPV6_MULTICAST_IF
IPV6_MULTICAST_LOOP
IPV6_UNICAST_HOPS
IPV6_V6ONLY

// macros
int IN6_IS_ADDR_UNSPECIFIED(in6_addr*)
int IN6_IS_ADDR_LOOPBACK(in6_addr*)
int IN6_IS_ADDR_MULTICAST(in6_addr*)
int IN6_IS_ADDR_LINKLOCAL(in6_addr*)
int IN6_IS_ADDR_SITELOCAL(in6_addr*)
int IN6_IS_ADDR_V4MAPPED(in6_addr*)
int IN6_IS_ADDR_V4COMPAT(in6_addr*)
int IN6_IS_ADDR_MC_NODELOCAL(in6_addr*)
int IN6_IS_ADDR_MC_LINKLOCAL(in6_addr*)
int IN6_IS_ADDR_MC_SITELOCAL(in6_addr*)
int IN6_IS_ADDR_MC_ORGLOCAL(in6_addr*)
int IN6_IS_ADDR_MC_GLOBAL(in6_addr*)
*/

version ( CRuntime_Glibc )
{
    struct in6_addr
    {
        union
        {
            uint8_t[16] s6_addr;
            uint16_t[8] s6_addr16;
            uint32_t[4] s6_addr32;
        }
    }

    struct sockaddr_in6
    {
        sa_family_t sin6_family;
        in_port_t   sin6_port;
        uint32_t    sin6_flowinfo;
        in6_addr    sin6_addr;
        uint32_t    sin6_scope_id;
    }

    extern __gshared immutable in6_addr in6addr_any;
    extern __gshared immutable in6_addr in6addr_loopback;

    struct ipv6_mreq
    {
        in6_addr    ipv6mr_multiaddr;
        uint        ipv6mr_interface;
    }

    enum : uint
    {
        IPPROTO_IPV6        = 41,

        //INET6_ADDRSTRLEN    = 46,

        IPV6_JOIN_GROUP     = 20,
        IPV6_LEAVE_GROUP    = 21,
        IPV6_MULTICAST_HOPS = 18,
        IPV6_MULTICAST_IF   = 17,
        IPV6_MULTICAST_LOOP = 19,
        IPV6_UNICAST_HOPS   = 16,
        IPV6_V6ONLY         = 26
    }

    // macros
    extern (D) int IN6_IS_ADDR_UNSPECIFIED( in6_addr* addr ) pure
    {
        return (cast(uint32_t*) addr)[0] == 0 &&
               (cast(uint32_t*) addr)[1] == 0 &&
               (cast(uint32_t*) addr)[2] == 0 &&
               (cast(uint32_t*) addr)[3] == 0;
    }

    extern (D) int IN6_IS_ADDR_LOOPBACK( in6_addr* addr ) pure
    {
        return (cast(uint32_t*) addr)[0] == 0  &&
               (cast(uint32_t*) addr)[1] == 0  &&
               (cast(uint32_t*) addr)[2] == 0  &&
               (cast(uint32_t*) addr)[3] == htonl( 1 );
    }

    extern (D) int IN6_IS_ADDR_MULTICAST( in6_addr* addr ) pure
    {
        return (cast(uint8_t*) addr)[0] == 0xff;
    }

    extern (D) int IN6_IS_ADDR_LINKLOCAL( in6_addr* addr ) pure
    {
        return ((cast(uint32_t*) addr)[0] & htonl( 0xffc00000 )) == htonl( 0xfe800000 );
    }

    extern (D) int IN6_IS_ADDR_SITELOCAL( in6_addr* addr ) pure
    {
        return ((cast(uint32_t*) addr)[0] & htonl( 0xffc00000 )) == htonl( 0xfec00000 );
    }

    extern (D) int IN6_IS_ADDR_V4MAPPED( in6_addr* addr ) pure
    {
        return (cast(uint32_t*) addr)[0] == 0 &&
               (cast(uint32_t*) addr)[1] == 0 &&
               (cast(uint32_t*) addr)[2] == htonl( 0xffff );
    }

    extern (D) int IN6_IS_ADDR_V4COMPAT( in6_addr* addr ) pure
    {
        return (cast(uint32_t*) addr)[0] == 0 &&
               (cast(uint32_t*) addr)[1] == 0 &&
               (cast(uint32_t*) addr)[2] == 0 &&
               ntohl( (cast(uint32_t*) addr)[3] ) > 1;
    }

    extern (D) int IN6_IS_ADDR_MC_NODELOCAL( in6_addr* addr ) pure
    {
        return IN6_IS_ADDR_MULTICAST( addr ) &&
               ((cast(uint8_t*) addr)[1] & 0xf) == 0x1;
    }

    extern (D) int IN6_IS_ADDR_MC_LINKLOCAL( in6_addr* addr ) pure
    {
        return IN6_IS_ADDR_MULTICAST( addr ) &&
               ((cast(uint8_t*) addr)[1] & 0xf) == 0x2;
    }

    extern (D) int IN6_IS_ADDR_MC_SITELOCAL( in6_addr* addr ) pure
    {
        return IN6_IS_ADDR_MULTICAST(addr) &&
               ((cast(uint8_t*) addr)[1] & 0xf) == 0x5;
    }

    extern (D) int IN6_IS_ADDR_MC_ORGLOCAL( in6_addr* addr ) pure
    {
        return IN6_IS_ADDR_MULTICAST( addr) &&
               ((cast(uint8_t*) addr)[1] & 0xf) == 0x8;
    }

    extern (D) int IN6_IS_ADDR_MC_GLOBAL( in6_addr* addr ) pure
    {
        return IN6_IS_ADDR_MULTICAST( addr ) &&
               ((cast(uint8_t*) addr)[1] & 0xf) == 0xe;
    }
}
else version( OSX )
{
    struct in6_addr
    {
        union
        {
            uint8_t[16] s6_addr;
            uint16_t[8] s6_addr16;
            uint32_t[4] s6_addr32;
        }
    }

    struct sockaddr_in6
    {
        uint8_t     sin6_len;
        sa_family_t sin6_family;
        in_port_t   sin6_port;
        uint32_t    sin6_flowinfo;
        in6_addr    sin6_addr;
        uint32_t    sin6_scope_id;
    }

    extern __gshared immutable in6_addr in6addr_any;
    extern __gshared immutable in6_addr in6addr_loopback;

    struct ipv6_mreq
    {
        in6_addr    ipv6mr_multiaddr;
        uint        ipv6mr_interface;
    }

    enum : uint
    {
        IPPROTO_IPV6        = 41,

        //INET6_ADDRSTRLEN    = 46,

        IPV6_JOIN_GROUP     = 12,
        IPV6_LEAVE_GROUP    = 13,
        IPV6_MULTICAST_HOPS = 10,
        IPV6_MULTICAST_IF   = 9,
        IPV6_MULTICAST_LOOP = 11,
        IPV6_UNICAST_HOPS   = 4,
        IPV6_V6ONLY         = 27
    }

    // macros
    extern (D) int IN6_IS_ADDR_UNSPECIFIED( in6_addr* addr ) pure
    {
        return (cast(uint32_t*) addr)[0] == 0 &&
               (cast(uint32_t*) addr)[1] == 0 &&
               (cast(uint32_t*) addr)[2] == 0 &&
               (cast(uint32_t*) addr)[3] == 0;
    }

    extern (D) int IN6_IS_ADDR_LOOPBACK( in6_addr* addr ) pure
    {
        return (cast(uint32_t*) addr)[0] == 0  &&
               (cast(uint32_t*) addr)[1] == 0  &&
               (cast(uint32_t*) addr)[2] == 0  &&
               (cast(uint32_t*) addr)[3] == ntohl( 1 );
    }

    extern (D) int IN6_IS_ADDR_MULTICAST( in6_addr* addr ) pure
    {
        return addr.s6_addr[0] == 0xff;
    }

    extern (D) int IN6_IS_ADDR_LINKLOCAL( in6_addr* addr ) pure
    {
        return addr.s6_addr[0] == 0xfe && (addr.s6_addr[1] & 0xc0) == 0x80;
    }

    extern (D) int IN6_IS_ADDR_SITELOCAL( in6_addr* addr ) pure
    {
        return addr.s6_addr[0] == 0xfe && (addr.s6_addr[1] & 0xc0) == 0xc0;
    }

    extern (D) int IN6_IS_ADDR_V4MAPPED( in6_addr* addr ) pure
    {
        return (cast(uint32_t*) addr)[0] == 0 &&
               (cast(uint32_t*) addr)[1] == 0 &&
               (cast(uint32_t*) addr)[2] == ntohl( 0x0000ffff );
    }

    extern (D) int IN6_IS_ADDR_V4COMPAT( in6_addr* addr ) pure
    {
        return (cast(uint32_t*) addr)[0] == 0 &&
               (cast(uint32_t*) addr)[1] == 0 &&
               (cast(uint32_t*) addr)[2] == 0 &&
               (cast(uint32_t*) addr)[3] != 0 &&
               (cast(uint32_t*) addr)[3] != ntohl( 1 );
    }

    extern (D) int IN6_IS_ADDR_MC_NODELOCAL( in6_addr* addr ) pure
    {
        return IN6_IS_ADDR_MULTICAST( addr ) &&
               ((cast(uint8_t*) addr)[1] & 0xf) == 0x1;
    }

    extern (D) int IN6_IS_ADDR_MC_LINKLOCAL( in6_addr* addr ) pure
    {
        return IN6_IS_ADDR_MULTICAST( addr ) &&
               ((cast(uint8_t*) addr)[1] & 0xf) == 0x2;
    }

    extern (D) int IN6_IS_ADDR_MC_SITELOCAL( in6_addr* addr ) pure
    {
        return IN6_IS_ADDR_MULTICAST(addr) &&
               ((cast(uint8_t*) addr)[1] & 0xf) == 0x5;
    }

    extern (D) int IN6_IS_ADDR_MC_ORGLOCAL( in6_addr* addr ) pure
    {
        return IN6_IS_ADDR_MULTICAST( addr) &&
               ((cast(uint8_t*) addr)[1] & 0xf) == 0x8;
    }

    extern (D) int IN6_IS_ADDR_MC_GLOBAL( in6_addr* addr ) pure
    {
        return IN6_IS_ADDR_MULTICAST( addr ) &&
               ((cast(uint8_t*) addr)[1] & 0xf) == 0xe;
    }
}
else version( FreeBSD )
{
    struct in6_addr
    {
        union
        {
            uint8_t[16] s6_addr;
            uint16_t[8] s6_addr16;
            uint32_t[4] s6_addr32;
        }
    }

    struct sockaddr_in6
    {
        uint8_t     sin6_len;
        sa_family_t sin6_family;
        in_port_t   sin6_port;
        uint32_t    sin6_flowinfo;
        in6_addr    sin6_addr;
        uint32_t    sin6_scope_id;
    }

    extern __gshared immutable in6_addr in6addr_any;
    extern __gshared immutable in6_addr in6addr_loopback;

    struct ipv6_mreq
    {
        in6_addr    ipv6mr_multiaddr;
        uint        ipv6mr_interface;
    }

    enum : uint
    {
        IPPROTO_IPV6        = 41,

        //INET6_ADDRSTRLEN    = 46,

        IPV6_JOIN_GROUP     = 12,
        IPV6_LEAVE_GROUP    = 13,
        IPV6_MULTICAST_HOPS = 10,
        IPV6_MULTICAST_IF   = 9,
        IPV6_MULTICAST_LOOP = 11,
        IPV6_UNICAST_HOPS   = 4,
        IPV6_V6ONLY         = 27,
    }

    private enum
    {
        __IPV6_ADDR_SCOPE_NODELOCAL     = 0x01,
        __IPV6_ADDR_SCOPE_INTFACELOCAL  = 0x01,
        __IPV6_ADDR_SCOPE_LINKLOCAL     = 0x02,
        __IPV6_ADDR_SCOPE_SITELOCAL     = 0x05,
        __IPV6_ADDR_SCOPE_ORGLOCAL      = 0x08,
        __IPV6_ADDR_SCOPE_GLOBAL        = 0x0e,
    }

    // macros
    extern (D) int IN6_IS_ADDR_UNSPECIFIED( in in6_addr* a ) pure
    {
        return (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[0]) == 0) &&
               (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[4]) == 0) &&
               (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[8]) == 0) &&
               (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[12]) == 0);
    }

    extern (D) int IN6_IS_ADDR_LOOPBACK( in in6_addr* a ) pure
    {
        return (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[0]) == 0) &&
               (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[4]) == 0) &&
               (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[8]) == 0) &&
               (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[12]) == ntohl(1));
    }

    extern (D) int IN6_IS_ADDR_V4COMPAT( in in6_addr* a ) pure
    {
        return (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[0]) == 0) &&
               (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[4]) == 0) &&
               (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[8]) == 0) &&
               (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[12]) != 0) &&
               (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[12]) != ntohl(1));
    }

    extern (D) int IN6_IS_ADDR_V4MAPPED( in in6_addr* a ) pure
    {
        return (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[0]) == 0) &&
               (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[4]) == 0) &&
               (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[8]) == ntohl(0x0000ffff));
    }

    extern (D) int IN6_IS_ADDR_LINKLOCAL( in in6_addr* a ) pure
    {
        return a.s6_addr[0] == 0xfe && (a.s6_addr[1] & 0xc0) == 0x80;
    }

    extern (D) int IN6_IS_ADDR_SITELOCAL( in in6_addr* a ) pure
    {
        return a.s6_addr[0] == 0xfe && (a.s6_addr[1] & 0xc0) == 0xc0;
    }

    extern (D) int IN6_IS_ADDR_MULTICAST( in in6_addr* a ) pure
    {
        return a.s6_addr[0] == 0xff;
    }

    extern (D) uint8_t __IPV6_ADDR_MC_SCOPE( in in6_addr* a ) pure
    {
        return a.s6_addr[1] & 0x0f;
    }

    extern (D) int IN6_IS_ADDR_MC_NODELOCAL( in in6_addr* a ) pure
    {
        return IN6_IS_ADDR_MULTICAST(a) &&
               __IPV6_ADDR_MC_SCOPE(a) == __IPV6_ADDR_SCOPE_NODELOCAL;
    }

    extern (D) int IN6_IS_ADDR_MC_LINKLOCAL( in in6_addr* a ) pure
    {
        return IN6_IS_ADDR_MULTICAST(a) &&
               __IPV6_ADDR_MC_SCOPE(a) == __IPV6_ADDR_SCOPE_LINKLOCAL;
    }

    extern (D) int IN6_IS_ADDR_MC_SITELOCAL( in in6_addr* a ) pure
    {
        return IN6_IS_ADDR_MULTICAST(a) &&
               __IPV6_ADDR_MC_SCOPE(a) == __IPV6_ADDR_SCOPE_SITELOCAL;
    }

    extern (D) int IN6_IS_ADDR_MC_ORGLOCAL( in in6_addr* a ) pure
    {
        return IN6_IS_ADDR_MULTICAST(a) &&
               __IPV6_ADDR_MC_SCOPE(a) == __IPV6_ADDR_SCOPE_ORGLOCAL;
    }

    extern (D) int IN6_IS_ADDR_MC_GLOBAL( in in6_addr* a ) pure
    {
        return IN6_IS_ADDR_MULTICAST(a) &&
               __IPV6_ADDR_MC_SCOPE(a) == __IPV6_ADDR_SCOPE_GLOBAL;
    }
}
else version( Solaris )
{
    struct in6_addr
    {
        union
        {
            uint8_t[16] s6_addr;
            uint8_t[16] s6_addr8;
            uint32_t[4] s6_addr32;
        }
    }

    struct sockaddr_in6
    {
        sa_family_t sin6_family;
        in_port_t   sin6_port;
        uint32_t    sin6_flowinfo;
        in6_addr    sin6_addr;
        uint32_t    sin6_scope_id;
        uint32_t    __sin6_src_id;
    }

    extern __gshared immutable in6_addr in6addr_any;
    extern __gshared immutable in6_addr in6addr_loopback;

    struct ipv6_mreq
    {
        in6_addr    ipv6mr_multiaddr;
        uint        ipv6mr_interface;
    }

    enum : uint
    {
        IPPROTO_IPV6        = 41,

        //INET6_ADDRSTRLEN    = 46,

        IPV6_JOIN_GROUP     = 9,
        IPV6_LEAVE_GROUP    = 10,
        IPV6_MULTICAST_HOPS = 7,
        IPV6_MULTICAST_IF   = 6,
        IPV6_MULTICAST_LOOP = 8,
        IPV6_UNICAST_HOPS   = 5,
        IPV6_V6ONLY         = 39,
    }

    // macros
    extern (D) int IN6_IS_ADDR_UNSPECIFIED( in in6_addr* a ) pure
    {
        return (a.s6_addr32[0] == 0) && (a.s6_addr32[1] == 0) &&
               (a.s6_addr32[2] == 0) && (a.s6_addr32[3] == 0);
    }

    extern (D) int IN6_IS_ADDR_LOOPBACK( in in6_addr* a ) pure
    {
        return (a.s6_addr32[0] == 0) && (a.s6_addr32[1] == 0) &&
               (a.s6_addr32[2] == 0) && (a.s6_addr32[3] == ntohl(1));
    }

    extern (D) int IN6_IS_ADDR_V4COMPAT( in in6_addr* a ) pure
    {
        return (a.s6_addr32[0] == 0) && (a.s6_addr32[1] == 0) &&
               (a.s6_addr32[2] == 0) && (a.s6_addr32[3] != 0) &&
               (a.s6_addr32[3] != ntohl(1));
    }

    extern (D) int IN6_IS_ADDR_V4MAPPED( in in6_addr* a ) pure
    {
        return (a.s6_addr32[0] == 0) && (a.s6_addr32[1] == 0) &&
               (a.s6_addr32[2] == ntohl(0x0000ffff));
    }

    extern (D) int IN6_IS_ADDR_LINKLOCAL( in in6_addr* a ) pure
    {
        return a.s6_addr8[0] == 0xfe && (a.s6_addr8[1] & 0xc0) == 0x80;
    }

    extern (D) int IN6_IS_ADDR_SITELOCAL( in in6_addr* a ) pure
    {
        return a.s6_addr8[0] == 0xfe && (a.s6_addr8[1] & 0xc0) == 0xc0;
    }

    extern (D) int IN6_IS_ADDR_MULTICAST( in in6_addr* a ) pure
    {
        return a.s6_addr8[0] == 0xff;
    }

    extern (D) int IN6_IS_ADDR_MC_NODELOCAL( in in6_addr* a ) pure
    {
        return a.s6_addr8[0] == 0xff && (a.s6_addr8[1] & 0x0f) == 0x01;
    }

    extern (D) int IN6_IS_ADDR_MC_LINKLOCAL( in in6_addr* a ) pure
    {
        return a.s6_addr8[0] == 0xff && (a.s6_addr8[1] & 0x0f) == 0x02;
    }

    extern (D) int IN6_IS_ADDR_MC_SITELOCAL( in in6_addr* a ) pure
    {
        return a.s6_addr8[0] == 0xff && (a.s6_addr8[1] & 0x0f) == 0x05;
    }

    extern (D) int IN6_IS_ADDR_MC_ORGLOCAL( in in6_addr* a ) pure
    {
        return a.s6_addr8[0] == 0xff && (a.s6_addr8[1] & 0x0f) == 0x08;
    }

    extern (D) int IN6_IS_ADDR_MC_GLOBAL( in in6_addr* a ) pure
    {
        return a.s6_addr8[0] == 0xff && (a.s6_addr8[1] & 0x0f) == 0x0e;
    }
}
else version( CRuntime_Bionic )
{
    struct in6_addr
    {
        union
        {
            uint8_t[16] s6_addr;
            uint16_t[8] s6_addr16;
            uint32_t[4] s6_addr32;
        }
    }

    struct sockaddr_in6
    {
        ushort      sin6_family;
        uint16_t    sin6_port;
        uint32_t    sin6_flowinfo;
        in6_addr    sin6_addr;
        uint32_t    sin6_scope_id;
    }

    __gshared immutable in6_addr in6addr_any = {[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]};
    __gshared immutable in6_addr in6addr_loopback = {[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]};

    struct ipv6_mreq
    {
        in6_addr ipv6mr_multiaddr;
        int      ipv6mr_ifindex;
    }

    enum : uint
    {
        IPPROTO_IPV6        = 41,

        IPV6_JOIN_GROUP     = 20,
        IPV6_LEAVE_GROUP    = 21,
        IPV6_MULTICAST_HOPS = 18,
        IPV6_MULTICAST_IF   = 17,
        IPV6_MULTICAST_LOOP = 19,
        IPV6_UNICAST_HOPS   = 16,
        IPV6_V6ONLY         = 26
    }

    private enum
    {
        IPV6_ADDR_SCOPE_NODELOCAL     = 0x01,
        IPV6_ADDR_SCOPE_INTFACELOCAL  = 0x01,
        IPV6_ADDR_SCOPE_LINKLOCAL     = 0x02,
        IPV6_ADDR_SCOPE_SITELOCAL     = 0x05,
        IPV6_ADDR_SCOPE_ORGLOCAL      = 0x08,
        IPV6_ADDR_SCOPE_GLOBAL        = 0x0e,
    }

    extern (D) pure
    {
        bool IN6_IS_ADDR_UNSPECIFIED( in in6_addr* a )
        {
            return (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[0]) == 0) &&
                   (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[4]) == 0) &&
                   (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[8]) == 0) &&
                   (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[12]) == 0);
        }

        bool IN6_IS_ADDR_LOOPBACK( in in6_addr* a )
        {
            return (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[0]) == 0) &&
                   (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[4]) == 0) &&
                   (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[8]) == 0) &&
                   (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[12]) == ntohl(1));
        }

        bool IN6_IS_ADDR_V4COMPAT( in in6_addr* a )
        {
            return (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[0]) == 0) &&
                   (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[4]) == 0) &&
                   (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[8]) == 0) &&
                   (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[12]) != 0) &&
                   (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[12]) != ntohl(1));
        }

        bool IN6_IS_ADDR_V4MAPPED( in in6_addr* a )
        {
            return (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[0]) == 0) &&
                   (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[4]) == 0) &&
                   (*cast(const uint32_t*) cast(const void*) (&a.s6_addr[8]) == ntohl(0x0000ffff));
        }

        bool IN6_IS_ADDR_LINKLOCAL( in in6_addr* a )
        {
            return a.s6_addr[0] == 0xfe && (a.s6_addr[1] & 0xc0) == 0x80;
        }

        bool IN6_IS_ADDR_SITELOCAL( in in6_addr* a )
        {
            return a.s6_addr[0] == 0xfe && (a.s6_addr[1] & 0xc0) == 0xc0;
        }

        bool IN6_IS_ADDR_ULA( in in6_addr* a )
        {
            return (a.s6_addr[0] & 0xfe) == 0xfc;
        }

        bool IN6_IS_ADDR_MULTICAST( in in6_addr* a )
        {
            return a.s6_addr[0] == 0xff;
        }

        uint8_t IPV6_ADDR_MC_SCOPE( in in6_addr* a )
        {
            return a.s6_addr[1] & 0x0f;
        }

        bool IN6_IS_ADDR_MC_NODELOCAL( in in6_addr* a )
        {
            return IN6_IS_ADDR_MULTICAST(a) &&
                   IPV6_ADDR_MC_SCOPE(a) == IPV6_ADDR_SCOPE_NODELOCAL;
        }

        bool IN6_IS_ADDR_MC_LINKLOCAL( in in6_addr* a )
        {
            return IN6_IS_ADDR_MULTICAST(a) &&
                   IPV6_ADDR_MC_SCOPE(a) == IPV6_ADDR_SCOPE_LINKLOCAL;
        }

        bool IN6_IS_ADDR_MC_SITELOCAL( in in6_addr* a )
        {
            return IN6_IS_ADDR_MULTICAST(a) &&
                   IPV6_ADDR_MC_SCOPE(a) == IPV6_ADDR_SCOPE_SITELOCAL;
        }

        bool IN6_IS_ADDR_MC_ORGLOCAL( in in6_addr* a )
        {
            return IN6_IS_ADDR_MULTICAST(a) &&
                   IPV6_ADDR_MC_SCOPE(a) == IPV6_ADDR_SCOPE_ORGLOCAL;
        }

        bool IN6_IS_ADDR_MC_GLOBAL( in in6_addr* a )
        {
            return IN6_IS_ADDR_MULTICAST(a) &&
                   IPV6_ADDR_MC_SCOPE(a) == IPV6_ADDR_SCOPE_GLOBAL;
        }
    }
}


//
// Raw Sockets (RS)
//
/*
IPPROTO_RAW
*/

version( linux )
{
    enum uint IPPROTO_RAW = 255;
}
else version( OSX )
{
    enum uint IPPROTO_RAW = 255;
}
else version( FreeBSD )
{
    enum uint IPPROTO_RAW = 255;
}
else version( Solaris )
{
    enum uint IPPROTO_RAW = 255;
}
else version( Android )
{
    enum uint IPPROTO_RAW = 255;
}
