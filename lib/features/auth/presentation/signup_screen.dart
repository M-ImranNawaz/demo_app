import 'package:demo_app/features/auth/bloc/auth_bloc.dart';
import 'package:demo_app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
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
            children: [
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: AppStrings.fNmae),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: AppStrings.email),
              ),
              TextField(
                controller: _passwordController,
                decoration:
                    const InputDecoration(labelText: AppStrings.password),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      final firstName = _firstNameController.text;
                      context
                          .read<AuthBloc>()
                          .add(SignUpRequested(email, password, firstName));
                    },
                    child: const Text(AppStrings.signUp),
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(AppStrings.haveAcc),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
