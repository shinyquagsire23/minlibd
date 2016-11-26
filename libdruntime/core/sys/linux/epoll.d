/**
 * D header file to interface with the Linux epoll API (http://man7.org/linux/man-pages/man7/epoll.7.html).
 * Available since Linux 2.6
 *
 * Copyright: Copyright Adil Baig 2012.
 * License : $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0) 
 * Authors  : Adil Baig (github.com/adilbaig)
 */
module core.sys.linux.epoll;

version (linux):

extern (C):
@system:
nothrow:

enum
{
    EPOLL_CLOEXEC  = 0x80000,
    EPOLL_NONBLOCK = 0x800
}

enum 
{
    EPOLLIN 	= 0x001,
    EPOLLPRI 	= 0x002,
    EPOLLOUT 	= 0x004,
    EPOLLRDNORM = 0x040,
    EPOLLRDBAND = 0x080,
    EPOLLWRNORM = 0x100,
    EPOLLWRBAND = 0x200,
    EPOLLMSG 	= 0x400,
    EPOLLERR 	= 0x008,
    EPOLLHUP 	= 0x010,
    EPOLLRDHUP 	= 0x2000, // since Linux 2.6.17
    EPOLLONESHOT = 1u << 30,
    EPOLLET 	= 1u << 31
}

/* Valid opcodes ( "op" parameter ) to issue to epoll_ctl().  */
enum
{
    EPOLL_CTL_ADD = 1, // Add a file descriptor to the interface.
    EPOLL_CTL_DEL = 2, // Remove a file descriptor from the interface.
    EPOLL_CTL_MOD = 3, // Change file descriptor epoll_event structure.
}

struct epoll_event 
{
    align(1):
      uint events;
      epoll_data_t data;
};

union epoll_data_t 
{
    void *ptr;
    int fd;
    uint u32;
    ulong u64;
};
 
int epoll_create (int size);
int epoll_create1 (int flags);
int epoll_ctl (int epfd, int op, int fd, epoll_event *event);
int epoll_wait (int epfd, epoll_event *events, int maxevents, int timeout);
