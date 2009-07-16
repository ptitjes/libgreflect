using GLib;
using Introspection;
using FFi;

namespace Reflect {

	public errordomain ProxyClassError {
		NOT_AN_INTERFACE,
		NOT_A_PROXY_INSTANCE
	}

	public interface InvocationHandler : Object {
		public abstract Value? invoke(Object proxy, Method method, Value[] arguments)
			throws GLib.Error;
	}

	public abstract class Proxy : Object {

		public InvocationHandler handler { get; construct; }

		private static Type proxy_type = typeof(Proxy);

		protected Proxy(InvocationHandler handler) {
			this.handler = handler;
		}

		public static Type get_proxy_class(params Type[] interfaces)
				throws ProxyClassError {
			return get_proxy_class_v(interfaces);
		}

		public static Object new_proxy_instance(Type[] interfaces, InvocationHandler handler)
				throws ProxyClassError {
			Type type = get_proxy_class_v(interfaces);
			return Object.new(type, "handler", handler, null);
		}

		public static bool is_proxy_class(Type type) {
			return type.parent() == proxy_type;
		}

		public static InvocationHandler get_invocation_handler(Object proxy)
				throws ProxyClassError {
			if (!is_proxy_class(proxy.get_type())) {
				throw new ProxyClassError.NOT_A_PROXY_INSTANCE("Object is not a proxy instance");
			}
			return ((Proxy) proxy).handler;
		}

		private const int G_TYPE_INTERFACE_SIZE = 8;

		protected static void interface_init(void* iface, void* interface_data) {
			Type type = (Type) interface_data;
			message(type.name());

			Callback* callbacks = (Callback*) (iface + G_TYPE_INTERFACE_SIZE);

			Interface i = (Interface) Reflect.get_classifier(type);
			foreach (Method method in i.get_methods()) {
				CallbackInfo callback_info = method.callback_info;

				ProxyCallbackClosure method_closure = new ProxyCallbackClosure(method);

				FFi.CIF cif = FFi.CIF();
				FFi.Closure closure = callback_info.prepare_closure(cif, method_closure.closure_callback);

				int offset = method.vfunc_offset;
				*(callbacks + offset) = (void*) closure;
			}
		}

		protected static void interface_finalize(void* iface, void* interface_data) {
			Type type = (Type) interface_data;
			message(type.name());

			Callback* callbacks = (Callback*) (iface + G_TYPE_INTERFACE_SIZE);

			Interface i = (Interface) Reflect.get_classifier(type);
			foreach (Method method in i.get_methods()) {
				CallbackInfo callback_info = method.callback_info;

				int offset = method.vfunc_offset;
				FFi.Closure closure = (FFi.Closure) (*(callbacks + offset));

				callback_info.free_closure(closure);
			}
		}

		private class ProxyCallbackClosure {
			private ProxyCallbackClosure(Method method) {
				this.method = method;
			}

			private Method method;

			public void closure_callback(CIF? cif, void* result, void** args) {
				message("In inner callback");
			}
		}

		private static int proxy_id = 0;

		private static Type get_proxy_class_v(Type[] interfaces)
				throws ProxyClassError {

			foreach (Type i in interfaces) {
				if (!i.is_interface()) {
					throw new ProxyClassError.NOT_AN_INTERFACE(
						"Type '%s' is not an interface".printf(i.name()));
				}
			}

			unowned ProxyTypePlugin plugin = ProxyTypePlugin.get_default();
			string name = "Proxy_%d".printf(proxy_id++);

			Type type_id = TypeExt.register_dynamic (typeof(Proxy), name, plugin, 0);
			foreach (Type iface_type in interfaces) {
				TypeExt.add_interface_dynamic (type_id, iface_type, plugin);
			}
			return type_id;
		}
	}
}
