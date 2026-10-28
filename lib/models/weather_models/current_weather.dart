import 'package:adv_flutter_weather/utils/weather_type.dart';
import 'package:weather_app/models/weather_models/rain_data.dart';
import 'package:weather_app/models/weather_models/weather_condition.dart';
import 'package:weather_app/models/weather_models/snow_data.dart';

class CurrentWeather {
  final int dt;
  final int? sunrise;
  final int? sunset;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double uvi;
  final int clouds;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final double? windGust;
  final RainData? rain;
  final SnowData? snow;
  final List<WeatherCondition> weather;
  final List<String> alerts;
  WeatherType get weatherScreen =>
      weather.isNotEmpty ? _mapWeatherScreen(weather.first.icon) : WeatherType.sunny;

  CurrentWeather({
    required this.dt,
    this.sunrise,
    this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    this.windGust,
    this.rain,
    this.snow,
    required this.weather,
    this.alerts = const [],
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data =
        (json['data'] is List && (json['data'] as List).isNotEmpty)
            ? (json['data'] as List).first as Map<String, dynamic>
            : json;

    return CurrentWeather(
      dt: (data['dt'] as num?)?.toInt() ?? 0,
      sunrise: (data['sunrise'] as num?)?.toInt(),
      sunset: (data['sunset'] as num?)?.toInt(),
      temp: (data['temp'] as num?)?.toDouble() ?? 0.0,
      feelsLike: (data['feels_like'] as num?)?.toDouble() ?? 0.0,
      pressure: (data['pressure'] as num?)?.toInt() ?? 0,
      humidity: (data['humidity'] as num?)?.toInt() ?? 0,
      dewPoint: (data['dew_point'] as num?)?.toDouble() ?? 0.0,
      uvi: (data['uvi'] as num?)?.toDouble() ?? 0.0,
      clouds: (data['clouds'] as num?)?.toInt() ?? 0,
      visibility: (data['visibility'] as num?)?.toInt() ?? 0,
      windSpeed: (data['wind_speed'] as num?)?.toDouble() ?? 0.0,
      windDeg: (data['wind_deg'] as num?)?.toInt() ?? 0,
      windGust: (data['wind_gust'] as num?)?.toDouble(),
      rain: RainData.fromDynamic(data['rain']),
      snow: SnowData.fromDynamic(data['snow']),
      weather:
          (data['weather'] as List<dynamic>?)
              ?.map((e) => WeatherCondition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      alerts:
          (data['alerts'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'sunrise': sunrise,
      'sunset': sunset,
      'temp': temp,
      'feels_like': feelsLike,
      'pressure': pressure,
      'humidity': humidity,
      'dew_point': dewPoint,
      'uvi': uvi,
      'clouds': clouds,
      'visibility': visibility,
      'wind_speed': windSpeed,
      'wind_deg': windDeg,
      'wind_gust': windGust,
      'rain': rain?.toJson(),
      'snow': snow?.toJson(),
      'weather': weather.map((e) => e.toJson()).toList(),
      'alerts': alerts,
    };
  }

  WeatherType _mapWeatherScreen(String icon) {
    return switch (icon) {
      'assets/weather/Weather Icon.svg' => WeatherType.sunny,
      'assets/weather/Weather Icon-6.svg' => WeatherType.cloudy,
      'assets/weather/Weather Icon-8.svg' => WeatherType.cloudy,
      'assets/weather/Weather Icon-23.svg' => WeatherType.middleRainy,
      'assets/weather/Weather Icon-11.svg' => WeatherType.lightRainy,
      'assets/weather/Weather Icon-14.svg' => WeatherType.heavyRainy,
      'assets/weather/Weather Icon-36.svg' => WeatherType.middleSnow,
      'assets/weather/Weather Icon-50.svg' => WeatherType.dusty,
      'assets/weather/Weather Icon-1.svg' => WeatherType.sunnyNight,
      'assets/weather/Weather Icon-7.svg' => WeatherType.cloudyNight,
      'assets/weather/Weather Icon-12.svg' => WeatherType.lightRainy,
      _ => WeatherType.sunny,
    };
  }
}
