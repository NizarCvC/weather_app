import 'package:flutter/material.dart';
import 'package:weather_app/utils/router/app_routes.dart';
import 'package:weather_app/views/pages/current_weather_page.dart';
import 'package:weather_app/views/pages/search_weather_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.currentWeather:
        return MaterialPageRoute(builder: (_) => CurrentWeatherPage());
      case AppRoutes.searchWeather:
        return MaterialPageRoute(builder: (_) => SearchWeatherPage());
      // case AppRoutes.currentWeatherDetails:
      //   return MaterialPageRoute(builder: (_) => CurrentWeatherDetailsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}