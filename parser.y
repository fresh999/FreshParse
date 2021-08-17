%{

#include <stdio.h>
#include <stdlib.h>

void yyerror(char *s);
int yylex();

extern FILE *yyin;

%}

%token BEG ID

%%

beg: BEG '\n' {printf("Hello world\n");}
   ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(int argc, char **argv) {

    if (argc != 2) {
        fprintf(stderr, "Wrong number of arguments provided\n");
        exit(1);
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        fprintf(stderr, "Not a valid filename\n");
        exit(1);
    }

    yyparse();

    return 0;
}
