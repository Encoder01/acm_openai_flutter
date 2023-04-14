import 'package:dio/dio.dart';

abstract class ACMOpenAINetworkingClientWrapper {
  Future<T> get<T>(String url,
      {required T Function(Map<String, dynamic>) onSuccess, CancelToken? cancelToken});

  Stream<T> getStream<T>(String url,
      {required T Function(Map<String, dynamic>) onSuccess, CancelToken? cancelToken});

  Future<T> delete<T>(String url,
      {required T Function(Map<String, dynamic>) onSuccess, CancelToken? cancelToken});

  Future<T> post<T>(String url, T Function(Map<String, dynamic>) request,
      {required T Function(Map<String, dynamic>) onSuccess, CancelToken? cancelToken});

  Stream<Response> postStream<T>(String url, T Function(Map<String, dynamic>) request,
      {CancelToken? cancelToken});

  Stream<T> sse<T>(String url, T Function(Map<String, dynamic>) request,
      {required T Function(Map<String, dynamic> value) complete, CancelToken? cancelToken});

  Future<T> postFormData<T>(String url, FormData request,
      {required T Function(Map<String, dynamic> value) complete, CancelToken? cancelToken});
}
