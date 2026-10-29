import 'package:weather_app/models/weather_models/rain_data.dart';
import 'package:weather_app/models/weather_models/weather_condition.dart';
import 'package:weather_app/models/weather_models/snow_data.dart';

class HourlyWeather {
  final int dt;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double uvi;
  final int clouds;
  final int visibility;
  final double windSpeed;
  final double? windGust;
  final int windDeg;
  final double? pop;
  final RainData? rain;
  final SnowData? snow;
  final List<WeatherCondition> weather;
  final List<String> alerts;

  HourlyWeather({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    this.windGust,
    required this.windDeg,
    required this.pop,
    this.rain,
    this.snow,
    required this.weather,
    this.alerts = const [],
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      dt: (json['dt'] as num?)?.toInt() ?? 0,
      temp: (json['temp'] as num?)?.toDouble() ?? 0.0,
      feelsLike: (json['feels_like'] as num?)?.toDouble() ?? 0.0,
      pressure: (json['pressure'] as num?)?.toInt() ?? 0,
      humidity: (json['humidity'] as num?)?.toInt() ?? 0,
      dewPoint: (json['dew_point'] as num?)?.toDouble() ?? 0.0,
      uvi: (json['uvi'] as num?)?.toDouble() ?? 0.0,
      clouds: (json['clouds'] as num?)?.toInt() ?? 0,
      visibility: (json['visibility'] as num?)?.toInt() ?? 0,
      windSpeed: (json['wind_speed'] as num?)?.toDouble() ?? 0.0,
      windGust: (json['wind_gust'] as num?)?.toDouble(),
      windDeg: (json['wind_deg'] as num?)?.toInt() ?? 0,
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

  static List<HourlyWeather> fromTimelineJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List<dynamic>?;
    return dataList
            ?.map((e) => HourlyWeather.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'temp': temp,
      'feels_like': feelsLike,
      'pressure': pressure,
      'humidity': humidity,
      'dew_point': dewPoint,
      'uvi': uvi,
      'clouds': clouds,
      'visibility': visibility,
      'wind_speed': windSpeed,
      'wind_gust': windGust,
      'wind_deg': windDeg,
      'pop': pop,
      'rain': rain?.toJson(),
      'snow': snow?.toJson(),
      'weather': weather.map((e) => e.toJson()).toList(),
      'alerts': alerts,
    };
  }
}
