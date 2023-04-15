import 'package:acm_open_ai_flutter/src/client/client.dart';
import 'package:acm_open_ai_flutter/src/core/constants/constansts.dart';
import 'package:acm_open_ai_flutter/src/model/edits/request/edit_req.dart';
import 'package:acm_open_ai_flutter/src/model/edits/response/edit_res.dart';
import 'package:acm_open_ai_flutter/src/routes/Edits/edits_route.dart';
import 'package:dio/dio.dart';

class ACMOpenAIEditsManager {
  ACMOpenAINetworkingClient _client;

  ACMOpenAIEditsManager(this._client);

  final _cancel = CancelToken();

  Future<ACMOpenAIEditResponse> prompt(ACMOpenAIEditRequest request) {
    return _client.post(kURL + EditsRoute.create, request.toJson(), onSuccess: (val) {
      return ACMOpenAIEditResponse.fromJson(val);
    }, cancelToken: _cancel);
  }

  ///cancel edit
  void cancelEdit() {
    _client.log("stop openAI edit");
    _cancel.cancel();
  }
}
