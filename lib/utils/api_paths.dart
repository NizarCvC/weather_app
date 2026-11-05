class ApiPaths {
    static const String geocodingUrl =
      'http://api.openweathermap.org/geo/1.0/direct';
  static const String weatherBaseUrl =
      'https://api.openweathermap.org/data/4.0/onecall';
  static const String currentWeatherUrl = '$weatherBaseUrl/current';
  static const String minutelyForecastUrl = '$weatherBaseUrl/timeline/1min';
  static const String fifteenMinuteForecastUrl = '$weatherBaseUrl/timeline/15min';
  static const String hourlyForecastUrl = '$weatherBaseUrl/timeline/1h';
  static const String dailyForecastUrl = '$weatherBaseUrl/timeline/1d';
  static const String alertForecastUrl = '$geocodingUrl/alert';
}
