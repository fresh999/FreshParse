obj = y.tab.o lex.yy.o

LEX = flex -I
YACC = yacc
CC = gcc
CFLAGS = -Wall -Wextra -c

main: y.tab.o lex.yy.o
	$(CC) -o test $(obj)

lex.yy.o: lex.yy.c y.tab.h
	$(CC) $(CFLAGS) lex.yy.c

y.tab.o: y.tab.c
	$(CC) $(CFLAGS) y.tab.c

y.tab.c y.tab.h: test.y
	$(YACC) -d parser.y

lex.yy.c: test.l
	$(LEX) lexer.l

.PHONY: run clean
run:
	@./test

clean:
	rm $(obj) lex.yy.c y.tab.c y.tab.h main
