%{

#include <stdio.h>
#include <stdlib.h>

void yyerror(char *s);
int yylex();

extern FILE *yyin;
extern char *yytext;

%}

%token BEG ID END BEG_EQ END_EQ

%%

lines: line
     | lines line
     ;

line: beg '\n'
    | end '\n'
    | eq '\n'
    | eq_end '\n'
    | ID {printf("%s\n", yytext);} '\n'
    ;

beg: BEG {printf("Hello world\n");}
   ;

end: END {printf("Goodbye world\n");}
   ;

eq: BEG_EQ {printf("Equation\n");}
  ;

eq_end: END_EQ {printf("Goodbye equation\n");}

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
