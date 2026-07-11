import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/utils/theme/app_colors.dart';
import 'package:weather_app/view_models/search_cubit/search_cubit.dart';
import 'package:weather_app/views/widgets/search_weather_widgets/city_result_widget.dart';
import 'package:weather_app/views/widgets/shared_widgets/empty_widget.dart';

class SearchWeatherPage extends StatefulWidget {
  const SearchWeatherPage({super.key});

  @override
  State<SearchWeatherPage> createState() => _SearchWeatherPageState();
}

class _SearchWeatherPageState extends State<SearchWeatherPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildSearchingText(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<SearchCubit>(context);
    return Container(
      height: size.height * 0.06,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        gradient: LinearGradient(colors: AppColors.nightColors),
      ),
      child: Center(
        child: TextField(
          textInputAction: .search,
          style: const TextStyle(),
          controller: _searchController,
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                size: size.height * 0.035,
                Icons.search,
                color: Colors.grey[600],
              ),
            ),
            hintText: 'Search',
            border: const OutlineInputBorder(borderSide: .none),
          ),
          onSubmitted: (text) {
            if (_searchController.text.isNotEmpty) {
              cubit.searchingWeather(text);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<SearchCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pick Location',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchingText(context),
            SizedBox(height: size.height * 0.04),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                bloc: cubit,
                buildWhen: (previous, current) =>
                    current is SearchingWeatherName ||
                    current is SearchedWeatherName ||
                    current is SearchingWeatherNameFailed,
                builder: (context, state) {
                  if (state is SearchingWeatherName) {
                    return const CircularProgressIndicator.adaptive();
                  } else if (state is SearchedWeatherName) {
                    final citiesList = state.cityModels;
                    if (citiesList.isEmpty) {
                      return const EmptyWidget();
                    }
                    return ListView.builder(
                      itemCount: citiesList.length,
                      itemBuilder: (context, index) =>
                          CityResultWidget(cityModel: citiesList[index]),
                    );
                  } else if (state is SearchingWeatherNameFailed) {
                    return const EmptyWidget();
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
