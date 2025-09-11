class ServerException implements Exception {
  final int? statusCode;
  final String? message;
  ServerException({this.statusCode, required this.message});
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}
