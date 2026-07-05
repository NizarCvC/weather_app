import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/models/weather_models/weather_model.dart';
import 'package:weather_app/utils/theme/app_colors.dart';

class WeatherItemWidget extends StatelessWidget {
  final WeatherModel cityWeather;
  final bool isDeleteActive;
  const WeatherItemWidget({
    super.key,
    required this.cityWeather,
    this.isDeleteActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: AppColors.nightColors),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisAlignment: .spaceBetween,
          children: [
            if (isDeleteActive) ...[
              IconButton(
                style: IconButton.styleFrom(
                  minimumSize: Size(size.width * 0.005, size.height * 0.005),
                  padding: const EdgeInsets.all(0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                icon: const Icon(Icons.delete_outline_outlined),
              ),
            ],
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  '${cityWeather.current?.temp.round() ?? 'Unknown'}°',
                  style: textTheme.displaySmall,
                ),
                SvgPicture.asset(
                  height: size.height * 0.06,
                  cityWeather.current?.weather.first.icon ??
                      'assets/weather/Weather Icon-14.svg',
                ),
              ],
            ),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  cityWeather.cityName,
                  style: textTheme.titleMedium!.copyWith(fontWeight: .w600),
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
