%{

#include <stdio.h>
#include <stdlib.h>

void yyerror(char *s);
int yylex();

extern FILE *yyin;
extern char *yytext;

%}

%token BEG DOC_ID END BEG_DISPLAY_MATH END_DISPLAY_MATH BEG_THEOREM BEG_PROPOSITION BEG_LEMMA BEG_PROOF END_THEOREM END_PROPOSITION END_LEMMA END_PROOF BEG_ENUMERATE END_ENUMERATE

%%

document: env
        | line
        | document line
        | document env
        ;

env: thm_env
   | math_env
   ;

thm_env: thm env_content end_thm
       | prop env_content end_prop
       | lemma env_content end_lemma
       | proof env_content end_proof
       ;

math_env: eq env_content end_eq
        ;

env_content: env
           | line
           | env_content line
           | env_content env
           ;

line: DOC_ID {printf("%s\n", yytext);} '\n'
    ;

eq: BEG_DISPLAY_MATH {printf("%s\n", yytext);} '\n'
   ;

end_eq: END_DISPLAY_MATH {printf("%s\n", yytext);} '\n'
      ;

thm: BEG_THEOREM {printf("%s\n", "<div class=\"theorem\">");} '\n'
   ;

end_thm: END_THEOREM {printf("%s\n", "</div>");} '\n'
       ;

prop: BEG_PROPOSITION {printf("%s\n", "<div class=\"proposition\">");} '\n'
    ;

end_prop: END_PROPOSITION {printf("%s\n", "</div>");} '\n'
        ;

lemma: BEG_LEMMA {printf("%s\n", "<div class=\"lemma\">");} '\n'
     ;

end_lemma: END_LEMMA {printf("%s\n", "</div>");} '\n'
         ;

proof: BEG_PROOF {printf("%s\n", "<div class=\"proof\">");} '\n'
     ;

end_proof: END_PROOF {printf("%s\n", "</div>");} '\n'
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
