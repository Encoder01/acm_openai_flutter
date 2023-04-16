import 'dart:io';

import 'package:acm_open_ai_flutter/acm_open_ai_sdk.dart';
import 'package:acm_open_ai_flutter/src/client/client.dart';
import 'package:acm_open_ai_flutter/src/core/exceptions/missing_clearance.dart';
import 'package:acm_open_ai_flutter/src/core/exceptions/missing_session.dart';
import 'package:acm_open_ai_flutter/src/core/interceptor/interceptors.dart';
import 'package:acm_open_ai_flutter/src/core/interfaces/acm_openai_interface.dart';
import 'package:acm_open_ai_flutter/src/core/logger/logger.dart';
import 'package:acm_open_ai_flutter/src/core/session/keep_session.dart';
import 'package:acm_open_ai_flutter/src/manager/chat_complete/chat_manager.dart';
import 'package:acm_open_ai_flutter/src/manager/complete_text/completions_manager.dart';
import 'package:acm_open_ai_flutter/src/manager/conversation/conversation_manager.dart';
import 'package:acm_open_ai_flutter/src/manager/edits/edits_manager.dart';
import 'package:acm_open_ai_flutter/src/manager/embeddings/embeddings_manager.dart';
import 'package:acm_open_ai_flutter/src/manager/files/files_manager.dart';
import 'package:acm_open_ai_flutter/src/manager/fine_tunes/fine_tunes_manager.dart';
import 'package:acm_open_ai_flutter/src/manager/images/images_manager.dart';
import 'package:acm_open_ai_flutter/src/manager/moderations/moderations_manager.dart';
import 'package:dio/dio.dart';

import 'core/exceptions/missing_token.dart';
import 'core/token/keep_token.dart';
import 'manager/audio/audio_manager.dart';

class ACMOpenAI extends IACMOpenAI {
  ACMOpenAI._();

  late Dio _dio;
  late ACMOpenAINetworkingClient _client;
  static final ACMOpenAI instance = ACMOpenAI._();

  factory ACMOpenAI() {
    return instance;
  }

  Dio get dio => instance._dio;

  String get token => "${TokenBuilder.instance.token}";

  String get orgId => "${TokenBuilder.instance.orgId}";

  // String get session => "${SessionBuilder.instance.session}";

  // String get clearance => "${SessionBuilder.instance.clearance}";

  set showLogs(bool val) => ACMOpenAILogger.isActive = val;

  void setToken(String token) {
    TokenBuilder.instance.setToken(token);
  }

/*  void setSession(String session) {
    SessionBuilder.instance.setSession(session);
  }

  void setClearance(String clearance) {
    SessionBuilder.instance.setClearance(clearance);
  }*/

  void setOrgId(String orgId) {
    TokenBuilder.instance.setOrgId(orgId);
  }

  ACMOpenAI init({
    String? token,
    bool isLog = false,
  }) {
    if ("$token".isEmpty) throw MissionTokenException();

    BaseOptions options = BaseOptions(
        contentType: Headers.jsonContentType,
        sendTimeout: const Duration(seconds: 40),
        receiveTimeout: const Duration(seconds: 40),
        connectTimeout: const Duration(seconds: 40),
        headers: {
          'accept': 'application/json, text/javascript, */*; q=0.01',
        });
    setToken(token!);

    _dio = Dio(options);
    _dio.interceptors.add(CustomInterceptors());

    _client = ACMOpenAINetworkingClient(dio: _dio, isLogging: isLog);
    return instance;
  }

  //ACMOpenAIConversationManager get conversation => ACMOpenAIConversationManager(instance);

  ACMOpenAIAudioManager get audio => ACMOpenAIAudioManager(_client);

  ACMOpenAIChatManager get chat => ACMOpenAIChatManager(_client);

  ACMOpenAICompleteTextManager get complete => ACMOpenAICompleteTextManager(_client);

  ACMOpenAIEditsManager get edits => ACMOpenAIEditsManager(_client);

  ACMOpenAIEmbeddingsManager get embedding => ACMOpenAIEmbeddingsManager(_client);

  ACMOpenAIFilesManager get file => ACMOpenAIFilesManager(_client);

  ACMOpenAIFineTunesManager get fineTune => ACMOpenAIFineTunesManager(_client);

  ACMOpenAIImagesManager get image => ACMOpenAIImagesManager(_client);

  ACMOpenAIModerationsManager get moderation => ACMOpenAIModerationsManager(_client);
}
