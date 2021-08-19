%{

#include "y.tab.h"
#include <stdio.h>

%}

%s DOC

%%

^[ \t]*\\begin\{document\} {BEGIN DOC; return BEG;}
^[ \t]*\\end\{document\} {BEGIN 0; return END;}

^[ \t]*\\begin\{equation\*?\} |
^[ \t]*\\begin\{align\*?\} {return BEG_DISPLAY_MATH;}

^[ \t]*\\end\{equation\*?\} |
^[ \t]*\\end\{align\*?\} {return END_DISPLAY_MATH;}

^[ \t]*\\begin\{theorem\} {return BEG_THEOREM;}
^[ \t]*\\begin\{proposition\} {return BEG_PROPOSITION;}
^[ \t]*\\begin\{lemma\} {return BEG_LEMMA;}
^[ \t]*\\begin\{proof\} {return BEG_PROOF;}

^[ \t]*\\end\{theorem\} {return END_THEOREM;}
^[ \t]*\\end\{proposition\} {return END_PROPOSITION;}
^[ \t]*\\end\{lemma\} {return END_LEMMA;}
^[ \t]*\\end\{proof\} {return END_PROOF;}

^[ \t]*\n ECHO;
[\(\)\[\]\{\}\?]*|.* {return DOC_ID;}
\n {return *yytext;}

%%

int yywrap() {
    return 1;
}
