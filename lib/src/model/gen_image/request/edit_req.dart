import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import 'generate_req.dart';

class ACMOpenAIEditImageRequest{
  final String image;

  final String? mask;

  final String prompt;

  final int n;

  final ImageSize size;

  final Format responseFormat;

  final String? user;

  ACMOpenAIEditImageRequest(
      {required this.image,
        this.mask,
        required this.prompt,
        this.n = 2,
        this.size = ImageSize.size1024,
        this.responseFormat = Format.url,
        this.user});

  Future<FormData> convert() async {
    return FormData.fromMap({
      'image': await MultipartFile.fromFile(image,
          filename: image, contentType: MediaType('image', 'png')),
      'mask': mask == null
          ? null
          : await MultipartFile.fromFile(image,
          filename: image, contentType: MediaType('image', 'png')),
      'prompt': prompt,
      'n': n,
      'size': size.size,
      'response_format': responseFormat.name,
      "user": user
    });
  }

  Map<String, dynamic> toJson() => Map.of({
    'image': image,
    'mask': mask,
    'prompt': prompt,
    'n': n,
    'size': size.size,
    'response_format': responseFormat.name,
    "user": user
  });

}