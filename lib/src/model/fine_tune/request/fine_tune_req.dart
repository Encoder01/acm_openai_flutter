class ACMOpenAICreateFineTune {
  final String trainingFile;

  final String? validationFile;

  final String? model;

  final int? nEpochs;

  final int? batchSize;

  final int? learningRateMultiplier;

  final double? promptLossWeight;

  final bool computeClassificationMetrics;

  final int? classificationNClasses;

  final String? classificationPositiveClass;

  final List<dynamic>? classificationBetas;

  final String? suffix;

  ACMOpenAICreateFineTune(
      {required this.trainingFile,
      this.validationFile,
      this.model,
      this.nEpochs = 4,
      this.batchSize,
      this.learningRateMultiplier,
      this.promptLossWeight = .01,
      this.computeClassificationMetrics = false,
      this.classificationNClasses,
      this.classificationPositiveClass,
      this.classificationBetas,
      this.suffix});

  Map<String, dynamic> toJson() => Map.of({
        'training_file': trainingFile,
        'validation_file': validationFile,
        'model': model,
        'n_epochs': nEpochs,
        'batch_size': batchSize,
        'learning_rate_multiplier': learningRateMultiplier,
        'prompt_loss_weight': promptLossWeight,
        'compute_classification_metrics': computeClassificationMetrics,
        'classification_n_classes': classificationNClasses,
        'classification_positive_class': classificationPositiveClass,
        'classification_betas': classificationBetas,
        'suffix': suffix
      });
}
