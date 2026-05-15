import 'package:flutter/material.dart';
import 'package:weather_app/temp/hourly_data.dart';
import 'package:weather_app/utils/app_assets.dart';
import 'package:weather_app/views/widgets/hourly_daily_forecast_widget.dart';
import 'package:weather_app/views/widgets/weather_card.dart';
import 'package:weather_app/views/widgets/weather_day_widget.dart';

class ForecastReportPage extends StatelessWidget {
  const ForecastReportPage({super.key});

  Widget _buildTitle({required BuildContext context, required String title}) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: .centerLeft,
      child: Row(
        children: [
          SizedBox(width: size.width * 0.05),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontWeight: .w600),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'Forecast Report',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),
              _buildTitle(context: context, title: 'Today'),
              SizedBox(
                height: size.height * 0.2,
                child: HourlyDailyForecastWidget.hourly(
                  hourlyList: HourlyData.dummyHourlyList,
                ),
              ),
              _buildTitle(context: context, title: 'Next forecast'),
              SizedBox(height: size.height * 0.02),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 7,
                itemBuilder: (context, index) => WeatherDayWidget(),
                separatorBuilder: (context, index) =>
                    SizedBox(height: size.height * 0.02),
              ),
              _buildTitle(context: context, title: 'Forecast Details'),
              SizedBox(height: size.height * 0.02),
              GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: size.height * 0.03,
                  crossAxisSpacing: size.width * 0.06,
                  mainAxisExtent: size.height * 0.16,
                ),
                children: [
                  WeatherCard(
                    iconPath: AppAssets.feelsLikeIcon,
                    title: 'Feels Like',
                    info: '20°',
                  ),
                  WeatherCard(
                    iconPath: AppAssets.visionIcon,
                    title: 'Vision',
                    info: '16 Km',
                  ),
                  WeatherCard(
                    iconPath: AppAssets.uvIcon,
                    title: 'UV Index',
                    info: '2',
                  ),
                  WeatherCard(
                    iconPath: AppAssets.windIcon,
                    title: 'Wind',
                    info: '2',
                  ),
                  WeatherCard(
                    iconPath: AppAssets.humidityIcon,
                    title: 'Humidity',
                    info: '2',
                  ),
                  WeatherCard(
                    iconPath: AppAssets.pressureIcon,
                    title: 'Pressure',
                    info: '2',
                  ),
                  WeatherCard(
                    iconPath: AppAssets.cloudIcon,
                    title: 'Cloudiness',
                    info: '20%',
                  ),
                  WeatherCard(
                    iconPath: AppAssets.rainIcon,
                    title: 'Rain',
                    info: '2 mm',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
