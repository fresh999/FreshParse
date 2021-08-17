%{

#include "y.tab.h"
#include <stdio.h>

%}

%s DOC

%%

^\\begin\{.*\} {return BEG;}
.* return ID;
\n ;

%%

int yywrap() {
    return 1;
}
