extension NumberExtension on num {
  num shorten() {
    if (this == null) return null;
    return this % 1 == 0 ? round() : this;
  }
}
