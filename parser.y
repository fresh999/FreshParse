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

%token BEG DOC_ID PREAMBLE_ID BEG_PREAMBLE END BEG_DISPLAY_MATH END_DISPLAY_MATH BEG_THEOREM BEG_PROPOSITION BEG_LEMMA BEG_PROOF BEG_DEFINITION END_THM_LIKE BEG_ENUMERATE END_ENUMERATE BEG_ITEMIZE END_ITEMIZE ITEM

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
    | main env
    | main line
    ;

env: thm_env
   | math_env
   | list_env
   ;

thm_env: thm env_content end_thm_like
       | prop env_content end_thm_like
       | lemma env_content end_thm_like
       | proof env_content end_thm_like
       | definition env_content end_thm_like
       ;

math_env: eq env_content end_eq
        ;

list_env: enumerate items end_enumerate
        | itemize items end_itemize
        ;

items: env {print_indentation(indent_level); printf("</li>\n");}
     | item
     | items env {print_indentation(indent_level); printf("</li>\n");}
     | items item
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
    if (!par_wrap)
        printf("%s%s%s\n", "<p>", yytext, "</p>");
    else
        printf("%s\n", yytext);} '\n'
    ;

item: ITEM {
    print_indentation(indent_level);
    if (is_empty_string(yytext))
        printf("%s\n", "<li>");
    else
        printf("%s%s%s\n", "<li>", yytext, "</li>");} '\n'

eq: BEG_DISPLAY_MATH {print_indentation(indent_level++); printf("%s\n", yytext); ++par_wrap;} '\n'
   ;

end_eq: END_DISPLAY_MATH {print_indentation(--indent_level); printf("%s\n", yytext); --par_wrap;} '\n'
      ;

thm: BEG_THEOREM {print_indentation(indent_level++); printf("%s\n", "<div class=\"theorem\">"); ++par_wrap;} '\n'
   ;

end_thm_like: END_THM_LIKE {print_indentation(--indent_level); printf("%s\n", "</div>"); --par_wrap;} '\n'
            ;

prop: BEG_PROPOSITION {print_indentation(indent_level++); printf("%s\n", "<div class=\"proposition\">"); ++par_wrap;} '\n'
    ;

lemma: BEG_LEMMA {print_indentation(indent_level++); printf("%s\n", "<div class=\"lemma\">"); ++par_wrap;} '\n'
     ;

proof: BEG_PROOF {print_indentation(indent_level++); printf("%s\n", "<div class=\"proof\">"); ++par_wrap;} '\n'
     ;

definition: BEG_DEFINITION {print_indentation(indent_level++); printf("%s\n", "<div class=\"definition\">"); ++par_wrap;} '\n'
     ;

enumerate: BEG_ENUMERATE {print_indentation(indent_level++); printf("%s\n", "<ol>"); ++par_wrap;} '\n'
         ;

end_enumerate: END_ENUMERATE {print_indentation(--indent_level); printf("%s\n", "</ol>"); --par_wrap;} '\n'
             ;

itemize: BEG_ITEMIZE {print_indentation(indent_level++); printf("%s\n", "<ul>"); ++par_wrap;} '\n'
       ;

end_itemize: END_ITEMIZE {print_indentation(--indent_level); printf("%s\n", "</ul>"); --par_wrap;} '\n'
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
