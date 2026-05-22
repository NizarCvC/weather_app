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
      '01d' => WeatherType.sunny,
      '02d' => WeatherType.cloudy,
      '03d' => WeatherType.cloudy,
      '04d' => WeatherType.cloudy,
      '09d' => WeatherType.middleRainy,
      '10d' => WeatherType.lightRainy,
      '11d' => WeatherType.heavyRainy,
      '13d' => WeatherType.middleSnow,
      '50d' => WeatherType.dusty,
      '01n' => WeatherType.sunnyNight,
      '02n' => WeatherType.cloudyNight,
      '03n' => WeatherType.cloudy,
      '04n' => WeatherType.cloudy,
      '09n' => WeatherType.middleRainy,
      '10n' => WeatherType.lightRainy,
      '11n' => WeatherType.heavyRainy,
      '13n' => WeatherType.middleSnow,
      '50n' => WeatherType.dusty,
      _ => WeatherType.sunny,
    };
  }
}
