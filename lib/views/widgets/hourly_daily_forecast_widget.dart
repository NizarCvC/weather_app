import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/models/weather_models/daily_weather.dart';
import 'package:weather_app/models/weather_models/hourly_weather.dart';
import 'package:weather_app/utils/helpers/date_time_helper.dart';

class HourlyDailyForecastWidget extends StatelessWidget {
  final List<HourlyWeather>? hourlyList;
  final List<DailyWeather>? dailyList;
  const HourlyDailyForecastWidget.hourly({
    super.key,
    required List<HourlyWeather> this.hourlyList,
  }) : dailyList = null;

  const HourlyDailyForecastWidget.daily({
    super.key,
    required List<DailyWeather> this.dailyList,
  }) : hourlyList = null;

  Widget _buildHourlyWeatherItem(
    BuildContext context,
    HourlyWeather hourlyItem,
  ) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: .center,
      children: [
        Text(
          DateTimeHelper.getTime(hourlyItem.dt),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          color: Color(0xFF2a3169),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset(
              hourlyItem.weather.first.icon,
              height: size.height * 0.04,
            ),
          ),
        ),
        Text(
          "${hourlyItem.feelsLike.round()}°",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  Widget _buildDailyWeatherItem(BuildContext context, DailyWeather dailyItem) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: .center,
      children: [
        Text(
          DateTimeHelper.getShortDayName(dailyItem.dt),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          color: Color(0xFF2a3169),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset(
              dailyItem.weather.first.icon,
              height: size.height * 0.04,
            ),
          ),
        ),
        Text(
          "${dailyItem.temp.day.round()}°",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: (hourlyList != null)
          ? ListView.builder(
              itemCount: hourlyList!.length,
              scrollDirection: .horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: _buildHourlyWeatherItem(context, hourlyList![index]),
              ),
            )
          : ListView.builder(
              itemCount: dailyList!.length,
              scrollDirection: .horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: _buildDailyWeatherItem(context, dailyList![index]),
              ),
            ),
    );
  }
}
