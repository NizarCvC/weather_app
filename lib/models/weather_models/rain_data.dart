class RainData {
  final double? oneHour;

  RainData({this.oneHour});

  factory RainData.fromJson(Map<String, dynamic> json) {
    return RainData(
      oneHour: (json['1h'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '1h': oneHour,
    };
  }
}
