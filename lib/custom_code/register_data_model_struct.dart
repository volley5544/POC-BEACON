import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterDataModelStruct {
  final int registerId;
  final int eventId;
  final String associatedEventId;
  final String uid;
  final DateTime createdAt;
  final String createdBy;
  final int isActive;

  RegisterDataModelStruct({
    required this.registerId,
    required this.eventId,
    required this.associatedEventId,
    required this.uid,
    required this.createdAt,
    required this.createdBy,
    required this.isActive,
  });

  factory RegisterDataModelStruct.fromMap(Map<String, dynamic> map) {
    return RegisterDataModelStruct(
      registerId: map['register_id'] ?? 0,
      eventId: map['event_id'] ?? 0,
      associatedEventId: map['associated_event_id'] ?? '',
      uid: map['uid'] ?? '',
      createdAt: map['created_at'] != null
          ? map['created_at'].toDate()
          : Timestamp.now().toDate(),
      createdBy: map['created_by'] ?? '',
      isActive: map['is_active'] ?? 0,
    );
  }
}
