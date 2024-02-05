import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../domain/provider/weather_provider.dart';
import '../resources/app_icons.dart';
import '../routes/app_routes.dart';
import '../style/app_colors.dart';
import '../style/app_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(onPressed: (){
              model.setFavorite(context, cityName: model.currentCity);
            }, icon:  Icon(Icons.location_on, color: AppColors.white,), label:  Text(model.currentCity, style: AppStyle.fontStyle),),
            IconButton(onPressed: (){
              context.go(AppRoutes.search);
            }, icon: SvgPicture.asset(AppIcons.menu))
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 50);
}
