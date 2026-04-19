class WeatherAlert {
  final String senderName;
  final String event;
  final int start;
  final int end;
  final String description;
  final List<String> tags;

  WeatherAlert({
    required this.senderName,
    required this.event,
    required this.start,
    required this.end,
    required this.description,
    required this.tags,
  });

  factory WeatherAlert.fromJson(Map<String, dynamic> json) {
    return WeatherAlert(
      senderName: json['sender_name'] ?? '',
      event: json['event'] ?? '',
      start: json['start'] ?? 0,
      end: json['end'] ?? 0,
      description: json['description'] ?? '',
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender_name': senderName,
      'event': event,
      'start': start,
      'end': end,
      'description': description,
      'tags': tags,
    };
  }
}
