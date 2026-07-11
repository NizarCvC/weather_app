import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/weather_models/weather_model.dart';
import 'package:weather_app/services/local_database_services.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/utils/app_constants.dart';

part 'saved_cities_state.dart';

class SavedCitiesCubit extends Cubit<SavedCitiesState> {
  SavedCitiesCubit() : super(SavedCitiesInitial());

  final _localDatabaseServices = LocalDatabaseServicesImpl();
  final _weatherServices = WeatherServicesImpl();
  bool _isDeletingSavedWeathersActive = false;
  bool get isDeletingActive => _isDeletingSavedWeathersActive;
  List<WeatherModel> _savedCitiesWeather = [];
  List<WeatherModel> get savedCitiesWeather => _savedCitiesWeather;

  Future<List<String>> _prepareSavedCitiesList() async {
    final fetchedCities = await _localDatabaseServices.getStringList(
      AppConstants.localDatabaseKey,
    );
    return fetchedCities ?? [];
  }

  Future<void> saveCityNameToLocalDatabase(String cityName) async {
    try {
      final citiesList = await _prepareSavedCitiesList();

      if (citiesList.contains(cityName)) {
        emit(SavedCityName());
        return;
      }

      if (citiesList.length > 50) {
        citiesList.removeAt(0);
      }

      citiesList.add(cityName);
      await _localDatabaseServices.setStringList(
        AppConstants.localDatabaseKey,
        citiesList,
      );
      _savedCitiesWeather = [];
      emit(SavedCityName());
    } catch (e) {
      emit(SaveCityNameError(e.toString()));
    }
  }

  Future<void> unsaveCityNameFromLocalDatabase(String cityName) async {
    try {
      final citiesList = await _prepareSavedCitiesList();

      if (citiesList.isEmpty) {
        emit(UnsavedCityName());
        return;
      }

      citiesList.removeWhere((e) => e == cityName);
      await _localDatabaseServices.setStringList(
        AppConstants.localDatabaseKey,
        citiesList,
      );
      _savedCitiesWeather = [];
      emit(UnsavedCityName());
    } catch (e) {
      emit(UnsaveCityNameError(e.toString()));
    }
  }

  Future<void> fetchSavedCitiesWeather() async {
    emit(FetchingSavedWeatherCities());

    try {
      final citiesList = await _prepareSavedCitiesList();

      if (citiesList.isEmpty) {
        _savedCitiesWeather = [];
        emit(SavedWeatherCitiesFetched());
        return;
      }

      final List<WeatherModel> allWeatherResults = [];
      const int batchSize = 5;

      for (int i = 0; i < citiesList.length; i += batchSize) {
        final batch = citiesList.sublist(
          i,
          i + batchSize > citiesList.length ? citiesList.length : i + batchSize,
        );

        final futures = batch.map((cityName) {
          return _weatherServices.getCityWeatherByCityName(cityName);
        });

        final List<WeatherModel> batchResults = await Future.wait(futures);
        allWeatherResults.addAll(batchResults);
      }
      _savedCitiesWeather = allWeatherResults;
      emit(SavedWeatherCitiesFetched());
    } catch (e) {
      emit(FetchingSavedWeatherCitiesFailed(e.toString()));
    }
  }

  void toggleActiveDeletingWeathers() {
    _isDeletingSavedWeathersActive = !_isDeletingSavedWeathersActive;

    if (_isDeletingSavedWeathersActive) {
      emit(ActiveDeletingSavedWeathers());
    } else {
      emit(DeactivatedDeletingSavedWeathers());
    }
  }
}
