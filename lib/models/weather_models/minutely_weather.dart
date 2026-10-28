class MinutelyWeather {
  final int dt;
  final double precipitation;
  final List<String> alerts;

  MinutelyWeather({
    required this.dt,
    required this.precipitation,
    this.alerts = const [],
  });

  factory MinutelyWeather.fromJson(Map<String, dynamic> json) {
    return MinutelyWeather(
      dt: (json['dt'] as num?)?.toInt() ?? 0,
      precipitation: (json['precipitation'] as num?)?.toDouble() ?? 0.0,
      alerts:
          (json['alerts'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  static List<MinutelyWeather> fromTimelineJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List<dynamic>?;
    return dataList
            ?.map((e) => MinutelyWeather.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'precipitation': precipitation,
      'alerts': alerts,
    };
  }
}
