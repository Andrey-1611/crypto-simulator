import 'package:dio/dio.dart';

class NetworkInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == .connectionError || err.type == .connectionTimeout) {
      return handler.reject(err.copyWith(error: NoInternetException()));
    }
    return handler.next(err);
  }
}

class NoInternetException implements Exception {}
