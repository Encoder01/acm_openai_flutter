import 'dart:convert';

class ACMOpenAIConversationResponse {
  final String message;
  final String messageId;
  final String conversationId;

  ACMOpenAIConversationResponse({
    required this.message,
    required this.messageId,
    required this.conversationId,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'message_id': messageId,
      'conversation_id': conversationId,
    };
  }

  factory ACMOpenAIConversationResponse.fromMap(Map<String, dynamic> map) {
    return ACMOpenAIConversationResponse(
      message: map['message'] ?? '',
      messageId: map['message_id'] ?? '',
      conversationId: map['conversation_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ACMOpenAIConversationResponse.fromJson(String source) =>
      ACMOpenAIConversationResponse.fromMap(json.decode(source));
}

class ConversationResponseEvent {
  final ConvMessage? message;
  final String conversationId;
  final String? error;

  ConversationResponseEvent({
    required this.message,
    required this.conversationId,
    required this.error,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message?.toMap(),
      'conversation_id': conversationId,
      'error': error,
    };
  }

  factory ConversationResponseEvent.fromMap(Map<String, dynamic> map) {
    return ConversationResponseEvent(
      message: map['message'] != null ? ConvMessage.fromMap(map['message']) : null,
      conversationId: map['conversation_id'] ?? '',
      error: map['error'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationResponseEvent.fromJson(String source) =>
      ConversationResponseEvent.fromMap(json.decode(source));
}

class ConvMessage {
  final String id;
  final MessageContent content;
  final String role;
  final String? user;
  //final dynamic endTurn;
  final double weight;
  final String recipient;
  //final dynamic metadata;

  ConvMessage({
    required this.id,
    required this.content,
    required this.role,
    required this.user,
    required this.weight,
    required this.recipient,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content.toMap(),
      'role': role,
      'user': user,
      'weight': weight,
      'recipient': recipient,
    };
  }

  factory ConvMessage.fromMap(Map<String, dynamic> map) {
    return ConvMessage(
      id: map['id'] ?? '',
      content: MessageContent.fromMap(map['content']),
      role: map['role'] ?? '',
      user: map['user'],
      weight: map['weight']?.toDouble() ?? 0.0,
      recipient: map['recipient'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ConvMessage.fromJson(String source) =>
      ConvMessage.fromMap(json.decode(source));
}

class MessageContent {
  final String contentType;
  final List<String> parts;
  MessageContent({
    required this.contentType,
    required this.parts,
  });

  Map<String, dynamic> toMap() {
    return {
      'content_type': contentType,
      'parts': parts,
    };
  }

  factory MessageContent.fromMap(Map<String, dynamic> map) {
    return MessageContent(
      contentType: map['content_type'] ?? '',
      parts: List<String>.from(map['parts']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageContent.fromJson(String source) =>
      MessageContent.fromMap(json.decode(source));
}
