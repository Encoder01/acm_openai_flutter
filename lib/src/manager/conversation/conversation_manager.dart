import 'dart:convert';
import 'dart:io';

import 'package:acm_open_ai_flutter/acm_open_ai_sdk.dart';
import 'package:acm_open_ai_flutter/src/core/utils/expiry_map.dart';
import 'package:acm_open_ai_flutter/src/model/conversation/request/conv_req.dart';
import 'package:acm_open_ai_flutter/src/model/conversation/response/conv_res.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

class ACMOpenAIConversationManager {
  ACMOpenAI openAI;

  ACMOpenAIConversationManager(this.openAI);

  final ExpiryMap<String, String> _accessTokenCache = ExpiryMap<String, String>();

  Future<ACMOpenAIConversationResponse> sendMessage(
    String message, {
    String? conversationId,
    String? parentMessageId,
  }) async {
    final accessToken = await _refreshAccessToken();
    parentMessageId ??= const Uuid().v4();

    final data = ACMOpenAIConversationRequest(
      action: 'next',
      conversationId: conversationId,
      messages: [
        Prompt(
          content: PromptContent(contentType: 'text', parts: [message]),
          id: const Uuid().v4(),
          role: 'user',
        )
      ],
      model: 'text-davinci-002-render',
      parentMessageId: parentMessageId,
    );

    const url = '$backendApiBaseUrl/conversation';

    final response = await openAI.dio.post(
      url,
      data: data.toJson(),
      options: Options(headers: {
        'user-agent': kdefaultUserAgent,
        'x-openai-assistant-app-id': '',
        'accept-language': 'en-US,en;q=0.9',
        HttpHeaders.accessControlAllowOriginHeader: 'https://chat.openai.com',
        HttpHeaders.refererHeader: 'https://chat.openai.com/chat',
        'sec-ch-ua': '"Not?A_Brand";v="8", "Chromium";v="108", "Google Chrome";v="108"',
        'sec-ch-ua-platform': '"Windows"',
        'sec-fetch-dest': 'empty',
        'sec-fetch-mode': 'cors',
        'sec-fetch-site': 'same-origin',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
        'Accept': 'text/event-stream',
        'Cookie': 'cf_clearance={openAI.clearance}'
      },)
    );

    if (response.statusCode != 200) {
      if (response.statusCode == 429) {
        throw Exception('Rate limited');
      } else {
        throw Exception('Failed to send message');
      }
    } else if (kerrorMessages.contains(response.data)) {
      throw Exception('OpenAI returned an error');
    }

    String longestLine = response.data.split('\n').reduce((a, b) => a.length > b.length ? a : b);

    var result = longestLine.replaceFirst('data: ', '');

    var messageResult = ConversationResponseEvent.fromJson(result);

    var lastResult = messageResult.message?.content.parts.first;

    if (lastResult == null) {
      throw Exception('No response from OpenAI');
    } else {
      return ACMOpenAIConversationResponse(
        message: lastResult,
        messageId: messageResult.message!.id,
        conversationId: messageResult.conversationId,
      );
    }
  }

  Future<String> _refreshAccessToken() async {
    final cachedAccessToken = _accessTokenCache['KEY_ACCESS_TOKEN'];
    if (cachedAccessToken != null) {
      return cachedAccessToken;
    }

    try {
      final res = await openAI.dio.get('$apiBaseUrl/auth/session',
          options: Options(
            headers: {
              'cookie': 'cf_clearance={openAI.clearance};__Secure-next-auth.session-token={openAI.session}',
              'accept': '*/*',
              //...openAI.defaultHeaders,
            },
          ));

      if (res.statusCode != 200) {
        throw Exception('Failed to refresh access token');
      }

      final accessToken = jsonDecode(res.data)['accessToken'];

      if (accessToken == null) {
        throw Exception('Failed to refresh access token, token in response is null');
      }

      _accessTokenCache['KEY_ACCESS_TOKEN'] = accessToken;
      return accessToken;
    } catch (err) {
      throw Exception('ChatGPT failed to refresh auth token: $err');
    }
  }
}
