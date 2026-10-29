class AlertDescription {
  final String language;
  final String description;

  AlertDescription({
    required this.language,
    required this.description,
  });

  factory AlertDescription.fromJson(Map<String, dynamic> json) {
    return AlertDescription(
      language: json['language'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'description': description,
    };
  }
}
