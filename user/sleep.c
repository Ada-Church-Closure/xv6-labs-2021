#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

// how to sleep?
int
main(int argc, char* argv[])
{
    if(argc < 2){
        fprintf(2, "usage:sleep ticks...\n");
        exit(1);
    }
    // 直接转换成int类型然后系统调用
    int ticks = atoi(argv[1]);
    sleep(ticks);
    exit(0);
}