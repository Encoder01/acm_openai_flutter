import 'package:acm_open_ai_flutter/src/core/interfaces/base_err.dart';

class MissionSessionException extends BaseErrorWrapper {
  @override
  String toString() =>
      "To get a session token:\nGo to https://chat.openai.com/chat and log in or sign up.\nOpen dev tools.\nOpen Application > Cookies (Storage > Cookies)\n__Secure-next-auth.session-token";
}
