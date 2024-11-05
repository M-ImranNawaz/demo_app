import 'package:demo_app/utils/res/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  AppStyles._();

  static const headLine = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );
  static const subHeadLine = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static const title = TextStyle(fontWeight: FontWeight.bold);

  static const loader = TextStyle(
      color: AppColors.black, fontSize: 16, fontWeight: FontWeight.w600);

  static const btnLabel = TextStyle(color: AppColors.white, fontSize: 19);

  static const s15B = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  static const s15M = TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
  static const s16M = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  static const s16N = TextStyle(fontSize: 16, color: AppColors.primary);
  static const s17M = TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
  static const s18M = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  static const subTitle = TextStyle(color: AppColors.gray);
}
