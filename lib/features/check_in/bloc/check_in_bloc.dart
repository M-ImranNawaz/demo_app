import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'check_in_event.dart';
part 'check_in_state.dart';

class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CheckInBloc() : super(CheckInInitial()) {
    on<SubmitCheckIn>((event, emit) async {
      emit(CheckInLoading());
      try {
        // Add check-in data to Firestore
        await _firestore.collection('check_ins').add({
          'gambledToday': event.gambledToday,
          'notes': event.notes,
          'date': FieldValue.serverTimestamp(),
        });
        emit(CheckInSuccess());
      } catch (e) {
        emit(CheckInError(e.toString()));
      }
    });

    on<LoadCheckInHistory>((event, emit) async {
      emit(CheckInLoading());
      try {
        // Fetch check-in history
        QuerySnapshot snapshot = await _firestore
            .collection('check_ins')
            .orderBy('date', descending: true)
            .get();

        List<Map<String, dynamic>> checkIns = snapshot.docs.map((doc) {
          return {
            'gambledToday': doc['gambledToday'],
            'notes': doc['notes'],
            'date': doc['date'].toDate(),
          };
        }).toList();

        emit(CheckInHistoryLoaded(checkIns));
      } catch (e) {
        emit(CheckInError(e.toString()));
      }
    });
  }
}
