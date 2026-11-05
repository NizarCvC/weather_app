import 'package:weather_app/models/geocoding_models/city_model.dart';
import 'package:weather_app/models/query_params_models/geocoding_query_params.dart';
import 'package:weather_app/models/query_params_models/weather_query_params.dart';
import 'package:weather_app/models/weather_models/weather_model.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/utils/api_paths.dart';
import 'package:weather_app/utils/app_constants.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

abstract class WeatherServices {
  Future<List<CityModel>> getCitesList(String cityName);
  Future<WeatherModel> getCurrentCityWeather(
    String cityName,
    WeatherQueryParams queryParams,
  );
}

class WeatherServicesImpl implements WeatherServices {
  final Dio dio = Dio();

  late final CacheOptions cacheOptions;

  WeatherServicesImpl() {
    cacheOptions = CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.request,
      hitCacheOnNetworkFailure: true,
      hitCacheOnErrorCodes: [500, 502, 503, 504],
      maxStale: const Duration(minutes: 30),
    );
    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
  }

  @override
  Future<WeatherModel> getCurrentCityWeather(
    String cityName,
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

      return WeatherModel.fromJson(cityName, weatherResponse.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CityModel>> getCitesList(String cityName) async {
    final geocodingQueryParams = GeocodingQueryParams(
      q: cityName,
      appid: AppConstants.apiKey,
    );

    final geocodingResponse = await dio.get(
      ApiPaths.geocodingUrl,
      queryParameters: geocodingQueryParams.toMap(),
      options: cacheOptions.copyWith(policy: CachePolicy.refresh).toOptions(),
    );

    if (geocodingResponse.statusCode != 200) {
      throw Exception(geocodingResponse.statusMessage);
    }

    final cityList = geocodingResponse.data as List;
    return cityList.map((e) => CityModel.fromMap(e)).toList();
  }
}
