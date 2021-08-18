%{

#include "y.tab.h"
#include <stdio.h>

%}

%s DOC

%%

^\\begin\{document\} {BEGIN DOC; return BEG;}
<DOC>^\\end\{document\} {BEGIN 0; return END;}
<DOC>\\begin\{equation\} {return BEG_EQ;}
<DOC>\\end\{equation\} {return END_EQ;}
^[ \t]*\n ECHO;
[\\\[\]\{\}]*|.* {return ID;}
\n return *yytext;

%%

int yywrap() {
    return 1;
}
