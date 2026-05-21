import 'package:weather_app/models/weather_models/hourly_weather.dart';
import 'package:weather_app/models/weather_models/minutely_weather.dart';
import 'package:weather_app/models/weather_models/current_weather.dart';
import 'package:weather_app/models/weather_models/daily_weather.dart';
import 'package:weather_app/models/weather_models/weather_alert.dart';

class WeatherModel {
  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final CurrentWeather? current;
  final List<MinutelyWeather> minutely;
  final List<HourlyWeather> hourly;
  final List<DailyWeather> daily;
  final List<WeatherAlert> alerts;

  WeatherModel({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    this.current,
    required this.minutely,
    required this.hourly,
    required this.daily,
    required this.alerts,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      timezone: json['timezone'] ?? '',
      timezoneOffset: json['timezone_offset'] ?? 0,
      current: json['current'] != null
          ? CurrentWeather.fromJson(json['current'])
          : null,
      minutely:
          (json['minutely'] as List<dynamic>?)
              ?.map((e) => MinutelyWeather.fromJson(e))
              .toList() ??
          [],
      hourly:
          (json['hourly'] as List<dynamic>?)
              ?.map((e) => HourlyWeather.fromJson(e))
              .take(24)
              .toList() ??
          [],
      daily:
          (json['daily'] as List<dynamic>?)
              ?.map((e) => DailyWeather.fromJson(e))
              .take(7)
              .toList() ??
          [],
      alerts:
          (json['alerts'] as List<dynamic>?)
              ?.map((e) => WeatherAlert.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
      'timezone': timezone,
      'timezone_offset': timezoneOffset,
      'current': current?.toJson(),
      'minutely': minutely.map((e) => e.toJson()).toList(),
      'hourly': hourly.map((e) => e.toJson()).toList(),
      'daily': daily.map((e) => e.toJson()).toList(),
      'alerts': alerts.map((e) => e.toJson()).toList(),
    };
  }
}
