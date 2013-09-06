#include <getopt.h>
#include <stdio.h>
#include <sys/utsname.h>
#include <time.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <ar.h>
#include <fcntl.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <utime.h>
#include <dirent.h>

#define BLOCKSIZE 16

typedef int bool;
enum {false, true};

int open_archive(char * file_name, char * prog_name);
int is_archive(char * magic_string);
int print_filename(char * header);
int cmp_filename(char * file_name, char * header);
int get_file_name(char * header, char * dest);
int parse_filesize(char * header);
int parse_file_mode(char * header);
int parse_time(char * header);
int print_ids(char * header);
int print_verbose(char * header);
void output_mode(int octal_mode);
int append_to_archive(char * archive_name, char * file_name, char * prog_name);
int find_file(char * archive_name, char * file_name, char * prog_name, int * f_size, char * header_copy);
int delete_from_archive(char * archive_name, char * file_name, char * prog_name);
int extract_from_archive(char * archive_name, char * file_name, char * prog_name);
int append_all_reg(char * archive_name, char * prog_name);

//Error message handlers
void exit_nsfile(char * prog_name, char * file_name);
void exit_formatnr(char * prog_name, char * file_name);
