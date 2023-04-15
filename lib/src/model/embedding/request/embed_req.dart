class ACMOpenAIEmbedRequest {
  final String model;

  final String input;

  final String? user;

  ACMOpenAIEmbedRequest({required this.model, required this.input, this.user = ""});

  Map<String, dynamic> toJson() =>
      Map.of({'model': model, 'input': input, 'user': user});
}