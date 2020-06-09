
ACLOCAL_AMFLAGS=-I m4
SUBDIRS=src
RM=rm -f
MAINTAINERCLEANFILES = .tarball-version .version

# See build-aux/git-version-gen script for details on .*version file usage
BUILT_SOURCES = $(top_srcdir)/.version
$(top_srcdir)/.version:
	echo $(VERSION) > $@-t && mv $@-t $@
dist-hook:
	echo $(VERSION) > $(distdir)/.tarball-version
	echo $(VERSION) > $(distdir)/.version

