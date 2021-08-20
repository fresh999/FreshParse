%{

#include "utils.h"

#include <stdio.h>
#include <stdlib.h>

void yyerror(char *s);
int yylex();

extern FILE *yyin;
extern char *yytext;
size_t indent_level = 0;
size_t par_wrap = 0;

%}

%token BEG DOC_ID PREAMBLE_ID BEG_PREAMBLE END BEG_DISPLAY_MATH END_DISPLAY_MATH BEG_THEOREM BEG_PROPOSITION BEG_LEMMA BEG_PROOF END_THEOREM END_PROPOSITION END_LEMMA END_PROOF

%%

document: preamble beg main end

preamble: beg_preamble preamble_content

preamble_content: PREAMBLE_ID '\n'
        | preamble_content PREAMBLE_ID '\n'
        ;

beg_preamble: BEG_PREAMBLE '\n'
            ;

main: env
    | line
    | main line
    | main env
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

beg: BEG '\n'
   ;

end: END '\n'
   ;

line: DOC_ID {
    print_indentation(indent_level);
    if (!par_wrap) {
        printf("<p>");
        printf("%s", yytext);
        printf("%s\n", "</p>");
    }
    else printf("%s\n", yytext);} '\n'
    ;

eq: BEG_DISPLAY_MATH {print_indentation(indent_level++); printf("%s\n", yytext); ++par_wrap;} '\n'
   ;

end_eq: END_DISPLAY_MATH {print_indentation(--indent_level); printf("%s\n", yytext); --par_wrap;} '\n'
      ;

thm: BEG_THEOREM {print_indentation(indent_level++); printf("%s\n", "<div class=\"theorem\">"); ++par_wrap;} '\n'
   ;

end_thm: END_THEOREM {print_indentation(--indent_level); printf("%s\n", "</div>"); --par_wrap;} '\n'
       ;

prop: BEG_PROPOSITION {print_indentation(indent_level++); printf("%s\n", "<div class=\"proposition\">"); ++par_wrap;} '\n'
    ;

end_prop: END_PROPOSITION {print_indentation(--indent_level); printf("%s\n", "</div>"); --par_wrap;} '\n'
        ;

lemma: BEG_LEMMA {print_indentation(indent_level++); printf("%s\n", "<div class=\"lemma\">"); ++par_wrap;} '\n'
     ;

end_lemma: END_LEMMA {print_indentation(--indent_level); printf("%s\n", "</div>"); --par_wrap;} '\n'
         ;

proof: BEG_PROOF {print_indentation(indent_level++); printf("%s\n", "<div class=\"proof\">"); ++par_wrap;} '\n'
     ;

end_proof: END_PROOF {print_indentation(--indent_level); printf("%s\n", "</div>"); --par_wrap;} '\n'
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
