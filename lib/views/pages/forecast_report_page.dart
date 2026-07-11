import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_models/weather_model.dart';
import 'package:weather_app/utils/app_assets.dart';
import 'package:weather_app/views/widgets/forecast_report_widgets/weather_detail_card.dart';
import 'package:weather_app/views/widgets/forecast_report_widgets/weather_day_widget.dart';
import 'package:weather_app/views/widgets/shared_widgets/hourly_daily_forecast_widget.dart';

class ForecastReportPage extends StatelessWidget {
  final WeatherModel weatherModel;
  const ForecastReportPage({super.key, required this.weatherModel});

  Widget _buildTitle({required BuildContext context, required String title}) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          SizedBox(width: size.width * 0.05),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  String _getUvDescription(double uv) {
    double uvValue = uv;
    if (uvValue <= 2) return 'Low';
    if (uvValue <= 5) return 'Moderate';
    if (uvValue <= 7) return 'High';
    if (uvValue <= 10) return 'Very High';
    return 'Extreme';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final current = weatherModel.current!;
    final windSpeedKmh = (current.windSpeed * 3.6).round(); 
    final visibilityKm = (current.visibility / 1000).toStringAsFixed(1);
    var weatherCards = [
      WeatherDetailCard(
        iconPath: AppAssets.feelsLikeIcon,
        title: 'Feels Like',
        info: '${current.feelsLike.round()}°',
      ),
      WeatherDetailCard(
        iconPath: AppAssets.visionIcon,
        title: 'Visibility',
        info: '$visibilityKm km',
      ),
      WeatherDetailCard(
        iconPath: AppAssets.uvIcon,
        title: 'UV Index',
        info: '${current.uvi.round()} ${_getUvDescription(current.uvi)}',
      ),
      WeatherDetailCard(
        iconPath: AppAssets.windIcon,
        title: 'Wind Speed',
        info: '$windSpeedKmh km/h',
      ),
      WeatherDetailCard(
        iconPath: AppAssets.humidityIcon,
        title: 'Humidity',
        info: '${current.humidity}%',
      ),
      WeatherDetailCard(
        iconPath: AppAssets.pressureIcon,
        title: 'Pressure',
        info: '${current.pressure} hPa',
      ),
      WeatherDetailCard(
        iconPath: AppAssets.cloudIcon,
        title: 'Cloudiness',
        info: '${current.clouds}%',
      ),
      WeatherDetailCard(
        iconPath: AppAssets.rainIcon,
        title: 'Rain (1h)',
        info: '${current.rain?.oneHour?.toStringAsFixed(1) ?? "0"} mm',
      ),
    ];

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
                  hourlyList: weatherModel.hourly,
                ),
              ),
              _buildTitle(context: context, title: 'Next forecast'),
              SizedBox(height: size.height * 0.02),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: weatherModel.daily.length,
                itemBuilder: (context, index) =>
                    WeatherDayWidget(dailyWeather: weatherModel.daily[index]),
                separatorBuilder: (context, index) =>
                    SizedBox(height: size.height * 0.02),
              ),
              _buildTitle(context: context, title: 'Forecast Details'),
              SizedBox(height: size.height * 0.02),
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: size.height * 0.03,
                  crossAxisSpacing: size.width * 0.06,
                  mainAxisExtent: size.height * 0.16,
                ),
                children: weatherCards,
              ),
            ],
          ),
        ),
      ),
    );
  }
}