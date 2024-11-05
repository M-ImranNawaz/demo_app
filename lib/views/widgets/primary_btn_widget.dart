import 'package:demo_app/utils/res/app_colors.dart';
import 'package:demo_app/utils/res/app_styles.dart';
import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final TextStyle? labelStyle;
  final double? height;
  final Color? primaryColor;
  const PrimaryButtonWidget(
      {super.key,
      required this.label,
      this.onPressed,
      this.labelStyle,
      this.height,
      this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        minimumSize: Size(double.infinity, height ?? 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        label,
        style:
            labelStyle ?? AppStyles.btnLabel.copyWith(color: AppColors.white),
      ),
    );
  }
}
