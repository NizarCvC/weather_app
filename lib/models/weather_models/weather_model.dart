import 'package:weather_app/models/weather_models/current_weather.dart';
import 'package:weather_app/models/weather_models/daily_weather.dart';
import 'package:weather_app/models/weather_models/hourly_weather.dart';
import 'package:weather_app/models/weather_models/minutely_weather.dart';
import 'package:weather_app/models/weather_models/weather_alert.dart';

enum WeatherDataKind { current, minutely, fifteenMinutely, hourly, daily }

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
      'timezone_offset': timezoneOffset,
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

  factory WeatherModel.fromJson(
    Map<String, dynamic> map, {
    WeatherDataKind? dataKind,
  }) {
    final prev = map['prev'] as String?;
    final next = map['next'] as String?;
    final data = (map['data'] as List<dynamic>?)?.cast<Map<String, dynamic>>();
    final kind = data == null || data.isEmpty
        ? null
        : dataKind ?? _inferDataKind(data, next ?? prev);
    final currentRecord = kind == WeatherDataKind.current
        ? data!.first
        : map['current'] as Map<String, dynamic>?;

    return WeatherModel(
      lat: (map['lat'] as num).toDouble(),
      lon: (map['lon'] as num).toDouble(),
      timezone: map['timezone'] as String,
      timezoneOffset: (map['timezone_offset'] ?? map['timezoneOffset']) as int,
      current: currentRecord == null
          ? null
          : CurrentWeather.fromJson(currentRecord),
      minutely: kind == WeatherDataKind.minutely
          ? MinutelyWeather.fromTimelineJson(map)
          : _readList(map['minutely'], MinutelyWeather.fromJson),
      fifteenMinutely: kind == WeatherDataKind.fifteenMinutely
          ? HourlyWeather.fromTimelineJson(map)
          : _readList(map['fifteenMinutely'], HourlyWeather.fromJson),
      hourly: kind == WeatherDataKind.hourly
          ? HourlyWeather.fromTimelineJson(map)
          : _readList(map['hourly'], HourlyWeather.fromJson),
      daily: kind == WeatherDataKind.daily
          ? DailyWeather.fromTimelineJson(map)
          : _readList(map['daily'], DailyWeather.fromJson),
      alerts: _readList(map['alerts'], WeatherAlert.fromJson),
      prev: prev,
      next: next,
    );
  }

  static List<T> _readList<T>(
    Object? value,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return (value as List<dynamic>?)
            ?.cast<Map<String, dynamic>>()
            .map(fromJson)
            .toList() ??
        <T>[];
  }

  static WeatherDataKind _inferDataKind(
    List<Map<String, dynamic>> data,
    String? pageUrl,
  ) {
    final path = pageUrl == null ? null : Uri.tryParse(pageUrl)?.path;
    final timelineKind = switch (path?.split('/').last) {
      '1min' => WeatherDataKind.minutely,
      '15min' => WeatherDataKind.fifteenMinutely,
      '1h' => WeatherDataKind.hourly,
      '1d' || '1day' => WeatherDataKind.daily,
      _ => null,
    };
    if (timelineKind != null) return timelineKind;

    final first = data.first;
    if (first['temp'] is Map) return WeatherDataKind.daily;
    if (first.containsKey('precipitation')) return WeatherDataKind.minutely;

    const quarterHour = 15 * Duration.secondsPerMinute;
    final timestamp = first['dt'] as int?;
    if (data.length == 1 &&
        (first.containsKey('sunrise') ||
            first.containsKey('sunset') ||
            (timestamp != null && timestamp % quarterHour != 0))) {
      return WeatherDataKind.current;
    }
    if (data.any((entry) {
      final timestamp = entry['dt'] as int?;
      return timestamp != null && timestamp % Duration.secondsPerHour != 0;
    })) {
      return WeatherDataKind.fifteenMinutely;
    }
    return WeatherDataKind.hourly;
  }
}
