#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/param.h"

// 最多有32个参数.
// 难度在于对于字符串的精细处理.
// Write a simple version of the UNIX xargs program: read lines from the standard input and run a command for each line, supplying the line as arguments to the command. Your solution should be in the file user/xargs.c.
int
main(int argc, char* argv[])
{
    if(argc < 2){
        fprintf(2, "Usage: xargs command [args...]\n");
        exit(1);
    }

    // 要执行的参数
    char* args[MAXARG];
    char buf[512];
    int suffix_index = 0;
    // echo line | xargs(argv[0]) echo(argv[1]) 1(argv[2]) (argc = 3)

    for(int index = 1; index < argc; ++index){
        args[suffix_index] = argv[index];
        ++suffix_index;
    }

    int line_end_index = 0;
    while(1){
        int cc;
        char c;
        cc = read(0, &c, 1);

        if(cc == 0){
            break;
        }

        if(c == '\n'){
            buf[line_end_index] = 0;
            line_end_index = 0;

            args[suffix_index] = buf;
            args[suffix_index + 1] = 0;

            if(fork() == 0){
                // 注意这里也是要包含function本身的名称的
                exec(argv[1], args);
                fprintf(2,"Execute falied...\n");
                exit(1);
            }

            wait(0);

        }else{
            buf[line_end_index] = c;
            ++line_end_index;
        }


    }

    exit(0);






    exit(0);
}