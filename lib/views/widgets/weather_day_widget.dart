import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/models/weather_models/daily_weather.dart';
import 'package:weather_app/utils/helpers/date_time_helper.dart';
import 'package:weather_app/utils/theme/app_colors.dart';

class WeatherDayWidget extends StatelessWidget {
  final DailyWeather dailyWeather;
  const WeatherDayWidget({super.key, required this.dailyWeather});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: size.height * 0.1,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(colors: AppColors.nightColors),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            SizedBox(
              height: double.infinity,
              width: size.width * 0.3,
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    DateTimeHelper.getDayName(dailyWeather.dt),
                    style: textTheme.titleLarge!.copyWith(fontWeight: .w500),
                  ),
                  Text(
                    DateTimeHelper.getDayAndMonth(dailyWeather.dt),
                    style: textTheme.titleMedium!.copyWith(fontWeight: .w400),
                  ),
                ],
              ),
            ),
            Text(
              '${dailyWeather.temp.day.round()}°',
              style: textTheme.displaySmall,
            ),
            SvgPicture.asset(
              height: size.height * 0.05,
              width: size.width * 0.05,
              fit: .cover,
              'assets/weather/Weather Icon-14.svg',
            ),
          ],
        ),
      ),
    );
  }
}
