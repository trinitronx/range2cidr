#####################################################################
# range2cidr Makefile template
#
#
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

ACLOCAL_AMFLAGS=-I m4

include $(top_srcdir)/build-aux/git-dist.mk

SUBDIRS=src man
RM=rm -f
MAINTAINERCLEANFILES = .tarball-version .version
EXTRA_DIST = README.md HACKING.md CHANGELOG.md .chglog/* .github/*

# See build-aux/git-version-gen script for details on .*version file usage
BUILT_SOURCES = $(top_srcdir)/.version
$(top_srcdir)/.version:
	echo $(VERSION) > $@-t && mv $@-t $@
dist-hook:
	echo $(VERSION) > $(distdir)/.tarball-version
	echo $(VERSION) > $(distdir)/.version
# Remove junk from the generated tarball.
	$(FIND) $(distdir) -name '#*' -print | $(XARGS) $(RM) -rf
	$(FIND) $(distdir) -name '*~' -print | $(XARGS) $(RM) -rf

# Clean all files autoreconf poops out
GITCLEANFILES = Makefile.in src/Makefile.in man/Makefile.in \
				$(AC_BUILD_AUX_DIR)/config.guess $(AC_BUILD_AUX_DIR)/config.sub configure \
				$(AC_BUILD_AUX_DIR)/depcomp $(AC_BUILD_AUX_DIR)/install-sh \
				$(AC_BUILD_AUX_DIR)/missing $(AC_BUILD_AUX_DIR)/compile \
				aclocal.m4 autoscan.log config.h.in
clean-local-am: maintainer-clean maintainer-clean-am
	$(RM) $(GITCLEANFILES)
