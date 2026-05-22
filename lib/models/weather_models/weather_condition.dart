class WeatherCondition {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherCondition({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      id: json['id'] ?? 0,
      main: json['main'] ?? '',
      description: json['description'] ?? '',
      icon: _mapWeatherIcons(json['icon']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }

  static String _mapWeatherIcons(String icon) {
    return switch (icon) {
      '01d' => 'assets/weather/Weather Icon.svg',
      '02d' => 'assets/weather/Weather Icon-6.svg',
      '03d' => 'assets/weather/Weather Icon-8.svg',
      '04d' => 'assets/weather/Weather Icon-8.svg',
      '09d' => 'assets/weather/Weather Icon-23.svg',
      '10d' => 'assets/weather/Weather Icon-11.svg',
      '11d' => 'assets/weather/Weather Icon-14.svg',
      '13d' => 'assets/weather/Weather Icon-36.svg',
      '50d' => 'assets/weather/Weather Icon-50.svg',
      '01n' => 'assets/weather/Weather Icon-1.svg',
      '02n' => 'assets/weather/Weather Icon-7.svg',
      '03n' => 'assets/weather/Weather Icon-8.svg',
      '04n' => 'assets/weather/Weather Icon-8.svg',
      '09n' => 'assets/weather/Weather Icon-23.svg',
      '10n' => 'assets/weather/Weather Icon-12.svg',
      '11n' => 'assets/weather/Weather Icon-14.svg',
      '13n' => 'assets/weather/Weather Icon-36.svg',
      '50n' => 'assets/weather/Weather Icon-50.svg',
      _ => 'assets/weather/Weather Icon.svg'
    };
  }
}
