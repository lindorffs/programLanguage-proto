YFLAGS = -d
PROGRAM = ezlearn 
OBJS = y.tab.o lex.yy.o
SRCS = y.tab.c lex.yy.c

CC = gcc

all: $(PROGRAM)
.c.o: $(SRCS)
	$(CC) -c $*.c -o $@ -O

y.tab.c: grammar.y
	yacc $(YFLAGS) grammar.y
	yacc grammar.y

lex.yy.c: lexicon.l
	flex lexicon.l

$(PROGRAM): $(OBJS)
	$(CC) $(OBJS) -o $@ -lfl -lm

clean:
	rm -v lex.yy.c y.tab.c y.tab.h *.o
