import 'package:flutter/cupertino.dart';
import 'package:weather_app/utils/app_assets.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Image.asset(height: size.height * 0.35, AppAssets.empty),
    );
  }
}
