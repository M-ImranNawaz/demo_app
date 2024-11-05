import 'package:cloud_firestore/cloud_firestore.dart';

class CheckInModel {
  final String id;
  final bool gambledToday;
  final String notes;
  final DateTime date;
  final String? userId;

  CheckInModel({
    required this.id,
    required this.gambledToday,
    required this.notes,
    required this.date,
    this.userId
  });

  factory CheckInModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CheckInModel(
      id: doc.id,
      gambledToday: data['gambledToday'] ?? false,
      notes: data['notes'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'gambledToday': gambledToday,
      'notes': notes,
      'date': FieldValue.serverTimestamp(),
      'userId': userId,
    };
  }
}
