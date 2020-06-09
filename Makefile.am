
ACLOCAL_AMFLAGS=-I m4
SUBDIRS=src
CC=gcc
CXX=g++
RM=rm -f
#AM_CPPFLAGS=-g $(shell dpkg-buildflags --get CPPFLAGS)
#LDFLAGS=-g $(shell dpkg-buildflags --get LDFLAGS)
#LDLIBS=$(shell root-config --libs)
MAINTAINERCLEANFILES = Makefile.in autom4te.cache/ configure depcomp install-sh missing src/Makefile.in

# See build-aux/git-version-gen script for details on .*version file usage
BUILT_SOURCES = $(top_srcdir)/.version
$(top_srcdir)/.version:
	echo $(VERSION) > $@-t && mv $@-t $@
dist-hook:
	echo $(VERSION) > $(distdir)/.tarball-version
	echo $(VERSION) > $(distdir)/.version

