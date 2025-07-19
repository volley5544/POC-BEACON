import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BoothsRecord extends FirestoreRecord {
  BoothsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "booth_id" field.
  int? _boothId;
  int get boothId => _boothId ?? 0;
  bool hasBoothId() => _boothId != null;

  // "booth_name" field.
  String? _boothName;
  String get boothName => _boothName ?? '';
  bool hasBoothName() => _boothName != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "notification_distance" field.
  int? _notificationDistance;
  int get notificationDistance => _notificationDistance ?? 0;
  bool hasNotificationDistance() => _notificationDistance != null;

  // "associated_event_id" field.
  String? _associatedEventId;
  String get associatedEventId => _associatedEventId ?? '';
  bool hasAssociatedEventId() => _associatedEventId != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _boothId = castToType<int>(snapshotData['booth_id']);
    _boothName = snapshotData['booth_name'] as String?;
    _description = snapshotData['description'] as String?;
    _notificationDistance =
        castToType<int>(snapshotData['notification_distance']);
    _associatedEventId = snapshotData['associated_event_id'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('booths')
          : FirebaseFirestore.instance.collectionGroup('booths');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('booths').doc(id);

  static Stream<BoothsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BoothsRecord.fromSnapshot(s));

  static Future<BoothsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BoothsRecord.fromSnapshot(s));

  static BoothsRecord fromSnapshot(DocumentSnapshot snapshot) => BoothsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BoothsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BoothsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BoothsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BoothsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBoothsRecordData({
  int? boothId,
  String? boothName,
  String? description,
  int? notificationDistance,
  String? associatedEventId,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'booth_id': boothId,
      'booth_name': boothName,
      'description': description,
      'notification_distance': notificationDistance,
      'associated_event_id': associatedEventId,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class BoothsRecordDocumentEquality implements Equality<BoothsRecord> {
  const BoothsRecordDocumentEquality();

  @override
  bool equals(BoothsRecord? e1, BoothsRecord? e2) {
    return e1?.boothId == e2?.boothId &&
        e1?.boothName == e2?.boothName &&
        e1?.description == e2?.description &&
        e1?.notificationDistance == e2?.notificationDistance &&
        e1?.associatedEventId == e2?.associatedEventId &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(BoothsRecord? e) => const ListEquality().hash([
        e?.boothId,
        e?.boothName,
        e?.description,
        e?.notificationDistance,
        e?.associatedEventId,
        e?.createdAt
      ]);

  @override
  bool isValidKey(Object? o) => o is BoothsRecord;
}
