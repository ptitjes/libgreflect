AUTOMAKE_OPTIONS = 

AM_CFLAGS = \
	$(VALA_CFLAGS) \
	$(GI_CFLAGS) \
	-include $(CONFIG_HEADER)

VALACFLAGS = \
	--vapidir vapi \
	--pkg vala-1.0 \
	--pkg ffi \
	--pkg gobject-introspection-1.0 \
	--pkg gobject-extended \
	--pkg greflect-proxy-internals
# \
#	--library GReflect-1.0

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
vapi_DATA = GReflect-1.0.vapi

typelibdir = `$(PKG_CONFIG) --variable=typelibdir gobject-introspection-1.0`
typelib_DATA = GReflect-1.0.typelib

girdir = `$(PKG_CONFIG) --variable=girdir gobject-introspection-1.0`
gir_DATA = GReflect-1.0.gir

libgreflect_la_SOURCES = \
	$(libgreflect_la_VALASOURCES:.vala=.c) \
	$(libgreflect_la_VALASOURCES:.vala=.h) \
	greflect-proxy-internals.c \
	greflect-proxy-internals.h \
	greflect-proxy-internals-stripped.h

libgreflect_la.vala.stamp: $(libgreflect_la_VALASOURCES)
	$(VALAC) -C ${VALACFLAGS} --basedir . $^
	touch $@

GReflect-1.0.typelib: GReflect-1.0.gir
	$(GIR_COMPILER) GReflect-1.0.gir -o GReflect-1.0.typelib

libgreflect_la_LIBADD = \
	$(VALA_LIBS) \
	$(GI_LIBS)

EXTRA_DIST = \
	greflect-proxy-internals.h \
	greflect-proxy-internals-stripped.h \
	greflect-proxy-internals.c \
	$(libgreflect_la_VALASOURCES) \
	libgreflect_la.vala.stamp

CLEANFILES = \
	greflect-model.h \
	greflect-model.c \
	greflect-proxy.h \
	greflect-proxy.c \
	*.gir \
	*.typelib \
	*.vapi \
	libgreflect_la.vala.stamp
