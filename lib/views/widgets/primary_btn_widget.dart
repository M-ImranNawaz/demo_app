import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final TextStyle? labelStyle;
  final double? height;
  // final Color primaryColor;
  const PrimaryButtonWidget({
    super.key,
    required this.label,
    this.onPressed,
    this.labelStyle,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // backgroundColor: primaryColor,
        minimumSize: Size(double.infinity, height ?? 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.white),
      ),
    );
  }
}
