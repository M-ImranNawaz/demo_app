import 'package:demo_app/utils/res/app_colors.dart';
import 'package:demo_app/utils/res/app_styles.dart';
import 'package:flutter/material.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color primaryColor;
  final Widget? child;
  final TextStyle? style;
  const OutlinedButtonWidget({
    super.key,
    this.primaryColor = AppColors.primary,
    required this.label,
    this.onPressed,
    this.child,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(color: primaryColor),
      ),
      child: child ??
          Text(
            label,
            style: style ?? AppStyles.btnLabel.copyWith(color: primaryColor),
          ),
    );
  }
}
