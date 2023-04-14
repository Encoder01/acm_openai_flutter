library acm_open_ai_flutter;

import 'package:acm_open_ai_flutter/src/core/exceptions/api_key.dart';
import 'package:acm_open_ai_flutter/src/core/interceptor/interceptors.dart';
import 'package:acm_open_ai_flutter/src/core/interfaces/acm_openai_interface.dart';
import 'package:acm_open_ai_flutter/src/core/logger/logger.dart';
import 'package:dio/dio.dart';

class ACMOpenAI extends IACMOpenAI {
  late String _baseUrl;
  late String? _organization;
  late String? _apiKey;
  late Dio _dio;

  static final ACMOpenAI _instance = ACMOpenAI._();

  factory ACMOpenAI() {
    return _instance;
  }

  static ACMOpenAI get instance {
    if (_instance._apiKey == null) {
      throw MissingApiKeyException('You must set the api key '
          'before accessing the '
          'instance of this class.Example:OpenAI.apiKey = "Your API Key;"');
    }
    return _instance;
  }

  Dio get dio => _instance._dio;

  set apiKey(String apiKey) {
    _apiKey = apiKey;
  }

  set baseUrl(String baseUrl) {
    _baseUrl = baseUrl;
  }

  set organizationId(String orgId) {
    _organization = orgId;
  }

  set showLogs(bool val) => ACMOpenAILogger.isActive = val;

  ACMOpenAI._() {
    BaseOptions options = BaseOptions(
        contentType: Headers.jsonContentType,
        baseUrl: _baseUrl,
        sendTimeout: const Duration(seconds: 40),
        receiveTimeout: const Duration(seconds: 40),
        connectTimeout: const Duration(seconds: 40),
        headers: {
          'accept': 'application/json, text/javascript, */*; q=0.01',
        });
    _dio = Dio(options)..interceptors.add(CustomInterceptors());
  }
}
