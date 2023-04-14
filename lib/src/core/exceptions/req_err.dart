import 'package:acm_open_ai_flutter/src/core/interfaces/base_err.dart';

class RequestError extends BaseErrorWrapper{
  final String? message;
  final int? code;

  RequestError({this.message,this.code});

  @override
  String toString() {
    return "\nstatus code :$code message :$message\n";
  }
}