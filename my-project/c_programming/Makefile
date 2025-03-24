task1:task1.c
	gcc -o task1 task1.c -lm
task2:task2.c
	gcc -o task2 task1.c -lm
task3:task3.c
	gcc -o task3 task3.c -lm
print:$(wildcard task*)
	ls -la $?
hey:one two
	echo $@
	echo $?
	echo $^
	echo $<
	touch hey
one:
	touch one
two:
	touch two
clean:
	rm one two hey blah.c blah.o blah task1 task2 task3
blah:blah.o

blah.c:
	echo '#include <stdio.h>\n int main() { printf("hello world"); return 0; }' > blah.c

