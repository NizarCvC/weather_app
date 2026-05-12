import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/temp/daily_data.dart';
import 'package:weather_app/temp/hourly_data.dart';
import 'package:weather_app/utils/router/app_routes.dart';
import 'package:weather_app/utils/theme/app_colors.dart';
import 'package:adv_flutter_weather/bg/weather_bg.dart';
import 'package:adv_flutter_weather/utils/weather_type.dart';
import 'package:weather_app/views/widgets/hourly_daily_forecast_widget.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({super.key});

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final _iconList = [Icons.location_on_outlined, Icons.list];
  int activeIconIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      body: Center(
        child: Stack(
          alignment: .center,
          children: [
            WeatherBg(
              weatherType: WeatherType.sunnyNight,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Column(
              mainAxisAlignment: .start,
              children: [
                SizedBox(height: size.height * 0.1),
                Text(
                  "Madinah",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(height: size.height * 0.02),
                Text("25°", style: Theme.of(context).textTheme.displayMedium),
                SizedBox(height: size.height * 0.035),
                SvgPicture.asset(
                  'assets/weather/Weather Icon-7.svg',
                  height: size.height * 0.18,
                ),
                SizedBox(height: size.height * 0.16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
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
                      SizedBox(
                        height: size.height * 0.2,
                        child: Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              HourlyDailyForecastWidget.hourly(
                                hourlyList: HourlyData.dummyHourlyList,
                              ),
                              HourlyDailyForecastWidget.daily(
                                dailyList: DailyData.dummyDailyList,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.themeColor,
        shape: CircleBorder(),
        child: Icon(size: size.height * 0.04, Icons.add),
        onPressed: () =>
            Navigator.of(context).pushNamed(AppRoutes.searchWeather),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              Navigator.of(context).pushNamed(AppRoutes.forecastReportWeather);
              break;
            case 1:
              Navigator.of(context).pushNamed(AppRoutes.searchWeather);
              break;
          }
        },
      ),
    );
  }
}
