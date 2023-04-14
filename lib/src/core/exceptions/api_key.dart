import 'package:acm_open_ai_flutter/src/core/interfaces/base_err.dart';

class MissingApiKeyException extends BaseErrorWrapper{
  final String message;

  MissingApiKeyException(this.message);

  @override
  String toString(){
    return message;
  }
}