part of 'check_in_bloc.dart';

sealed class CheckInState {}

class CheckInInitial extends CheckInState {}

class CheckInLoading extends CheckInState {}

class CheckInSuccess extends CheckInState {}

class CheckInError extends CheckInState {
  final String error;
  CheckInError(this.error);
}

class CheckInHistoryLoaded extends CheckInState {
  final List<CheckInModel> checkIns;

  CheckInHistoryLoaded(this.checkIns);
}
