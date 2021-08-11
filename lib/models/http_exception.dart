class HttpExcetion implements Exception {
  final String message;
  HttpExcetion(this.message);
  @override
  String toString() {
    return message;
  }
}
