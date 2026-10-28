class SnowData {
  final double? oneHour;

  SnowData({this.oneHour});

  factory SnowData.fromJson(Map<String, dynamic> json) {
    return SnowData(
      oneHour: (json['1h'] as num?)?.toDouble(),
    );
  }

  static SnowData? fromDynamic(dynamic value) {
    if (value == null) return null;
    if (value is Map<String, dynamic>) {
      return SnowData.fromJson(value);
    }
    if (value is num) {
      return SnowData(oneHour: value.toDouble());
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      '1h': oneHour,
    };
  }
}