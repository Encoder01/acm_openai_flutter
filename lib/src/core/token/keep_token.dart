class TokenBuilder {
  TokenBuilder._();

  static TokenBuilder get instance => _instance;
  static final TokenBuilder _instance = TokenBuilder._();
  String? _token;
  String? _orgId;

  factory TokenBuilder() {
    return _instance;
  }

  String? get token => _instance._token;

  String? get orgId => _instance._orgId;

  String? setToken(String? token) => _token = token;

  String? setOrgId(String? orgId) => _orgId = orgId;
}
