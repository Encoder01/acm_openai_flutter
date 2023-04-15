class ACMOpenAIEditRequest {
  ///ID of the model to use. You can use the or model with this endpoint.[model]
  final String? model;

  final String? input;

  final String? instruction;

  final int? n;

  final int? temperature;

  final int? topP;

  ACMOpenAIEditRequest(
      {required this.model,
      required this.input,
      required this.instruction,
      this.n = 1,
      this.temperature = 1,
      this.topP = 1});

  Map<String, dynamic> toJson() => Map.of({
        "model": model,
        "input": input,
        "instruction": instruction,
        "n": n,
        "temperature": temperature,
        "top_p": topP
      });
}
