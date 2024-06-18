import 'dart:convert';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  final String authHeader;

  LoggingInterceptor(this.authHeader);
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final bytes = utf8.encode(authHeader);
    final base64Str = base64.encode(bytes);
    options.headers['Authorization'] = 'Basic $base64Str';
    options.headers['Content-Type'] = Headers.jsonContentType;
    options.responseType = ResponseType.plain;
    options.validateStatus = (status) {
      return status! < 401;
    };
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    response.data = jsonDecode(response.data);
    super.onResponse(response, handler);
    print('Response data: ${response.data}');
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final error = jsonDecode(err.response!.data);
    super.onError(err, handler);
    print('Error data: $error');
  }
}
