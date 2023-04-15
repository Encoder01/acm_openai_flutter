import 'package:acm_open_ai_flutter/src/model/complete_text/response/complete_text_res.dart';

class ACMOpenAIEmbedResponse {
  ACMOpenAIEmbedResponse({
    required this.object,
    required this.data,
    required this.model,
    required this.usage,
  });

  String object;
  List<EmbedData> data;
  String model;
  Usage usage;

  factory ACMOpenAIEmbedResponse.fromJson(Map<String, dynamic> json) => ACMOpenAIEmbedResponse(
    object: json["object"],
    data: List<EmbedData>.from(
        json["data"].map((x) => EmbedData.fromJson(x))),
    model: json["model"],
    usage: Usage.fromJson(json["usage"]),
  );

  Map<String, dynamic> toJson() => {
    "object": object,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "model": model,
    "usage": usage.toJson(),
  };
}
class EmbedData {
  EmbedData({
    required this.object,
    required this.embedding,
    required this.index,
  });

  String object;
  List<double> embedding;
  int index;

  factory EmbedData.fromJson(Map<String, dynamic> json) => EmbedData(
    object: json["object"],
    embedding:
    List<double>.from(json["embedding"].map((x) => x?.toDouble())),
    index: json["index"],
  );

  Map<String, dynamic> toJson() => {
    "object": object,
    "embedding": List<dynamic>.from(embedding.map((x) => x)),
    "index": index,
  };
}