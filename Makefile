CC=gcc
DEBUG=-g
CFLAGS=$(DEBUG) -Wall
PROGS=myar
TESTFILES=ar12345.ar myar12345.ar ar135.ar myar135.ar ar24.ar \
myar24.ar ar-ctoc.txt myar-ctoc.txt ar-vtoc.txt myar-vtoc.txt
TESTS=testq12345 testq135 testq24 testt12345 testt135 testt24 testv12345 testv135 testv24
.PHONY: all testq testt testv tests $(TESTS) clean

all: $(PROGS)

myar: myar.o
	$(CC) $(CFLAGS) -o myar myar.o

myar.o: myar.c
	$(CC) $(CFLAGS) -c myar.c

testq12345: myar
	rm -f ar12345.ar myar12345.ar
	ar q ar12345.ar 1-s.txt 2-s.txt 3-s.txt 4-s.txt 5-s.txt
	./myar -q myar12345.ar 1-s.txt 2-s.txt 3-s.txt 4-s.txt 5-s.txt
	diff ar12345.ar myar12345.ar

testq135: myar
	rm -f ar135.ar myar135.ar
	ar q ar135.ar 1-s.txt 3-s.txt 5-s.txt
	./myar -q myar135.ar 1-s.txt 3-s.txt 5-s.txt
	diff ar135.ar myar135.ar

testq24: myar
	rm -f ar24.ar myar24.ar
	ar q ar24.ar 2-s.txt 4-s.txt
	./myar -q myar24.ar 2-s.txt 4-s.txt
	diff ar24.ar myar24.ar

testt12345: myar
	rm -f ar12345.ar
	ar q ar12345.ar 1-s.txt 2-s.txt 3-s.txt 4-s.txt 5-s.txt
	ar t ar12345.ar > ar-ctoc.txt
	./myar -t ar12345.ar > myar-ctoc.txt
	diff ar-ctoc.txt myar-ctoc.txt

testt135: myar
	rm -f ar135.ar
	ar q ar135.ar 1-s.txt 3-s.txt 5-s.txt
	ar t ar135.ar > ar-ctoc.txt
	./myar -t ar135.ar > myar-ctoc.txt
	diff ar-ctoc.txt myar-ctoc.txt

testt24: myar
	rm -f ar24.ar
	ar q ar24.ar 2-s.txt 4-s.txt
	ar t ar24.ar > ar-ctoc.txt
	./myar -t ar24.ar > myar-ctoc.txt
	diff ar-ctoc.txt myar-ctoc.txt

testv12345: myar
	rm -f ar12345.ar
	ar q ar12345.ar 1-s.txt 2-s.txt 3-s.txt 4-s.txt 5-s.txt
	ar tv ar12345.ar > ar-vtoc.txt
	./myar -v ar12345.ar > myar-vtoc.txt
	diff ar-vtoc.txt myar-vtoc.txt

testv135: myar
	rm -f ar135.ar
	ar q ar135.ar 1-s.txt 3-s.txt 5-s.txt
	ar tv ar135.ar > ar-vtoc.txt
	./myar -v ar135.ar > myar-vtoc.txt
	diff ar-vtoc.txt myar-vtoc.txt

testv24: myar
	rm -f ar24.ar
	ar q ar24.ar 2-s.txt 4-s.txt
	ar tv ar24.ar > ar-vtoc.txt
	./myar -v ar24.ar > myar-vtoc.txt
	diff ar-vtoc.txt myar-vtoc.txt

testd12345: myar
	rm -f ar12345.ar myar12345.ar
	ar q ar12345.ar 1-s.txt 2-s.txt 3-s.txt 4-s.txt 5-s.txt
	ar q myar12345.ar 1-s.txt 2-s.txt 3-s.txt 4-s.txt 5-s.txt
	ar d ar12345.ar 1-s.txt 2-s.txt 3-s.txt 4-s.txt 5-s.txt
	./myar -d myar12345.ar 1-s.txt 2-s.txt 3-s.txt 4-s.txt 5-s.txt
	diff ar12345.ar myar12345.ar

testd135: myar
	rm -f ar12345.ar myar12345.ar
	ar q ar12345.ar 1-s.txt 2-s.txt 3-s.txt 4-s.txt 5-s.txt
	ar q myar12345.ar 1-s.txt 2-s.txt 3-s.txt 4-s.txt 5-s.txt
	ar d ar12345.ar 1-s.txt 3-s.txt 5-s.txt
	./myar -d myar12345.ar 1-s.txt txt 3-s.txt 5-s.txt
	diff ar12345.ar myar12345.ar

testd24: myar
	rm -f ar12345.ar myar12345.ar
	ar q ar12345.ar 1-s.txt 2-s.txt 3-s.txt 4-s.txt 5-s.txt
	ar q myar12345.ar 1-s.txt 2-s.txt 3-s.txt 4-s.txt 5-s.txt
	ar d ar12345.ar 2-s.txt 4-s.txt
	./myar -d myar12345.ar 2-s.txt 4-s.txt
	diff ar12345.ar myar12345.ar

testx12345: myar
	rm -f ar12345.ar
	rm -rf inputbackup
	ar q ar12345.ar 1-s.txt 2-s.txt 3-s.txt 4-s.txt 5-s.txt
	mkdir inputbackup
	cp 1-s.txt 2-s.txt 3-s.txt 4-s.txt 5-s.txt inputbackup
	./myar -x ar12345.ar
	diff 1-s.txt inputbackup/1-s.txt
	diff 2-s.txt inputbackup/2-s.txt
	diff 3-s.txt inputbackup/3-s.txt
	diff 4-s.txt inputbackup/4-s.txt
	diff 5-s.txt inputbackup/5-s.txt
	rm -f 1-s.txt 2-s.txt 3-s.txt 4-s.txt 5-s.txt
	mv inputbackup/1-s.txt 1-s.txt
	mv inputbackup/2-s.txt 2-s.txt
	mv inputbackup/3-s.txt 3-s.txt
	mv inputbackup/4-s.txt 4-s.txt
	mv inputbackup/5-s.txt 5-s.txt
	rm -rf inputbackup

testq: testq12345 testq135 testq24

testt: testt12345 testt135 testt24

testv: testv12345 testv135 testv24

testd: testd12345 testd135 testd24

testx: testx12345

tests: testq testt testv testd testx

clean:
	rm -f $(PROGS) $(TESTFILES) *.o *~
