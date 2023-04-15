import 'package:dio/dio.dart';
enum AudioFormat { json, text, srt, verboseJson, vtt }

extension AudioFormatExtension on AudioFormat {
  String getName() {
    switch (this) {
      case AudioFormat.json:
        return 'json';
      case AudioFormat.text:
        return 'text';
      case AudioFormat.srt:
        return 'srt';
      case AudioFormat.verboseJson:
        return 'verbose_json';
      case AudioFormat.vtt:
        return 'vtt';
      default:
        return '';
    }
  }
}
class ACMOpenAIAudioRequest {
  final String? file;
  final String? model;
  final String? prompt;
  final AudioFormat? responseFormat;
  final int? temperature;
  final String? language;

  ACMOpenAIAudioRequest(
    this.file,
    this.model, {
    this.prompt,
    this.responseFormat,
    this.temperature,
    this.language,
  });
  Future<FormData> toJson() async {
    return FormData.fromMap({
      'file': await MultipartFile.fromFile(file!, filename: file),
      'prompt': prompt,
      "model": "whisper-1",
      'response_format': responseFormat == null
          ? AudioFormat.json.getName()
          : responseFormat?.getName(),
      'temperature': temperature,
      'language': language
    });
  }
}
