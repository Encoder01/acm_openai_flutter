class ACMOpenAICompleteTextResponse {
  final String conversionId = "${DateTime.now().millisecondsSinceEpoch}";
  final String id;
  final String object;
  final int created;
  final String model;
  final List<Choices> choices;
  final Usage? usage;

  ACMOpenAICompleteTextResponse(this.id, this.object, this.created, this.model, this.choices, this.usage);

  factory ACMOpenAICompleteTextResponse.fromJson(Map<String, dynamic> json) => ACMOpenAICompleteTextResponse(
        json['id'] as String,
        json['object'] as String,
        json['created'] as int,
        json['model'] as String,
        (json['choices'] as List<dynamic>)
            .map((e) => Choices.fromJson(e as Map<String, dynamic>))
            .toList(),
        json['usage'] == null ? null : Usage.fromJson(json['usage'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => responseToJson(this);

  Map<String, dynamic> responseToJson(ACMOpenAICompleteTextResponse instance) => <String, dynamic>{
        'id': instance.id,
        'object': instance.object,
        'created': instance.created,
        'model': instance.model,
        'choices': instance.choices,
        'usage': instance.usage,
      };
}

class Choices {
  final String text;
  final int index;
  final dynamic logprobs;
  final String? finishReason;
  final String id = "${DateTime.now().millisecondsSinceEpoch}";

  Choices(this.text, this.index, this.logprobs, this.finishReason);

  factory Choices.fromJson(Map<String, dynamic> json) => Choices(
        json['text'],
        json['index'],
        json['logprobs'],
        json['finish_reason'],
      );

  Map<String, dynamic> toJson() => choicesToJson(this);

  Map<String, dynamic> choicesToJson(Choices instance) => <String, dynamic>{
        'text': instance.text,
        'index': instance.index,
        'logprobs': instance.logprobs,
        'finish_reason': instance.finishReason,
      };
}

class Usage {
  final int promptTokens;
  final int? completionTokens;
  final int totalTokens;
  final String id = "${DateTime.now().millisecondsSinceEpoch}";

  Usage(this.promptTokens, this.completionTokens, this.totalTokens);

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        json['prompt_tokens'] as int,
        json['completion_tokens'] == null ? 0 : json['completion_tokens'] as int,
        json['total_tokens'] as int,
      );

  Map<String, dynamic> toJson() => usageToJson(this);

  Map<String, dynamic> usageToJson(Usage instance) => <String, dynamic>{
        'prompt_tokens': instance.promptTokens,
        'completion_tokens': instance.completionTokens,
        'total_tokens': instance.totalTokens,
      };
}
