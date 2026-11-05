import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/query_params_models/weather_query_params.dart';
import 'package:weather_app/models/weather_models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/utils/app_constants.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  final _weatherServices = WeatherServicesImpl();

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<Location?> _getGeocodingByCityName(String cityName) async {
    final geocoding = Geocoding();
    List<Location> locations = await geocoding.locationFromAddress(cityName);
    return locations.isEmpty ? null : locations.first;
  }

  Future<Placemark?> _getCityNameByGeocoding(
    double latitude,
    double longitude,
  ) async {
    final geocoding = Geocoding();
    List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(
      latitude,
      longitude,
    );
    return placemarks.isEmpty ? null : placemarks.first;
  }

  Future<void> fetchCurrentLocationWeather() async {
    emit(FetchingWeatherInfo());

    try {
      Position? position = await _determinePosition();

      if (position != null) {
        final params = WeatherQueryParams(
          lat: position.latitude,
          lon: position.longitude,
          appid: AppConstants.apiKey,
        );

        final placemark = await _getCityNameByGeocoding(
          position.latitude,
          position.longitude,
        );

        if (placemark == null || placemark.locality == null) {
          emit(
            FetchingWeatherInfoFailed(
              'There is no city found for the current location.',
            ),
          );
          return;
        }

        WeatherModel weatherInfo = await _weatherServices.getCurrentCityWeather(
          placemark.locality!,
          params,
        );

        emit(WeatherInfoFetched(weatherModel: weatherInfo));
      } else {
        await fetchWeatherInfo(AppConstants.defaultCityName);
      }
    } catch (e) {
      emit(FetchingWeatherInfoFailed(e.toString()));
    }
  }

  Future<void> fetchWeatherInfo(String cityName) async {
    emit(FetchingWeatherInfo());

    try {
      final location = await _getGeocodingByCityName(cityName);

      if (location == null) {
        emit(
          FetchingWeatherInfoFailed(
            'There is no city with this name: $cityName.',
          ),
        );
        return;
      }

      final params = WeatherQueryParams(
        lat: location.latitude,
        lon: location.longitude,
        appid: AppConstants.apiKey,
      );

      var weatherInfo = await _weatherServices.getCurrentCityWeather(
        cityName,
        params,
      );
      emit(WeatherInfoFetched(weatherModel: weatherInfo));
    } catch (e) {
      emit(FetchingWeatherInfoFailed(e.toString()));
    }
  }
}
