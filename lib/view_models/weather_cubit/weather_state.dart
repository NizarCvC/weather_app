part of 'weather_cubit.dart';

sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class FetchingWeatherInfo extends WeatherState {}

final class WeatherInfoFetched extends WeatherState {
  final CityWeather cityWeatherModel;

  WeatherInfoFetched({required this.cityWeatherModel});
}

final class FetchingWeatherInfoFailed extends WeatherState {
  final String errorMessage;

  FetchingWeatherInfoFailed(this.errorMessage);
}
