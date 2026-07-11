import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/weather_models/weather_model.dart';
import 'package:weather_app/utils/router/app_routes.dart';
import 'package:weather_app/view_models/saved_cities_cubit/saved_cities_cubit.dart';
import 'package:weather_app/view_models/search_cubit/search_cubit.dart';
import 'package:weather_app/view_models/weather_cubit/weather_cubit.dart';
import 'package:weather_app/views/pages/current_weather_page.dart';
import 'package:weather_app/views/pages/forecast_report_page.dart';
import 'package:weather_app/views/pages/saved_weathers_page.dart';
import 'package:weather_app/views/pages/search_weather_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.currentWeather:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = WeatherCubit();
              cubit.fetchCurrentLocationWeather();
              return cubit;
            },
            child: const CurrentWeatherPage(),
          ),
        );
      case AppRoutes.searchWeather:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SearchCubit(),
            child: const SearchWeatherPage(),
          ),
        );
      case AppRoutes.forecastReportWeather:
        return MaterialPageRoute(
          builder: (_) {
            final WeatherModel weatherModel =
                settings.arguments as WeatherModel;
            return ForecastReportPage(weatherModel: weatherModel);
          },
        );
      case AppRoutes.savedWeathers:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = SavedCitiesCubit();
              cubit.fetchSavedCitiesWeather();
              return cubit;
            },
            child: const SavedWeathersPage(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
