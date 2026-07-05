import 'dart:convert';

enum WeatherOptions { current, minutely, hourly, daily, alerts }

enum Units { standard, metric, imperial }

class WeatherQueryParams {
  final double lat;
  final double lon;
  final String appid;
  final List<WeatherOptions> exclude;
  final Units units;
  final String? lang;

  WeatherQueryParams({
    required this.lat,
    required this.lon,
    required this.appid,
    this.exclude = const [],
    this.units = Units.metric,
    this.lang = 'en',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lon': lon,
      'appid': appid,
      'exclude': exclude.map((x) => x.name).join(','),
      'units': units.name,
      'lang': lang,
    };
  }

  factory WeatherQueryParams.fromMap(Map<String, dynamic> map) {
    return WeatherQueryParams(
      lat: (map['lat'] as num).toDouble(),
      lon: (map['lon'] as num).toDouble(),
      appid: map['appid'] as String,
      exclude: map['exclude'] != null
          ? (map['exclude'] as String)
                .split(',')
                .map(
                  (e) => WeatherOptions.values.firstWhere((x) => x.name == e),
                )
                .toList()
          : [],
      units: Units.values.firstWhere((x) => x.name == map['units']),
      lang: map['lang'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherQueryParams.fromJson(String source) =>
      WeatherQueryParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
