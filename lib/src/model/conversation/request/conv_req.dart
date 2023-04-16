import 'dart:convert';


class  ACMOpenAIConversationRequest {
  final String? action;
  final String? conversationId;
  final List<Prompt>? messages;
  final String model;
  final String parentMessageId;

  ACMOpenAIConversationRequest({
    required this.action,
    required this.conversationId,
    required this.messages,
    required this.model,
    required this.parentMessageId,
  });

  Map<String, dynamic> toMap() {
    return {
      'action': action,
      'conversation_id': conversationId,
      'messages': messages?.map((x) => x.toMap()).toList(),
      'model': model,
      'parent_message_id': parentMessageId,
    };
  }

  factory ACMOpenAIConversationRequest.fromMap(Map<String, dynamic> map) {
    return ACMOpenAIConversationRequest(
      action: map['action'],
      conversationId: map['conversation_id'],
      messages: map['messages'] != null
          ? List<Prompt>.from(map['messages']?.map((x) => Prompt.fromMap(x)))
          : null,
      model: map['model'] ?? '',
      parentMessageId: map['parent_message_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ACMOpenAIConversationRequest.fromJson(String source) =>
      ACMOpenAIConversationRequest.fromMap(json.decode(source));
}


class Prompt {
  final PromptContent content;
  final String id;
  final String role;

  Prompt({
    required this.content,
    required this.id,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'content': content.toMap(),
      'id': id,
      'role': role,
    };
  }

  factory Prompt.fromMap(Map<String, dynamic> map) {
    return Prompt(
      content: PromptContent.fromMap(map['content']),
      id: map['id'] ?? '',
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Prompt.fromJson(String source) => Prompt.fromMap(json.decode(source));
}

class PromptContent {
  final String contentType;
  final List<String> parts;

  PromptContent({
    required this.contentType,
    required this.parts,
  });

  Map<String, dynamic> toMap() {
    return {
      'content_type': contentType,
      'parts': parts,
    };
  }

  factory PromptContent.fromMap(Map<String, dynamic> map) {
    return PromptContent(
      contentType: map['content_type'] ?? '',
      parts: List<String>.from(map['parts']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PromptContent.fromJson(String source) =>
      PromptContent.fromMap(json.decode(source));
}

