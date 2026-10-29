class RainData {
  final double? oneHour;

  double? get amount => oneHour;

  RainData({this.oneHour});

  factory RainData.fromJson(Map<String, dynamic> json) {
    return RainData(
      oneHour: (json['1h'] as num?)?.toDouble(),
    );
  }

  static RainData? fromDynamic(dynamic value) {
    if (value == null) return null;
    if (value is Map<String, dynamic>) {
      return RainData.fromJson(value);
    }
    if (value is num) {
      return RainData(oneHour: value.toDouble());
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      '1h': oneHour,
    };
  }
}
