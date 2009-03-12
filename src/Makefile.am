AUTOMAKE_OPTIONS = 

AM_CFLAGS = \
	$(VALA_CFLAGS) \
	$(GI_CFLAGS) \
	-include $(CONFIG_HEADER)

VALACFLAGS = \
	--pkg vala-1.0 \
	--pkg gobject-instrospection-1.0 \
	--library greflect-1.0

BUILT_SOURCES = \
	libgreflect_la.vala.stamp

lib_LTLIBRARIES = libgreflect.la

libgreflect_la_VALASOURCES = \
	greflect-model.vala \
	greflect-proxy.vala

libgreflectdir = $(includedir)/greflect
libgreflect_HEADERS = \
	greflect-model.h \
	greflect-proxy.h

vapidir = $(datadir)/vala/vapi
vapi_DATA = greflect-1.0.vapi

girdir = `$(PKG_CONFIG) --variable=girdir gobject-introspection-1.0`
gir_DATA = greflect-1.0.gir

libgreflect_la_SOURCES = \
	$(libgreflect_la_VALASOURCES:.vala=.c) \
	$(libgreflect_la_VALASOURCES:.vala=.h)

libgreflect_la.vala.stamp: $(libgreflect_la_VALASOURCES)
	$(VALAC) -C ${VALACFLAGS} --basedir . $^
	touch $@

libgreflect_la_LIBADD = \
	$(VALA_LIBS) \
	$(GI_LIBS)

EXTRA_DIST = \
	$(libgreflect_la_VALASOURCES) \
	libgreflect_la.vala.stamp

CLEANFILES = \
	*.c \
	*.h \
	*.gir \
	*.vapi \
	libgreflect_la.vala.stamp
