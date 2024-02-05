import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../domain/provider/weather_provider.dart';
import '../resources/app_icons.dart';
import '../style/app_colors.dart';
import '../style/app_style.dart';



class SunriseSunsetWidget extends StatelessWidget {
  const SunriseSunsetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.gray.withOpacity(.6),
        borderRadius: BorderRadius.circular(24),
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RowItemsWidget(text:'Восход ${model.setSunRise()}' , icon: AppIcons.sunrise),
           RowItemsWidget(text:'Закат ${model.setSunSet()}' , icon: AppIcons.sunset),
        ],
      ),
    );
  }
}

class RowItemsWidget extends StatelessWidget {
  const RowItemsWidget({super.key, required this.icon, required this.text});

  final String icon, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(icon,color: Colors.white, theme: const SvgTheme(currentColor: Colors.yellow),),
        const SizedBox(height: 10),
        Text(text, style: AppStyle.fontStyle.copyWith(fontSize: 16),)
      ],
    );
  }
}
