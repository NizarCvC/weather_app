import 'package:weather_app/models/weather_models/current_weather.dart';
import 'package:weather_app/models/weather_models/daily_weather.dart';
import 'package:weather_app/models/weather_models/hourly_weather.dart';
import 'package:weather_app/models/weather_models/minutely_weather.dart';
import 'package:weather_app/models/weather_models/weather_alert.dart';

class WeatherModel {
  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final CurrentWeather? current;
  final List<MinutelyWeather> minutely;
  final List<HourlyWeather> fifteenMinutely;
  final List<HourlyWeather> hourly;
  final List<DailyWeather> daily;
  final List<WeatherAlert> alerts;
  final String? prev;
  final String? next;

  WeatherModel({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    this.current,
    this.minutely = const [],
    this.fifteenMinutely = const [],
    this.hourly = const [],
    this.daily = const [],
    this.alerts = const [],
    this.prev,
    this.next,
  });

  WeatherModel copyWith({
    String? cityName,
    double? lat,
    double? lon,
    String? timezone,
    int? timezoneOffset,
    CurrentWeather? current,
    List<MinutelyWeather>? minutely,
    List<HourlyWeather>? fifteenMinutely,
    List<HourlyWeather>? hourly,
    List<DailyWeather>? daily,
    List<WeatherAlert>? alerts,
    String? prev,
    String? next,
  }) {
    return WeatherModel(
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      timezone: timezone ?? this.timezone,
      timezoneOffset: timezoneOffset ?? this.timezoneOffset,
      current: current ?? this.current,
      minutely: minutely ?? this.minutely,
      fifteenMinutely: fifteenMinutely ?? this.fifteenMinutely,
      hourly: hourly ?? this.hourly,
      daily: daily ?? this.daily,
      alerts: alerts ?? this.alerts,
      prev: prev ?? this.prev,
      next: next ?? this.next,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'lat': lat,
      'lon': lon,
      'timezone': timezone,
      'timezoneOffset': timezoneOffset,
      'current': current?.toJson(),
      'minutely': minutely.map((x) => x.toJson()).toList(),
      'fifteenMinutely': fifteenMinutely.map((x) => x.toJson()).toList(),
      'hourly': hourly.map((x) => x.toJson()).toList(),
      'daily': daily.map((x) => x.toJson()).toList(),
      'alerts': alerts.map((x) => x.toJson()).toList(),
      'prev': prev,
      'next': next,
    };
  }

  factory WeatherModel.fromJson(Map<String, dynamic> map) {
    return WeatherModel(
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      timezone: map['timezone'] as String,
      timezoneOffset: map['timezoneOffset'] as int,
      current: map['current'] != null ? CurrentWeather.fromJson(map['current'] as Map<String,dynamic>) : null,
      minutely: List<MinutelyWeather>.from((map['minutely'] as List<int>).map<MinutelyWeather>((x) => MinutelyWeather.fromJson(x as Map<String,dynamic>),),),
      fifteenMinutely: List<HourlyWeather>.from((map['fifteenMinutely'] as List<int>).map<HourlyWeather>((x) => HourlyWeather.fromJson(x as Map<String,dynamic>),),),
      hourly: List<HourlyWeather>.from((map['hourly'] as List<int>).map<HourlyWeather>((x) => HourlyWeather.fromJson(x as Map<String,dynamic>),),),
      daily: List<DailyWeather>.from((map['daily'] as List<int>).map<DailyWeather>((x) => DailyWeather.fromJson(x as Map<String,dynamic>),),),
      alerts: List<WeatherAlert>.from((map['alerts'] as List<int>).map<WeatherAlert>((x) => WeatherAlert.fromJson(x as Map<String,dynamic>),),),
      prev: map['prev'] != null ? map['prev'] as String : null,
      next: map['next'] != null ? map['next'] as String : null,
    );
  }
}
