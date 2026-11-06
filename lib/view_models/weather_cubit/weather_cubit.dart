import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/query_params_models/weather_query_params.dart';
import 'package:weather_app/models/weather_models/city_weather.dart';
import 'package:weather_app/services/geocoding_services.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/utils/app_constants.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  final _weatherServices = WeatherServicesImpl();
  final _geocodingServices = GeocodingServicesImpl();

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

        final weatherInfo = await _weatherServices.getCurrentCityWeather(
          params,
        );

        final cityWeatherModel = CityWeather(
          cityName: placemark.locality!,
          weatherModel: weatherInfo,
        );

        emit(WeatherInfoFetched(cityWeatherModel: cityWeatherModel));
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
      final location = await _geocodingServices.getCityGeocoding(cityName);

      final params = WeatherQueryParams(
        lat: location.lat,
        lon: location.lon,
        appid: AppConstants.apiKey,
      );

      final weatherInfo = await _weatherServices.getCurrentCityWeather(params);

      final cityWeatherMode = CityWeather(
        cityName: cityName,
        weatherModel: weatherInfo,
      );
      emit(WeatherInfoFetched(cityWeatherModel: cityWeatherMode));
    } catch (e) {
      emit(FetchingWeatherInfoFailed(e.toString()));
    }
  }
}
