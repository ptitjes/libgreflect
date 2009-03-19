using GLib;
using Introspection;
using FFi;

namespace Reflect {

	internal class MethodSet : Object {

		public MethodSet(Method[] methods) {
			this.methods = methods;
		}

		private Method[] methods;

		public unowned Method[] get_methods() {
			return methods;
		}

		public Method? from_name(string name) {
			foreach (Method method in methods) {
				if (method.name == name) {
					return method;
				}
			}
			return null;
		}

		private static HashTable<Type, MethodSet> per_type_methods = null;

		public static unowned MethodSet from_type(Type type) {
			if (per_type_methods == null) {
				per_type_methods = new HashTable<Type, MethodSet>(int_hash, int_equal);
			}

			unowned MethodSet? methods = per_type_methods.lookup(type);
			if (methods == null) {
				per_type_methods.insert(type, introspect_methods(type));
			}
			methods = per_type_methods.lookup(type);

			return methods;
		}

		private static MethodSet introspect_methods(Type type) {
			Repository.prepend_search_path(Environment.get_current_dir());

			Repository repository = Repository.get_default();
			repository.require("Test");

			BaseInfo? base_info = repository.find_by_type(type);
			assert(base_info != null);

			MethodSet methods = new MethodSet(new Method[0]);

			InfoType info_type = base_info.get_type();
			if(info_type == InfoType.INTERFACE) {
				InterfaceInfo iface_info = (InterfaceInfo*) base_info;

				for (int i = 0; i < iface_info.get_n_vfuncs(); i++) {
					VFuncInfo? func_info = iface_info.get_vfunc(i);
					methods.methods += new Method(type,
						func_info.get_invoker(),
						func_info);
				}
			}

			return methods;
		}
	}

	public class Method : Object {

		private Method(Type type, FunctionInfo function_info, VFuncInfo? vfunc_info = null) {
			this.declaring_type = type;
			this.function_info = function_info;
			this.vfunc_info = vfunc_info;
			
			message("method name: %s", function_info.get_name());
			message("invoker flags: %d", function_info.get_flags());
			message("vfunc flags: %d", vfunc_info.get_flags());
		}

		public static Method from_name(Type type, string name) {
			return MethodSet.from_type(type).from_name(name);
		}

		public Type declaring_type { get; private set; }

		private FunctionInfo? function_info;
		private  VFuncInfo? vfunc_info;

		public string name {
			get {
				return function_info.get_name();
			}
		}

		public bool is_virtual {
			get {
				return function_info.get_flags() == FunctionInfoFlags.WRAPS_VFUNC;
			}
		}

		internal int vfunc_offset {
			get {
				return vfunc_info.get_offset();
			}
		}

		public bool is_property_accessor { get; private set; }

		public Parameter return_value { get; private set; }

		private Parameter[] _parameters;
		public Parameter[] parameters {
			get {
				return _parameters;
			}
		}

		public Value? invoke(Object object, params Value[] arguments)
				throws Error {
			return null;
		}

		private FFi.Closure? _closure;
		internal unowned FFi.Closure? get_closure() {
			if (_closure == null) {
				FFi.CIF cif = FFi.CIF();
				_closure = vfunc_info.get_callback().prepare_closure(cif, closure_callback);
			}
			return _closure;
		}

		private void closure_callback(CIF? cif, void* result, void** args) {
			message("In inner callback");
		}
	}

	public enum Direction {
		IN, OUT, REF
	}

	public class Parameter : Object {
		
		public Type value_type { get; private set; }

		public Direction direction { get; private set; }

		public bool is_nullable { get; private set; }

		public bool is_owned { get; private set; }
	}
}
