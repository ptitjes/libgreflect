
#include <greflect-proxy-internals.h>




enum  {
	REFLECT_PROXY_TYPE_PLUGIN_DUMMY_PROPERTY
};
static ReflectProxyTypePlugin* reflect_proxy_type_plugin__default = NULL;
static void reflect_proxy_type_plugin_real_use_plugin (GTypePlugin* base);
static void reflect_proxy_type_plugin_real_unuse_plugin (GTypePlugin* base);
static void reflect_proxy_type_plugin_real_complete_type_info (GTypePlugin* base, GType type, GTypeInfo* info, GTypeValueTable* value_table);
static void reflect_proxy_type_plugin_real_complete_interface_info (GTypePlugin* base, GType instance_type, GType interface_type, GInterfaceInfo* info);
static gpointer reflect_proxy_type_plugin_parent_class = NULL;
static GTypePluginClass* reflect_proxy_type_plugin_g_type_plugin_parent_iface = NULL;
static void reflect_proxy_type_plugin_finalize (GObject* obj);
enum  {
	REFLECT_PROXY_IMPL_DUMMY_PROPERTY
};
static gpointer reflect_proxy_impl_parent_class = NULL;




ReflectProxyImpl* reflect_proxy_impl_construct (GType object_type, ReflectInvocationHandler* handler) {
	ReflectProxyImpl* self;
	g_return_val_if_fail (handler != NULL, NULL);
	self = (ReflectProxyImpl*) reflect_proxy_construct (object_type, handler);
	return self;
}


ReflectProxyImpl* reflect_proxy_impl_new (ReflectInvocationHandler* handler) {
	return reflect_proxy_impl_construct (REFLECT_TYPE_PROXY_IMPL, handler);
}


static void reflect_proxy_impl_class_init (ReflectProxyImplClass * klass) {
	reflect_proxy_impl_parent_class = g_type_class_peek_parent (klass);
}


static void reflect_proxy_impl_instance_init (ReflectProxyImpl * self) {
}


GType reflect_proxy_impl_get_type (void) {
	static GType reflect_proxy_impl_type_id = 0;
	if (reflect_proxy_impl_type_id == 0) {
		static const GTypeInfo g_define_type_info = { sizeof (ReflectProxyImplClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) reflect_proxy_impl_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (ReflectProxyImpl), 0, (GInstanceInitFunc) reflect_proxy_impl_instance_init, NULL };
		reflect_proxy_impl_type_id = g_type_register_static (REFLECT_TYPE_PROXY, "ReflectProxyImpl", &g_define_type_info, 0);
	}
	return reflect_proxy_impl_type_id;
}



ReflectProxyTypePlugin* reflect_proxy_type_plugin_get_default (void) {
	ReflectProxyTypePlugin* _tmp1;
	if (reflect_proxy_type_plugin__default == NULL) {
		ReflectProxyTypePlugin* _tmp0;
		_tmp0 = NULL;
		reflect_proxy_type_plugin__default = (_tmp0 = reflect_proxy_type_plugin_new (), (reflect_proxy_type_plugin__default == NULL) ? NULL : (reflect_proxy_type_plugin__default = (g_object_unref (reflect_proxy_type_plugin__default), NULL)), _tmp0);
	}
	_tmp1 = NULL;
	return (_tmp1 = reflect_proxy_type_plugin__default, (_tmp1 == NULL) ? NULL : g_object_ref (_tmp1));
}


static void reflect_proxy_type_plugin_real_use_plugin (GTypePlugin* base) {
	ReflectProxyTypePlugin * self;
	self = (ReflectProxyTypePlugin*) base;
}


static void reflect_proxy_type_plugin_real_unuse_plugin (GTypePlugin* base) {
	ReflectProxyTypePlugin * self;
	self = (ReflectProxyTypePlugin*) base;
}


static void reflect_proxy_type_plugin_real_complete_type_info (GTypePlugin* base, GType type, GTypeInfo* info, GTypeValueTable* value_table) {
	ReflectProxyTypePlugin * self;
	self = (ReflectProxyTypePlugin*) base;
	info->class_size = sizeof (ReflectProxyImplClass);
	info->base_init = (GBaseInitFunc) NULL;
	info->base_finalize = (GBaseFinalizeFunc) NULL;
	info->class_init = (GClassInitFunc) reflect_proxy_impl_class_init;
	info->class_finalize = (GClassFinalizeFunc) NULL;
	info->class_data = NULL;
	info->instance_size = sizeof (ReflectProxyImpl);
	info->n_preallocs = 0;
	info->instance_init = (GInstanceInitFunc) reflect_proxy_impl_instance_init;
}


static void reflect_proxy_type_plugin_real_complete_interface_info (GTypePlugin* base, GType instance_type, GType interface_type, GInterfaceInfo* info) {
	ReflectProxyTypePlugin * self;
	self = (ReflectProxyTypePlugin*) base;
	info->interface_init = reflect_proxy_interface_init;
	info->interface_finalize = reflect_proxy_interface_finalize;
	info->interface_data = (void*)interface_type;
}


ReflectProxyTypePlugin* reflect_proxy_type_plugin_construct (GType object_type) {
	ReflectProxyTypePlugin * self;
	self = g_object_newv (object_type, 0, NULL);
	return self;
}


ReflectProxyTypePlugin* reflect_proxy_type_plugin_new (void) {
	return reflect_proxy_type_plugin_construct (REFLECT_TYPE_PROXY_TYPE_PLUGIN);
}


static void reflect_proxy_type_plugin_class_init (ReflectProxyTypePluginClass * klass) {
	reflect_proxy_type_plugin_parent_class = g_type_class_peek_parent (klass);
	G_OBJECT_CLASS (klass)->finalize = reflect_proxy_type_plugin_finalize;
}

static void reflect_proxy_type_plugin_g_type_plugin_interface_init (GTypePluginClass * iface) {
	reflect_proxy_type_plugin_g_type_plugin_parent_iface = g_type_interface_peek_parent (iface);
	iface->use_plugin = reflect_proxy_type_plugin_real_use_plugin;
	iface->unuse_plugin = reflect_proxy_type_plugin_real_unuse_plugin;
	iface->complete_type_info = reflect_proxy_type_plugin_real_complete_type_info;
	iface->complete_interface_info = reflect_proxy_type_plugin_real_complete_interface_info;
}


static void reflect_proxy_type_plugin_instance_init (ReflectProxyTypePlugin * self) {
}


static void reflect_proxy_type_plugin_finalize (GObject* obj) {
	ReflectProxyTypePlugin * self;
	self = REFLECT_PROXY_TYPE_PLUGIN (obj);
	G_OBJECT_CLASS (reflect_proxy_type_plugin_parent_class)->finalize (obj);
}


GType reflect_proxy_type_plugin_get_type (void) {
	static GType reflect_proxy_type_plugin_type_id = 0;
	if (reflect_proxy_type_plugin_type_id == 0) {
		static const GTypeInfo g_define_type_info = { sizeof (ReflectProxyTypePluginClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) reflect_proxy_type_plugin_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (ReflectProxyTypePlugin), 0, (GInstanceInitFunc) reflect_proxy_type_plugin_instance_init, NULL };
		static const GInterfaceInfo g_typeplugin_info = { (GInterfaceInitFunc) reflect_proxy_type_plugin_g_type_plugin_interface_init, (GInterfaceFinalizeFunc) NULL, NULL};
		reflect_proxy_type_plugin_type_id = g_type_register_static (G_TYPE_OBJECT, "ReflectProxyTypePlugin", &g_define_type_info, 0);
		g_type_add_interface_static (reflect_proxy_type_plugin_type_id, G_TYPE_TYPE_PLUGIN, &g_typeplugin_info);
	}
	return reflect_proxy_type_plugin_type_id;
}
