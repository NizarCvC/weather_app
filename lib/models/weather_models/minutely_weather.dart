class MinutelyWeather {
  final int dt;
  final double precipitation;

  MinutelyWeather({
    required this.dt,
    required this.precipitation,
  });

  factory MinutelyWeather.fromJson(Map<String, dynamic> json) {
    return MinutelyWeather(
      dt: json['dt'] ?? 0,
      precipitation: (json['precipitation'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'precipitation': precipitation,
    };
  }
}
