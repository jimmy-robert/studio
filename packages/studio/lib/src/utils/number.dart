extension NumberExtension on num {
  num shorten() => this % 1 == 0 ? round() : this;
}
