import 'package:weather_app/models/weather_models/alert_description.dart';

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

  String get primaryDescription =>
      description.isNotEmpty ? description.first.description : '';

  String getDescription([String? lang]) {
    if (description.isEmpty) return '';
    if (lang != null && lang.isNotEmpty) {
      final match = description.firstWhere(
        (d) => d.language.toLowerCase().startsWith(lang.toLowerCase()),
        orElse: () => description.first,
      );
      return match.description;
    }
    return description.first.description;
  }

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
