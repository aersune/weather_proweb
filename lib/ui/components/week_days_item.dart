import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/provider/weather_provider.dart';
import '../style/app_colors.dart';
import '../style/app_style.dart';

class WeekDayItem extends StatelessWidget {
  const WeekDayItem({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 19),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.gray.withOpacity(.6)
      ),
      child: SizedBox(
        height: 130,
        child: ListView.separated(
          shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: 7,
            separatorBuilder: (context, i) => const SizedBox(width: 30,),
            itemBuilder: (context, index){
              return  DayItem(day: model.date[index],dayTemp: model.setDailyTemp(index),icon: model.setDailyIcons(index),windSpeed: '${model.setDailyWindSpeed(index)} km/h',);
            }),
      ));
  }

}

class DayItem extends StatelessWidget {
  const DayItem({super.key, required this.day, required this.icon, required this.windSpeed, required this.dayTemp});

  final String day, icon, windSpeed;
  final int dayTemp;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(day, style: AppStyle.fontStyle.copyWith(fontSize: 14, color: AppColors.dayColor),),
        const SizedBox(height: 12),

        // Icon(Icons.cloud, size: 40,color: AppColors.white,),
        Image.network(icon),
        const SizedBox(height: 7),
        Text('$dayTemp  º', style: AppStyle.fontStyle.copyWith(fontSize: 16, color: AppColors.dayColor),),
        Text(windSpeed, style: AppStyle.fontStyle.copyWith(fontSize: 10, color: AppColors.dayColor),),
      ],
    );
  }
}

