class SnowData {
  final double? oneHour;

  SnowData({this.oneHour});

  factory SnowData.fromJson(Map<String, dynamic> json) {
    return SnowData(
      oneHour: (json['1h'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '1h': oneHour,
    };
  }
}