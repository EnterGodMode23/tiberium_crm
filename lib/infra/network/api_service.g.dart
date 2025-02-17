// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiService implements ApiService {
  _ApiService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://79.137.133.56:8118/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AuthResponse> smsLogin({required SmsLoginReq smsLoginReq}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(smsLoginReq.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<AuthResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/client_auth/login/sms',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AuthResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UsersList> getUsers() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<UsersList>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/tasks/users_to_assign',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = UsersList.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HarvestTaskList> getHarvestTasks() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<HarvestTaskList>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/tasks/harvest',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = HarvestTaskList.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SingleHarvestTaskResponse> postHarvestTask(
      {required CreateNewHarvestTaskReq createReq}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(createReq.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleHarvestTaskResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/tasks/harvest',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SingleHarvestTaskResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SingleHarvestTaskResponse> patchHarvestTasks({
    required String id,
    required String hTask,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = hTask;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleHarvestTaskResponse>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/tasks/harvest/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SingleHarvestTaskResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MainTaskResponse> getMainTasks() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<MainTaskResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/tasks/main',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = MainTaskResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SingleMainTaskResponse> patchMainTasks({
    required String id,
    required String hTask,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = hTask;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleMainTaskResponse>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/tasks/main/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SingleMainTaskResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SingleMainTaskResponse> postMainTask(
      {required CreateNewMainTaskReq createReq}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(createReq.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleMainTaskResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/tasks/main',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SingleMainTaskResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProcessingTaskList> getProcessingTasks() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ProcessingTaskList>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/tasks/processing',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ProcessingTaskList.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SingleProcessingTaskResponse> postProcessingTask(
      {required CreateNewProcTaskReq createReq}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(createReq.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleProcessingTaskResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/tasks/processing',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SingleProcessingTaskResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SingleProcessingTaskResponse> patchProcessingTasks({
    required String id,
    required String pTask,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = pTask;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleProcessingTaskResponse>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/tasks/processing/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SingleProcessingTaskResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
