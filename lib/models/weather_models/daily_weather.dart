import 'package:weather_app/models/weather_models/daily_feels_like.dart';
import 'package:weather_app/models/weather_models/daily_temp.dart';
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
  final double pop;
  final double? rain;
  final double? snow;
  final List<WeatherCondition> weather;

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
    required this.pop,
    this.rain,
    this.snow,
    required this.weather,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      dt: json['dt'] ?? 0,
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      moonrise: json['moonrise'],
      moonset: json['moonset'],
      moonPhase: (json['moon_phase'] as num?)?.toDouble() ?? 0.0,
      summary: json['summary'],
      temp: DailyTemp.fromJson(json['temp']),
      feelsLike: json['feels_like'] != null
          ? DailyFeelsLike.fromJson(json['feels_like'])
          : null,
      pressure: json['pressure'] ?? 0,
      humidity: json['humidity'] ?? 0,
      dewPoint: (json['dew_point'] as num).toDouble(),
      windSpeed: (json['wind_speed'] as num).toDouble(),
      windGust: (json['wind_gust'] as num?)?.toDouble(),
      windDeg: json['wind_deg'] ?? 0,
      clouds: json['clouds'] ?? 0,
      uvi: (json['uvi'] as num?)?.toDouble() ?? 0.0,
      pop: (json['pop'] as num?)?.toDouble() ?? 0.0,
      rain: (json['rain'] as num?)?.toDouble(),
      snow: (json['snow'] as num?)?.toDouble(),
      weather: (json['weather'] as List<dynamic>?)
              ?.map((e) => WeatherCondition.fromJson(e))
              .toList() ??
          [],
    );
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
      'pop': pop,
      'rain': rain,
      'snow': snow,
      'weather': weather.map((e) => e.toJson()).toList(),
    };
  }
}
