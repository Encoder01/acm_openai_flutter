class ACMOAIModerationsRequest {
  final String input;
  final String? model;

  ACMOAIModerationsRequest({required this.input, this.model});

  Map<String, dynamic> toJson() => Map.of({
        'model': model,
        'input': input,
      });
}
