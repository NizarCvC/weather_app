import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/geocoding_models/city_model.dart';
import 'package:weather_app/models/weather_models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  final WeatherServices _weatherServices = WeatherServicesImpl();

  Future<void> fetchWeatherInfo() async {
    emit(FetchingWeatherInfo());

    try {
      var weatherInfo = await _weatherServices.getCityWeather("Medina"); // TODO: Need to updated
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
}
