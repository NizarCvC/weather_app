import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/utils/router/app_routes.dart';
import 'package:weather_app/utils/theme/app_colors.dart';
import 'package:weather_app/view_models/weather_cubit/weather_cubit.dart';
import 'package:weather_app/views/widgets/city_weather_widget.dart';

class CurrentWeatherPage extends StatelessWidget {
  const CurrentWeatherPage({super.key});

  static const _iconList = [Icons.location_on_outlined, Icons.list];

  Widget _buildAnimatedBottomNavigationBar(
    BuildContext context,
    Function(int) onTap,
  ) {
    final size = MediaQuery.of(context).size;
    return AnimatedBottomNavigationBar(
      iconSize: size.height * 0.035,
      icons: _iconList,
      backgroundColor: AppColors.bottomNavigationColor,
      activeColor: AppColors.white,
      inactiveColor: AppColors.white,
      activeIndex: 0,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      onTap: onTap,
    );
  }

  Widget _buildFloatingActionButton(
    BuildContext context,
    VoidCallback onPressed,
  ) {
    final size = MediaQuery.of(context).size;
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.themeColor,
      shape: CircleBorder(),
      child: Icon(size: size.height * 0.04, Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      buildWhen: (previous, current) =>
          current is FetchingWeatherInfo ||
          current is WeatherInfoFetched ||
          current is FetchingWeatherInfoFailed,
      builder: (context, state) {
        if (state is WeatherInfoFetched) {
          final weatherInfo = state.weatherModel;
          return Scaffold(
            extendBody: true,
            body: CityWeatherWidget(weatherInfo: weatherInfo),
            floatingActionButton: _buildFloatingActionButton(
              context,
              () => Navigator.of(context).pushNamed(AppRoutes.searchWeather),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: _buildAnimatedBottomNavigationBar(context, (
              index,
            ) {
              switch (index) {
                case 0:
                  Navigator.of(context).pushNamed(
                    AppRoutes.forecastReportWeather,
                    arguments: weatherInfo,
                  );
                  break;
                case 1:
                  Navigator.of(context).pushNamed(AppRoutes.savedWeathers);
                  break;
              }
            }),
          );
        } else {
          return Scaffold(
            extendBody: true,
            body: CityWeatherWidget.loading(),
            floatingActionButton: _buildFloatingActionButton(context, () {}),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: _buildAnimatedBottomNavigationBar(
              context,
              (index) {},
            ),
          );
        }
      },
    );
  }
}
