import 'package:weather_app/models/weather_models/daily_feels_like.dart';
import 'package:weather_app/models/weather_models/daily_temp.dart';
import 'package:weather_app/models/weather_models/rain_data.dart';
import 'package:weather_app/models/weather_models/snow_data.dart';
import 'package:weather_app/models/weather_models/weather_condition.dart';

class DailyWeather {
  final int dt;
  final int? sunrise;
  final int? sunset;
  final int? moonrise;
  final int? moonset;
  final double moonPhase;
  final String? summary;
  final DailyTemp temp;
  final DailyFeelsLike? feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double windSpeed;
  final double? windGust;
  final int windDeg;
  final int clouds;
  final double uvi;
  final int? visibility;
  final double pop;
  final RainData? rain;
  final SnowData? snow;
  final List<WeatherCondition> weather;
  final List<String> alerts;

  DailyWeather({
    required this.dt,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    required this.moonPhase,
    this.summary,
    required this.temp,
    this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    this.windGust,
    required this.windDeg,
    required this.clouds,
    required this.uvi,
    this.visibility,
    required this.pop,
    this.rain,
    this.snow,
    required this.weather,
    this.alerts = const [],
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      dt: (json['dt'] as num?)?.toInt() ?? 0,
      sunrise: (json['sunrise'] as num?)?.toInt(),
      sunset: (json['sunset'] as num?)?.toInt(),
      moonrise: (json['moonrise'] as num?)?.toInt(),
      moonset: (json['moonset'] as num?)?.toInt(),
      moonPhase: (json['moon_phase'] as num?)?.toDouble() ?? 0.0,
      summary: json['summary'] as String?,
      temp: DailyTemp.fromDynamic(json['temp']),
      feelsLike: DailyFeelsLike.fromDynamic(json['feels_like']),
      pressure: (json['pressure'] as num?)?.toInt() ?? 0,
      humidity: (json['humidity'] as num?)?.toInt() ?? 0,
      dewPoint: (json['dew_point'] as num?)?.toDouble() ?? 0.0,
      windSpeed: (json['wind_speed'] as num?)?.toDouble() ?? 0.0,
      windGust: (json['wind_gust'] as num?)?.toDouble(),
      windDeg: (json['wind_deg'] as num?)?.toInt() ?? 0,
      clouds: (json['clouds'] as num?)?.toInt() ?? 0,
      uvi: (json['uvi'] as num?)?.toDouble() ?? 0.0,
      visibility: (json['visibility'] as num?)?.toInt(),
      pop: (json['pop'] as num?)?.toDouble() ?? 0.0,
      rain: RainData.fromDynamic(json['rain']),
      snow: SnowData.fromDynamic(json['snow']),
      weather:
          (json['weather'] as List<dynamic>?)
              ?.map((e) => WeatherCondition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      alerts:
          (json['alerts'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  static List<DailyWeather> fromTimelineJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List<dynamic>?;
    return dataList
            ?.map((e) => DailyWeather.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'sunrise': sunrise,
      'sunset': sunset,
      'moonrise': moonrise,
      'moonset': moonset,
      'moon_phase': moonPhase,
      'summary': summary,
      'temp': temp.toJson(),
      'feels_like': feelsLike?.toJson(),
      'pressure': pressure,
      'humidity': humidity,
      'dew_point': dewPoint,
      'wind_speed': windSpeed,
      'wind_gust': windGust,
      'wind_deg': windDeg,
      'clouds': clouds,
      'uvi': uvi,
      'visibility': visibility,
      'pop': pop,
      'rain': rain?.toJson(),
      'snow': snow?.toJson(),
      'weather': weather.map((e) => e.toJson()).toList(),
      'alerts': alerts,
    };
  }
}
