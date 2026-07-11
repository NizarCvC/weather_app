import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/geocoding_models/city_model.dart';
import 'package:weather_app/services/weather_services.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  final _weatherServices = WeatherServicesImpl();

  Future<void> searchingWeather(String cityName) async {
    emit(SearchingWeatherName());

    try {
      var cityList = await _weatherServices.getCitesList(cityName);
      emit(SearchedWeatherName(cityModels: cityList));
    } catch (e) {
      emit(SearchingWeatherNameFailed(e.toString()));
    }
  }
}
