using GLib;

namespace Reflect {

	public class Method {
		public string name { get; private set; }
		public Parameter return_value { get; private set; }
		public Parameter[] parameters { get; private set; }
	}

	public enum Direction {
		In, Out, Ref
	}

	public class Parameter {
		public Type type { get; private set; }
		public Direction direction { get; private set; }
		public bool is_nullable { get; private set; }
		public bool is_owned { get; private set; }
	}

	private static Method get_method(Type type, string name) {
		
	}
}
