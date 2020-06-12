#include <stdbool.h>

/* Define the package copyright notice. */
#define PACKAGE_COPYRIGHT const char * COPYRIGHT = "\n\tCopyright © 2017 Michele Santullo\n\tCopyright © 2020 James Cuzella";

#define PACKAGE_LICENSE const char * LICENSE = "License: GPL-3+\n"\
       "This program is free software; you can redistribute it and/or modify\n"\
       "it under the terms of the GNU General Public License as published by\n"\
       "the Free Software Foundation; either version 3 of the License, or\n"\
       "(at your option) any later version.\n"\
       "\n"\
       "This package is distributed in the hope that it will be useful,\n"\
       "but WITHOUT ANY WARRANTY; without even the implied warranty of\n"\
       "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\n"\
       "GNU General Public License for more details.\n"\
       "\n"\
       "You should have received a copy of the GNU General Public License\n"\
       "along with this program. If not, see <https://www.gnu.org/licenses/>\n"\
       "\n"\
       "On Debian systems, the complete text of the GNU General\n"\
       "Public License version 3 can be found in \"/usr/share/common-licenses/GPL-3\".\n";

// autotools generated config.h handles restrict keyword
// GNU C++ compiler likes to have __attribute__ format for printf variadic calls
int verbose(const char * restrict format, ... ) __attribute__ ((format (printf, 1, 2))); //(since C99)
bool getVerbose(void);
void setVerbose(bool);
