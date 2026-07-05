import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/view_models/weather_cubit/weather_cubit.dart';
import 'package:weather_app/views/widgets/empty_widget.dart';
import 'package:weather_app/views/widgets/weather_item_widget.dart';

class SavedWeathersPage extends StatelessWidget {
  const SavedWeathersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<WeatherCubit>(context);
    return BlocBuilder<WeatherCubit, WeatherState>(
      buildWhen: (previous, current) =>
          current is ActiveDeletingSavedWeathers ||
          current is UnActiveDeletingSavedWeathers,
      builder: (context, state) {
        if (state is ActiveDeletingSavedWeathers) {
          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              title: Text(
                'Saved weathers',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              actions: [
                IconButton(
                  onPressed: () => cubit.toggleActiveDeletingWeathers(),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            body: BlocBuilder<WeatherCubit, WeatherState>(
              buildWhen: (previous, current) =>
                  current is FetchingSavedWeatherCities ||
                  current is SavedWeatherCitiesFetched ||
                  current is FetchingSavedWeatherCitiesFailed,
              builder: (context, state) {
                if (state is FetchingSavedWeatherCities) {
                  return Center(
                    child: const CircularProgressIndicator.adaptive(),
                  );
                } else if (state is SavedWeatherCitiesFetched) {
                  final savedCities = state.weatherModels;
                  if (savedCities.isEmpty) {
                    return EmptyWidget();
                  }
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                      itemCount: savedCities.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: size.height * 0.03,
                        crossAxisSpacing: size.width * 0.06,
                        mainAxisExtent: size.height * 0.2,
                      ),
                      itemBuilder: (context, index) => WeatherItemWidget(
                        cityWeather: savedCities[index],
                        isDeleteActive: true,
                      ),
                    ),
                  );
                } else if (state is FetchingSavedWeatherCitiesFailed) {
                  return Center(child: Text('An error occurred'));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              title: Text(
                'Saved weathers',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
            ),
            body: BlocBuilder<WeatherCubit, WeatherState>(
              buildWhen: (previous, current) =>
                  current is FetchingSavedWeatherCities ||
                  current is SavedWeatherCitiesFetched ||
                  current is FetchingSavedWeatherCitiesFailed,
              builder: (context, state) {
                if (state is FetchingSavedWeatherCities) {
                  return Center(
                    child: const CircularProgressIndicator.adaptive(),
                  );
                } else if (state is SavedWeatherCitiesFetched) {
                  final savedCities = state.weatherModels;
                  if (savedCities.isEmpty) {
                    return EmptyWidget();
                  }
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                      itemCount: savedCities.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: size.height * 0.03,
                        crossAxisSpacing: size.width * 0.06,
                        mainAxisExtent: size.height * 0.17,
                      ),
                      itemBuilder: (context, index) =>
                          WeatherItemWidget(cityWeather: savedCities[index]),
                    ),
                  );
                } else if (state is FetchingSavedWeatherCitiesFailed) {
                  return Center(child: Text('An error occurred'));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          );
        }
      },
    );
  }
}
