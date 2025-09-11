import 'package:dio/dio.dart';

Dio buildDio() {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://rickandmortyapi.com/api/',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout:  const Duration(seconds: 15),
  ));
  dio.interceptors.add(LogInterceptor(requestBody: false, responseBody: false));
  return dio;
}
