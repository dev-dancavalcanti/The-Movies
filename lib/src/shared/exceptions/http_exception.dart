/// 400-399: client errors
///
/// 500-599: server errors
///
/// 999: connectivity error
///
class HttpException implements Exception {
  final int statusCode;
  final String message;

  const HttpException([this.statusCode = 0, this.message = '']);

  @override
  String toString() => "${(HttpException).toString()}: $statusCode: $message";
}
