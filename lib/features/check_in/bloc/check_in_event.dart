part of 'check_in_bloc.dart';

sealed class CheckInEvent {}

class SubmitCheckIn extends CheckInEvent {
  final bool gambledToday;
  final String notes;

  SubmitCheckIn({required this.gambledToday, required this.notes});
}

class LoadCheckInHistory extends CheckInEvent {}
