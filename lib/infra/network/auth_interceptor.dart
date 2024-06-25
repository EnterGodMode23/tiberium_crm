import 'dart:convert';

import 'package:dio/dio.dart';

import '../../app.dart';

class AuthInterceptor extends Interceptor {

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
  void onResponse(Response response, ResponseInterceptorHandler handler) async{
    response.data = jsonDecode(response.data);
    super.onResponse(response, handler);
    App.localStorage.setString('user', jsonEncode(response.data['data']['user']));
    App.localStorage.setString('role', response.data['data']['user']['role']);
    print('data - ${response.data}');
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final error = jsonDecode(err.response!.data);
    super.onError(err, handler);
    print('data - $error');
  }
}
