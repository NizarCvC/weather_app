import 'package:weather_app/models/weather_models/weather_model.dart';

class CityWeather {
  final String cityName;
  final WeatherModel weatherModel;

  CityWeather({required this.cityName, required this.weatherModel});

  CityWeather copyWith({String? cityName, WeatherModel? weatherModel}) {
    return CityWeather(
      cityName: cityName ?? this.cityName,
      weatherModel: weatherModel ?? this.weatherModel,
    );
  }
}
