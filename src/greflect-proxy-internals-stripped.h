
#ifndef __GREFLECT_PROXY_INTERNALS_STRIPPED_H__
#define __GREFLECT_PROXY_INTERNALS_STRIPPED_H__

#include <glib.h>
#include <glib-object.h>

G_BEGIN_DECLS


#define REFLECT_TYPE_PROXY_TYPE_PLUGIN (reflect_proxy_type_plugin_get_type ())
#define REFLECT_PROXY_TYPE_PLUGIN(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), REFLECT_TYPE_PROXY_TYPE_PLUGIN, ReflectProxyTypePlugin))
#define REFLECT_PROXY_TYPE_PLUGIN_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), REFLECT_TYPE_PROXY_TYPE_PLUGIN, ReflectProxyTypePluginClass))
#define REFLECT_IS_PROXY_TYPE_PLUGIN(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), REFLECT_TYPE_PROXY_TYPE_PLUGIN))
#define REFLECT_IS_PROXY_TYPE_PLUGIN_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), REFLECT_TYPE_PROXY_TYPE_PLUGIN))
#define REFLECT_PROXY_TYPE_PLUGIN_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), REFLECT_TYPE_PROXY_TYPE_PLUGIN, ReflectProxyTypePluginClass))

typedef struct _ReflectProxyTypePlugin ReflectProxyTypePlugin;
typedef struct _ReflectProxyTypePluginClass ReflectProxyTypePluginClass;
typedef struct _ReflectProxyTypePluginPrivate ReflectProxyTypePluginPrivate;

struct _ReflectProxyTypePlugin {
	GObject parent_instance;
	ReflectProxyTypePluginPrivate * priv;
};

struct _ReflectProxyTypePluginClass {
	GObjectClass parent_class;
};


ReflectProxyTypePlugin* reflect_proxy_type_plugin_get_default (void);
ReflectProxyTypePlugin* reflect_proxy_type_plugin_construct (GType object_type);
ReflectProxyTypePlugin* reflect_proxy_type_plugin_new (void);
GType reflect_proxy_type_plugin_get_type (void);

G_END_DECLS

#endif
