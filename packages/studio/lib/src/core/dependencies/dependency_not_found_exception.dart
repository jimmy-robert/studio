class DependencyNotFoundException implements Exception {
  final Type valueType;

  final Type widgetType;

  const DependencyNotFoundException(
    this.valueType,
    this.widgetType,
  );

  @override
  String toString() {
    return 'Error: Could not find the correct Dependency<$valueType> above this $widgetType Widget';
  }
}
