
<a name="distribution/range2cidr-0.0.5"></a>
## [distribution/range2cidr-0.0.5](https://github.com/trinitronx/range2cidr/compare/release/range2cidr-0.0.5...distribution/range2cidr-0.0.5)

> 2020-06-12

### Distribution

* Distribution of range2cidr version 0.0.5


<a name="release/range2cidr-0.0.5"></a>
## [release/range2cidr-0.0.5](https://github.com/trinitronx/range2cidr/compare/v0.0.5...release/range2cidr-0.0.5)

> 2020-06-12


<a name="v0.0.5"></a>
## [v0.0.5](https://github.com/trinitronx/range2cidr/compare/v0.0.4...v0.0.5)

> 2020-06-12

### Add

* Add GPL-3+ copyright notice to autotools input files
* Add internal verbose.h to noinst_HEADERS (so make dist tarball will compile!)
* Add format attribute to verbose / printf variadic function call

### Adding

* Adding extra clean steps to dist-hook for pristine tarball
* Adding Roger Leigh's git-dist.mk Automake template from schroot project

### Ensure

* Ensure manpage is included in dist tarball

### Fix

* Fix GNU-ism in git-dist Makefile template

### Hook

* Hook up git-dist Makefile.am include

### Ignore

* Ignore autom4te.cache files

### Link

* Link configure script revision to git-version-gen output

### Move

* Move manpage to man/ dir & tell autotools about it

### Refactor

* Refactor autotools generated config.h includes


<a name="v0.0.4"></a>
## [v0.0.4](https://github.com/trinitronx/range2cidr/compare/v0.0.3...v0.0.4)

> 2020-06-09

### Add

* Add some missed files to clean during clean-local-am
* Add --version (-V) option with GPL-3+ notice
* Add friendly configure output for Header & Library checks
* Add initial popt implementation of command line flag parsing
* Add clean-local-am autoreconf clean target
* Add GNOME version of git-version-gen script

### Hook

* Hook up AX_IS_RELEASE & AX_COMPILER_FLAGS to automake CXXFLAGS, LDFLAGS
* Hook autoconf & automake into using git-version-gen + .*version files

### Only

* Only remove .*version files during maintainer-clean target

### Reimplement

* Reimplement argv processing with ptopt when HAVE_LIBPOPT defined

### Replace

* Replace all printf with new verbose() function

### Switch

* Switch to pulseaudio's git-version-gen script

### Update

* Update manpage & pull it into upstream branch

### Vendor

* Vendor autoconf-archive AX_IS_RELEASE & AX_COMPILER_FLAGS M4 templates


<a name="v0.0.3"></a>
## [v0.0.3](https://github.com/trinitronx/range2cidr/compare/v0.0.2...v0.0.3)

> 2020-06-08

### Add

* Add configure checks for boost library & headers


<a name="v0.0.2"></a>
## [v0.0.2](https://github.com/trinitronx/range2cidr/compare/v0.0.1...v0.0.2)

> 2020-06-08

### Add

* Add autoconf / automake generated files to: make maintainer-clean target

### Embed

* Embed COPYING & INSTALL files that automake wants into the repo

### Get

* Get *FLAGS vars from dpkg-buildflags

### Move

* Move source files to src/

### Switching

* Switching to autoconf / automake

### Vendor

* Vendor autoconf-archive boost M4 templates


<a name="v0.0.1"></a>
## v0.0.1

> 2020-06-07

### Add

* Add README

### Adding

* Adding range2cidr initial code

### Fix

* Fix space formatting

