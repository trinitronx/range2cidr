#include "config.h"
#include <stdbool.h>

// autotools generated config.h handles restrict keyword
//int verbose(const char *format, ... ); //(until C99)
int verbose(const char * restrict format, ... ); //(since C99)
bool getVerbose(void);
void setVerbose(bool);
