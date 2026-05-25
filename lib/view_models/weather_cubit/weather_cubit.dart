import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/geocoding_models/city_model.dart';
import 'package:weather_app/models/weather_models/weather_model.dart';
import 'package:weather_app/services/local_database_services.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/utils/app_constants.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  final _localDatabaseServices = LocalDatabaseServicesImpl();
  final _weatherServices = WeatherServicesImpl();

  Future<void> fetchWeatherInfoTemp() async {
    emit(FetchingWeatherInfo());

    try {
      var weatherInfo = await _weatherServices.getCityWeather("Medina");
      emit(WeatherInfoFetched(weatherModel: weatherInfo));
    } catch (e) {
      debugPrint("Error has occurred $e");
      emit(FetchingWeatherInfoFailed(e.toString()));
    }
  }

  Future<void> fetchWeatherInfo(String cityName) async {
    emit(FetchingWeatherInfo());

    try {
      var weatherInfo = await _weatherServices.getCityWeather(cityName);
      emit(WeatherInfoFetched(weatherModel: weatherInfo));
    } catch (e) {
      debugPrint("Error has occurred $e");
      emit(FetchingWeatherInfoFailed(e.toString()));
    }
  }

  Future<void> searchingWeather(String cityName) async {
    emit(SearchingWeatherName());

    try {
      var cityList = await _weatherServices.getCitesList(cityName);
      emit(SearchedWeatherName(cityModels: cityList));
    } catch (e) {
      debugPrint("Error has occurred $e");
      emit(SearchingWeatherNameFailed(e.toString()));
    }
  }

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
        emit(SavedWeatherCitiesFetched(weatherModels: []));
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
          return _weatherServices.getCityWeather(cityName);
        });

        final List<WeatherModel> batchResults = await Future.wait(futures);
        allWeatherResults.addAll(batchResults);
      }

      emit(SavedWeatherCitiesFetched(weatherModels: allWeatherResults));
    } catch (e) {
      emit(FetchingSavedWeatherCitiesFailed(e.toString()));
    }
  }
}
