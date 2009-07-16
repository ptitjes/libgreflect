using GLib;
using Introspection;
using FFi;

namespace Reflect {

	private Repository get_introspection_repository() {
			Repository.prepend_search_path(Environment.get_current_dir());

			Repository repository = Repository.get_default();
			repository.require("Test");
			
			return repository;
	}
	
	private HashTable<Type, Classifier> per_type_classifier;
	
	public Classifier get_classifier(Type type) {
		if (per_type_classifier == null) {
			per_type_classifier = new HashTable<Type, Classifier>(int_hash, int_equal);
		}

		Classifier? classifier = per_type_classifier.lookup(type);
		if (classifier == null) {
			if (type.is_object()) {
				classifier = new Class(type);
			} else if (type.is_interface()) {
				classifier = new Interface(type);
			}
			per_type_classifier.insert(type, classifier);
		}
		
		return classifier;
	}

	public abstract class Classifier : Object {
		private Classifier(Type type) {
			this.gtype = type;
		}

		public Type gtype { get; construct; }

		public string name {
			get {
				return gtype.name();
			}
		}

		private Method[] methods;

		public Method[] get_methods() {
			if (methods == null) {
				introspect_methods();
			}
			return methods;
		}

		public Method? get_method(string name) {
			foreach (Method method in methods) {
				if (method.name == name) {
					return method;
				}
			}
			return null;
		}

		private void introspect_methods() {
			Repository repository = get_introspection_repository();

			BaseInfo? base_info = repository.find_by_type(gtype);
			assert(base_info != null);

			methods = new Method[0];

			InfoType info_type = base_info.get_type();
			if(info_type == InfoType.INTERFACE) {
				InterfaceInfo iface_info = (InterfaceInfo*) base_info;

				for (int i = 0; i < iface_info.get_n_vfuncs(); i++) {
					VFuncInfo? func_info = iface_info.get_vfunc(i);
					Method method = new Method(gtype, func_info.get_invoker(), func_info);

					methods += method;
				}
			}
		}
	}

	public class Interface : Classifier {
		private Interface(Type type) {
			base(type);
		}
	}

	public class Class : Classifier {
		private Class(Type type) {
			base(type);
		}
		
		public Object? new_instance() {
			return null;
		}
	}

	public class Method : Object {

		private Method(Type type, FunctionInfo function_info, VFuncInfo? vfunc_info = null) {
			this.declaring_type = type;
			this.function_info = function_info;
			this.vfunc_info = vfunc_info;
			if (vfunc_info != null) {
				_callback_info = vfunc_info.get_callback();
			}
			
			message("method name: %s", function_info.get_name());
			message("invoker flags: %d", function_info.get_flags());
			message("vfunc flags: %d", vfunc_info.get_flags());
		}

		public Type declaring_type { get; private set; }

		private FunctionInfo? function_info;
		private VFuncInfo? vfunc_info;
		private CallbackInfo? _callback_info;

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

		internal CallbackInfo? callback_info {
			get {
				return _callback_info;
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
