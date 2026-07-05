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

final class SearchingWeatherName extends WeatherState {}

final class SearchedWeatherName extends WeatherState {
  final List<CityModel> cityModels;

  SearchedWeatherName({required this.cityModels});
}

final class SearchingWeatherNameFailed extends WeatherState {
  final String errorMessage;

  SearchingWeatherNameFailed(this.errorMessage);
}

final class SavedCityName extends WeatherState {}

final class SaveCityNameError extends WeatherState {
  final String errorMessage;

  SaveCityNameError(this.errorMessage);
}

final class UnsavedCityName extends WeatherState {}

final class UnsaveCityNameError extends WeatherState {
  final String errorMessage;

  UnsaveCityNameError(this.errorMessage);
}

final class FetchingSavedWeatherCities extends WeatherState {}

final class SavedWeatherCitiesFetched extends WeatherState {
  final List<WeatherModel> weatherModels;

  SavedWeatherCitiesFetched({required this.weatherModels});
}

final class FetchingSavedWeatherCitiesFailed extends WeatherState {
  final String errorMessage;

  FetchingSavedWeatherCitiesFailed(this.errorMessage);
}

final class ActiveDeletingSavedWeathers extends WeatherState {}

final class UnActiveDeletingSavedWeathers extends WeatherState {}