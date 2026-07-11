import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/weather_models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:geolocator/geolocator.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  final _weatherServices = WeatherServicesImpl();

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
}
