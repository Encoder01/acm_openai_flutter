import 'dart:developer';

import 'package:acm_open_ai_flutter/src/core/constants/constansts.dart';
import 'package:acm_open_ai_flutter/src/core/token/keep_token.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll(kHeader("${TokenBuilder.instance.token}"));
    log(options.data.toString());
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('http status code => ${response.statusCode} \nresponse data => ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint('have Error [${err.response?.statusCode}] => Data: ${err.response?.data.toString()}');
    debugPrint('have Error [${err.response?.statusCode}] => Data: ${err.response?.extra.toString()}');
    debugPrint('have Error [${err.response?.statusCode}] => Data: ${err.response?.headers.map.toString()}');
    debugPrint('have Error [${err.response?.statusCode}] => Data: ${err.response?.statusMessage.toString()}');
    super.onError(err, handler);
  }
}
