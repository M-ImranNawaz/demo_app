import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/features/auth/presentation/auth_gate.dart';
import 'package:demo_app/features/check_in/presentation/check_in_screen.dart';
import 'package:demo_app/utils/app_utils.dart';
import 'package:demo_app/utils/nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthBloc() : super(AuthInitial()) {
    on<SignInRequested>((event, emit) async {
      // emit(AuthLoading());
      AppUtils.showLoading();
      try {
        await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(AuthAuthenticated());
        Nav.offAll(const CheckInScreen());
      } catch (e) {
        AppUtils.hideLoading();
        AppUtils.showErrorToast(
            e is FirebaseAuthException ? e.message ?? '' : e.toString());
      }
    });

    on<SignUpRequested>((event, emit) async {
      // emit(AuthLoading());
      AppUtils.showLoading();
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'fullname': event.fullName,
          'email': event.email,
          'createdAt': FieldValue.serverTimestamp(),
        });
        emit(AuthAuthenticated());

        Nav.offAll(const CheckInScreen());
      } catch (e) {
        AppUtils.hideLoading();
        AppUtils.showErrorToast(
            e is FirebaseAuthException ? e.message ?? '' : e.toString());
      }
    });

    on<AuthStatusRequested>((event, emit) async {
      final user = _auth.currentUser;
      if (user != null) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<SignOutRequested>((event, emit) async {
      emit(AuthLoading());
      await _auth.signOut();
      Nav.offAll(const AuthGate());
      emit(AuthUnauthenticated());
    });
  }
}
