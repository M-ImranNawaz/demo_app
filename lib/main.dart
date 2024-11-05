import 'package:demo_app/features/auth/bloc/auth_bloc.dart';
import 'package:demo_app/features/auth/presentation/auth_gate.dart';
import 'package:demo_app/features/check_in/bloc/check_in_bloc.dart';
import 'package:demo_app/firebase_options.dart';
import 'package:demo_app/utils/res/app_strings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'utils/nav.dart';

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
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: false,
        ),
        navigatorKey: Nav.key,
        home: const AuthGate(),
      ),
    );
  }
}
