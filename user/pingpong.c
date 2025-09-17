#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"


int
main(int argc, char* argv[])
{
   // first create a pipe and use it.
   int p[2];
   pipe(p);
   // subprocess
   if(fork() == 0){
    // The goal of read is making the process waiting for another.
    // pay attention to the close function,it's necessary.
        void* byte;
        byte = "F";
        read(p[0], byte, 1);
        close(p[0]);
        printf("%d: received ping\n", getpid());
        write(p[1], byte,1);
        close(p[1]);
        exit(0);
   }else{
        void* byte;
        byte = "F";
        write(p[1], byte, 1);
        close(p[1]);
        read(p[0], byte, 1);
        close(p[0]);
        printf("%d: received pong\n", getpid());
   }
   exit(0);
}