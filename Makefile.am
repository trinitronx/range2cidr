
ACLOCAL_AMFLAGS=-I m4
SUBDIRS=src man
RM=rm -f
MAINTAINERCLEANFILES = .tarball-version .version

# See build-aux/git-version-gen script for details on .*version file usage
BUILT_SOURCES = $(top_srcdir)/.version
$(top_srcdir)/.version:
	echo $(VERSION) > $@-t && mv $@-t $@
dist-hook:
	echo $(VERSION) > $(distdir)/.tarball-version
	echo $(VERSION) > $(distdir)/.version

# Clean all files autoreconf poops out
GITCLEANFILES = Makefile.in src/Makefile.in man/Makefile.in \
				$(AC_BUILD_AUX_DIR)/config.guess $(AC_BUILD_AUX_DIR)/config.sub configure \
				$(AC_BUILD_AUX_DIR)/depcomp $(AC_BUILD_AUX_DIR)/install-sh \
				$(AC_BUILD_AUX_DIR)/missing $(AC_BUILD_AUX_DIR)/compile \
				aclocal.m4 autoscan.log config.h.in
clean-local-am: maintainer-clean maintainer-clean-am
	$(RM) $(GITCLEANFILES)
