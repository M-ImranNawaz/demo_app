import 'package:demo_app/features/auth/presentation/signup_screen.dart';
import 'package:demo_app/utils/app_utils.dart';
import 'package:demo_app/utils/nav.dart';
import 'package:demo_app/utils/res/app_colors.dart';
import 'package:demo_app/utils/res/app_strings.dart';
import 'package:demo_app/utils/res/app_styles.dart';
import 'package:demo_app/views/widgets/primary_btn_widget.dart';
import 'package:demo_app/views/widgets/text_ff_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _emailC;
  late TextEditingController _passwordC;
  late GlobalKey<FormState> _siginFormKey;
  @override
  void initState() {
    _emailC = TextEditingController();
    _passwordC = TextEditingController();
    _siginFormKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: AppUtils.height(context) * .15),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: AppUtils.hrPadding,
                child: Form(
                  key: _siginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        AppStrings.welcome,
                        style: AppStyles.headLine,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        AppStrings.login,
                        style: AppStyles.subHeadLine
                            .copyWith(color: AppColors.primary),
                      ),
                      const SizedBox(height: 36.0),
                      TextFormFieldWidget(
                        controller: _emailC,
                        label: AppStrings.email,
                        validator: (val) {
                          if (!AppUtils.isValidateEmail(val!)) {
                            return 'Provide correct email address';
                          }
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormFieldWidget(
                        controller: _passwordC,
                        label: AppStrings.password,
                        isPasswordField: true,
                        validator: (val) {
                          if (val!.length < 8) {
                            return 'Password length must be greater than 8 charracters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const CircularProgressIndicator();
                          }
                          return PrimaryButtonWidget(
                            label: AppStrings.signIn,
                            onPressed: () {
                              if (!(_siginFormKey.currentState!.validate())) {
                                return;
                              }
                              context.read<AuthBloc>().add(SignInRequested(
                                  _emailC.text, _passwordC.text));
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            Nav.to(const SignUpScreen());
                          },
                          child: const Text(AppStrings.dontHaveAcc),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailC.dispose();
    _passwordC.dispose();
    super.dispose();
  }
}
