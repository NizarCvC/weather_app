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

class WeatherAlert {
  final String id;
  final String senderName;
  final String event;
  final int start;
  final int end;
  final List<AlertDescription> description;
  final List<String> tags;

  WeatherAlert({
    required this.id,
    required this.senderName,
    required this.event,
    required this.start,
    required this.end,
    required this.description,
    required this.tags,
  });

  factory WeatherAlert.fromJson(Map<String, dynamic> json) {
    final rawDesc = json['description'];
    List<AlertDescription> parsedDescriptions = [];
    if (rawDesc is List) {
      parsedDescriptions = rawDesc
          .whereType<Map<String, dynamic>>()
          .map((e) => AlertDescription.fromJson(e))
          .toList();
    } else if (rawDesc is String && rawDesc.isNotEmpty) {
      parsedDescriptions = [
        AlertDescription(language: 'en', description: rawDesc),
      ];
    }

    return WeatherAlert(
      id: json['id'] ?? '',
      senderName: json['sender_name'] ?? '',
      event: json['event'] ?? '',
      start: (json['start'] as num?)?.toInt() ?? 0,
      end: (json['end'] as num?)?.toInt() ?? 0,
      description: parsedDescriptions,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender_name': senderName,
      'event': event,
      'start': start,
      'end': end,
      'description': description.map((e) => e.toJson()).toList(),
      'tags': tags,
    };
  }
}
