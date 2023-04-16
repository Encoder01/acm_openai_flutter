
class ACMOpenAICompleteTextRequest {
  final String? model;
  final String? prompt;
  final String? suffix;
  final int? maxToken;
  final double? temperature;
  final double? topP;
  final int? n;
  final bool? stream;
  final int? logProbs;
  final bool? echo;
  final List<String>? stop;
  final double? presencePenalty;
  final double? frequencyPenalty;
  final int? bestOf;
  final Map? logitBias;
  final String? user;

  ACMOpenAICompleteTextRequest(
    this.model,
    this.prompt, {
    this.suffix,
    this.maxToken = 100,
    this.temperature = 0.4,
    this.topP = 1.0,
    this.n = 1,
    this.stream = false,
    this.logProbs,
    this.echo = false,
    this.stop,
    this.presencePenalty = .0,
    this.frequencyPenalty = .0,
    this.bestOf = 1,
    this.logitBias=const {},
    this.user = '',
  });

  Map<String, dynamic> toJson() => Map.of({
        'model': model,
        'prompt': prompt,
        'suffix': suffix,
        'max_tokens': maxToken,
        'temperature': temperature,
        'top_p': topP,
        'n': n,
        'stream': stream,
        'logprobs': logProbs,
        'echo': echo,
        'stop': stop,
        'presence_penalty': presencePenalty,
        'frequency_penalty': frequencyPenalty,
        'best_of': bestOf,
        'logit_bias': logitBias,
        'user': user,
      });
}
