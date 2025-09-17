#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

// it's from ls.c file.---maybe it's not good here but i don't want to change the code anymore...
char*
fmtname(char *path)
{
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    ;
  p++;

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}


void find(char* path, char* name)
{
    char buf[512];
    char* p;
    int fd;
    struct dirent de;
    struct stat st;

    if((fd = open(path, 0)) < 0){
    fprintf(2, "find: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    fprintf(2, "find: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  case T_FILE:
     char *bn = path + strlen(path);
    while (bn > path && *(bn-1) != '/'){
        bn--;
    }
    if(strcmp(bn, name) == 0){
        printf("%s\n", path);
    }
        close(fd);
        return;


  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf("find: path too long\n");
      break;
    }
    
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';

    while(read(fd, &de, sizeof(de)) == sizeof(de)){
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      // don't get yourself into endless recursive!!!. and ..
      if(strcmp(p, ".") == 0 || strcmp(p, "..") == 0){
        continue;
      }

      if(stat(buf, &st) < 0){
        printf("find: cannot stat %s\n", buf);
        continue;
      }
      // it's kink of actually dfs on a file tree...
      find(buf, name);
    }

    break;
  }
  close(fd);

}


// how to read directories.
int 
main(int argc, char* argv[])
{
    if(argc < 3){
        fprintf(2, "Find what!\n");
        exit(1);
    }
    // get the starting path and name of the file.
    char* path = argv[1];
    char* name = argv[2];
    find(path, name);
    exit(0);
}