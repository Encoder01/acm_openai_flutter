import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:acm_open_ai_flutter/acm_open_ai_flutter.dart';
import 'package:acm_open_ai_flutter/src/core/exceptions/req_err.dart';
import 'package:acm_open_ai_flutter/src/core/interfaces/base_client.dart';
import 'package:acm_open_ai_flutter/src/core/logger/logger.dart';
import 'package:dio/dio.dart';

class ACMOpenAINetworkingClient extends ACMOpenAINetworkingClientWrapper {
  ACMOpenAINetworkingClient({bool isLogging = false}) {
    _dio = ACMOpenAI.instance.dio;
    ACMOpenAILogger.isActive = isLogging;
  }

  late Dio _dio;

  log(String message) {
    ACMOpenAILogger.log(message);
  }

  @override
  Future<T> get<T>(String url,
      {required T Function(Map<String, dynamic>) onSuccess, CancelToken? cancelToken}) async {
    try {
      log('starting request');
      final rawData = await _dio.get(url, cancelToken: cancelToken);
      if (rawData.statusCode == HttpStatus.ok) {
        log("========= success =========");
        return onSuccess(rawData.data);
      } else {
        log("error code: ${rawData.statusCode}, message :${rawData.data}");
        throw RequestError(message: "${rawData.data}", code: rawData.statusCode);
      }
    } on DioError catch (err) {
      log("error code: ${err.response?.statusCode}, message :${err.message} + ${err.response?.data}");
      throw RequestError(message: "${err.message}", code: err.response?.statusCode);
    }
  }

  @override
  Stream<T> getStream<T>(String url,
      {required T Function(Map<String, dynamic>) onSuccess, CancelToken? cancelToken}) {
    log("starting request");
    final controller = StreamController<T>.broadcast();

    _dio
        .get(url, cancelToken: cancelToken, options: Options(responseType: ResponseType.stream))
        .then((value) {
      (value.data.stream as Stream).listen(
          (event) {
            final rawData = utf8.decode(event);

            final dataList = rawData.split("\n").where((element) => element.isNotEmpty).toList();
            for (var line in dataList) {
              if (line.startsWith("data: ")) {
                final data = line.substring(6);
                if (data.startsWith("[DONE]")) {
                  log("stream response is done");
                  return;
                }
                controller
                  ..sink
                  ..add(onSuccess(json.decode(data)));
              }
            }
          },
          onDone: () => controller.close(),
          onError: (err, t) {
            log(err.toString());
            controller
              ..sink
              ..addError(err, t);
          });
    });
    return controller.stream;
  }

  @override
  Future<T> delete<T>(String url,
      {required T Function(Map<String, dynamic>) onSuccess, CancelToken? cancelToken}) async {
    try {
      log('starting request');
      final rawData = await _dio.delete(url, cancelToken: cancelToken);
      if (rawData.statusCode == HttpStatus.ok) {
        log("========= success =========");
        return onSuccess(rawData.data);
      } else {
        log("error code: ${rawData.statusCode}, message :${rawData.data}");
        throw RequestError(message: "${rawData.data}", code: rawData.statusCode);
      }
    } on DioError catch (err) {
      log("error code: ${err.response?.statusCode}, message :${err.message} + ${err.response?.data}");
      throw RequestError(message: "${err.message}", code: err.response?.statusCode);
    }
  }

  @override
  Future<T> post<T>(String url,Map<String, dynamic> request,
      {required T Function(Map<String, dynamic>) onSuccess, CancelToken? cancelToken}) async {
    try {
      log('starting request');
      final rawData = await _dio.post(url, data: json.encode(request), cancelToken: cancelToken);
      if (rawData.statusCode == HttpStatus.ok) {
        log("============= success ==================");
        return onSuccess(rawData.data);
      } else {
        log("error code: ${rawData.statusCode}, message :${rawData.data}");
        throw RequestError(message: "${rawData.data}", code: rawData.statusCode);
      }
    } on DioError catch (err) {
      log("error code: ${err.response?.statusCode}, message :${err.message} + ${err.response?.data}");
      throw RequestError(message: "${err.message}", code: err.response?.statusCode);
    }
  }

  @override
  Future<T> postFormData<T>(String url, FormData request,
      {required T Function(Map<String, dynamic> value) complete, CancelToken? cancelToken}) async {
    try {
      log('starting request');
      final response = await _dio.post(url, data: request, cancelToken: cancelToken);

      if (response.statusCode == HttpStatus.ok) {
        log("============= success ==================");
        final Map<String, dynamic> responseData = response.data;
        final T result = complete(responseData);
        return result;
      } else {
        throw DioError(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Server returned status code ${response.statusCode}',
        );
      }
    } on DioError catch (err) {
      log("error code: ${err.response?.statusCode}, message :${err.message} + ${err.response?.data}");
      throw RequestError(message: "${err.message}", code: err.response?.statusCode);
    }
  }

  @override
  Stream<Response> postStream<T>(String url, Map<String, dynamic> request,
      {CancelToken? cancelToken}) {
    try {
      final rawData =
          _dio.post(url, data: json.encode(request), cancelToken: cancelToken).asStream();

      return rawData;
    } catch (e) {
      throw DioError(
        requestOptions: RequestOptions(path: url),
        error: e.toString(),
      );
    }
  }

  @override
  Stream<T> sse<T>(String url, Map<String, dynamic> request,
      {required T Function(Map<String, dynamic> value) complete, CancelToken? cancelToken}) {
    log("starting request");
    log("request body :$request");
    final controller = StreamController<T>.broadcast();

    _dio
        .get(url, cancelToken: cancelToken, options: Options(responseType: ResponseType.stream))
        .then((value) {
      (value.data.stream as Stream).listen(
          (event) {
            final rawData = utf8.decode(event);

            final dataList = rawData.split("\n").where((element) => element.isNotEmpty).toList();
            for (var line in dataList) {
              if (line.startsWith("data: ")) {
                final data = line.substring(6);
                if (data.startsWith("[DONE]")) {
                  log("stream response is done");
                  return;
                }
                controller
                  ..sink
                  ..add(complete(json.decode(data)));
              }
            }
          },
          onDone: () => controller.close(),
          onError: (err, t) {
            log(err.toString());
            controller
              ..sink
              ..addError(err, t);
          });
    });
    return controller.stream;
  }
}
