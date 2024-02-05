import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/provider/weather_provider.dart';
import '../components/current_temp.dart';
import '../components/custom_appbar.dart';
import '../components/row_items.dart';
import '../components/surise_sunset_widget.dart';
import '../components/week_days_item.dart';
import '../style/app_colors.dart';
import '../style/app_style.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<WeatherProvider>().setUp(),
      builder: (context, snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return const Center(child: CupertinoActivityIndicator());
          case ConnectionState.done:
            return Scaffold(
              backgroundColor: AppColors.black,
              extendBodyBehindAppBar: true,
              appBar: const CustomAppBar(),
              body: const WeatherBody(),
            );
          default:
            return const SizedBox();
        }
      }
    );
  }
}

class WeatherBody extends StatelessWidget {
  const WeatherBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration:  BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(model.setBg()))),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            '${model.currentDay}',
            textAlign: TextAlign.center,
            style: AppStyle.fontStyle.copyWith(fontSize: 30, fontWeight: FontWeight.w500),
          ),

          Text(
            'Updated  ${model.currentDayTime} ${model.currentTime}',
            textAlign: TextAlign.center,
            style: AppStyle.fontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w300),
          ),
          const SizedBox(height: 30),

          Image.network(model.iconData(), scale: .5, height: 95,fit: BoxFit.fitHeight,),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Text(model.getCurrentStatus(),
                style: AppStyle.fontStyle.copyWith(fontSize: 30, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center),
          ),
          const CurrentTemp(),
          const SizedBox(height: 60),
          const RowItems(),
          const SizedBox(height: 15),
          const WeekDayItem(),
          const SizedBox(height: 15),
          const SunriseSunsetWidget(), const SizedBox(height: 25),
        ],
      ),
    );
  }
}
