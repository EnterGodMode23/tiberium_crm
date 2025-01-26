import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  final SharedPreferences localStorage = GetIt.I.get();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Content-Type'] = Headers.jsonContentType;
    options.responseType = ResponseType.plain;
    options.validateStatus = (status) {
      return status! < 401;
    };
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    response.data = jsonDecode(response.data);
    super.onResponse(response, handler);
    print('data - ${response.data}');
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final error = jsonDecode(err.response!.data);
    super.onError(err, handler);
    print('data - $error');
  }
}
