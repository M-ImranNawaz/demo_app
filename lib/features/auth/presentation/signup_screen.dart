import 'package:demo_app/features/auth/bloc/auth_bloc.dart';
import 'package:demo_app/utils/app_utils.dart';
import 'package:demo_app/utils/res/app_colors.dart';
import 'package:demo_app/utils/res/app_strings.dart';
import 'package:demo_app/utils/res/app_styles.dart';
import 'package:demo_app/views/widgets/primary_btn_widget.dart';
import 'package:demo_app/views/widgets/text_ff_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _emailC;
  late TextEditingController _passwordC;
  late TextEditingController _fullNameC;
  late GlobalKey<FormState> _signUpFormKey;
  @override
  void initState() {
    _emailC = TextEditingController();
    _passwordC = TextEditingController();
    _fullNameC = TextEditingController();
    _signUpFormKey = GlobalKey<FormState>();
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
                  key: _signUpFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        AppStrings.createAccount,
                        style: AppStyles.headLine,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        AppStrings.signUp,
                        style: AppStyles.subHeadLine
                            .copyWith(color: AppColors.primary),
                      ),
                      const SizedBox(height: 36.0),
                      TextFormFieldWidget(
                        controller: _fullNameC,
                        label: AppStrings.fullName,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormFieldWidget(
                        controller: _emailC,
                        label: AppStrings.email,
                        inputType: TextInputType.emailAddress,
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
                          return PrimaryButtonWidget(
                            onPressed: () {
                              if (!(_signUpFormKey.currentState!.validate())) {
                                return;
                              }
                              context.read<AuthBloc>().add(SignUpRequested(
                                  _fullNameC.text,
                                  _emailC.text,
                                  _passwordC.text));
                            },
                            label: AppStrings.signUp,
                          );
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(AppStrings.haveAcc),
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
    _fullNameC.dispose();
    _emailC.dispose();
    _passwordC.dispose();
    super.dispose();
  }
}
