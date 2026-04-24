import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/models/weather_models/daily_temp.dart';
import 'package:weather_app/models/weather_models/daily_weather.dart';
import 'package:weather_app/models/weather_models/hourly_weather.dart';
import 'package:weather_app/models/weather_models/weather_condition.dart';
import 'package:weather_app/utils/router/app_routes.dart';
import 'package:weather_app/utils/theme/app_colors.dart';
import 'package:adv_flutter_weather/bg/weather_bg.dart';
import 'package:adv_flutter_weather/utils/weather_type.dart';
import 'package:weather_app/views/widgets/hourly_daily_forcast_widget.dart';

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
    final List<HourlyWeather> dummyHourlyList = [
      HourlyWeather(
        dt: 1714046400,
        temp: 18.0,
        feelsLike: 17.5,
        pressure: 1012,
        humidity: 60,
        dewPoint: 10.0,
        uvi: 0.0,
        clouds: 20,
        visibility: 10000,
        windSpeed: 4.5,
        windDeg: 120,
        pop: 0.1, // احتمالية هطول المطر
        weather: [
          WeatherCondition(
            id: 801,
            main: 'Clouds',
            description: 'few clouds',
            icon: '02n',
          ),
        ],
      ),
      HourlyWeather(
        dt: 1714046400,
        temp: 18.0,
        feelsLike: 17.5,
        pressure: 1012,
        humidity: 60,
        dewPoint: 10.0,
        uvi: 0.0,
        clouds: 20,
        visibility: 10000,
        windSpeed: 4.5,
        windDeg: 120,
        pop: 0.1, // احتمالية هطول المطر
        weather: [
          WeatherCondition(
            id: 801,
            main: 'Clouds',
            description: 'few clouds',
            icon: '02n',
          ),
        ],
      ),
      HourlyWeather(
        dt: 1714046400,
        temp: 18.0,
        feelsLike: 17.5,
        pressure: 1012,
        humidity: 60,
        dewPoint: 10.0,
        uvi: 0.0,
        clouds: 20,
        visibility: 10000,
        windSpeed: 4.5,
        windDeg: 120,
        pop: 0.1, // احتمالية هطول المطر
        weather: [
          WeatherCondition(
            id: 801,
            main: 'Clouds',
            description: 'few clouds',
            icon: '02n',
          ),
        ],
      ),
      HourlyWeather(
        dt: 1714046400,
        temp: 18.0,
        feelsLike: 17.5,
        pressure: 1012,
        humidity: 60,
        dewPoint: 10.0,
        uvi: 0.0,
        clouds: 20,
        visibility: 10000,
        windSpeed: 4.5,
        windDeg: 120,
        pop: 0.1, // احتمالية هطول المطر
        weather: [
          WeatherCondition(
            id: 801,
            main: 'Clouds',
            description: 'few clouds',
            icon: '02n',
          ),
        ],
      ),
      HourlyWeather(
        dt: 1714046400,
        temp: 18.0,
        feelsLike: 17.5,
        pressure: 1012,
        humidity: 60,
        dewPoint: 10.0,
        uvi: 0.0,
        clouds: 20,
        visibility: 10000,
        windSpeed: 4.5,
        windDeg: 120,
        pop: 0.1, // احتمالية هطول المطر
        weather: [
          WeatherCondition(
            id: 801,
            main: 'Clouds',
            description: 'few clouds',
            icon: '02n',
          ),
        ],
      ),
      HourlyWeather(
        dt: 1714050000,
        temp: 17.0,
        feelsLike: 17.0,
        pressure: 1013,
        humidity: 65,
        dewPoint: 11.0,
        uvi: 0.0,
        clouds: 80,
        visibility: 10000,
        windSpeed: 5.0,
        windDeg: 130,
        pop: 0.4,
        weather: [
          WeatherCondition(
            id: 500,
            main: 'Rain',
            description: 'light rain',
            icon: '10n',
          ),
        ],
      ),
      HourlyWeather(
        dt: 1714053600,
        temp: 16.5,
        feelsLike: 16.0,
        pressure: 1014,
        humidity: 70,
        dewPoint: 12.0,
        uvi: 0.0,
        clouds: 100,
        visibility: 8000,
        windSpeed: 6.0,
        windDeg: 140,
        pop: 0.8,
        weather: [
          WeatherCondition(
            id: 501,
            main: 'Rain',
            description: 'moderate rain',
            icon: '10n',
          ),
        ],
      ),
    ];
    final List<DailyWeather> dummyDailyList = [
      DailyWeather(
        dt: 1714046400,
        moonPhase: 0.5,
        temp: DailyTemp(
          day: 25.0,
          min: 18.0,
          max: 27.0,
          night: 19.0,
          eve: 22.0,
          morn: 20.0,
        ), // افتراض كلاس DailyTemp
        pressure: 1015,
        humidity: 50,
        dewPoint: 12.0,
        windSpeed: 5.0,
        windDeg: 180,
        clouds: 10,
        uvi: 8.0,
        pop: 0.0,
        weather: [
          WeatherCondition(
            id: 800,
            main: 'Clear',
            description: 'clear sky',
            icon: '01d',
          ),
        ],
      ),
      DailyWeather(
        dt: 1714132800,
        moonPhase: 0.6,
        temp: DailyTemp(
          day: 24.0,
          min: 17.0,
          max: 25.0,
          night: 18.0,
          eve: 21.0,
          morn: 19.0,
        ),
        pressure: 1012,
        humidity: 65,
        dewPoint: 14.0,
        windSpeed: 8.0,
        windDeg: 200,
        clouds: 50,
        uvi: 5.0,
        pop: 0.3,
        weather: [
          WeatherCondition(
            id: 802,
            main: 'Clouds',
            description: 'scattered clouds',
            icon: '03d',
          ),
        ],
      ),
      DailyWeather(
        dt: 1714219200,
        moonPhase: 0.7,
        temp: DailyTemp(
          day: 20.0,
          min: 15.0,
          max: 21.0,
          night: 16.0,
          eve: 18.0,
          morn: 17.0,
        ),
        pressure: 1008,
        humidity: 80,
        dewPoint: 16.0,
        windSpeed: 12.0,
        windDeg: 220,
        clouds: 100,
        uvi: 2.0,
        pop: 0.9,
        weather: [
          WeatherCondition(
            id: 502,
            main: 'Rain',
            description: 'heavy intensity rain',
            icon: '10d',
          ),
        ],
      ),
    ];
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
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF070826),
                        Color(0xFF060727),
                        Color(0xFF1b1145),
                      ],
                    ),
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
                              HourlyDailyForcastWidget(
                                hourlyList: dummyHourlyList,
                              ),
                              HourlyDailyForcastWidget(
                                dailyList: dummyDailyList,
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
        activeIndex: activeIconIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) => setState(() {
          activeIconIndex = index;
        }),
        //other params
      ),
    );
  }
}
