myar
====

Basic replica of [GNU ar][1] written in C.

##Installation##

1. Place myar.c, myar.h, and Makefile in the desired directory.

2. Run make.

##Usage##

Execute myar to view usage information.

Example commands:

* View contents of "archive.ar" with detailed permissions: ```./myar -v archive.ar```
* Append "file1.txt", "file2.txt", "file3.txt" to "archive.ar": ```./myar -q archive.ar file1.txt file2.txt file3.txt```
* Extract all files from "archive.ar": ```./myar -x archive.ar```


[1]: http://linux.about.com/library/cmd/blcmdl1_ar.htm
