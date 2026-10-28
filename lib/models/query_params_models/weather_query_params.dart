import 'dart:convert';

enum Units { standard, metric, imperial }

class WeatherQueryParams {
  final double lat;
  final double lon;
  final String appid;
  final Units units;
  final String? lang;
  final int? start;
  final int? cnt;

  WeatherQueryParams({
    required this.lat,
    required this.lon,
    required this.appid,
    this.units = Units.metric,
    this.lang = 'en',
    this.start,
    this.cnt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lon': lon,
      'appid': appid,
      'units': units.name,
      if (lang != null) 'lang': lang,
      if (start != null) 'start': start,
      if (cnt != null) 'cnt': cnt,
    };
  }

  factory WeatherQueryParams.fromMap(Map<String, dynamic> map) {
    return WeatherQueryParams(
      lat: (map['lat'] as num).toDouble(),
      lon: (map['lon'] as num).toDouble(),
      appid: map['appid'] as String,
      units: map['units'] != null
          ? Units.values.firstWhere(
              (x) => x.name == map['units'],
              orElse: () => Units.metric,
            )
          : Units.metric,
      lang: map['lang'] as String?,
      start: (map['start'] as num?)?.toInt(),
      cnt: (map['cnt'] as num?)?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherQueryParams.fromJson(String source) =>
      WeatherQueryParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
