import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/features/check_in/models/check_in_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'check_in_event.dart';
part 'check_in_state.dart';

class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CheckInBloc() : super(CheckInInitial()) {
    on<SubmitCheckIn>((event, emit) async {
      emit(CheckInLoading());
      try {
        final uId = FirebaseAuth.instance.currentUser?.uid;
        CheckInModel checkIn = CheckInModel(
          gambledToday: event.gambledToday,
          notes: event.notes,
          date: DateTime.now(),
          userId: uId,
          id: '',
        );

        await _firestore.collection('check_ins').add(checkIn.toMap());

        emit(CheckInSuccess());
      } catch (e) {
        emit(CheckInError(e.toString()));
      }
    });

    on<LoadCheckInHistory>((event, emit) async {
      emit(CheckInLoading());
      try {
        final uId = FirebaseAuth.instance.currentUser?.uid;
        QuerySnapshot snapshot = await _firestore
            .collection('check_ins')
            .where('userId', isEqualTo: uId)
            .orderBy('date', descending: true)
            .get();

        List<CheckInModel> checkIns = snapshot.docs.map((doc) {
          return CheckInModel.fromDocument(doc);
        }).toList();
        emit(CheckInHistoryLoaded(checkIns));
      } catch (e) {
        emit(CheckInError(e.toString()));
      }
    });
  }
}
