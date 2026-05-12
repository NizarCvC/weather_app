import 'package:flutter/material.dart';
import 'package:weather_app/utils/app_assets.dart';
import 'package:weather_app/utils/theme/app_colors.dart';

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pick Location',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: size.height * 0.06,
                    width: size.width * 0.78,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32.0),
                      gradient: LinearGradient(
                        colors: AppColors.nightColors,
                      ),
                    ),
                    child: Center(
                      child: TextField(
                        style: TextStyle(),
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
                          border: OutlineInputBorder(borderSide: .none),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    iconSize: size.height * 0.04,
                    style: IconButton.styleFrom(
                      backgroundColor: Color(0xFF1b1145), // TODO: Need to remove it later
                    ),
                    icon: Icon(Icons.location_on_outlined),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.15),
              Image.asset(height: size.height * 0.35, AppAssets.empty),
            ],
          ),
        ),
      ),
    );
  }
}
