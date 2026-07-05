import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/geocoding_models/city_model.dart';
import 'package:weather_app/utils/theme/app_colors.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:weather_app/view_models/weather_cubit/weather_cubit.dart';
import 'package:weather_app/views/widgets/city_weather_widget.dart';

class CityResultWidget extends StatelessWidget {
  final CityModel cityModel;

  const CityResultWidget({super.key, required this.cityModel});

  Widget _buildWeatherBottomSheetInfo(
    BuildContext context,
    WeatherCubit cubit,
  ) {
    const fullSize = SheetOffset(0.86);
    const minSize = SheetOffset(0.0);
    final size = MediaQuery.of(context).size;
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<WeatherCubit, WeatherState>(
        buildWhen: (previous, current) =>
            current is FetchingWeatherInfo ||
            current is WeatherInfoFetched ||
            current is FetchingWeatherInfoFailed,
        builder: (context, state) {
          if (state is WeatherInfoFetched) {
            return Sheet(
              snapGrid: const SheetSnapGrid(snaps: [minSize, fullSize]),
              decoration: MaterialSheetDecoration(
                size: SheetSize.stretch,
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(32),
                clipBehavior: Clip.antiAlias,
              ),
              child: Stack(
                alignment: .topLeft,
                children: [
                  CityWeatherWidget(weatherInfo: state.weatherModel),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white30,
                      ),
                      iconSize: size.height * 0.04,
                      onPressed: () {
                        cubit.saveCityNameToLocalDatabase(
                          state.weatherModel.cityName,
                        );
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Sheet(
              snapGrid: const SheetSnapGrid(snaps: [minSize, fullSize]),
              decoration: MaterialSheetDecoration(
                size: SheetSize.stretch,
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(32),
                clipBehavior: Clip.antiAlias,
              ),
              child: const CityWeatherWidget.loading(),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.08,
      width: double.infinity,
      child: InkWell(
        onTap: () {
          final weatherCubit = BlocProvider.of<WeatherCubit>(context);
          weatherCubit.fetchWeatherInfo(cityModel.name);
          Navigator.push(
            context,
            ModalSheetRoute(
              builder: (modalContext) {
                return _buildWeatherBottomSheetInfo(modalContext, weatherCubit);
              },
            ),
          );
        },
        child: Card(
          color: AppColors.nightColorLight,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '${cityModel.name}, ${cityModel.state}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
