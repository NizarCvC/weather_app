import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/weather_models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  final WeatherServices _weatherServices = WeatherServicesImpl();

  Future<void> fetchWeatherInfo() async {
    emit(FetchingWeatherInfo());

    try {
      var weatherInfo = await _weatherServices.getCityWeather("Medina");
      emit(WeatherInfoFetched(weatherModel: weatherInfo));
    } catch (e) {
      debugPrint("Error has occurred$e");
      emit(FetchingWeatherInfoFailed(errorMessage: e.toString()));
    }
  }
}
