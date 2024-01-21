import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.green,
      ),
      useMaterial3: true,
      textTheme: TextTheme(
        displayMedium: const TextStyle(
            //overflow: TextOverflow.ellipsis,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18),
        titleSmall: TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 16,
          color: AppColors.grey,
        ),
        displayLarge:
            const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
      appBarTheme: AppBarTheme(
          iconTheme:
              IconThemeData(color: AppColors.black, size: 40, weight: 100)),
      iconTheme: const IconThemeData(size: 40));
}
