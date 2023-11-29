#include <sys/stat.h>
#include <stdio.h>
#include <errno.h>
#include <stdarg.h>

#if !defined(STDIN_FILENO)

#define STDIN_FILENO    0       /* Standard input.  */
#define STDOUT_FILENO   1       /* Standard output.  */
#define STDERR_FILENO   2       /* Standard error output.  */

#endif

__attribute__((weak)) int isatty(int fd)
{
    if (fd >= STDIN_FILENO && fd <= STDERR_FILENO)
        return 1;
 
    errno = EBADF;
    return 0;
}
 
__attribute__((weak)) int close(int fd)
{
    if (fd >= STDIN_FILENO && fd <= STDERR_FILENO)
        return 0;
    errno = EBADF;
    return -1;
}
 
 
__attribute__((weak)) int fstat(int fd, struct stat *st)
{
    if (fd >= STDIN_FILENO && fd <= STDERR_FILENO)
    {
        st->st_mode = S_IFCHR;
        return 0;
    }
 
    errno = EBADF;
    return 0;
}
__attribute__((weak)) int _read(int file, char *ptr, int len){
    return -1;    
}
__attribute__((weak)) int _write(int file, const void *ptr, int len){
    return -1;    
}




__attribute__((weak))  int _kill(int pid){
    return -1;
}

__attribute__((weak))  int _isatty(int pid){
    return -1;
}
__attribute__((weak))  int _getpid(int pid){
    return -1;
}
__attribute__((weak))  int _close_r(int pid){
    return -1;
}
__attribute__((weak))  int _fstat_r(int pid){
    return -1;
}

__attribute__((weak)) int _lseek(int fd, int ptr, int dir)
{
    (void)fd;
    (void)ptr;
    (void)dir;
 
    errno = EBADF;
    return -1;
}



