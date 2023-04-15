import 'package:acm_open_ai_flutter/src/client/client.dart';
import 'package:acm_open_ai_flutter/src/core/constants/constansts.dart';
import 'package:acm_open_ai_flutter/src/model/chat_complete/request/chat_complete_req.dart';
import 'package:acm_open_ai_flutter/src/model/chat_complete/response/chat_complete_res.dart';
import 'package:acm_open_ai_flutter/src/routes/chat_complete/chat_route.dart';
import 'package:dio/dio.dart';

class ACMOpenAIChatManager {
  ACMOpenAINetworkingClient _client;
  final _cancel = CancelToken();

  ACMOpenAIChatManager(this._client);

  Future<ACMOpenAIChatCompleteResponse> create(ACMOpenAIChatCompleteTextRequest request) async {
    return _client.post(kURL + ChatRoute.create, request.toJson(), onSuccess: (p0) {
      return ACMOpenAIChatCompleteResponse.fromJson(p0);
    }, cancelToken: _cancel);
  }

  Stream<ACMOpenAIChatCompleteResponse> createSSE(ACMOpenAIChatCompleteTextRequest request)  {
    return _client.sse(kURL + ChatRoute.create, request.toJson()..addAll({"stream": true}), complete: (p0) {
      return ACMOpenAIChatCompleteResponse.fromJson(p0);
    }, cancelToken: _cancel);
  }

  void cancelCreate() {
    _client.log("stop openAI Chat");
    _cancel.cancel();
  }
}
