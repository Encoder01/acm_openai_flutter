import 'package:acm_open_ai_flutter/src/client/client.dart';
import 'package:acm_open_ai_flutter/src/core/constants/constansts.dart';
import 'package:acm_open_ai_flutter/src/model/moderation/request/moderation_req.dart';
import 'package:acm_open_ai_flutter/src/model/moderation/response/moderation_res.dart';
import 'package:acm_open_ai_flutter/src/routes/Moderations/moderations_route.dart';
import 'package:dio/dio.dart';

class ACMOpenAIModerationsManager {
  final ACMOpenAINetworkingClient _client;

  ACMOpenAIModerationsManager(this._client);

  final _cancel = CancelToken();

  Future<ACMOpenAIModerationResponse> create(ACMOAIModerationsRequest request) async {
    return _client.post(
      kURL + ModerationsRoute.create,
      request.toJson(),
      onSuccess: (it) => ACMOpenAIModerationResponse.fromJson(it),
      cancelToken: _cancel,
    );
  }

  ///cancel moderation
  void cancelModeration() {
    _client.log("stop openAI Moderation");
    _cancel.cancel();
  }
}
