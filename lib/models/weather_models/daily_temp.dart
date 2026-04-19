class DailyTemp {
  final double morn;
  final double day;
  final double eve;
  final double night;
  final double min;
  final double max;

  DailyTemp({
    required this.morn,
    required this.day,
    required this.eve,
    required this.night,
    required this.min,
    required this.max,
  });

  factory DailyTemp.fromJson(Map<String, dynamic> json) {
    return DailyTemp(
      morn: (json['morn'] as num?)?.toDouble() ?? 0.0,
      day: (json['day'] as num?)?.toDouble() ?? 0.0,
      eve: (json['eve'] as num?)?.toDouble() ?? 0.0,
      night: (json['night'] as num?)?.toDouble() ?? 0.0,
      min: (json['min'] as num?)?.toDouble() ?? 0.0,
      max: (json['max'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'morn': morn,
      'day': day,
      'eve': eve,
      'night': night,
      'min': min,
      'max': max,
    };
  }
}
