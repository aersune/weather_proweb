import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_pr/domain/provider/weather_provider.dart';


import '../components/favorite_list.dart';
import '../style/app_colors.dart';
import '../style/app_style.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomSearchAppBar(),
      body: SearchBody(),
    );
  }
}


class CustomSearchAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomSearchAppBar({super.key});


  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top:20 ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
             TextFieldWidget(model: model),
            IconButton(onPressed: (){
              model.setCurrentCity(context);
            }, icon: Icon(Icons.search_rounded, size: 50, color: AppColors.white,)),


          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 80);
}


class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key, required this.model});

final WeatherProvider model;

  @override
  Widget build(BuildContext context) {


    return Expanded(
      child: TextField(
        controller: model.searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          hintText: 'Поиск...'
        ),
      ),
    );
  }
}


class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.gradientColor1,
              AppColors.gradientColor2,
              AppColors.gradientColor3,
              AppColors.gradientColor2,
              AppColors.gradientColor1,
            ]),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 100),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text('Saved Locations', style: AppStyle.fontStyle,),
           const SizedBox(height: 25),
          const FavoriteList(),
        ],
      ),
    );
  }
}
