%{

#include "y.tab.h"
#include <stdio.h>

%}

%s DOC

%%

^\\begin\{document\} {BEGIN DOC; return BEG;}
<DOC>^\\end\{document\} {BEGIN 0; return END;}

<DOC>^[ \t]*\\begin\{equation\*?\} |
<DOC>^[ \t]*\\begin\{align\*?\} {return BEG_DISPLAY_MATH;}

<DOC>^[ \t]*\\end\{equation\*?\} |
<DOC>^[ \t]*\\end\{align\*?\} {return END_DISPLAY_MATH;}

<DOC>^[ \t]*\\begin\{theorem\} {return BEG_THEOREM;}
<DOC>^[ \t]*\\begin\{proposition\} {return BEG_PROPOSITION;}
<DOC>^[ \t]*\\begin\{lemma\} {return BEG_LEMMA;}
<DOC>^[ \t]*\\begin\{proof\} {return BEG_PROOF;}

<DOC>^[ \t]*\\end\{theorem\} {return END_THEOREM;}
<DOC>^[ \t]*\\end\{proposition\} {return END_PROPOSITION;}
<DOC>^[ \t]*\\end\{lemma\} {return END_LEMMA;}
<DOC>^[ \t]*\\end\{proof\} {return END_PROOF;}

<DOC>^[ \t]*\\begin\{enumerate\} {return BEG_ENUMERATE;}
<DOC>^[ \t]*\\end\{enumerate\} {return END_ENUMERATE;}

<DOC>^[ \t]*\\item {return ITEM;}

^[ \t]*\n ECHO;
[\\\(\)\[\]\{\}]*|.* {return DOC_ID;}
\n return *yytext;

%%

int yywrap() {
    return 1;
}
