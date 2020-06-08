#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([range2cidr], [m4_esyscmd_s([git describe --abbrev=0 --dirty --always --tags])], [james.cuzella@lyraphase.com], [range2cidr], [https://github.com/trinitronx/range2cidr])
AC_CONFIG_SRCDIR([src])
AC_CONFIG_HEADERS([config.h])
AM_INIT_AUTOMAKE([-Wall -Werror foreign subdir-objects tar-pax])


# Checks for programs.
AC_PROG_CXX
AC_PROG_CC
AC_PROG_INSTALL

# Checks for libraries.
#AC_CHECK_LIB(c, dlopen, LIBDL="", AC_CHECK_LIB(dl, dlopen, LIBDL="-ldl"))
#AC_SEARCH_LIBS([string_ref], [boost], [], [
#  AC_MSG_ERROR([unable to find string_ref()])
#])

#AX_BOOST_BASE([1.60], [], [
#    AC_MSG_ERROR([unable to find boost::string_ref()])
#  ])
#AC_CHECK_LIB([boost], [string_ref], [LIBPTHREAD=true], [], [])



# Checks for header files.
AC_CHECK_HEADERS([arpa/inet.h netinet/in.h unistd.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_TYPE_UINT32_T

# Checks for library functions.
AC_CHECK_FUNCS([inet_ntoa])

AC_CONFIG_FILES([Makefile src/Makefile])
AC_OUTPUT
