import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserActivitiesRecord extends FirestoreRecord {
  UserActivitiesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "event_id" field.
  String? _eventId;
  String get eventId => _eventId ?? '';
  bool hasEventId() => _eventId != null;

  // "booth_id" field.
  String? _boothId;
  String get boothId => _boothId ?? '';
  bool hasBoothId() => _boothId != null;

  // "check_in_time" field.
  DateTime? _checkInTime;
  DateTime? get checkInTime => _checkInTime;
  bool hasCheckInTime() => _checkInTime != null;

  // "check_in_location" field.
  LatLng? _checkInLocation;
  LatLng? get checkInLocation => _checkInLocation;
  bool hasCheckInLocation() => _checkInLocation != null;

  // "is_completed" field.
  bool? _isCompleted;
  bool get isCompleted => _isCompleted ?? false;
  bool hasIsCompleted() => _isCompleted != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  bool hasCreatedBy() => _createdBy != null;

  // "activity_id" field.
  int? _activityId;
  int get activityId => _activityId ?? 0;
  bool hasActivityId() => _activityId != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _eventId = snapshotData['event_id'] as String?;
    _boothId = snapshotData['booth_id'] as String?;
    _checkInTime = snapshotData['check_in_time'] as DateTime?;
    _checkInLocation = snapshotData['check_in_location'] as LatLng?;
    _isCompleted = snapshotData['is_completed'] as bool?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as String?;
    _activityId = castToType<int>(snapshotData['activity_id']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('userActivities');

  static Stream<UserActivitiesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserActivitiesRecord.fromSnapshot(s));

  static Future<UserActivitiesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserActivitiesRecord.fromSnapshot(s));

  static UserActivitiesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserActivitiesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserActivitiesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserActivitiesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserActivitiesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserActivitiesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserActivitiesRecordData({
  String? uid,
  String? eventId,
  String? boothId,
  DateTime? checkInTime,
  LatLng? checkInLocation,
  bool? isCompleted,
  DateTime? createdAt,
  String? createdBy,
  int? activityId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'event_id': eventId,
      'booth_id': boothId,
      'check_in_time': checkInTime,
      'check_in_location': checkInLocation,
      'is_completed': isCompleted,
      'created_at': createdAt,
      'created_by': createdBy,
      'activity_id': activityId,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserActivitiesRecordDocumentEquality
    implements Equality<UserActivitiesRecord> {
  const UserActivitiesRecordDocumentEquality();

  @override
  bool equals(UserActivitiesRecord? e1, UserActivitiesRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.eventId == e2?.eventId &&
        e1?.boothId == e2?.boothId &&
        e1?.checkInTime == e2?.checkInTime &&
        e1?.checkInLocation == e2?.checkInLocation &&
        e1?.isCompleted == e2?.isCompleted &&
        e1?.createdAt == e2?.createdAt &&
        e1?.createdBy == e2?.createdBy &&
        e1?.activityId == e2?.activityId;
  }

  @override
  int hash(UserActivitiesRecord? e) => const ListEquality().hash([
        e?.uid,
        e?.eventId,
        e?.boothId,
        e?.checkInTime,
        e?.checkInLocation,
        e?.isCompleted,
        e?.createdAt,
        e?.createdBy,
        e?.activityId
      ]);

  @override
  bool isValidKey(Object? o) => o is UserActivitiesRecord;
}
