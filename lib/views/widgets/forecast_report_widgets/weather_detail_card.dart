import 'package:flutter/material.dart';
import 'package:weather_app/utils/theme/app_colors.dart';

class WeatherDetailCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String info;

  const WeatherDetailCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.info,
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
          children: [
            Row(
              children: [
                Image.asset(
                  height: size.height * 0.05,
                  width: size.width * 0.05,
                  fit: .contain,
                  iconPath,
                ),
                SizedBox(width: size.width * 0.03),
                Text(title, style: textTheme.titleMedium),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Text(info, style: textTheme.headlineMedium),
          ],
        ),
      ),
    );
  }
}
