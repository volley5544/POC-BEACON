import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DetectionsRecord extends FirestoreRecord {
  DetectionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "detection_id" field.
  int? _detectionId;
  int get detectionId => _detectionId ?? 0;
  bool hasDetectionId() => _detectionId != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "event_id" field.
  int? _eventId;
  int get eventId => _eventId ?? 0;
  bool hasEventId() => _eventId != null;

  // "booth_id" field.
  int? _boothId;
  int get boothId => _boothId ?? 0;
  bool hasBoothId() => _boothId != null;

  // "detect_timestamp" field.
  DateTime? _detectTimestamp;
  DateTime? get detectTimestamp => _detectTimestamp;
  bool hasDetectTimestamp() => _detectTimestamp != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _detectionId = castToType<int>(snapshotData['detection_id']);
    _uid = snapshotData['uid'] as String?;
    _eventId = castToType<int>(snapshotData['event_id']);
    _boothId = castToType<int>(snapshotData['booth_id']);
    _detectTimestamp = snapshotData['detect_timestamp'] as DateTime?;
    _createdAt = snapshotData['created_at'] as DateTime?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('detections')
          : FirebaseFirestore.instance.collectionGroup('detections');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('detections').doc(id);

  static Stream<DetectionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DetectionsRecord.fromSnapshot(s));

  static Future<DetectionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DetectionsRecord.fromSnapshot(s));

  static DetectionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DetectionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DetectionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DetectionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DetectionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DetectionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDetectionsRecordData({
  int? detectionId,
  String? uid,
  int? eventId,
  int? boothId,
  DateTime? detectTimestamp,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'detection_id': detectionId,
      'uid': uid,
      'event_id': eventId,
      'booth_id': boothId,
      'detect_timestamp': detectTimestamp,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class DetectionsRecordDocumentEquality implements Equality<DetectionsRecord> {
  const DetectionsRecordDocumentEquality();

  @override
  bool equals(DetectionsRecord? e1, DetectionsRecord? e2) {
    return e1?.detectionId == e2?.detectionId &&
        e1?.uid == e2?.uid &&
        e1?.eventId == e2?.eventId &&
        e1?.boothId == e2?.boothId &&
        e1?.detectTimestamp == e2?.detectTimestamp &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(DetectionsRecord? e) => const ListEquality().hash([
        e?.detectionId,
        e?.uid,
        e?.eventId,
        e?.boothId,
        e?.detectTimestamp,
        e?.createdAt
      ]);

  @override
  bool isValidKey(Object? o) => o is DetectionsRecord;
}
