<!--                                   -*- text/markdown -*- -->
Working on range2cidr
=====================

This document is a short guide to the conventions used in the range2cidr
project.


Building from git
-----------------

First, clone the git repository:

    git clone git@github.com:trinitronx/range2cidr.git
    cd range2cidr
    ./bootstrap.sh


`./bootstrap.sh` is required to bootstrap the autotools.  Once this is done,
you can run `./configure` just like from the release tarball.


Coding
------

The style should be apparent from the source.  It is the default Emacs
c++-mode style, with paired brackets aligned vertically.

* Indent using 2 spaces instead of TAB characters.
* Use 0 rather than NULL.
* Use C++ casts rather than C-style casts.
* Don't use `void *` unless there is no alternative.
* Add doxygen comments for everything; use `EXTRACT_ALL = NO` in
  `doc/range2cidr.dox` to check for missing or incomplete documentation.


Format strings
--------------

### **TODO:**

The sources use `boost::format` for type-safe formatted output.  Make
sure that the maximum number of options passed is the same as the
highest `%n%` in the format string.

The following styles are used

| Style        | Formatting    | Syntax |
|--------------|---------------|--------|
| Values       | Single quotes | `'`    |
| Example text | Double quotes | `\"`   |
| User input   | Double quotes | `\"`   |

These are transformed into proper UTF-8 quotes with `gettext`.


Documentation
-------------

All the documentation is in UNIX manual page format.  GNU `roff`
extensions are permitted, as is use of `tbl`.  Make sure the printed
output is as good as terminal display. **TODO:** Implement `make {ps,pdf}`
Run "`make ps`" or "`make pdf`" to
build the printed documentation.


The following styles are used:

| Style                 | Formatting               | Syntax                |
|-----------------------|--------------------------|-----------------------|
| New term              | Bold                     | `.B` or `\fB`         |
| Option definition     | Bold, args in italic     | `.BR` and `\fI`       |
| Option reference      | Italic                   | `.I` or `\fI`         |
| File definition       | Bold italic              | `\f[BI]`              |
| File reference        | Italic                   | `.I` or `\fI`         |
| Config key definition | Courier bold italic      | `\f[CBI]`             |
| Config key reference  | Courier italic           | `\f[CI]`              |
| Values                | Single quotes            | `\[oq]` and `\[cq]`   |
| Example text          | Double quotes            | `\[lq]` and `\[rq]`   |
| Cross references      | Italics in double quotes | `\[lq]\fI...\fP\[rq]` |
| Verbatim examples     | Courier                  | `\f[CR]`              |
| Verbatim user input   | Courier bold             | `\f[CB]`              |

Contributing Changes
--------------------

Once you're ready to contribute changes back to the main Git repository,
just file a Pull Request to this GitHub repo!  The default branch to merge into
should be `upstream`.  If you are trying to merge into `master` and you're not
a Debian package maintainer, then you're probably doing it wrong.

The `master` branch of this repo is special, and is used for maintaining the
Debian packaging files separately from the "pristine `upstream` source".

Maintainer Information
======================

The following information is for those maintaining the main GitHub repository
for this project.  Generally, contributors will not have to cut releases or
build Debian packages themselves. Of course, this information can be helpful
when forking this repo and setting up a similar release workflow.

Releasing
---------

This repository is where the distribution branches are stored (from which
the distribution tarballs are created with "`git archive`").

### GitHub Release Action & Changelog Commit Message Format

The releases on GitHub are created by a GitHub Actions Workflow.  The sources
for this workflow are under `.github/workflows/create-release.yml`.  This 
workflow watches for tag push events matching `distribution/range2cidr-*`, then
sets `$version` as a step output based on the final contents after the dash
`-` character.  Finally, it generates a dynamic changelog using
[`git-chglog`][git-chglog]. This is implemented in a GitHub Marketplace Action:
[`generate-changelog-with-git-chglog`][git-chglog-action]. Finally, it should
create a Release on GitHub using the generated `changelog` Markdown text.

The included `.chglog/CHANGELOG.tpl.md` template and `.chglog/config.yml` config
should support free-form commit message headers as changelog items.  It also
supports a more standardized format: "`type(scope): subject`"

This gets translated by the GoLang template into the actual `CHANGELOG.md` text.

#### For Example:

Assuming that the diff between tags `v0.0.6..distribution/range2cidr-0.0.6`
contains the following `git` commit headings:

    * fe6b624 feat: Adding HACKING.md docs about how to work on this repo
    * 3bfbc46 feat(GitHub Actions): Adding GitHub Release Workflow
    * 392baf9 fix(git-chglog): CHANGELOG GoTemplate now supports commit messages without special "type(scope): Subject" format
    * 8314131 Adding initial CHANGELOG.md
    * 079d4d4 Add git-chglog configs for nuuday/github-changelog-action

Would get translated to:

    <a name="v0.0.6"></a>
    ## [v0.0.6](https://github.com/trinitronx/range2cidr/compare/distribution/range2cidr-0.0.5...v0.0.6)
    
    > 2020-06-13
    
    ### Bug Fixes
    
    * **git-chglog:** CHANGELOG GoTemplate now supports commit messages without special "type(scope): Subject" format
    
    ### Features
    
    * Adding HACKING.md docs about how to work on this repo
    * **GitHub Actions:** Adding GitHub Release Workflow

#### Supported Git Commit Heading Tags

The supported "`type`" `Title` heading tags are:

    feat: Features
    fix: Bug Fixes
    perf: Performance Improvements
    refactor: Code Refactoring

[git-chglog]: https://github.com/git-chglog/git-chglog
[git-chglog-action]: https://github.com/marketplace/actions/generate-changelog-with-git-chglog

The branching model follows the recommended layout and naming from
the [`git-buildpackage` set of tools][1].

[1]: http://honk.sigxcpu.org/projects/git-buildpackage/manual-html/gbp.intro.html#gbp.repository

### Branching Model

* The `debian-branch` (the default branch name used in the Git™ repository is
  `master`) holds your current development work. That's the branch you usually
  cut your releases from and the default branch new upstream releases are
  merged onto.
  In this repository, our `debian-branch` is `master`. It is for maintaining
  and tracking changes to the Debian packaging files under: `debian/` directory.
  `master` branch is where you will build the debian package from, after merging
  the tagged `upstream-branch`, `upstream` into.
* The `upstream-branch` (the default branch name used in the Git™ repository
  is `upstream`) holds the upstream releases. In `git-buildpackage`, this can
  either be a branch you import to or a branch of an upstream Git™ repository
  you pull from.
  In this repository, it is included as the main development branch.
  The GNU Autotools input files, and all source code files are maintained and
  tracked here.  You will do most of your development work for the project's
  code on the `upstream` branch.
* In `git-buildpackage`, there is also a concept of a `pristine-tar` branch
  (the default branch name used in the Git™ repository is `pristine-tar`).
  It usually holds the necessary additional information to recreate the
  original tarball from the `upstream-branch`. In order to use this feature,
  you need to install the pristine-tar™ package.
  In this repository, we do not use `pristine-tar`.  The functionality provided
  by the `build-aux/git-dist.mk` Automake template performs this duty.
  This is because the `VERSION` of this project is controlled by Git™ tags.
  The `build-aux/git-version-gen` script is called in Autoconf's `AC_INIT` in
  `configure.ac`.  This script populates the `.version` and `.tarball-version`
  files when you run `autoconf`

### Package Versioning

As mentioned above, the `VERSION` of this project is controlled by Git™ tags.
This is mainly done by scripts and automake templates included in `build-aux`.

* `build-aux/git-version-gen`: Script derived from `GIT-VERSION-GEN`, which is
  from the GIT project: http://git.or.cz/.
  - Creates two version files:
    - `.tarball-version` - present only in a distribution tarball, and not in
      a checked-out repository (unless you have checked out a `distribution/*`
      tag or `distribution-*` branch). Created with contents that were learned
      at the last time autoconf was run, and used by `git-version-gen`.  Must
      not be present in either `$(srcdir)` or `$(builddir)` for
      `git-version-gen` to give accurate answers during normal development with
      a checked out tree, but must be present in a tarball when there is no
      version control system.
      Therefore, it cannot be used in any dependencies.  GNU makefile has
      hooks to force a reconfigure at distribution time to get the value
      correct, without penalizing normal development with extra reconfigures.
    - `.version` - present in a checked-out repository `release/*` tag,
      `distribution*` tag/branch, and in a distribution tarball.  Usable in
      dependencies, particularly for files that don't want to depend on
      `config.h` but do want to track version changes.
      Delete this file prior to any `autoconf` run where you want to rebuild
      files to pick up a version string change; and leave it stale to
      minimize rebuild time after unrelated changes to configure sources.

### Unit Tests

The code must pass the testsuite:

    make check

In order to make a release, the following must be done:

* Use a fresh clone or make sure the tree is pristine, including
  NO `debian/` directory (make sure it also does not contain any build
  material, which could be packaged if present).
* Make sure all generated files are up to date.  Run "`make dist`"
  and/or "`make distcheck`" to test that the distribution tarball contents
  will work with the generated autotools files. To double check this,
  Run:

        mkdir -p /tmp/install_test_prefix/
        ./configure --prefix=/tmp/install_test_prefix/
        make check && make && make install
        # Check the installed output tree looks OK:
        tree /tmp/install_test_prefix/

* Ensure that the distribution branch is branched locally.  For
  example, if making a `1.6.x` release, checkout
  `origin/distribution-1.6.0` as `distribution-1.6.0` e.g.

        VERSION=1.6.0
        git checkout -b distribution-$VERSION origin/distribution-$VERSION

  If this is the first release in a stable series, e.g. `1.6.0`,
  the local branch will be created automatically.  If you are basing off a newer
  distribution than is yet available in the remote Git repo, you will need to
  create such a branch with:

        VERSION=1.6.0
        git checkout upstream
        # Hack, and get code ready for release as needed
        # Ensure all your work is done, committed, and ready for release
        git checkout -b distribution-$VERSION


* Tag & Sign the release with standard GitHub tagging pattern (`vN.N.N`)
  Replace `N.N.N` with the actual version you are releasing:

        VERSION=N.N.N
        git tag -s v${VERSION}

* Make the release:

        make release-git ENABLE_RELEASE_GIT=true

  You will be prompted for your GPG key passphrase or 
  smart card PIN (e.g. for Yubikey GPG keys) in order to
  sign the release tag (`release/range2cidr-$VERSION`).
* Rebootstrap and reconfigure:

        ./bootstrap.sh
        ./config.status --recheck
        make

  This will ensure the release metadata in `VERSION` is up to date (it's
  generated from the release tag).  Double check that there are no
  modifed files.  **If there are, delete the release tag and start again!**
* Make the distribution:

        make dist-git ENABLE_DIST_GIT=true

  You will again be prompted for your GPG key passphrase, to sign the
  distribution tag (`distribution/range2cidr-$VERSION`).  This will also
  inject the distributed release onto the distribution-x.y branch.
  Verify with "`gitk distribution-x.y`" or 
  "`git log --graph --decorate --oneline --all --abbrev-commit`"
  that the distribution is sane,
  and ties in sanely with the previous distributions and releases.  If
  there's a mistake, delete the distribution tag and `git reset --hard` the
  `distribution-x.y.z` branch to its previous state.
* Make the distributed release tarball:

        git archive --format=tar --prefix=range2cidr-$VERSION/ distribution/range2cidr-$VERSION | xz --best > range2cidr-$VERSION.tar.xz

  This creates a tarball from the release tag.
* Push all branches and tags to the correct places:

        git push origin upstream
        git push origin release/range2cidr-$VERSION
        git push origin distribution-$VERSION
        git push origin distribution/range2cidr-$VERSION
        git push origin --tags


Building Debian Package
-----------------------

* Ensure all steps to create a release distribution & "pristine" tarball
  have been followed. Note: we are **NOT** using `gbp pristine-tar` here
  because all the above steps rely on the `.*version` files created by the
  `build-aux/git-version-gen` script, and the `make git-dist` GNU Makefile
  targets generated by the `build-aux/git-dist.mk` Automake template include.
* Fetch all remote refs & Checkout the `master` branch

        git fetch
        git checkout master

* Merge the latest `upstream` branch release into the `master` branch

        # Look at the latest available release tags
        git log --graph --decorate --oneline --all --abbrev-commit
        # Checkout master branch for Debian packaging
        git checkout master
        # Set VERSION environment variable to match the latest release tag found
        VERSION=0.0.6
        git merge release/range2cidr-${VERSION}

* Pull down a "pristine" distribution tarball from the git tags.

        uscan --verbose

* Make any necessary changes to the `debian/` directory files to update the
  packaging info.

        # Look at the latest available release tags
