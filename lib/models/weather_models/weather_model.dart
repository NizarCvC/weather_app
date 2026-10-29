import 'package:weather_app/models/weather_models/hourly_weather.dart';
import 'package:weather_app/models/weather_models/minutely_weather.dart';
import 'package:weather_app/models/weather_models/current_weather.dart';
import 'package:weather_app/models/weather_models/daily_weather.dart';
import 'package:weather_app/models/weather_models/weather_alert.dart';

class WeatherModel {
  final String cityName;
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
    required this.cityName,
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

  List<String> get alertIds {
    if (current != null && current!.alerts.isNotEmpty) {
      return current!.alerts;
    }
    return alerts.map((a) => a.id).where((id) => id.isNotEmpty).toList();
  }

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
      cityName: cityName ?? this.cityName,
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

  factory WeatherModel.fromResponses({
    required String cityName,
    required Map<String, dynamic> currentJson,
    Map<String, dynamic>? minutelyJson,
    Map<String, dynamic>? fifteenMinutelyJson,
    Map<String, dynamic>? hourlyJson,
    Map<String, dynamic>? dailyJson,
    List<Map<String, dynamic>>? alertsJson,
  }) {
    final Map<String, dynamic> baseJson = currentJson.isNotEmpty
        ? currentJson
        : (hourlyJson ??
              dailyJson ??
              fifteenMinutelyJson ??
              minutelyJson ??
              {});

    return WeatherModel(
      cityName: cityName,
      lat: (baseJson['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (baseJson['lon'] as num?)?.toDouble() ?? 0.0,
      timezone: baseJson['timezone'] ?? '',
      timezoneOffset: (baseJson['timezone_offset'] as num?)?.toInt() ?? 0,
      current: currentJson.isNotEmpty
          ? CurrentWeather.fromJson(currentJson)
          : null,
      minutely: minutelyJson != null
          ? MinutelyWeather.fromTimelineJson(minutelyJson)
          : [],
      fifteenMinutely: fifteenMinutelyJson != null
          ? HourlyWeather.fromTimelineJson(fifteenMinutelyJson)
          : [],
      hourly: hourlyJson != null
          ? HourlyWeather.fromTimelineJson(hourlyJson)
          : [],
      daily: dailyJson != null ? DailyWeather.fromTimelineJson(dailyJson) : [],
      alerts: alertsJson != null
          ? alertsJson.map((e) => WeatherAlert.fromJson(e)).toList()
          : [],
      prev:
          (dailyJson ?? hourlyJson ?? fifteenMinutelyJson)?['prev'] as String?,
      next:
          (dailyJson ?? hourlyJson ?? fifteenMinutelyJson)?['next'] as String?,
    );
  }

  factory WeatherModel.fromJson(String cityName, Map<String, dynamic> json) {
    CurrentWeather? parsedCurrent;
    if (json['current'] is Map<String, dynamic>) {
      parsedCurrent = CurrentWeather.fromJson(
        json['current'] as Map<String, dynamic>,
      );
    } else if (json['data'] is List && (json['data'] as List).isNotEmpty) {
      parsedCurrent = CurrentWeather.fromJson(
        (json['data'] as List).first as Map<String, dynamic>,
      );
    }

    List<dynamic>? extractList(dynamic field) {
      if (field is List<dynamic>) return field;
      if (field is Map<String, dynamic> && field['data'] is List<dynamic>) {
        return field['data'] as List<dynamic>;
      }
      return null;
    }

    return WeatherModel(
      cityName: cityName,
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
      timezone: json['timezone'] ?? '',
      timezoneOffset: (json['timezone_offset'] as num?)?.toInt() ?? 0,
      current: parsedCurrent,
      minutely:
          extractList(json['minutely'])
              ?.map((e) => MinutelyWeather.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      fifteenMinutely:
          extractList(json['fifteen_minutely'])
              ?.map((e) => HourlyWeather.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      hourly:
          extractList(json['hourly'])
              ?.map((e) => HourlyWeather.fromJson(e as Map<String, dynamic>))
              .take(24)
              .toList() ??
          [],
      daily:
          extractList(json['daily'])
              ?.map((e) => DailyWeather.fromJson(e as Map<String, dynamic>))
              .take(7)
              .toList() ??
          [],
      alerts:
          (json['alerts'] as List<dynamic>?)
              ?.whereType<Map<String, dynamic>>()
              .map((e) => WeatherAlert.fromJson(e))
              .toList() ??
          [],
      prev: json['prev'] as String?,
      next: json['next'] as String?,
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
      'fifteen_minutely': fifteenMinutely.map((e) => e.toJson()).toList(),
      'hourly': hourly.map((e) => e.toJson()).toList(),
      'daily': daily.map((e) => e.toJson()).toList(),
      'alerts': alerts.map((e) => e.toJson()).toList(),
      if (prev != null) 'prev': prev,
      if (next != null) 'next': next,
    };
  }
}
