part of 'saved_cities_cubit.dart';

sealed class SavedCitiesState {}

final class SavedCitiesInitial extends SavedCitiesState {}

final class SavedCityName extends SavedCitiesState {}

final class SaveCityNameError extends SavedCitiesState {
  final String errorMessage;

  SaveCityNameError(this.errorMessage);
}

final class UnsavedCityName extends SavedCitiesState {}

final class UnsaveCityNameError extends SavedCitiesState {
  final String errorMessage;

  UnsaveCityNameError(this.errorMessage);
}

final class FetchingSavedWeatherCities extends SavedCitiesState {}

final class SavedWeatherCitiesFetched extends SavedCitiesState {}

final class FetchingSavedWeatherCitiesFailed extends SavedCitiesState {
  final String errorMessage;

  FetchingSavedWeatherCitiesFailed(this.errorMessage);
}

final class ActiveDeletingSavedWeathers extends SavedCitiesState {}

final class DeactivatedDeletingSavedWeathers extends SavedCitiesState {}
