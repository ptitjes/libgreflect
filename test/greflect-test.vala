using Reflect;

namespace Test {

	public interface TestInterface : Object {
		public abstract void test_method();
	}

	public class MyInvocationHandler : InvocationHandler, Object {
		public Value? invoke(Object proxy, Method method, params Value[] arguments) throws Error {
			message("Yes");
			return null;
		}
	}

	public static void main(string[] args) {
		Method m = Method.from_name(typeof(TestInterface), "test_method");
		()m.get_closure()();
		
		TestInterface proxy =
			(TestInterface) Proxy.new_proxy_instance(
				new Type[] { typeof(TestInterface) }, new MyInvocationHandler());
		proxy.test_method();
	}
}
