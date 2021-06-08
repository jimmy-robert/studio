T? _cast<T>(dynamic value) => value is T ? value : null;

const cast = _cast;

extension CastExtension on Object {
  T? cast<T>() => _cast(this);
}
