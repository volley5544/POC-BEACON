import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// คนที่ลงทะเบียนเข้างาน
class RegisterRecord extends FirestoreRecord {
  RegisterRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "register_id" field.
  int? _registerId;
  int get registerId => _registerId ?? 0;
  bool hasRegisterId() => _registerId != null;

  // "event_id" field.
  int? _eventId;
  int get eventId => _eventId ?? 0;
  bool hasEventId() => _eventId != null;

  // "associated_event_id" field.
  String? _associatedEventId;
  String get associatedEventId => _associatedEventId ?? '';
  bool hasAssociatedEventId() => _associatedEventId != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

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

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _registerId = castToType<int>(snapshotData['register_id']);
    _eventId = castToType<int>(snapshotData['event_id']);
    _associatedEventId = snapshotData['associated_event_id'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as String?;
    _isActive = castToType<int>(snapshotData['is_active']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('register')
          : FirebaseFirestore.instance.collectionGroup('register');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('register').doc(id);

  static Stream<RegisterRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RegisterRecord.fromSnapshot(s));

  static Future<RegisterRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RegisterRecord.fromSnapshot(s));

  static RegisterRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RegisterRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RegisterRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RegisterRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RegisterRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RegisterRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRegisterRecordData({
  int? registerId,
  int? eventId,
  String? associatedEventId,
  String? uid,
  DateTime? createdAt,
  String? createdBy,
  int? isActive,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'register_id': registerId,
      'event_id': eventId,
      'associated_event_id': associatedEventId,
      'uid': uid,
      'created_at': createdAt,
      'created_by': createdBy,
      'is_active': isActive,
    }.withoutNulls,
  );

  return firestoreData;
}

class RegisterRecordDocumentEquality implements Equality<RegisterRecord> {
  const RegisterRecordDocumentEquality();

  @override
  bool equals(RegisterRecord? e1, RegisterRecord? e2) {
    return e1?.registerId == e2?.registerId &&
        e1?.eventId == e2?.eventId &&
        e1?.associatedEventId == e2?.associatedEventId &&
        e1?.uid == e2?.uid &&
        e1?.createdAt == e2?.createdAt &&
        e1?.createdBy == e2?.createdBy &&
        e1?.isActive == e2?.isActive;
  }

  @override
  int hash(RegisterRecord? e) => const ListEquality().hash([
        e?.registerId,
        e?.eventId,
        e?.associatedEventId,
        e?.uid,
        e?.createdAt,
        e?.createdBy,
        e?.isActive
      ]);

  @override
  bool isValidKey(Object? o) => o is RegisterRecord;
}
