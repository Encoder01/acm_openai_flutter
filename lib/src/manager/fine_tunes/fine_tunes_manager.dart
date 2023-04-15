import 'package:acm_open_ai_flutter/src/client/client.dart';
import 'package:acm_open_ai_flutter/src/core/constants/constansts.dart';
import 'package:acm_open_ai_flutter/src/model/fine_tune/request/fine_tune_req.dart';
import 'package:acm_open_ai_flutter/src/model/fine_tune/response/fine_tune_delete_res.dart';
import 'package:acm_open_ai_flutter/src/model/fine_tune/response/fine_tune_res.dart';
import 'package:acm_open_ai_flutter/src/routes/fine_tunes/fine_tunes_route.dart';
import 'package:dio/dio.dart';

class ACMOpenAIFineTunesManager {
  final ACMOpenAINetworkingClient _client;

  ACMOpenAIFineTunesManager(this._client);

  final _cancel = CancelToken();

  Future<ACMOpenAIFineTuneResponse> create(ACMOpenAICreateFineTuneRequest request) async {
    return _client.post(kURL + FineTunesRoute.create, request.toJson(),
        onSuccess: (val) => ACMOpenAIFineTuneResponse.fromJson(val));
  }

  Future<List<ACMOpenAIFineTuneResponse>> list() async {
    return _client.get(
      kURL + FineTunesRoute.list,
      onSuccess: (val) {
        final data = val['data'] as List;
        return data.map((e) => ACMOpenAIFineTuneResponse.fromJson(e)).toList();
      },
      cancelToken: _cancel,
    );
  }

  Future<ACMOpenAIFineTuneResponse> retrieve(String fineTuneId) async {
    return _client.get(
      "$kURL${FineTunesRoute.retrieve}/$fineTuneId",
      onSuccess: (val) => ACMOpenAIFineTuneResponse.fromJson(val),
      cancelToken: _cancel,
    );
  }

  Future<ACMOpenAIFineTuneResponse> cancel(String fineTuneId) async {
    return _client.post(
      "$kURL${FineTunesRoute.cancel}/$fineTuneId/cancel",
      {},
      onSuccess: (val) => ACMOpenAIFineTuneResponse.fromJson(val),
      cancelToken: _cancel,
    );
  }

  Future<ACMOpenAIFineTuneDeleteResponse> delete(String model) {
    return _client.delete(
      "$kURL${FineTunesRoute.delete}/$model",
      onSuccess: (val) => ACMOpenAIFineTuneDeleteResponse.fromJson(val),
      cancelToken: _cancel,
    );
  }

  Stream<List<ACMOpenAIFineTuneResponse>> listStream(String fineTuneId) {
    return _client.getStream(
      "$kURL${FineTunesRoute.listEvents}/$fineTuneId/events",
      onSuccess: (val) {
        final data = val['data'] as List;
        return data.map((e) => ACMOpenAIFineTuneResponse.fromJson(e)).toList();
      },
      cancelToken: _cancel,
    );
  }

  ///cancel file
  void cancelFileTune() {
    _client.log("stop openAI");
    _cancel.cancel();
  }
}
