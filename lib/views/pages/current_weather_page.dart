import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/utils/router/app_routes.dart';
import 'package:weather_app/utils/theme/app_colors.dart';
import 'package:adv_flutter_weather/bg/weather_bg.dart';
import 'package:adv_flutter_weather/utils/weather_type.dart';
import 'package:weather_app/view_models/weather_cubit/weather_cubit.dart';
import 'package:weather_app/views/widgets/city_weather_widget.dart';
import 'package:weather_app/views/widgets/hourly_daily_forecast_widget.dart';

class CurrentWeatherPage extends StatelessWidget {
  const CurrentWeatherPage({super.key});

  static const _iconList = [Icons.location_on_outlined, Icons.list];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<WeatherCubit>(context);
    return BlocBuilder<WeatherCubit, WeatherState>(
      bloc: cubit,
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
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.themeColor,
              shape: CircleBorder(),
              child: Icon(size: size.height * 0.04, Icons.add),
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.searchWeather),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar(
              iconSize: size.height * 0.035,
              icons: _iconList,
              backgroundColor: AppColors.bottomNavigationColor,
              activeColor: AppColors.white,
              inactiveColor: AppColors.white,
              activeIndex: 0,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.softEdge,
              onTap: (index) {
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
              },
            ),
          );
        } else {
          return Scaffold(
            extendBody: true,
            body: CityWeatherWidget.loading(),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.themeColor,
              shape: CircleBorder(),
              child: Icon(size: size.height * 0.04, Icons.add),
              onPressed: () {},
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar(
              iconSize: size.height * 0.035,
              icons: _iconList,
              backgroundColor: AppColors.bottomNavigationColor,
              activeColor: AppColors.white,
              inactiveColor: AppColors.white,
              activeIndex: 0,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.softEdge,
              onTap: (index) {
                switch (index) {}
              },
            ),
          );
        }
      },
    );
  }
}
