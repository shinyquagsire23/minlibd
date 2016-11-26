/**
 * D header file for GNU/Linux
 *
 * Authors: Martin Nowak
 */
module core.sys.linux.config;

version (linux):

public import core.sys.posix.config;

// man 7 feature_test_macros
// http://www.gnu.org/software/libc/manual/html_node/Feature-Test-Macros.html
enum _GNU_SOURCE = true;
// deduced <features.h>
// http://sourceware.org/git/?p=glibc.git;a=blob;f=include/features.h
enum _BSD_SOURCE = true;
enum _SVID_SOURCE = true;
enum _ATFILE_SOURCE = true;

enum __USE_MISC = _BSD_SOURCE || _SVID_SOURCE;
enum __USE_BSD = _BSD_SOURCE;
enum __USE_SVID = _SVID_SOURCE;
enum __USE_ATFILE = _ATFILE_SOURCE;
enum __USE_GNU = _GNU_SOURCE;
