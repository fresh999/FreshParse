#include "utils.h"
#include <stdlib.h>

size_t count_lspaces(char *s) {
    size_t count = 0;

    while (isspace((unsigned char) *s++)) ++count;
    return count;
}

void print_indentation(size_t indent_level) {
    for (size_t i = 0; i != indent_level; ++i)
        printf("    ");
}

int is_empty_string(const char *s) {
    while (*s != '\0') {
        if (!isspace((unsigned char)*s))
            return 0;
        s++;
    }
    return 1;
}

/*
int main(int argc, char **argv) {

    char *s = malloc(10 * sizeof(char));
    s = "\tFuck";

    char *ss = malloc(10 * sizeof(char));
    ss = "     ";
    printf("%s\n", ss);
    printf("%s: %ld\n", "count_lspaces", count_lspaces(ss));
    printf("%s: %d\n", "is empty string", is_empty_string(ss));

    return 0;
}
*/


