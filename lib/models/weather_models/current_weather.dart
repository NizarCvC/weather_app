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
  WeatherType get weatherScreen => _mapWeatherScreen(weather.first.icon);

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
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      dt: json['dt'] ?? 0,
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      temp: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      pressure: json['pressure'] ?? 0,
      humidity: json['humidity'] ?? 0,
      dewPoint: (json['dew_point'] as num).toDouble(),
      uvi: (json['uvi'] as num).toDouble(),
      clouds: json['clouds'] ?? 0,
      visibility: json['visibility'] ?? 0,
      windSpeed: (json['wind_speed'] as num).toDouble(),
      windDeg: json['wind_deg'] ?? 0,
      windGust: (json['wind_gust'] as num?)?.toDouble(),
      rain: json['rain'] != null ? RainData.fromJson(json['rain']) : null,
      snow: json['snow'] != null ? SnowData.fromJson(json['snow']) : null,
      weather:
          (json['weather'] as List<dynamic>?)
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
