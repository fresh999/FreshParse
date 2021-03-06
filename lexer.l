%{

#include "utils.h"
#include "y.tab.h"
#include <stdio.h>

%}

%s DOC PREAMBLE

%%

^\\documentclass\[.*\]\{.*\} {BEGIN PREAMBLE; return BEG_PREAMBLE;}

^[ \t]*\\begin\{document\} {BEGIN DOC; return BEG;}
<DOC>^[ \t]*\\end\{document\} {BEGIN 0; return END;}

<DOC>^[ \t]*\\begin\{equation\*?\} |
<DOC>^[ \t]*\\begin\{align\*?\} {yytext += count_lspaces(yytext); return BEG_DISPLAY_MATH;}

<DOC>^[ \t]*\\end\{equation\*?\} |
<DOC>^[ \t]*\\end\{align\*?\} {yytext += count_lspaces(yytext); return END_DISPLAY_MATH;}

<DOC>^[ \t]*\\begin\{theorem\} {yytext += count_lspaces(yytext); return BEG_THEOREM;}
<DOC>^[ \t]*\\begin\{proposition\} {yytext += count_lspaces(yytext); return BEG_PROPOSITION;}
<DOC>^[ \t]*\\begin\{lemma\} {yytext += count_lspaces(yytext); return BEG_LEMMA;}
<DOC>^[ \t]*\\begin\{proof\} {yytext += count_lspaces(yytext); return BEG_PROOF;}
<DOC>^[ \t]*\\begin\{definition\} {yytext += count_lspaces(yytext); return BEG_DEFINITION;}

<DOC>^[ \t]*\\end\{theorem\} |
<DOC>^[ \t]*\\end\{proposition\} |
<DOC>^[ \t]*\\end\{lemma\} |
<DOC>^[ \t]*\\end\{proof\} |
<DOC>^[ \t]*\\end\{definition\} {yytext += count_lspaces(yytext); return END_THM_LIKE;}

<DOC>^[ \t]*\\begin\{enumerate\} {yytext += count_lspaces(yytext); return BEG_ENUMERATE;}
<DOC>^[ \t]*\\end\{enumerate\} {yytext += count_lspaces(yytext); return END_ENUMERATE;}
<DOC>^[ \t]*\\begin\{itemize\} {yytext += count_lspaces(yytext); return BEG_ITEMIZE;}
<DOC>^[ \t]*\\end\{itemize\} {yytext += count_lspaces(yytext); return END_ITEMIZE;}

^[ \t]*\n ECHO;
^[ \t]*\\item(.*) {yytext += (count_lspaces(yytext) + 5); return ITEM;}
<DOC>.* {yytext += count_lspaces(yytext); return DOC_ID;}
<PREAMBLE>[\\\{\}]*|.* {return PREAMBLE_ID;}
\n {return *yytext;}

%%

int yywrap() {
    return 1;
}
