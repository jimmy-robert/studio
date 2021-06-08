class ScreenNotFoundException implements Exception {
  final String url;

  const ScreenNotFoundException(this.url);

  @override
  String toString() {
    return 'Error: Could not find the correct Screen for this url: $url';
  }
}
