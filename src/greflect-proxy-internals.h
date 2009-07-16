
#ifndef __GREFLECT_PROXY_INTERNALS_H__
#define __GREFLECT_PROXY_INTERNALS_H__

#include <glib.h>
#include <glib-object.h>
#include <greflect-proxy.h>
#include <greflect-proxy-internals-stripped.h>

G_BEGIN_DECLS


#define REFLECT_TYPE_PROXY_IMPL (reflect_proxy_impl_get_type ())
#define REFLECT_PROXY_IMPL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), REFLECT_TYPE_PROXY_IMPL, ReflectProxyImpl))
#define REFLECT_PROXY_IMPL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), REFLECT_TYPE_PROXY_IMPL, ReflectProxyImplClass))
#define REFLECT_IS_PROXY_IMPL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), REFLECT_TYPE_PROXY_IMPL))
#define REFLECT_IS_PROXY_IMPL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), REFLECT_TYPE_PROXY_IMPL))
#define REFLECT_PROXY_IMPL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), REFLECT_TYPE_PROXY_IMPL, ReflectProxyImplClass))

typedef struct _ReflectProxyImpl ReflectProxyImpl;
typedef struct _ReflectProxyImplClass ReflectProxyImplClass;
typedef struct _ReflectProxyImplPrivate ReflectProxyImplPrivate;

struct _ReflectProxyImpl {
	ReflectProxy parent_instance;
	ReflectProxyImplPrivate * priv;
};

struct _ReflectProxyImplClass {
	ReflectProxyClass parent_class;
};


ReflectProxyImpl* reflect_proxy_impl_construct (GType object_type, ReflectInvocationHandler* handler);
ReflectProxyImpl* reflect_proxy_impl_new (ReflectInvocationHandler* handler);
GType reflect_proxy_impl_get_type (void);


G_END_DECLS

#endif
