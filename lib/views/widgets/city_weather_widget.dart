import 'package:adv_flutter_weather/bg/weather_bg.dart';
import 'package:adv_flutter_weather/utils/weather_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/models/weather_models/weather_model.dart';
import 'package:weather_app/utils/theme/app_colors.dart';
import 'package:weather_app/views/widgets/hourly_daily_forecast_widget.dart';

class CityWeatherWidget extends StatefulWidget {
  final WeatherModel? weatherInfo;
  final bool isLoading;

  const CityWeatherWidget({super.key, required this.weatherInfo})
    : isLoading = false;

  const CityWeatherWidget.loading({super.key})
    : isLoading = true,
      weatherInfo = null;

  @override
  State<CityWeatherWidget> createState() => _CityWeatherWidgetState();
}

class _CityWeatherWidgetState extends State<CityWeatherWidget>
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
                child: Text(
                  widget.isLoading
                      ? '--'
                      : widget.weatherInfo?.cityName ?? 'Unknown',
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: .center,
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                "${(widget.isLoading) ? '--' : widget.weatherInfo?.current?.temp.round() ?? 'Unknown'}°",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(height: size.height * 0.035),
              SvgPicture.asset(
                widget.weatherInfo?.current?.weather.first.icon ??
                    'assets/weather/Weather Icon.svg',
                height: size.height * 0.18,
              ),
              SizedBox(height: size.height * 0.16),
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
