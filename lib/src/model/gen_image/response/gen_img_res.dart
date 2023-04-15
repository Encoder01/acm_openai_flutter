class ACMOpenAIGenImgResponse {
  ACMOpenAIGenImgResponse({
    this.created,
    this.data,
  });

  int? created;
  List<ImageData?>? data;
  final String conversionId = "${DateTime.now().millisecondsSinceEpoch}";

  factory ACMOpenAIGenImgResponse.fromJson(Map<String, dynamic> json) => ACMOpenAIGenImgResponse(
    created: json["created"],
    data: json["data"] == null
        ? []
        : List<ImageData?>.from(
        json["data"]!.map((x) => ImageData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "created": created,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x!.toJson())),
  };
}
class ImageData {
  ImageData({this.url, this.b64Json});

  String? url;
  String? b64Json;
  final String id = "${DateTime.now().millisecondsSinceEpoch}";

  factory ImageData.fromJson(Map<String, dynamic> json) =>
      ImageData(url: json["url"], b64Json: json["b64_json"]);

  Map<String, dynamic> toJson() => {"url": url, "b64_json": b64Json};
}
