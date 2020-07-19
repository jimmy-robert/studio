extension NumberExtension on num {
  num get short {
    if (this == null) return null;
    return this % 1 == 0 ? round() : this;
  }
}
