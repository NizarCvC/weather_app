import 'package:weather_app/models/query_params_models/weather_query_params.dart';
import 'package:weather_app/models/weather_models/daily_weather.dart';
import 'package:weather_app/models/weather_models/hourly_weather.dart';
import 'package:weather_app/models/weather_models/weather_model.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/utils/api_paths.dart';
import 'package:weather_app/utils/app_constants.dart';

abstract class WeatherServices {
  Future<WeatherModel> getCurrentCityWeather(WeatherQueryParams queryParams);
}

class WeatherServicesImpl implements WeatherServices {
  final Dio dio = Dio();

  Future<List<HourlyWeather>> _getCity24HourlyWeather(
    WeatherQueryParams queryParams,
  ) async {
    try {
      final weatherQueryParams = WeatherQueryParams(
        lat: queryParams.lat,
        lon: queryParams.lon,
        appid: AppConstants.apiKey,
      );

      final weatherResponse = await dio.get(
        ApiPaths.hourlyForecastUrl,
        queryParameters: weatherQueryParams.toMap(),
      );

      if (weatherResponse.statusCode != 200) {
        throw Exception(weatherResponse.statusMessage);
      }

      return WeatherModel.fromJson(weatherResponse.data).hourly;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WeatherModel> getCurrentCityWeather(
    WeatherQueryParams queryParams,
  ) async {
    try {
      final weatherQueryParams = WeatherQueryParams(
        lat: queryParams.lat,
        lon: queryParams.lon,
        appid: AppConstants.apiKey,
      );

      final weatherResponse = await dio.get(
        ApiPaths.currentWeatherUrl,
        queryParameters: weatherQueryParams.toMap(),
      );

      if (weatherResponse.statusCode != 200) {
        throw Exception(weatherResponse.statusMessage);
      }

      final hourlyWeather = await _getCity24HourlyWeather(weatherQueryParams);
      final dailyWeather = await _getCityDailyWeather(weatherQueryParams);

      final currentWeatherModel = WeatherModel.fromJson(weatherResponse.data).copyWith(
        hourly: hourlyWeather,
        daily: dailyWeather,
      );

      return currentWeatherModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DailyWeather>> _getCityDailyWeather(WeatherQueryParams queryParams) async {
    try {
      final weatherQueryParams = WeatherQueryParams(
        lat: queryParams.lat,
        lon: queryParams.lon,
        appid: AppConstants.apiKey,
      );

      final weatherResponse = await dio.get(
        ApiPaths.dailyForecastUrl,
        queryParameters: weatherQueryParams.toMap(),
      );

      if (weatherResponse.statusCode != 200) {
        throw Exception(weatherResponse.statusMessage);
      }

      return WeatherModel.fromJson(weatherResponse.data).daily.take(7).toList();
    } catch (e) {
      rethrow;
    }
  }
}
