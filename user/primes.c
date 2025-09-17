#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
// The process is a sift...
// we will create a lot of pipes,one pipe for two process.
// implement the logic of sieve
// it's similiar to main,right?
void sieve(int rd){
    int prime;
    if(read(rd, &prime, 4) == 0){
        exit(0);
    }
    
    printf("prime %d\n", prime);

    int p[2];
    pipe(p);

    if(fork() == 0){
        close(p[1]);
        sieve(p[0]);
        close(p[0]);
        exit(1);
    }else{
        close(p[0]);
        int number_read;
        while(read(rd, &number_read, sizeof(number_read)) == sizeof(number_read)){
            if(number_read % prime != 0){
                write(p[1], &number_read, sizeof(number_read));
            }
        }
        close(rd);
        close(p[1]);
        wait(0);
    }

    exit(0);
} 

int
main(int argc, char *argv[])
{   
    // first create a pipe
    int p[2];
    pipe(p);
    // write 2-35 into the pipeline
    if(fork() == 0){
    // If you call a function here,the subprocess will handle with it,you got to be familiar with this.
    close(p[1]);
    sieve(p[0]);
    close(p[0]);
    exit(1);
    }else{
        close(p[0]);
        // write 2-35 to the pipe
        for(int index = 2; index <= 35; ++index){
            write(p[1], &index, sizeof(index));
        }
        // pay attention to this wait(0), important
        close(p[1]);
        wait(0);
    }

    exit(0);
}
