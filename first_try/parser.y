%{

#include <stdio.h>
#include <stdlib.h>

void yyerror(char *s);
int yylex();

extern FILE *yyin;
extern char *yytext;

%}

%token BEG DOC_ID END BEG_DISPLAY_MATH END_DISPLAY_MATH BEG_THEOREM BEG_PROPOSITION BEG_LEMMA BEG_PROOF END_THEOREM END_PROPOSITION END_LEMMA END_PROOF BEG_ENUMERATE END_ENUMERATE ITEM

%%

lines: line
     | lines line
     ;

line: beg '\n'
    | end '\n'
    | eq '\n'
    | end_eq '\n'
    | thm '\n'
    | end_thm '\n'
    | prop '\n'
    | end_prop '\n'
    | lemma '\n'
    | end_lemma '\n'
    | proof '\n'
    | end_proof '\n'
    | ol '\n'
    | end_ol '\n'
    | DOC_ID {printf("%s\n", yytext);} '\n'
    ;

beg: BEG {printf("Hello world\n");}
   ;

end: END {printf("Goodbye world\n");}
   ;

eq: BEG_DISPLAY_MATH {printf("%s\n", yytext);}
   ;

end_eq: END_DISPLAY_MATH {printf("%s\n", yytext);}
   ;

thm: BEG_THEOREM {printf("%s\n", "<div class=\"theorem\">");}
   ;

end_thm: END_THEOREM {printf("%s\n", "</div>");}
   ;

prop: BEG_PROPOSITION {printf("%s\n", "<div class=\"proposition\">");}
   ;

end_prop: END_PROPOSITION {printf("%s\n", "</div>");}
   ;

lemma: BEG_LEMMA {printf("%s\n", "<div class=\"lemma\">");}
   ;

end_lemma: END_LEMMA {printf("%s\n", "</div>");}
   ;

proof: BEG_PROOF {printf("%s\n", "<div class=\"proof\">");}
   ;

end_proof: END_PROOF {printf("%s\n", "</div>");}
   ;

ol: BEG_ENUMERATE {printf("%s\n", "<ol>");}
   ;

end_ol: END_ENUMERATE {printf("%s\n", "</ol>");}

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
