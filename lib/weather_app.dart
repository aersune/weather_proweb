import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_pr/ui/routes/app_router.dart';

import 'domain/provider/weather_provider.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
