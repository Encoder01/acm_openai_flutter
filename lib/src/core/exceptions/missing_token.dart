import 'package:acm_open_ai_flutter/src/core/interfaces/base_err.dart';

class MissionTokenException extends BaseErrorWrapper {
  @override
  String toString() =>
      "Not Missing Your Token look more <a>https://beta.openai.com/account/api-keys</a>";
}