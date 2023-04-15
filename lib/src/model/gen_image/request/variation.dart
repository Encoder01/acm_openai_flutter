import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import 'generate_req.dart';

class ACMOpenAIVariationRequest {
  final String image;

  final int n;

  final ImageSize size;

  final Format responseFormat;

  final String? user;

  ACMOpenAIVariationRequest(
      {required this.image,
        this.n = 2,
        this.size = ImageSize.size1024,
        this.responseFormat = Format.url,
        this.user});

  Future<FormData> convert() async {
    return FormData.fromMap({
      'image': await MultipartFile.fromFile(image,
          filename: image, contentType: MediaType('image', 'png')),
      'n': n,
      'size': size.size,
      'response_format': responseFormat.name,
      "user": user
    });
  }

  Map<String, dynamic> toJson() => Map.of({
    'image': image,
    'n': n,
    'size': size.size,
    'response_format': responseFormat.name,
    "user": user
  });
}
