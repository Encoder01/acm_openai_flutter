class SessionBuilder {
  SessionBuilder._();

  static SessionBuilder get instance => _instance;
  static final SessionBuilder _instance = SessionBuilder._();
  String? _sessionToken;
  String? _clearanceToken;

  factory SessionBuilder() {
    return _instance;
  }

  String? get session => _instance._sessionToken;

  String? get clearance => _instance._clearanceToken;

  String? setSession(String? session) => _sessionToken = session;

  String? setClearance(String? clearance) => _clearanceToken = clearance;
}
