import 'package:demo_app/utils/app_strings.dart';
import 'package:demo_app/views/widgets/primary_btn_widget.dart';
import 'package:demo_app/views/widgets/text_ff_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.welcom,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 16.0),
              Text(
                AppStrings.login,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 36.0),
              TextFormFieldWidget(
                controller: _emailController,
                label: AppStrings.email,
              ),
              const SizedBox(height: 16.0),
              TextFormFieldWidget(
                controller: _passwordController,
                label: AppStrings.password,
                isPasswordField: true,
              ),
              const SizedBox(height: 16.0),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator();
                  }
                  return PrimaryButtonWidget(
                    label: AppStrings.signIn,
                    onPressed: () {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      context
                          .read<AuthBloc>()
                          .add(SignInRequested(email, password));
                    },
                  );
                },
              ),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text(AppStrings.dontHaveAcc),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
