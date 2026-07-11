part of 'search_cubit.dart';

sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchingWeatherName extends SearchState {}

final class SearchedWeatherName extends SearchState {
  final List<CityModel> cityModels;

  SearchedWeatherName({required this.cityModels});
}

final class SearchingWeatherNameFailed extends SearchState {
  final String errorMessage;

  SearchingWeatherNameFailed(this.errorMessage);
}
