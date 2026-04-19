import 'package:weather_app/models/geocoding_models/city_model.dart';
import 'package:weather_app/models/query_params_models/geocoding_query_params.dart';
import 'package:weather_app/models/query_params_models/weather_query_params.dart';
import 'package:weather_app/models/weather_models/weather_model.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/utils/app_constants.dart';

abstract class WeatherServices {
  Future<WeatherModel> getCityWeather(String cityName);
}

class WeatherServicesImpl implements WeatherServices {
  final dio = Dio();

  Future<CityModel> _getCityGeocoding(String cityName) async {
    final geocodingQueryParams = GeocodingQueryParams(
      q: cityName,
      appid: AppConstants.apiKey,
    );
    final geocodingResponse = await dio.get(
      AppConstants.geocodingUrl,
      queryParameters: geocodingQueryParams.toMap(),
    );

    if (geocodingResponse.statusCode != 200) {
      throw Exception(geocodingResponse.statusMessage);
    }

    final cityList = geocodingResponse.data as List;
    if (cityList.isEmpty) {
      throw Exception("No city found");
    }
    return CityModel.fromJson(cityList.first);
  }

  @override
  Future<WeatherModel> getCityWeather(String cityName) async {
    try {
      final cityModel = await _getCityGeocoding(cityName);
      final weatherQueryParams = WeatherQueryParams(
        lat: cityModel.lat,
        lon: cityModel.lon,
        appid: AppConstants.apiKey,
      );
      final weatherResponse = await dio.get(
        AppConstants.weatherUrl,
        queryParameters: weatherQueryParams.toMap(),
      );

      if (weatherResponse.statusCode != 200) {
        throw Exception(weatherResponse.statusMessage);
      }

      return WeatherModel.fromJson(weatherResponse.data);
    } catch (e) {
      rethrow;
    }
  }
}
