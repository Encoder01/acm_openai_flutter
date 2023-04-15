class ACMOpenAIFineTuneDelete {
  final String id;
  final String object;
  final bool deleted;

  ACMOpenAIFineTuneDelete(
      {required this.id, required this.object, required this.deleted});

  factory ACMOpenAIFineTuneDelete.fromJson(Map<String, dynamic> json) => ACMOpenAIFineTuneDelete(
      id: json['id'], object: json['object'], deleted: json['deleted']);
}
