import 'package:acm_open_ai_flutter/src/core/interfaces/base_err.dart';

class MissionClearanceException extends BaseErrorWrapper {
  @override
  String toString() =>
      "To get a clearance token:\nGo to https://chat.openai.com/chat and log in or sign up.\nOpen dev tools.\nOpen Application > Cookies (Storage > Cookies)\ncf_clearance";
}