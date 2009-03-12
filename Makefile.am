AUTOMAKE_OPTIONS = 

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = libmodulo.pc

SUBDIRS = \
	src \
	samples

EXTRA_DIST = \
	intltool-extract.in \
	intltool-update.in \
	intltool-merge.in

DISTCLEANFILES = \
	intltool-extract \
	intltool-update \
	intltool-merge \
	po/.intltool-merge-cache

MAINTAINERCLEANFILES = \
	Makefile.in Makefile aclocal.m4 config.guess \
	config.h.in config.sub configure install-sh \
	ltconfig ltmain.sh missing mkinstalldirs \
	stamp-h.in acconfig.h stamp-h depcomp
