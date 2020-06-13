
<a name="v0.0.6"></a>
## [v0.0.6](https://github.com/trinitronx/range2cidr/compare/distribution/range2cidr-0.0.5...v0.0.6)

> 2020-06-13

### Bug Fixes

* **git-chglog:** CHANGELOG GoTemplate now supports commit messages without special "type(scope): Subject" format

### Features

* Adding HACKING.md docs about how to work on this repo
* **GitHub Actions:** Adding GitHub Release Workflow


<a name="distribution/range2cidr-0.0.5"></a>
## [distribution/range2cidr-0.0.5](https://github.com/trinitronx/range2cidr/compare/release/range2cidr-0.0.5...distribution/range2cidr-0.0.5)

> 2020-06-12

* Distribution of range2cidr version 0.0.5

<a name="release/range2cidr-0.0.5"></a>
## [release/range2cidr-0.0.5](https://github.com/trinitronx/range2cidr/compare/v0.0.5...release/range2cidr-0.0.5)

> 2020-06-12


<a name="v0.0.5"></a>
## [v0.0.5](https://github.com/trinitronx/range2cidr/compare/v0.0.4...v0.0.5)

> 2020-06-12

* .gitgnore all autotools generated files
* Adding extra clean steps to dist-hook for pristine tarball
* Add GPL-3+ copyright notice to autotools input files
* Link configure script revision to git-version-gen output
* Hook up git-dist Makefile.am include
* Fix GNU-ism in git-dist Makefile template
* Adding Roger Leigh's git-dist.mk Automake template from schroot project
* Refactor autotools generated config.h includes
* Ensure manpage is included in dist tarball
* Move manpage to man/ dir & tell autotools about it
* Ignore autom4te.cache files
* Un-ignore autotools generated files required for source distribution
* bootstrap.sh now calls autogen.sh - FULL initial autotools bootstrap
* Add internal verbose.h to noinst_HEADERS (so make dist tarball will compile!)
* Add format attribute to verbose / printf variadic function call

<a name="v0.0.4"></a>
## [v0.0.4](https://github.com/trinitronx/range2cidr/compare/v0.0.3...v0.0.4)

> 2020-06-09

* Add some missed files to clean during clean-local-am
* Update manpage & pull it into upstream branch
* Add --version (-V) option with GPL-3+ notice
* Add friendly configure output for Header & Library checks
* Reimplement argv processing with ptopt when HAVE_LIBPOPT defined
* Replace all printf with new verbose() function
* Add initial popt implementation of command line flag parsing
* Add clean-local-am autoreconf clean target
* Hook up AX_IS_RELEASE & AX_COMPILER_FLAGS to automake CXXFLAGS, LDFLAGS
* Vendor autoconf-archive AX_IS_RELEASE & AX_COMPILER_FLAGS M4 templates
* Only remove .*version files during maintainer-clean target
* Hook autoconf & automake into using git-version-gen + .*version files
* Switch to pulseaudio's git-version-gen script
* Add GNOME version of git-version-gen script

<a name="v0.0.3"></a>
## [v0.0.3](https://github.com/trinitronx/range2cidr/compare/v0.0.2...v0.0.3)

> 2020-06-08

* Add configure checks for boost library & headers

<a name="v0.0.2"></a>
## [v0.0.2](https://github.com/trinitronx/range2cidr/compare/v0.0.1...v0.0.2)

> 2020-06-08

* Embed COPYING & INSTALL files that automake wants into the repo
* Add autoconf / automake generated files to: make maintainer-clean target
* bootstrap.sh: Run automake --install-missing
* Vendor autoconf-archive boost M4 templates
* Switching to autoconf / automake
* Move source files to src/
* Get *FLAGS vars from dpkg-buildflags
* Makefile: List .PHONY targets

<a name="v0.0.1"></a>
## v0.0.1

> 2020-06-07

* Add README
* Fix space formatting
* Adding range2cidr initial code
