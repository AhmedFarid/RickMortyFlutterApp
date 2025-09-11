class ServerExcpection implements Exception {
  final int? statusCode;
  final String message;
  ServerExcpection({this.statusCode, required this.message});
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}