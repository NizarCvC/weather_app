import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/geocoding_models/city_model.dart';
import 'package:weather_app/models/weather_models/weather_model.dart';
import 'package:weather_app/services/local_database_services.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/utils/app_constants.dart';
import 'package:geolocator/geolocator.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  final _localDatabaseServices = LocalDatabaseServicesImpl();
  final _weatherServices = WeatherServicesImpl();
  bool _isDeletingSavedWeathersActive = false;
  bool get isDeletingActive => _isDeletingSavedWeathersActive;
  List<WeatherModel> _savedCitiesWeather = [];
  List<WeatherModel> get savedCitiesWeather => _savedCitiesWeather;

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Location services are disabled.');
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('Location permissions are denied');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> fetchCurrentLocationWeather() async {
    emit(FetchingWeatherInfo());

    try {
      Position? position = await _determinePosition();
      WeatherModel weatherInfo;

      if (position != null) {
        weatherInfo = await _weatherServices.getCityWeatherByCoordinate(
          position.latitude,
          position.longitude,
        );
      } else {
        weatherInfo = await _weatherServices.getCityWeatherByCityName('Makkah');
      }
      emit(WeatherInfoFetched(weatherModel: weatherInfo));
    } catch (e) {
      debugPrint('Error has occurred $e');
      emit(FetchingWeatherInfoFailed(e.toString()));
    }
  }

  Future<void> fetchWeatherInfo(String cityName) async {
    emit(FetchingWeatherInfo());

    try {
      var weatherInfo = await _weatherServices.getCityWeatherByCityName(
        cityName,
      );
      emit(WeatherInfoFetched(weatherModel: weatherInfo));
    } catch (e) {
      debugPrint('Error has occurred $e');
      emit(FetchingWeatherInfoFailed(e.toString()));
    }
  }

  Future<void> searchingWeather(String cityName) async {
    emit(SearchingWeatherName());

    try {
      var cityList = await _weatherServices.getCitesList(cityName);
      emit(SearchedWeatherName(cityModels: cityList));
    } catch (e) {
      debugPrint('Error has occurred $e');
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
