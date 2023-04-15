import 'dart:convert';

ACMOpenAIFineTuneResponse fineTuneFromJson(String str) => ACMOpenAIFineTuneResponse.fromJson(json.decode(str));

class ACMOpenAIFineTuneResponse {
  ACMOpenAIFineTuneResponse({
    required this.id,
    required this.object,
    required this.model,
    required this.createdAt,
    required this.events,
    this.fineTunedModel,
    required this.hyperparams,
    required this.organizationId,
    required this.resultFiles,
    required this.status,
    required this.validationFiles,
    required this.trainingFiles,
    required this.updatedAt,
  });

  String id;
  String object;
  String model;
  int createdAt;
  List<Event>? events;
  dynamic fineTunedModel;
  HyperParams? hyperparams;
  String? organizationId;
  List<dynamic> resultFiles;
  String status;
  List<dynamic>? validationFiles;
  List<TrainingFile>? trainingFiles;
  DateTime? updatedAt;

  factory ACMOpenAIFineTuneResponse.fromJson(Map<String, dynamic> json) => ACMOpenAIFineTuneResponse(
    id: json["id"],
    object: json["object"],
    model: json["model"],
    createdAt: json["created_at"],
    events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
    fineTunedModel: json["fine_tuned_model"],
    hyperparams: HyperParams.fromJson(json["hyperparams"]),
    organizationId: json["organization_id"],
    resultFiles: List<dynamic>.from(json["result_files"].map((x) => x)),
    status: json["status"],
    validationFiles: List<dynamic>.from(json["validation_files"].map((x) => x)),
    trainingFiles: List<TrainingFile>.from(json["training_files"].map((x) => TrainingFile.fromJson(x))),
    updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updated_at'] * 1000),
  );
}

class Event {
  Event({
    required this.object,
    required this.createdAt,
    required this.level,
    required this.message,
  });

  String object;
  int createdAt;
  String? level;
  String? message;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    object: json["object"],
    createdAt: json["created_at"],
    level: json["level"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "object": object,
    "created_at": createdAt,
    "level": level,
    "message": message,
  };
}

class HyperParams {
  HyperParams({
    required this.batchSize,
    required this.learningRateMultiplier,
    required this.nEpochs,
    required this.promptLossWeight,
  });

  int? batchSize;
  double? learningRateMultiplier;
  int? nEpochs;
  double ?promptLossWeight;

  factory HyperParams.fromJson(Map<String, dynamic> json) => HyperParams(
    batchSize: json["batch_size"],
    learningRateMultiplier: json["learning_rate_multiplier"]?.toDouble(),
    nEpochs: json["n_epochs"],
    promptLossWeight: json["prompt_loss_weight"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "batch_size": batchSize,
    "learning_rate_multiplier": learningRateMultiplier,
    "n_epochs": nEpochs,
    "prompt_loss_weight": promptLossWeight,
  };
}

class TrainingFile {
  TrainingFile({
    required this.id,
    required this.object,
    required this.bytes,
    required this.createdAt,
    required this.filename,
    required this.purpose,
  });

  String id;
  String object;
  int bytes;
  int createdAt;
  String filename;
  String? purpose;

  factory TrainingFile.fromJson(Map<String, dynamic> json) => TrainingFile(
    id: json["id"],
    object: json["object"],
    bytes: json["bytes"],
    createdAt: json["created_at"],
    filename: json["filename"],
    purpose: json["purpose"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "bytes": bytes,
    "created_at": createdAt,
    "filename": filename,
    "purpose": purpose,
  };
}
