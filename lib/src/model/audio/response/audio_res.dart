class ACMOpenAIAudioResponse {
  final String text;

  ACMOpenAIAudioResponse(this.text);

  factory ACMOpenAIAudioResponse.fromJson(Map<String, dynamic> json) =>
      ACMOpenAIAudioResponse(json["text"]);
}