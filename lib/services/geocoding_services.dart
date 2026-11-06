import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:weather_app/models/geocoding_models/city_model.dart';
import 'package:weather_app/models/query_params_models/geocoding_query_params.dart';
import 'package:weather_app/utils/api_paths.dart';
import 'package:weather_app/utils/app_constants.dart';
import 'package:dio/dio.dart';

abstract class GeocodingServices {
  Future<CityModel> getCityGeocoding(String cityName);
  Future<List<CityModel>> getCitesList(String cityName);
}

class GeocodingServicesImpl implements GeocodingServices {
  final Dio dio = Dio();

  late final CacheOptions _cacheOptions;

  GeocodingServicesImpl() {
    _cacheOptions = CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.request,
      hitCacheOnNetworkFailure: true,
      hitCacheOnErrorCodes: [500, 502, 503, 504],
      maxStale: const Duration(minutes: 30),
    );
    dio.interceptors.add(DioCacheInterceptor(options: _cacheOptions));
  }

  @override
  Future<CityModel> getCityGeocoding(String cityName) async {
    final geocodingQueryParams = GeocodingQueryParams(
      q: cityName,
      appid: AppConstants.apiKey,
    );

    final geocodingResponse = await dio.get(
      ApiPaths.geocodingUrl,
      queryParameters: geocodingQueryParams.toMap(),
      options: _cacheOptions
          .copyWith(maxStale: const Duration(days: 30))
          .toOptions(),
    );

    if (geocodingResponse.statusCode != 200) {
      throw Exception(geocodingResponse.statusMessage);
    }

    final cityList = geocodingResponse.data as List;
    if (cityList.isEmpty) {
      throw Exception('No city found');
    }
    return CityModel.fromMap(cityList.first);
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
      options: _cacheOptions.copyWith(policy: CachePolicy.refresh).toOptions(),
    );

    if (geocodingResponse.statusCode != 200) {
      throw Exception(geocodingResponse.statusMessage);
    }

    final cityList = geocodingResponse.data as List;
    return cityList.map((e) => CityModel.fromMap(e)).toList();
  }
}
