import 'package:acm_open_ai_flutter/src/client/client.dart';
import 'package:acm_open_ai_flutter/src/core/constants/constansts.dart';
import 'package:acm_open_ai_flutter/src/model/embedding/request/embed_req.dart';
import 'package:acm_open_ai_flutter/src/model/embedding/response/embed_res.dart';
import 'package:acm_open_ai_flutter/src/routes/Embeddings/embeddings_route.dart';
import 'package:dio/dio.dart';

class ACMOpenAIEmbeddingsManager {
  static const create = "v1/embeddings";
  final ACMOpenAINetworkingClient _client;

  ACMOpenAIEmbeddingsManager(this._client);

  final _cancel = CancelToken();

  Future<ACMOpenAIEmbedResponse> embedding(ACMOpenAIEmbedRequest request) async {
    return _client.post(
      kURL + EmbeddingsRoute.create,
      request.toJson(),
      onSuccess: (val) => ACMOpenAIEmbedResponse.fromJson(val),
      cancelToken: _cancel,
    );
  }

  ///cancel embedding
  void cancelEmbedding() {
    _client.log("stop openAI embedding");
    _cancel.cancel();
  }
}
