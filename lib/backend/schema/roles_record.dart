import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RolesRecord extends FirestoreRecord {
  RolesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "roles_id" field.
  int? _rolesId;
  int get rolesId => _rolesId ?? 0;
  bool hasRolesId() => _rolesId != null;

  // "roles_name" field.
  String? _rolesName;
  String get rolesName => _rolesName ?? '';
  bool hasRolesName() => _rolesName != null;

  // "roles_level" field.
  int? _rolesLevel;
  int get rolesLevel => _rolesLevel ?? 0;
  bool hasRolesLevel() => _rolesLevel != null;

  // "roles_description" field.
  String? _rolesDescription;
  String get rolesDescription => _rolesDescription ?? '';
  bool hasRolesDescription() => _rolesDescription != null;

  // "is_active" field.
  int? _isActive;
  int get isActive => _isActive ?? 0;
  bool hasIsActive() => _isActive != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  bool hasCreatedBy() => _createdBy != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "updated_by" field.
  String? _updatedBy;
  String get updatedBy => _updatedBy ?? '';
  bool hasUpdatedBy() => _updatedBy != null;

  // "roles_ref" field.
  String? _rolesRef;
  String get rolesRef => _rolesRef ?? '';
  bool hasRolesRef() => _rolesRef != null;

  void _initializeFields() {
    _rolesId = castToType<int>(snapshotData['roles_id']);
    _rolesName = snapshotData['roles_name'] as String?;
    _rolesLevel = castToType<int>(snapshotData['roles_level']);
    _rolesDescription = snapshotData['roles_description'] as String?;
    _isActive = castToType<int>(snapshotData['is_active']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as String?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _updatedBy = snapshotData['updated_by'] as String?;
    _rolesRef = snapshotData['roles_ref'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('roles');

  static Stream<RolesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RolesRecord.fromSnapshot(s));

  static Future<RolesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RolesRecord.fromSnapshot(s));

  static RolesRecord fromSnapshot(DocumentSnapshot snapshot) => RolesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RolesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RolesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RolesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RolesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRolesRecordData({
  int? rolesId,
  String? rolesName,
  int? rolesLevel,
  String? rolesDescription,
  int? isActive,
  DateTime? createdAt,
  String? createdBy,
  DateTime? updatedAt,
  String? updatedBy,
  String? rolesRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'roles_id': rolesId,
      'roles_name': rolesName,
      'roles_level': rolesLevel,
      'roles_description': rolesDescription,
      'is_active': isActive,
      'created_at': createdAt,
      'created_by': createdBy,
      'updated_at': updatedAt,
      'updated_by': updatedBy,
      'roles_ref': rolesRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class RolesRecordDocumentEquality implements Equality<RolesRecord> {
  const RolesRecordDocumentEquality();

  @override
  bool equals(RolesRecord? e1, RolesRecord? e2) {
    return e1?.rolesId == e2?.rolesId &&
        e1?.rolesName == e2?.rolesName &&
        e1?.rolesLevel == e2?.rolesLevel &&
        e1?.rolesDescription == e2?.rolesDescription &&
        e1?.isActive == e2?.isActive &&
        e1?.createdAt == e2?.createdAt &&
        e1?.createdBy == e2?.createdBy &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.updatedBy == e2?.updatedBy &&
        e1?.rolesRef == e2?.rolesRef;
  }

  @override
  int hash(RolesRecord? e) => const ListEquality().hash([
        e?.rolesId,
        e?.rolesName,
        e?.rolesLevel,
        e?.rolesDescription,
        e?.isActive,
        e?.createdAt,
        e?.createdBy,
        e?.updatedAt,
        e?.updatedBy,
        e?.rolesRef
      ]);

  @override
  bool isValidKey(Object? o) => o is RolesRecord;
}
