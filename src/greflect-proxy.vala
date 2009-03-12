using GLib;

namespace Reflect {

	public errordomain ProxyClassError {
		TYPE_IS_CLASS,
		NOT_A_PROXY_INSTANCE
	}

	public interface InvocationHandler : Object {
		public abstract Value invoke(Object proxy, Method method, Value[] arguments)
			throws Error;
	}

	public class Proxy {

		private InvocationHandler handler;

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
			return Object.new(type, handler);
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

		private static Type get_proxy_class_v(Type[] interfaces)
				throws ProxyClassError {
			throw new ProxyClassError.TYPE_IS_CLASS("");
		}
	}
}
