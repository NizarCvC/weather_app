part of 'weather_cubit.dart';

sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class FetchingWeatherInfo extends WeatherState {}

final class WeatherInfoFetched extends WeatherState {
  final WeatherModel weatherModel;

  WeatherInfoFetched({required this.weatherModel});
}

final class FetchingWeatherInfoFailed extends WeatherState {
  final String errorMessage;

  FetchingWeatherInfoFailed(this.errorMessage);
}
