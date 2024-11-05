import 'package:demo_app/utils/res/app_colors.dart';
import 'package:demo_app/utils/res/app_styles.dart';
import 'package:demo_app/views/widgets/outlined_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../views/widgets/primary_btn_widget.dart';
import 'nav.dart';
import 'res/app_strings.dart';

class AppUtils {
  AppUtils._();

  static double calculatePercentage(int value, int total) =>
      total == 0 ? 0.0 : (value / total) * 100;

  static double width(context) => MediaQuery.sizeOf(context).width;
  static double height(context) => MediaQuery.sizeOf(context).height;

  static EdgeInsets hrPadding = const EdgeInsets.symmetric(horizontal: 20);

  static String formattedAmount(double? amount, String? code) =>
      '${code ?? ''} ${code == "ISK" ? amount?.toStringAsFixed(0) : amount?.toStringAsFixed(2)}';
  static bool isValidateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  static bool isLoaderDlgVisible = false;
  static showLoading({Color? color, String? msg}) {
    isLoaderDlgVisible = true;
    showDialog(
      context: Nav.key.currentState!.context,
      barrierDismissible: false,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            color: AppColors.transparent,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.white,
              ),
              child: Column(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 15),
                  Text(
                    msg ?? 'Please Wait...',
                    style: AppStyles.loader,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static hideLoading() {
    if (isLoaderDlgVisible) {
      isLoaderDlgVisible = false;
      Navigator.pop(Nav.key.currentState!.context);
    }
  }

  static showErrorToast(String msg) => Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: AppColors.red,
      );

  static showSuccessToast(String msg) => Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: AppColors.green,
      );

  static Future<bool?> showConfirmDilogue(
    String title,
    String description, {
    bool warning = false,
    String? confirmLabel,
    String? cancelLabel,
    Color? btnColor,
    void Function()? onConfirm,
    void Function()? onCancel,
  }) {
    return showDialog<bool?>(
      context: Nav.key.currentContext!,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) => Dialog(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppStyles.title.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Text(
                description,
                style: AppStyles.subTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              PrimaryButtonWidget(
                primaryColor:
                    btnColor ?? (warning ? AppColors.red : AppColors.primary),
                label: confirmLabel ?? AppStrings.save,
                onPressed: onConfirm ?? () => Nav.back(true),
              ),
              const SizedBox(height: 20),
              OutlinedButtonWidget(
                primaryColor:
                    btnColor ?? (warning ? AppColors.red : AppColors.primary),
                label: cancelLabel ?? AppStrings.cancel,
                onPressed: onCancel ?? () => Nav.back(false),
              )
            ],
          ),
        ),
      ),
    );
  }
}
