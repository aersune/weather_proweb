import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/provider/weather_provider.dart';
import '../style/app_style.dart';


class CurrentTemp extends StatelessWidget {
  const CurrentTemp({super.key});

  @override
  Widget build(BuildContext context) {

    final model = context.watch<WeatherProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${model.currentTemp}', style: AppStyle.fontStyle.copyWith(fontSize: 80, height: 80 / 80),),
        Text('°C', style: AppStyle.fontStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w700),)
      ],
    );
  }
}
