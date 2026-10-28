class DailyFeelsLike {
  final double morn;
  final double day;
  final double eve;
  final double night;

  DailyFeelsLike({
    required this.morn,
    required this.day,
    required this.eve,
    required this.night,
  });

  factory DailyFeelsLike.fromJson(Map<String, dynamic> json) {
    return DailyFeelsLike(
      morn: (json['morn'] as num?)?.toDouble() ?? 0.0,
      day: (json['day'] as num?)?.toDouble() ?? 0.0,
      eve: (json['eve'] as num?)?.toDouble() ?? 0.0,
      night: (json['night'] as num?)?.toDouble() ?? 0.0,
    );
  }

  static DailyFeelsLike? fromDynamic(dynamic value) {
    if (value == null) return null;
    if (value is Map<String, dynamic>) {
      return DailyFeelsLike.fromJson(value);
    }
    if (value is num) {
      final v = value.toDouble();
      return DailyFeelsLike(morn: v, day: v, eve: v, night: v);
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'morn': morn,
      'day': day,
      'eve': eve,
      'night': night,
    };
  }
}
