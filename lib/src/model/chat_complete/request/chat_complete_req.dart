class ACMOpenAIChatCompleteTextRequest {
  final String? model;
  final List<Map<String, String>>? messages;
  final double? temperature;
  final double? topP;
  final int? n;
  final bool? stream;
  final List<String>? stop;
  final int? maxToken;
  final double? presencePenalty;
  final double? frequencyPenalty;
  final Map? logitBias;
  final String? user;

  ACMOpenAIChatCompleteTextRequest(
    this.model,
    this.messages, {
    this.temperature = 0.4,
    this.topP = 1.0,
    this.n = 1,
    this.stream = false,
    this.stop,
    this.maxToken = 100,
    this.presencePenalty = .0,
    this.frequencyPenalty = .0,
    this.logitBias,
    this.user = '',
  });

  Map<String, dynamic> toJson() => Map.of({
        'model': model,
        'messages': messages,
        'temperature': temperature,
        'top_p': topP,
        'n': n,
        'stream': stream,
        'stop': stop,
        'max_token': maxToken,
        'presence_penalty': presencePenalty,
        'frequency_penalty': frequencyPenalty,
        'logit_bias': logitBias,
        'user': user,
      });
}
