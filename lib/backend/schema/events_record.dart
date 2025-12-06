import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventsRecord extends FirestoreRecord {
  EventsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "event_id" field.
  int? _eventId;
  int get eventId => _eventId ?? 0;
  bool hasEventId() => _eventId != null;

  // "event_name" field.
  String? _eventName;
  String get eventName => _eventName ?? '';
  bool hasEventName() => _eventName != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

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

  // "notification_frequency_amount" field.
  int? _notificationFrequencyAmount;
  int get notificationFrequencyAmount => _notificationFrequencyAmount ?? 0;
  bool hasNotificationFrequencyAmount() => _notificationFrequencyAmount != null;

  // "notification_frequency_minute" field.
  int? _notificationFrequencyMinute;
  int get notificationFrequencyMinute => _notificationFrequencyMinute ?? 0;
  bool hasNotificationFrequencyMinute() => _notificationFrequencyMinute != null;

  // "start_datetime" field.
  DateTime? _startDatetime;
  DateTime? get startDatetime => _startDatetime;
  bool hasStartDatetime() => _startDatetime != null;

  // "end_datetime" field.
  DateTime? _endDatetime;
  DateTime? get endDatetime => _endDatetime;
  bool hasEndDatetime() => _endDatetime != null;

  // "event_image_list" field.
  List<String>? _eventImageList;
  List<String> get eventImageList => _eventImageList ?? const [];
  bool hasEventImageList() => _eventImageList != null;

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  bool hasUrl() => _url != null;

  // "notification_frequency_second" field.
  double? _notificationFrequencySecond;
  double get notificationFrequencySecond => _notificationFrequencySecond ?? 0.0;
  bool hasNotificationFrequencySecond() => _notificationFrequencySecond != null;

  void _initializeFields() {
    _eventId = castToType<int>(snapshotData['event_id']);
    _eventName = snapshotData['event_name'] as String?;
    _description = snapshotData['description'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as String?;
    _isActive = castToType<int>(snapshotData['is_active']);
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _updatedBy = snapshotData['updated_by'] as String?;
    _notificationFrequencyAmount =
        castToType<int>(snapshotData['notification_frequency_amount']);
    _notificationFrequencyMinute =
        castToType<int>(snapshotData['notification_frequency_minute']);
    _startDatetime = snapshotData['start_datetime'] as DateTime?;
    _endDatetime = snapshotData['end_datetime'] as DateTime?;
    _eventImageList = getDataList(snapshotData['event_image_list']);
    _url = snapshotData['url'] as String?;
    _notificationFrequencySecond =
        castToType<double>(snapshotData['notification_frequency_second']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('events');

  static Stream<EventsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EventsRecord.fromSnapshot(s));

  static Future<EventsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EventsRecord.fromSnapshot(s));

  static EventsRecord fromSnapshot(DocumentSnapshot snapshot) => EventsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EventsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EventsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EventsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EventsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEventsRecordData({
  int? eventId,
  String? eventName,
  String? description,
  DateTime? createdAt,
  String? createdBy,
  int? isActive,
  DateTime? updatedAt,
  String? updatedBy,
  int? notificationFrequencyAmount,
  int? notificationFrequencyMinute,
  DateTime? startDatetime,
  DateTime? endDatetime,
  String? url,
  double? notificationFrequencySecond,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'event_id': eventId,
      'event_name': eventName,
      'description': description,
      'created_at': createdAt,
      'created_by': createdBy,
      'is_active': isActive,
      'updated_at': updatedAt,
      'updated_by': updatedBy,
      'notification_frequency_amount': notificationFrequencyAmount,
      'notification_frequency_minute': notificationFrequencyMinute,
      'start_datetime': startDatetime,
      'end_datetime': endDatetime,
      'url': url,
      'notification_frequency_second': notificationFrequencySecond,
    }.withoutNulls,
  );

  return firestoreData;
}

class EventsRecordDocumentEquality implements Equality<EventsRecord> {
  const EventsRecordDocumentEquality();

  @override
  bool equals(EventsRecord? e1, EventsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.eventId == e2?.eventId &&
        e1?.eventName == e2?.eventName &&
        e1?.description == e2?.description &&
        e1?.createdAt == e2?.createdAt &&
        e1?.createdBy == e2?.createdBy &&
        e1?.isActive == e2?.isActive &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.updatedBy == e2?.updatedBy &&
        e1?.notificationFrequencyAmount == e2?.notificationFrequencyAmount &&
        e1?.notificationFrequencyMinute == e2?.notificationFrequencyMinute &&
        e1?.startDatetime == e2?.startDatetime &&
        e1?.endDatetime == e2?.endDatetime &&
        listEquality.equals(e1?.eventImageList, e2?.eventImageList) &&
        e1?.url == e2?.url &&
        e1?.notificationFrequencySecond == e2?.notificationFrequencySecond;
  }

  @override
  int hash(EventsRecord? e) => const ListEquality().hash([
        e?.eventId,
        e?.eventName,
        e?.description,
        e?.createdAt,
        e?.createdBy,
        e?.isActive,
        e?.updatedAt,
        e?.updatedBy,
        e?.notificationFrequencyAmount,
        e?.notificationFrequencyMinute,
        e?.startDatetime,
        e?.endDatetime,
        e?.eventImageList,
        e?.url,
        e?.notificationFrequencySecond
      ]);

  @override
  bool isValidKey(Object? o) => o is EventsRecord;
}
