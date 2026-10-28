import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static const String appName = 'Weather App';
  static final String apiKey =
      dotenv.env['API_KEY'] ??
      (throw Exception('API_KEY is missing in .env file'));
  static const String localDatabaseKey = 'saved_cities';
}
