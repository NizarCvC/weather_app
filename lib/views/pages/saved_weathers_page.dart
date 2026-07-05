import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/view_models/weather_cubit/weather_cubit.dart';
import 'package:weather_app/views/widgets/custom_error_widget.dart';
import 'package:weather_app/views/widgets/empty_widget.dart';
import 'package:weather_app/views/widgets/weather_item_widget.dart';

class SavedWeathersPage extends StatelessWidget {
  const SavedWeathersPage({super.key});

  Widget _buildEditingIconButton(BuildContext context) {
    final cubit = BlocProvider.of<WeatherCubit>(context);
    return BlocBuilder<WeatherCubit, WeatherState>(
      buildWhen: (previous, current) =>
          current is ActiveDeletingSavedWeathers ||
          current is DeactivatedDeletingSavedWeathers,
      builder: (context, state) {
        if (state is ActiveDeletingSavedWeathers) {
          return IconButton(
            onPressed: () => cubit.toggleActiveDeletingWeathers(),
            icon: const Icon(Icons.close),
          );
        } else {
          return IconButton(
            onPressed: () => cubit.toggleActiveDeletingWeathers(),
            icon: const Icon(Icons.edit),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<WeatherCubit>(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'Saved weathers',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [_buildEditingIconButton(context)],
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        buildWhen: (previous, current) =>
            current is FetchingSavedWeatherCities ||
            current is SavedWeatherCitiesFetched ||
            current is FetchingSavedWeatherCitiesFailed,
        builder: (context, state) {
          if (state is FetchingSavedWeatherCities) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is SavedWeatherCitiesFetched) {
            final savedCities = cubit.savedCitiesWeather;
            if (savedCities.isEmpty) {
              return const EmptyWidget();
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
            return const CustomErrorWidget();
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
