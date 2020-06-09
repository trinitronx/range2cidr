#include "config.h"
#include "verbose.h"
#include <stdbool.h>
#include <stdarg.h>
#include <stdio.h>

bool Verbose = false;

void setVerbose(bool setting) {
    Verbose = setting;
}

bool getVerbose() {
    if (Verbose)
        return true;
    else
        return false;
}
int verbose(const char * restrict format, ...) {
    if( !Verbose )
        return 0;

    va_list args;
    va_start(args, format);
    int ret = vprintf(format, args);
    va_end(args);

    return ret;
}
