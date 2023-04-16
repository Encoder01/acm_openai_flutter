import 'package:acm_open_ai_flutter/src/model/complete_text/response/complete_text_res.dart';

class ACMOpenAIChatCompleteResponse {
  final String id;
  final String object;
  final int created;
  final List<ChatChoice> choices;
  final Usage? usage;
  final String conversionId = "${DateTime.now().millisecondsSinceEpoch}";

  ACMOpenAIChatCompleteResponse(
      {required this.id,
      required this.object,
      required this.created,
      required this.choices,
      required this.usage});

  factory ACMOpenAIChatCompleteResponse.fromJson(Map<String, dynamic> json) =>
      ACMOpenAIChatCompleteResponse(
        id: json["id"],
        object: json["object"],
        created: json["created"],
        choices: List<ChatChoice>.from(json["choices"].map((x) => ChatChoice.fromJson(x))),
        usage: json["usage"] == null ? null : Usage.fromJson(json["usage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "created": created,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
        "usage": usage?.toJson(),
      };
}

class ChatChoice {
  final String id = "${DateTime.now().millisecondsSinceEpoch}";
  final int index;
  final Message? message;
  final String? finishReason;

  ChatChoice({required this.index, required this.message, this.finishReason});

  factory ChatChoice.fromJson(Map<String, dynamic> json) => ChatChoice(
        index: json["index"],
        message: json["message"] == null ? Message.fromJson(json["delta"]) : Message.fromJson(json["message"]),
        finishReason: json["finish_reason"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "message": message?.toJson(),
        "finish_reason": finishReason ?? "",
      };
}

class Message {
  final String role;
  final String content;
  final String id = "${DateTime.now().millisecondsSinceEpoch}";

  Message({required this.role, required this.content});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        role: json["role"] ?? "",
        content: json["content"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "content": content,
      };
}
