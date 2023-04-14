import 'dart:developer' as dev;
import 'package:meta/meta.dart';

@protected
@immutable
@internal
abstract class ACMOpenAILogger {
  static bool _isActive = true;

  static set isActive(bool val) => _isActive = val;

  static void log(String message) {
    if (!_isActive) {
      return;
    }
    dev.log(message, name: 'ACMOpenAI');
  }

  static void logEndpoint(String endpoint) {
    log('accessing endpoint: $endpoint');
  }

  static void logApiKey() {
    log('api key is set');
  }

  static void logBaseUrl() {
    log('baseUrl is set');
  }

  static void logOrg(String? orgId) {
    log('organization id set to $orgId');
  }
}
