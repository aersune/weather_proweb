import 'package:flutter/material.dart';

import 'app_colors.dart';


abstract class AppStyle{
  static TextStyle fontStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    shadows: [
      Shadow(
        color: AppColors.black.withOpacity(0.40),
        offset: const Offset(4, 4),
        blurRadius: 20,
      )
    ]
  );
}