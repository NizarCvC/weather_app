import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/utils/app_constants.dart';
import 'package:weather_app/utils/router/app_router.dart';
import 'package:weather_app/utils/router/app_routes.dart';
import 'package:weather_app/utils/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env');
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: .dark,
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.lightModeTheme,
      darkTheme: AppTheme.darkModeTheme,
      initialRoute: AppRoutes.currentWeather,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
