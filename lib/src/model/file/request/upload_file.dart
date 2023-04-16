import 'package:dio/dio.dart';

class ACMOpenAIUploadFileRequest {
  final String fileName;
  final String filePath;

  final String purpose;

  ACMOpenAIUploadFileRequest({required this.fileName,required this.filePath, this.purpose = 'fine-tune'});

  Future<FormData> getForm() async {
    return FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: fileName),
      'purpose': purpose
    });
  }
}
