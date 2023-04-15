import 'package:acm_open_ai_flutter/src/client/client.dart';
import 'package:acm_open_ai_flutter/src/core/constants/constansts.dart';
import 'package:acm_open_ai_flutter/src/model/complete_text/request/complete_text_req.dart';
import 'package:acm_open_ai_flutter/src/model/complete_text/response/complete_text_res.dart';
import 'package:acm_open_ai_flutter/src/routes/complete_text/completions_route.dart';
import 'package:dio/dio.dart';

class ACMOpenAICompleteTextManager {
  ACMOpenAINetworkingClient _client;
  final _cancel = CancelToken();

  ACMOpenAICompleteTextManager(this._client);

  Future<ACMOpenAICompleteTextResponse> create(ACMOpenAICompleteTextRequest request)async {
    return await _client.post(kURL + CompletionsRoute.create, request.toJson(),
        onSuccess: (p0) {
      return ACMOpenAICompleteTextResponse.fromJson(p0);
    }, cancelToken: _cancel);
  }

  Stream<ACMOpenAICompleteTextResponse> createSSE(ACMOpenAICompleteTextRequest request) {
    return _client.sse(kURL + CompletionsRoute.create, request.toJson()..addAll({"stream": true}),
        complete: (p0) {
      return ACMOpenAICompleteTextResponse.fromJson(p0);
    }, cancelToken: _cancel);
  }

  void cancelCreate() {
    _client.log("stop openAI completion");
    _cancel.cancel();
  }
}
