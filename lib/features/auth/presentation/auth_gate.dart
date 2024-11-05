import 'package:demo_app/features/auth/presentation/signin_screen.dart';
import 'package:demo_app/features/check_in/presentation/check_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return const CheckInScreen();
        } else if (state is AuthUnauthenticated) {
          return const SignInScreen();
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
