import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/models/weather_models/weather_model.dart';
import 'package:weather_app/utils/theme/app_colors.dart';
import 'package:weather_app/view_models/saved_cities_cubit/saved_cities_cubit.dart';

class WeatherItemWidget extends StatefulWidget {
  final WeatherModel cityWeather;

  const WeatherItemWidget({
    super.key,
    required this.cityWeather,
  });

  @override
  State<WeatherItemWidget> createState() => _WeatherItemWidgetState();
}

class _WeatherItemWidgetState extends State<WeatherItemWidget> {
  bool _isPressed = false;

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Delete City'),
          content: Text(
              'Are you sure you want to remove ${widget.cityWeather.cityName} from your saved cities?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final cubit = BlocProvider.of<SavedCitiesCubit>(context);
                cubit.unsaveCityNameFromLocalDatabase(widget.cityWeather.cityName);
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${widget.cityWeather.cityName} deleted'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return AnimatedScale(
      scale: _isPressed ? 0.93 : 1.0,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onHighlightChanged: (isHighlighted) {
          setState(() {
            _isPressed = isHighlighted;
          });
        },
        onTap: () {
          Navigator.pop(context, widget.cityWeather.cityName);
        },
        onLongPress: () {
          _showDeleteDialog(context);
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: AppColors.nightColors),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.cityWeather.current?.temp.round() ?? 'Unknown'}°',
                      style: textTheme.displaySmall,
                    ),
                    SvgPicture.asset(
                      widget.cityWeather.current?.weather.first.icon ??
                          'assets/weather/Weather Icon-14.svg',
                      height: size.height * 0.06,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cityWeather.cityName,
                      style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}