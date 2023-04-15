class ACMOpenAIFileResponse {
  ACMOpenAIFileResponse({
    required this.data,
    required this.object,
  });

  List<FileData> data;
  String object;

  factory ACMOpenAIFileResponse.fromJson(Map<String, dynamic> json) => ACMOpenAIFileResponse(
    data: json["data"] == null || json["data"] == []
        ? List.empty()
        : (json["data"] as List).map((e) => FileData.fromJson(e)).toList(),
    object: json["object"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "object": object,
  };
}
class FileData {
  FileData({
    required this.id,
    required this.object,
    required this.bytes,
    required this.createdAt,
    required this.filename,
    required this.purpose,
  });

  String id;
  String object;
  int bytes;
  int createdAt;
  String filename;
  String purpose;

  factory FileData.fromJson(Map<String, dynamic> json) => FileData(
    id: json["id"],
    object: json["object"],
    bytes: json["bytes"],
    createdAt: json["created_at"],
    filename: json["filename"],
    purpose: json["purpose"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "bytes": bytes,
    "created_at": createdAt,
    "filename": filename,
    "purpose": purpose,
  };
}
