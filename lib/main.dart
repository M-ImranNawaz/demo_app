import 'package:demo_app/features/auth/bloc/auth_bloc.dart';
import 'package:demo_app/features/auth/presentation/signin_screen.dart';
import 'package:demo_app/features/auth/presentation/signup_screen.dart';
import 'package:demo_app/features/check_in/bloc/check_in_bloc.dart';
import 'package:demo_app/features/check_in/presentation/check_in_screen.dart';
import 'package:demo_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthBloc()..add(AuthStatusRequested())),
        BlocProvider(create: (context) => CheckInBloc()),
      ],
      child: MaterialApp(
        title: 'Digital Health App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: false,
        ),
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.authGate,
      ),
    );
  }
}

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

class AppRoutes {
  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String home = '/home';
  static const String authGate = '/authGate';

  // Add more routes as needed
  static Map<String, WidgetBuilder> routes = {
    '/signin': (context) => const SignInScreen(),
    '/signup': (context) => const SignUpScreen(),
    '/home': (context) => const CheckInScreen(),
    '/authGate': (context) => const AuthGate(),
  };
}
