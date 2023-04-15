class ACMOpenAIModerationResponse {
  ACMOpenAIModerationResponse({
    required this.id,
    required this.model,
    required this.results,
  });

  late final String id;
  late final String model;
  late final List<ModerationResult> results;

  ACMOpenAIModerationResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    model = json['model'];
    results = List.from(json['results']).map((e) => ModerationResult.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['model'] = model;
    data['results'] = results.map((e) => e.toJson()).toList();
    return data;
  }
}

class ModerationResult {
  ModerationResult({
    required this.categories,
    required this.categoryScores,
    required this.flagged,
  });

  late final Categories categories;
  late final CategoryScores categoryScores;
  late final bool flagged;

  ModerationResult.fromJson(Map<String, dynamic> json) {
    categories = Categories.fromJson(json['categories']);
    categoryScores = CategoryScores.fromJson(json['category_scores']);
    flagged = json['flagged'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['categories'] = categories.toJson();
    data['category_scores'] = categoryScores.toJson();
    data['flagged'] = flagged;
    return data;
  }
}

class CategoryScores {
  CategoryScores({
    required this.hate,
    required this.hateThreatening,
    required this.selfHarm,
    required this.sexual,
    required this.sexualMinors,
    required this.violence,
    required this.violenceGraphic,
  });

  late final double hate;
  late final double hateThreatening;
  late final double selfHarm;
  late final double sexual;
  late final double sexualMinors;
  late final double violence;
  late final double violenceGraphic;

  CategoryScores.fromJson(Map<String, dynamic> json) {
    hate = json['hate'];
    hateThreatening = json['hate/threatening'];
    selfHarm = json['self-harm'];
    sexual = json['sexual'];
    sexualMinors = json['sexual/minors'];
    violence = json['violence'];
    violenceGraphic = json['violence/graphic'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['hate'] = hate;
    data['hate/threatening'] = hateThreatening;
    data['self-harm'] = selfHarm;
    data['sexual'] = sexual;
    data['sexual/minors'] = sexualMinors;
    data['violence'] = violence;
    data['violence/graphic'] = violenceGraphic;
    return data;
  }
}

class Categories {
  Categories({
    required this.hate,
    required this.hateThreatening,
    required this.selfHarm,
    required this.sexual,
    required this.sexualMinors,
    required this.violence,
    required this.violenceGraphic,
  });

  late final bool hate;
  late final bool hateThreatening;
  late final bool selfHarm;
  late final bool sexual;
  late final bool sexualMinors;
  late final bool violence;
  late final bool violenceGraphic;

  Categories.fromJson(Map<String, dynamic> json) {
    hate = json['hate'];
    hateThreatening = json['hate/threatening'];
    selfHarm = json['self-harm'];
    sexual = json['sexual'];
    sexualMinors = json['sexual/minors'];
    violence = json['violence'];
    violenceGraphic = json['violence/graphic'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['hate'] = hate;
    data['hate/threatening'] = hateThreatening;
    data['self-harm'] = selfHarm;
    data['sexual'] = sexual;
    data['sexual/minors'] = sexualMinors;
    data['violence'] = violence;
    data['violence/graphic'] = violenceGraphic;
    return data;
  }
}
