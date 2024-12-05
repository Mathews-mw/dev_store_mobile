class HttpExceptions implements Exception {
  final msg;
  final statusCode;

  HttpExceptions({required this.msg, required this.statusCode});

  @override
  String toString() {
    return msg;
  }
}
