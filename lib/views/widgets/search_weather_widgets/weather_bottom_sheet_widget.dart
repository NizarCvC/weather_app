import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:weather_app/view_models/saved_cities_cubit/saved_cities_cubit.dart';
import 'package:weather_app/view_models/weather_cubit/weather_cubit.dart';
import 'package:weather_app/views/widgets/current_weather_widgets/current_city_weather_widget.dart';

class WeatherBottomSheetWidget extends StatelessWidget {
  final String cityName;
  const WeatherBottomSheetWidget({super.key, required this.cityName});

  Widget _buildSaveWeatherIconButton(
    BuildContext context,
    VoidCallback onPressed,
  ) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<WeatherCubit>(context);
    return BlocBuilder<WeatherCubit, WeatherState>(
      bloc: cubit,
      buildWhen: (previous, current) => current is SavedCityName,
      builder: (context, state) {
        if (state is SavedCityName) {
          return IconButton(
            style: IconButton.styleFrom(backgroundColor: Colors.white30),
            iconSize: size.height * 0.04,
            onPressed: () {},
            icon: const Icon(Icons.check),
          );
        }
        return IconButton(
          style: IconButton.styleFrom(backgroundColor: Colors.white30),
          iconSize: size.height * 0.04,
          onPressed: onPressed,
          icon: const Icon(Icons.add),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const fullSize = SheetOffset(0.86);
    const minSize = SheetOffset(0.0);
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>(
          create: (context) {
            final cubit = WeatherCubit();
            cubit.fetchWeatherInfo(cityName);
            return cubit;
          },
        ),
        BlocProvider(create: (context) => SavedCitiesCubit()),
      ],
      child: Builder(
        builder: (context) {
          final weatherCubit = BlocProvider.of<WeatherCubit>(context);
          return BlocBuilder<WeatherCubit, WeatherState>(
            bloc: weatherCubit,
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
                      CurrentCityWeatherWidget(weatherInfo: state.weatherModel),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: _buildSaveWeatherIconButton(context, () {
                          final savedCitiesCubit =
                              BlocProvider.of<SavedCitiesCubit>(context);
                          savedCitiesCubit.saveCityNameToLocalDatabase(
                            state.weatherModel.cityName,
                          );
                        }),
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
                  child: const CurrentCityWeatherWidget.loading(),
                );
              }
            },
          );
        },
      ),
    );
  }
}
