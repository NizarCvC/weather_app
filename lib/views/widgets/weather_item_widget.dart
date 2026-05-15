import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/utils/theme/app_colors.dart';

class WeatherItemWidget extends StatelessWidget {
  const WeatherItemWidget({super.key});

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
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text('20°', style: textTheme.displaySmall),
                SvgPicture.asset(
                  height: size.height * 0.06,
                  'assets/weather/Weather Icon-14.svg',
                ),
              ],
            ),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text('H:24° L:40°', style: TextStyle(color: Colors.grey[500])),
                Text(
                  'Madinah, Saudi',
                  style: textTheme.titleMedium!.copyWith(fontWeight: .w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
