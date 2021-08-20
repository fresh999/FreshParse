#include "utils.h"

size_t count_lspaces(char *s) {
    size_t count = 0;

    while (isspace((unsigned char) *s++)) ++count;
    if (*s == 0) return 0;

    return count;
}

void print_indentation(size_t indent_level) {
    for (size_t i = 0; i != indent_level; ++i)
        printf("    ");
}

/*
int main(int argc, char **argv) {

    char *s = malloc(10 * sizeof(char));
    s = "\tFuck";

    printf("%s: %s\n", "Original string", s);
    int wrap = 0;
    set_par_wrap(&wrap, 0);
    printf("%d\n", wrap);
    return 0;
}
*/

