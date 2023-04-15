import 'package:acm_open_ai_flutter/src/model/complete_text/response/complete_text_res.dart';

class ACMOpenAIEditResponse {
  ACMOpenAIEditResponse({
    required this.object,
    required this.created,
    required this.choices,
    required this.usage,
  });

  String object;
  int created;
  List<Choice> choices;
  Usage usage;
  final String id = "${DateTime.now().millisecondsSinceEpoch}";

  factory ACMOpenAIEditResponse.fromJson(Map<String, dynamic> json) => ACMOpenAIEditResponse(
    object: json["object"],
    created: json["created"],
    choices:
    List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
    usage: Usage.fromJson(json["usage"]),
  );

  Map<String, dynamic> toJson() => {
    "object": object,
    "created": created,
    "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
    "usage": usage.toJson(),
  };
}

class Choice {
  Choice({
    required this.text,
    required this.index,
  });

  String text;
  int index;
  final String id = "${DateTime.now().millisecondsSinceEpoch}";

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
    text: json["text"],
    index: json["index"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "index": index,
  };
}