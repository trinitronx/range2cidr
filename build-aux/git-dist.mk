# Automake support for git-based release and distribution management
#
#
# Copyright © 2009-2010  Roger Leigh <rleigh@debian.org>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see
# <http://www.gnu.org/licenses/>.
#
#####################################################################

# Include this file in your top-level Makefile.am using
#   include $(top_srcdir)/scripts/git-dist.mk
# (for example)
# Note that this script uses GNU make-specific functions, and so run
# automake with -Wno-portability or add this to the automake options
# in configure.ac.

# Customise using the following variables.  See below for instructions
# on what each variable does.  Note that these could be overridden in
# the Makefile including this Makefile fragment, so this file doesn't
# need editing directly.

# Check for untracked files in working tree
GIT_CHECK_UNTRACKED=true

# GPG sign release tags
GIT_RELEASE_TAG_SIGN=true
# Naming scheme for release tags.  Note: must include $(VERSION)
GIT_RELEASE_TAG_NAME=release/$(PACKAGE)-$(VERSION)
# Message for release tags
GIT_RELEASE_TAG_MESSAGE="Release of $(PACKAGE)-$(VERSION)"

# GPG sign distribution tags
GIT_DIST_TAG_SIGN=true
# Branch to place distributed release on
GIT_DIST_BRANCH="distribution-$(VERSION)"
# Message for distribution commit
GIT_DIST_COMMIT_MESSAGE="Distribution of $(PACKAGE) version $(VERSION)"
# Naming scheme for distribution tags.  Note: must include $(VERSION)
GIT_DIST_TAG_NAME=distribution/$(PACKAGE)-$(VERSION)
# Message for distribution tags
GIT_DIST_TAG_MESSAGE="Distribution of $(PACKAGE)-$(VERSION)"
# Release to distribute
GIT_DIST_ROOT=$(distdir)

# Check that the working tree and index are clean prior to making any
# changes.  If dirty, then the changes may be unreproducible and not
# match what was expected.  For example, the distributed files may not
# match those actually committed or may not even be under version
# control.
#
# Project customisation:
# Checking of untracked files may be disabled by setting
# GIT_CHECK_UNTRACKED to false.
check-git:
	@cd "$(abs_top_srcdir)"; \
	if [ ! -d .git ]; then \
	    echo "$@: Not a git repository" 1>&2; \
	    exit 1; \
	fi; \
	git diff-index --quiet HEAD; \
	case $$? in \
	  0) \
	    if [ "$(GIT_CHECK_UNTRACKED)" == "true" ]; then \
	      exclude_options=""; \
	      git ls-files --others --exclude-standard --exclude="$(GIT_DIST_ROOT)" --error-unmatch . >/dev/null 2>&1; \
	      case $$? in \
	        0) \
	          echo "$@: Untracked files present in working tree"; \
	          exit 1; \
	          ;; \
	        1) \
	          : \
	          ;; \
	        *) \
	          echo "$@: Error checking working tree"; \
	          exit 1; \
	          ;; \
	      esac; \
	    fi; \
	    ;; \
	  1) \
	    echo "$@: Uncommitted changes in working tree"; \
	    exit 1; \
	    ;; \
	  *) \
	    echo "$@: Error checking git index"; \
	    exit 1; \
	    ;; \
	esac;

# Make a release.
#
# The current working tree is tagged as a new release.  If the release
# tag already exists then the operation will do nothing if the tag
# matches the current working tree, or else it will abort with an
# error.  If the repository has been accidentally tagged previously,
# then remove the tag with "git tag -d TAG" before releasing.
#
# NOTE: Set ENABLE_RELEASE_GIT=true when running make.  This is a
# safety check to avoid accidental damage to the git repository.
#
# NOTE: Running release-git independently of dist-git is NOT
# RECOMMENDED.  The distdir rule can update files in the working tree
# (for example, gettext translations in po/), so running "make
# distdir" prior to tagging the release will ensure the tagged release
# will not differ from the distributed release.
#
# Project customisation:
# The tag will be signed by default; set GIT_RELEASE_TAG_SIGN to
# alter.  The tag will be named using GIT_RELEASE_TAG_NAME with the
# GIT_RELEASE_TAG_MESSAGE specifying an appropriate message for the
# tag.
release-git:
	@cd "$(abs_top_srcdir)"; \
	if [ ! -d .git ]; then \
	    echo "$@: Not a git repository" 1>&2; \
	    exit 1; \
	fi; \
	if git show-ref --tags -q $(GIT_RELEASE_TAG_NAME); then \
	  echo "$@: git release tag $(GIT_RELEASE_TAG_NAME) already exists; not releasing" 1>&2; \
	  exit 0; \
	fi; \
	if [ "$(ENABLE_RELEASE_GIT)" != "true" ]; then \
	  echo "$@: ENABLE_RELEASE_GIT not true; not releasing"; \
	  exit 1; \
	fi; \
	$(MAKE) $(AM_MAKEFLAGS) check-git; \
	echo "$@: releasing $(PACKAGE)-$(VERSION)"; \
	RELEASE_TAG_OPTS=""; \
	if [ "$(GIT_RELEASE_TAG_SIGN)" = "true" ]; then \
	  RELEASE_TAG_OPTS="$$TAG_OPTS -s"; \
	fi; \
	git tag -m $(GIT_RELEASE_TAG_MESSAGE) $$RELEASE_TAG_OPTS "$(GIT_RELEASE_TAG_NAME)" HEAD || exit 1; \
	echo "$(PACKAGE) $(VERSION) release tagged as $(GIT_RELEASE_TAG_NAME)";

# Make a distribution of a release.
#
# A distribution is created and committed onto the specified branch.
# The commit is then tagged.  The distribution commit will have the
# release commit and the previous distribution (if any) as its
# parents.  Thus distribution releases appear to git as merges (with
# the exception of the initial release).
#
# NOTE: Set ENABLE_DIST_GIT=true when running make, plus
# ENABLE_RELEASE_GIT=true if the working tree has not already been
# tagged with a release tag.  This is a safety check to avoid
# accidental damage to the git repository.
#
# Project customisation:
# GIT_DIST_COMMIT_MESSAGE specifies the commit message for the commit,
# and GIT_DIST_BRANCH specifies the branch to add the commit to.
# The tag will be signed by default; set GIT_DIST_TAG_SIGN to
# alter.  The tag will be named using GIT_DIST_TAG_NAME with the
# GIT_DIST_TAG_MESSAGE specifying an appropriate message for the
# tag.
dist-git: distdir
	$(MAKE) $(AM_MAKEFLAGS) release-git ENABLE_RELEASE_GIT="$(ENABLE_RELEASE_GIT)"; \
	RELEASE_COMMIT="$$(git rev-parse $(GIT_RELEASE_TAG_NAME)^{})"; \
	HEAD_COMMIT="$$(git rev-parse HEAD)"; \
	if [ "$$RELEASE_COMMIT" != "$$HEAD_COMMIT" ]; then \
	  echo "$@: Working tree is not at $(GIT_RELEASE_TAG_NAME)^{} $$RELEASE_COMMIT; not distributing"; \
	  exit 1; \
	fi; \
	$(MAKE) $(AM_MAKEFLAGS) check-git; \
	$(MAKE) $(AM_MAKEFLAGS) dist-git-generic ENABLE_DIST_GIT="$(ENABLE_DIST_GIT)" GIT_DIST_ROOT="$(abs_top_builddir)/$(distdir)"; \
	$(am__remove_distdir)

# Make a distribution of an arbitrary release.
#
# The same as dist-git, but this allows addition of any distribution
# rather than just the release in the current working tree.  This rule
# is intended for allowing retrospective addition of a project's
# entire release history (driven by a shell script), for example.
# See below for an example of how to do this.
#
# GIT_DIST_ROOT must be set to specify the release to distribute and
# VERSION must match the release version.  GIT_DIST_BRANCH may also
# require setting if not using the default.  GIT_RELEASE_TAG_NAME must
# be set to the tag name of the existing release.
dist-git-generic: $(GIT_DIST_ROOT)
	@cd "$(abs_top_srcdir)"; \
	if [ ! -d .git ]; then \
	    echo "$@: Not a git repository" 1>&2; \
	    exit 1; \
	fi; \
	if git show-ref --tags -q $(GIT_DIST_TAG_NAME); then \
	  echo "$@: git distribution tag $(GIT_DIST_TAG_NAME) already exists; not distributing" 1>&2; \
	  exit 1; \
	fi; \
	if [ "$(ENABLE_DIST_GIT)" != "true" ]; then \
	  echo "$@: ENABLE_DIST_GIT not true; not distributing"; \
	  exit 0; \
	fi; \
	echo "$@: distributing $(PACKAGE)-$(VERSION) on git branch $(GIT_DIST_BRANCH)"; \
	DIST_INDEX="$(abs_top_builddir)/.git-dist-index"; \
	DIST_TREE="$(GIT_DIST_ROOT)"; \
	rm -f "$$DIST_INDEX"; \
	GIT_INDEX_FILE="$$DIST_INDEX" GIT_WORK_TREE="$$DIST_TREE" git add -A || exit 1; \
	TREE="$$(GIT_INDEX_FILE="$$DIST_INDEX" git write-tree)"; \
	rm -f "$$DIST_INDEX"; \
	[ -n "$$TREE" ] || exit 1; \
	RELEASE_COMMIT="$$(git rev-parse $(GIT_RELEASE_TAG_NAME)^{})"; \
	COMMIT_OPTS="-p $$RELEASE_COMMIT"; \
	DIST_PARENT="$$(git show-ref --heads -s refs/heads/$(GIT_DIST_BRANCH))"; \
	if [ -n "$$DIST_PARENT" ]; then \
	  COMMIT_OPTS="$$COMMIT_OPTS -p $$DIST_PARENT"; \
	fi; \
	COMMIT="$$(echo $(GIT_DIST_COMMIT_MESSAGE) | git commit-tree "$$TREE" $$COMMIT_OPTS)"; \
	[ -n "$$COMMIT" ] || exit 1; \
	git update-ref "refs/heads/$(GIT_DIST_BRANCH)" "$$COMMIT" "$$DIST_PARENT" || exit 1;\
	if [ -n "$$DIST_PARENT" ]; then \
	  NEWROOT="(root-commit) "; \
	fi; \
	echo "[$(GIT_DIST_BRANCH) $${NEWROOT}$$COMMIT] $(GIT_DIST_COMMIT_MESSAGE)"; \
	DIST_TAG_OPTS=""; \
	if [ "$(GIT_DIST_TAG_SIGN)" = "true" ]; then \
	  DIST_TAG_OPTS="$$TAG_OPTS -s"; \
	fi; \
	git tag -m $(GIT_DIST_TAG_MESSAGE) $$DIST_TAG_OPTS "$(GIT_DIST_TAG_NAME)" "$$COMMIT" || exit 1; \
	echo "$@: $(PACKAGE) $(VERSION) distribution tagged as $(GIT_DIST_TAG_NAME)";

.PHONY: check-git release-git dist-git dist-git-generic

# Example: How to retrospectively insert the complete distribution
# history for a project.  Note: GIT_RELEASE_TAG_NAME must match the
# pattern used to tag all previous releases since this requires tags
# for all releases.
#
# #!/bin/sh
#
# set -e
#
# # Clean up any existing distribution branches and tags which could
# # interfere with addition of a complete clean distribution history.
# git tag -l | grep distribution | while read tag; do
#   git tag -d $tag
# done;
# git branch -l | grep distribution | while read branch; do
#   git branch -D $branch
# done;
#
# # Read an ordered list of versions from release-versions and get
# # distribution for each version from the given path and distribute
# # in git
# while read version; do
#   make dist-git-generic GIT_DIST_ROOT="/path/to/unpacked/releases/$package-$version" VERSION="$version" ENABLE_DIST_GIT=true
# done < release-versions

# Example: How to check that the added distributions are correctly
# representing the content of the old distributed releases following
# import as in the above example.
#
# #!/bin/sh
#
# set -e
#
# # For each version in the list of releases, check out and unpack
# # that version, and then compare it with the original.
# while read version; do
#   git checkout distribution/package-$version
#   rm -rf /tmp/package-$version
#   mkdir /tmp/package-$version
#   git archive HEAD | tar -x -C /tmp/$package-$version
#   diff -urN /tmp/$package-$version "/path/to/unpacked/releases/$package-$version" | lsdiff
#   rm -rf /tmp/package-$version
# done < release-versions
