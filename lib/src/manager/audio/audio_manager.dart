import 'package:acm_open_ai_flutter/src/client/client.dart';
import 'package:acm_open_ai_flutter/src/core/constants/constansts.dart';
import 'package:acm_open_ai_flutter/src/model/audio/request/audio_req.dart';
import 'package:acm_open_ai_flutter/src/model/audio/response/audio_res.dart';
import 'package:acm_open_ai_flutter/src/routes/Audio/audio_rotute.dart';
import 'package:dio/dio.dart';

class ACMOpenAIAudioManager {
  final ACMOpenAINetworkingClient _client;

  ACMOpenAIAudioManager(this._client);

  final _cancel = CancelToken();

  Future<ACMOpenAIAudioResponse> transcribes(ACMOpenAIAudioRequest request) async {
    final mReq = await request.toJson();
    return _client.postFormData(
      kURL + AudioRoute.transcriptions,
      mReq,
      complete: (value) => ACMOpenAIAudioResponse.fromJson(value),
    );
  }

  Future<ACMOpenAIAudioResponse> translate(ACMOpenAIAudioRequest request) async {
    final mReq = await request.toJson();
    return _client.postFormData(
      kURL + AudioRoute.translations,
      mReq,
      complete: (value) => ACMOpenAIAudioResponse.fromJson(value),
    );
  }

  ///cancel edit
  void cancelAudio() {
    _client.log("stop openAI Audio");
    _cancel.cancel();
  }
}
