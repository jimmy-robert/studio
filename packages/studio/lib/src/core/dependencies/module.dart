part of 'dependency.dart';

class Module extends StatelessWidget {
  final List<Dependency> _dependencies;
  final Widget? child;

  Module({
    Key? key,
    List<Dependency>? dependencies,
    this.child,
  })  : _dependencies = dependencies ?? [],
        super(key: key);

  Module.fromModule({
    Key? key,
    required Module module,
    this.child,
  })  : _dependencies = module._dependencies,
        super(key: key);

  @core.override
  Widget build(BuildContext context) {
    final providers = _dependencies.map((dependency) => dependency._provider).toList();
    return MultiProvider(
      providers: providers,
      child: child,
    );
  }

  void dependency<T>(ValueGetter<T> create) {
    _dependencies.add(Dependency<T>(create: create));
  }

  void factory<T>(ValueGetter<T> create) {
    _dependencies.add(Dependency.factory<T>(create));
  }

  void clear() => _dependencies.clear();

  void add<T>(Dependency<T> dependency) {
    _dependencies.add(dependency);
  }

  void remove<T>() {
    _dependencies.removeWhere((element) => element.type == T);
  }

  void removeLast<T>() {
    _dependencies.removeLastWhere((element) => element.type == T);
  }

  void override<T>(Dependency<T> dependency) {
    _dependencies.replaceWhere(dependency, (value) => value.type == T);
  }

  void insertBefore<T>(Dependency dependency) {
    _dependencies.insertBeforeWhere(dependency, (value) => value.type == T);
  }

  void insertBeforeLast<T>(Dependency dependency) {
    _dependencies.insertBeforeLastWhere(dependency, (value) => value.type == T);
  }

  void insertAfter<T>(Dependency dependency) {
    _dependencies.insertAfterWhere(dependency, (value) => value.type == T);
  }

  void insertAfterLast<T>(Dependency dependency) {
    _dependencies.insertAfterLastWhere(dependency, (value) => value.type == T);
  }
}
