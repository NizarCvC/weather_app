import 'package:weather_app/models/weather_models/daily_temp.dart';
import 'package:weather_app/models/weather_models/daily_weather.dart';
import 'package:weather_app/models/weather_models/weather_condition.dart';

class DailyData {
  static final List<DailyWeather> dummyDailyList = [
      DailyWeather(
        dt: 1714046400,
        moonPhase: 0.5,
        temp: DailyTemp(
          day: 25.0,
          min: 18.0,
          max: 27.0,
          night: 19.0,
          eve: 22.0,
          morn: 20.0,
        ),
        pressure: 1015,
        humidity: 50,
        dewPoint: 12.0,
        windSpeed: 5.0,
        windDeg: 180,
        clouds: 10,
        uvi: 8.0,
        pop: 0.0,
        weather: [
          WeatherCondition(
            id: 800,
            main: 'Clear',
            description: 'clear sky',
            icon: '01d',
          ),
        ],
      ),
      DailyWeather(
        dt: 1714132800,
        moonPhase: 0.6,
        temp: DailyTemp(
          day: 24.0,
          min: 17.0,
          max: 25.0,
          night: 18.0,
          eve: 21.0,
          morn: 19.0,
        ),
        pressure: 1012,
        humidity: 65,
        dewPoint: 14.0,
        windSpeed: 8.0,
        windDeg: 200,
        clouds: 50,
        uvi: 5.0,
        pop: 0.3,
        weather: [
          WeatherCondition(
            id: 802,
            main: 'Clouds',
            description: 'scattered clouds',
            icon: '03d',
          ),
        ],
      ),
      DailyWeather(
        dt: 1714219200,
        moonPhase: 0.7,
        temp: DailyTemp(
          day: 20.0,
          min: 15.0,
          max: 21.0,
          night: 16.0,
          eve: 18.0,
          morn: 17.0,
        ),
        pressure: 1008,
        humidity: 80,
        dewPoint: 16.0,
        windSpeed: 12.0,
        windDeg: 220,
        clouds: 100,
        uvi: 2.0,
        pop: 0.9,
        weather: [
          WeatherCondition(
            id: 502,
            main: 'Rain',
            description: 'heavy intensity rain',
            icon: '10d',
          ),
        ],
      ),
    ];
    
}