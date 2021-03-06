#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.
#####################################################################
# Copyright © 2020  James Cuzella <james.cuzella@lyraphase.com>
#
# range2cidr is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# range2cidr is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see
# <http://www.gnu.org/licenses/>.
#
#####################################################################

AC_PREREQ([2.69])
AC_INIT([range2cidr], [m4_esyscmd_s(build-aux/git-version-gen .tarball-version)],
        [james.cuzella@lyraphase.com], [range2cidr],
        [https://github.com/trinitronx/range2cidr])

AC_REVISION([Revision: m4_esyscmd_s(build-aux/git-version-gen .tarball-version)])

AC_CONFIG_SRCDIR([src])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_AUX_DIR([build-aux])
AC_SUBST(AC_BUILD_AUX_DIR, 'build-aux')

AC_COPYRIGHT(
[
Copyright © 2020  James Cuzella <james.cuzella@lyraphase.com>

range2cidr is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

range2cidr is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see
<http://www.gnu.org/licenses/>.
])

AM_INIT_AUTOMAKE([-Wall -Werror foreign subdir-objects tar-pax])

# Checks for programs.
AC_PROG_CXX
AC_PROG_CC
AC_PROG_AWK
AC_PROG_INSTALL
AC_PROG_MKDIR_P
AC_PATH_PROG([FIND], [find])
AC_PATH_PROG([XARGS], [xargs])

# Set WARN_CXXFLAGS dependent on release
# See: https://www.gnu.org/software/autoconf-archive/ax_compiler_flags.html
AX_IS_RELEASE([git-directory])
AX_COMPILER_FLAGS([], [], [$ax_is_release])

# Checks for libraries.
AC_CHECK_LIB(popt, poptGetContext,,
	[AC_MSG_ERROR([You need popt 1.7 or newer to compile.])])
AC_CHECK_LIB([popt], [poptGetArg], [popt_links=yes],
             [AC_MSG_ERROR([You need popt 1.7 or newer to compile.])])

#AC_CHECK_LIB(c, dlopen, LIBDL="", AC_CHECK_LIB(dl, dlopen, LIBDL="-ldl"))
#AC_SEARCH_LIBS([string_ref], [boost], [], [
#  AC_MSG_ERROR([unable to find string_ref()])
#])

AC_LANG_PUSH(C++)
AX_BOOST_BASE([1.60], [], [
    AC_MSG_ERROR([unable to find libboost])
  ])

# Checks for header files.
AC_CHECK_HEADERS([arpa/inet.h netinet/in.h unistd.h])
AC_CHECK_HEADERS([boost/utility/string_ref.hpp boost/range/algorithm/copy.hpp])
AC_CHECK_HEADER([popt.h],
    [AC_DEFINE([HAVE_POPT_H], [1],
      [Define to 1 if you have <popt.h>.])],
    [AC_MSG_ERROR([unable to find libpopt])])
AC_LANG_POP(C++)

# Checks for typedefs, structures, and compiler characteristics.
AC_CHECK_HEADER_STDBOOL
AC_C_RESTRICT
AC_TYPE_UINT32_T

# Checks for library functions.
AC_CHECK_FUNCS([inet_ntoa])

AC_CONFIG_FILES([Makefile src/Makefile man/Makefile])
AC_OUTPUT

AC_MSG_NOTICE([
------------------------------------------------------------------------
  $PACKAGE_NAME $PACKAGE_VERSION:  Automatic configuration OK.
    Compiler support:
      C99 header stdbool.h: .......... ${ac_cv_header_stdbool_h}
      C99 restrict keyword: .......... ${ac_cv_c_restrict}
      C99 uint32_t: .................. ${ac_cv_c_uint32_t}
    Header checks:
      popt.h: ........................ ${ac_cv_header_popt_h}
    Library checks:
      libpopt poptGetContext(): ...... ${ac_cv_lib_popt_poptGetContext}
      libpopt poptGetArg(): .......... ${ac_cv_lib_popt_poptGetArg}
    General configuration:
      Enable popt options lib: ....... ${ac_cv_header_popt_h}
------------------------------------------------------------------------
 Type "make; make install" to compile and install
 Type "make check" to run the test suite
])
