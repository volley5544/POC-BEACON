import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserActivityRecord extends FirestoreRecord {
  UserActivityRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

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

  // "is_active" field.
  int? _isActive;
  int get isActive => _isActive ?? 0;
  bool hasIsActive() => _isActive != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "updated_by" field.
  String? _updatedBy;
  String get updatedBy => _updatedBy ?? '';
  bool hasUpdatedBy() => _updatedBy != null;

  // "activity_id" field.
  int? _activityId;
  int get activityId => _activityId ?? 0;
  bool hasActivityId() => _activityId != null;

  // "associated_event_id" field.
  String? _associatedEventId;
  String get associatedEventId => _associatedEventId ?? '';
  bool hasAssociatedEventId() => _associatedEventId != null;

  // "associated_booth_id" field.
  String? _associatedBoothId;
  String get associatedBoothId => _associatedBoothId ?? '';
  bool hasAssociatedBoothId() => _associatedBoothId != null;

  // "is_surveyed" field.
  bool? _isSurveyed;
  bool get isSurveyed => _isSurveyed ?? false;
  bool hasIsSurveyed() => _isSurveyed != null;

  // "survey_data" field.
  SurveyDataModelStruct? _surveyData;
  SurveyDataModelStruct get surveyData =>
      _surveyData ?? SurveyDataModelStruct();
  bool hasSurveyData() => _surveyData != null;

  // "booth_name" field.
  String? _boothName;
  String get boothName => _boothName ?? '';
  bool hasBoothName() => _boothName != null;

  // "event_id" field.
  int? _eventId;
  int get eventId => _eventId ?? 0;
  bool hasEventId() => _eventId != null;

  // "booth_id" field.
  int? _boothId;
  int get boothId => _boothId ?? 0;
  bool hasBoothId() => _boothId != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _checkInTime = snapshotData['check_in_time'] as DateTime?;
    _checkInLocation = snapshotData['check_in_location'] as LatLng?;
    _isCompleted = snapshotData['is_completed'] as bool?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as String?;
    _isActive = castToType<int>(snapshotData['is_active']);
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _updatedBy = snapshotData['updated_by'] as String?;
    _activityId = castToType<int>(snapshotData['activity_id']);
    _associatedEventId = snapshotData['associated_event_id'] as String?;
    _associatedBoothId = snapshotData['associated_booth_id'] as String?;
    _isSurveyed = snapshotData['is_surveyed'] as bool?;
    _surveyData = snapshotData['survey_data'] is SurveyDataModelStruct
        ? snapshotData['survey_data']
        : SurveyDataModelStruct.maybeFromMap(snapshotData['survey_data']);
    _boothName = snapshotData['booth_name'] as String?;
    _eventId = castToType<int>(snapshotData['event_id']);
    _boothId = castToType<int>(snapshotData['booth_id']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('UserActivity')
          : FirebaseFirestore.instance.collectionGroup('UserActivity');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('UserActivity').doc(id);

  static Stream<UserActivityRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserActivityRecord.fromSnapshot(s));

  static Future<UserActivityRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserActivityRecord.fromSnapshot(s));

  static UserActivityRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserActivityRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserActivityRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserActivityRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserActivityRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserActivityRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserActivityRecordData({
  String? uid,
  DateTime? checkInTime,
  LatLng? checkInLocation,
  bool? isCompleted,
  DateTime? createdAt,
  String? createdBy,
  int? isActive,
  DateTime? updatedAt,
  String? updatedBy,
  int? activityId,
  String? associatedEventId,
  String? associatedBoothId,
  bool? isSurveyed,
  SurveyDataModelStruct? surveyData,
  String? boothName,
  int? eventId,
  int? boothId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'check_in_time': checkInTime,
      'check_in_location': checkInLocation,
      'is_completed': isCompleted,
      'created_at': createdAt,
      'created_by': createdBy,
      'is_active': isActive,
      'updated_at': updatedAt,
      'updated_by': updatedBy,
      'activity_id': activityId,
      'associated_event_id': associatedEventId,
      'associated_booth_id': associatedBoothId,
      'is_surveyed': isSurveyed,
      'survey_data': SurveyDataModelStruct().toMap(),
      'booth_name': boothName,
      'event_id': eventId,
      'booth_id': boothId,
    }.withoutNulls,
  );

  // Handle nested data for "survey_data" field.
  addSurveyDataModelStructData(firestoreData, surveyData, 'survey_data');

  return firestoreData;
}

class UserActivityRecordDocumentEquality
    implements Equality<UserActivityRecord> {
  const UserActivityRecordDocumentEquality();

  @override
  bool equals(UserActivityRecord? e1, UserActivityRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.checkInTime == e2?.checkInTime &&
        e1?.checkInLocation == e2?.checkInLocation &&
        e1?.isCompleted == e2?.isCompleted &&
        e1?.createdAt == e2?.createdAt &&
        e1?.createdBy == e2?.createdBy &&
        e1?.isActive == e2?.isActive &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.updatedBy == e2?.updatedBy &&
        e1?.activityId == e2?.activityId &&
        e1?.associatedEventId == e2?.associatedEventId &&
        e1?.associatedBoothId == e2?.associatedBoothId &&
        e1?.isSurveyed == e2?.isSurveyed &&
        e1?.surveyData == e2?.surveyData &&
        e1?.boothName == e2?.boothName &&
        e1?.eventId == e2?.eventId &&
        e1?.boothId == e2?.boothId;
  }

  @override
  int hash(UserActivityRecord? e) => const ListEquality().hash([
        e?.uid,
        e?.checkInTime,
        e?.checkInLocation,
        e?.isCompleted,
        e?.createdAt,
        e?.createdBy,
        e?.isActive,
        e?.updatedAt,
        e?.updatedBy,
        e?.activityId,
        e?.associatedEventId,
        e?.associatedBoothId,
        e?.isSurveyed,
        e?.surveyData,
        e?.boothName,
        e?.eventId,
        e?.boothId
      ]);

  @override
  bool isValidKey(Object? o) => o is UserActivityRecord;
}
