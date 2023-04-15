class ACMOpenAIDeleteFileResponse {
  ACMOpenAIDeleteFileResponse({
    required this.id,
    required this.object,
    required this.deleted,
  });

  String id;
  String object;
  bool deleted;

  factory ACMOpenAIDeleteFileResponse.fromJson(Map<String, dynamic> json) => ACMOpenAIDeleteFileResponse(
    id: json["id"],
    object: json["object"],
    deleted: json["deleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "deleted": deleted,
  };
}
