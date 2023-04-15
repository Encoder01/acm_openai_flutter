import 'package:dio/dio.dart';

class ACMOpenAIUploadFile {
  final String file;

  final String purpose;

  ACMOpenAIUploadFile({required this.file, this.purpose = 'fine-tune'});

  Future<FormData> getForm() async {
    return FormData.fromMap({
      'file': await MultipartFile.fromFile(file, filename: file),
      'purpose': purpose
    });
  }
}
