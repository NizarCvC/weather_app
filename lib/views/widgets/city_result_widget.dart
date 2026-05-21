import 'package:flutter/material.dart';
import 'package:weather_app/models/geocoding_models/city_model.dart';
import 'package:weather_app/utils/theme/app_colors.dart';

class CityResultWidget extends StatelessWidget {
  final CityModel cityModel;

  const CityResultWidget({super.key, required this.cityModel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.08,
      width: double.infinity,
      child: Card(
        color: AppColors.nightColorLight,
        child: Align(
          alignment: .centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              '${cityModel.name}, ${cityModel.state}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
    );
  }
}
