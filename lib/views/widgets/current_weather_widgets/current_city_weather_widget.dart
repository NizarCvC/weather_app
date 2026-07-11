import 'dart:ui';

import 'package:adv_flutter_weather/bg/weather_bg.dart';
import 'package:adv_flutter_weather/utils/weather_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/models/weather_models/weather_model.dart';
import 'package:weather_app/utils/theme/app_colors.dart';
import 'package:weather_app/views/widgets/shared_widgets/hourly_daily_forecast_widget.dart';

class CurrentCityWeatherWidget extends StatefulWidget {
  final WeatherModel? weatherInfo;
  final bool isLoading;

  const CurrentCityWeatherWidget({super.key, required this.weatherInfo})
    : isLoading = false;

  const CurrentCityWeatherWidget.loading({super.key})
    : isLoading = true,
      weatherInfo = null;

  @override
  State<CurrentCityWeatherWidget> createState() =>
      _CurrentCityWeatherWidgetState();
}

class _CurrentCityWeatherWidgetState extends State<CurrentCityWeatherWidget>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTextWithGlassBackground(String text) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Stack(
        alignment: .center,
        children: [
          WeatherBg(
            weatherType:
                widget.weatherInfo?.current?.weatherScreen ??
                WeatherType.sunnyNight,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .center,
            children: [
              SizedBox(height: size.height * 0.1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildTextWithGlassBackground(
                  widget.isLoading
                      ? '--'
                      : widget.weatherInfo?.cityName ?? 'Unknown',
                ),
              ),
              SizedBox(height: size.height * 0.02),
              _buildTextWithGlassBackground(
                "${(widget.isLoading) ? '--' : widget.weatherInfo?.current?.temp.round() ?? 'Unknown'}°",
              ),
              SizedBox(height: size.height * 0.035),
              SvgPicture.asset(
                widget.weatherInfo?.current?.weather.first.icon ??
                    'assets/weather/Weather Icon.svg',
                height: size.height * 0.18,
              ),
              SizedBox(height: size.height * 0.12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(32.0),
                    topLeft: Radius.circular(32.0),
                  ),
                  gradient: LinearGradient(colors: AppColors.nightColors),
                ),
                height: size.height * 0.325,
                width: double.infinity,
                child: Column(
                  children: [
                    Align(
                      alignment: .topCenter,
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Colors.white,
                        unselectedLabelColor: const Color(0xFF8B8EAB),
                        dividerColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: const UnderlineTabIndicator(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 53, 36, 124),
                            width: 1.5,
                          ),
                        ),
                        labelStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        tabs: const [
                          Tab(text: 'Hourly Forecast'),
                          Tab(text: 'Daily Forecast'),
                        ],
                      ),
                    ),
                    if (!widget.isLoading) ...[
                      SizedBox(
                        height: size.height * 0.2,
                        child: TabBarView(
                          controller: _tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            HourlyDailyForecastWidget.hourly(
                              hourlyList: widget.weatherInfo?.hourly ?? [],
                            ),
                            HourlyDailyForecastWidget.daily(
                              dailyList: widget.weatherInfo?.daily ?? [],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
