class ACMOpenAIFineTuneDeleteResponse {
  final String id;
  final String object;
  final bool deleted;

  ACMOpenAIFineTuneDeleteResponse(
      {required this.id, required this.object, required this.deleted});

  factory ACMOpenAIFineTuneDeleteResponse.fromJson(Map<String, dynamic> json) => ACMOpenAIFineTuneDeleteResponse(
      id: json['id'], object: json['object'], deleted: json['deleted']);
}
