import 'package:flutter/material.dart';
import 'package:weather_app/views/widgets/weather_item_widget.dart';

class SavedWeathersPage extends StatelessWidget {
  const SavedWeathersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'Saved weathers',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: size.height * 0.03,
            crossAxisSpacing: size.width * 0.06,
            mainAxisExtent: size.height * 0.15,
          ),
          itemBuilder: (context, index) => WeatherItemWidget(),
        ),
      ),
    );
  }
}
