import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MediaFilesRecord extends FirestoreRecord {
  MediaFilesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "file_id" field.
  int? _fileId;
  int get fileId => _fileId ?? 0;
  bool hasFileId() => _fileId != null;

  // "file_name" field.
  String? _fileName;
  String get fileName => _fileName ?? '';
  bool hasFileName() => _fileName != null;

  // "file_url" field.
  String? _fileUrl;
  String get fileUrl => _fileUrl ?? '';
  bool hasFileUrl() => _fileUrl != null;

  // "file_type" field.
  String? _fileType;
  String get fileType => _fileType ?? '';
  bool hasFileType() => _fileType != null;

  // "related_type" field.
  String? _relatedType;
  String get relatedType => _relatedType ?? '';
  bool hasRelatedType() => _relatedType != null;

  // "related_id" field.
  int? _relatedId;
  int get relatedId => _relatedId ?? 0;
  bool hasRelatedId() => _relatedId != null;

  // "is_cover" field.
  bool? _isCover;
  bool get isCover => _isCover ?? false;
  bool hasIsCover() => _isCover != null;

  // "seq" field.
  int? _seq;
  int get seq => _seq ?? 0;
  bool hasSeq() => _seq != null;

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

  void _initializeFields() {
    _fileId = castToType<int>(snapshotData['file_id']);
    _fileName = snapshotData['file_name'] as String?;
    _fileUrl = snapshotData['file_url'] as String?;
    _fileType = snapshotData['file_type'] as String?;
    _relatedType = snapshotData['related_type'] as String?;
    _relatedId = castToType<int>(snapshotData['related_id']);
    _isCover = snapshotData['is_cover'] as bool?;
    _seq = castToType<int>(snapshotData['seq']);
    _isActive = castToType<int>(snapshotData['is_active']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as String?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _updatedBy = snapshotData['updated_by'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('mediaFiles');

  static Stream<MediaFilesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MediaFilesRecord.fromSnapshot(s));

  static Future<MediaFilesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MediaFilesRecord.fromSnapshot(s));

  static MediaFilesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MediaFilesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MediaFilesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MediaFilesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MediaFilesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MediaFilesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMediaFilesRecordData({
  int? fileId,
  String? fileName,
  String? fileUrl,
  String? fileType,
  String? relatedType,
  int? relatedId,
  bool? isCover,
  int? seq,
  int? isActive,
  DateTime? createdAt,
  String? createdBy,
  DateTime? updatedAt,
  String? updatedBy,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'file_id': fileId,
      'file_name': fileName,
      'file_url': fileUrl,
      'file_type': fileType,
      'related_type': relatedType,
      'related_id': relatedId,
      'is_cover': isCover,
      'seq': seq,
      'is_active': isActive,
      'created_at': createdAt,
      'created_by': createdBy,
      'updated_at': updatedAt,
      'updated_by': updatedBy,
    }.withoutNulls,
  );

  return firestoreData;
}

class MediaFilesRecordDocumentEquality implements Equality<MediaFilesRecord> {
  const MediaFilesRecordDocumentEquality();

  @override
  bool equals(MediaFilesRecord? e1, MediaFilesRecord? e2) {
    return e1?.fileId == e2?.fileId &&
        e1?.fileName == e2?.fileName &&
        e1?.fileUrl == e2?.fileUrl &&
        e1?.fileType == e2?.fileType &&
        e1?.relatedType == e2?.relatedType &&
        e1?.relatedId == e2?.relatedId &&
        e1?.isCover == e2?.isCover &&
        e1?.seq == e2?.seq &&
        e1?.isActive == e2?.isActive &&
        e1?.createdAt == e2?.createdAt &&
        e1?.createdBy == e2?.createdBy &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.updatedBy == e2?.updatedBy;
  }

  @override
  int hash(MediaFilesRecord? e) => const ListEquality().hash([
        e?.fileId,
        e?.fileName,
        e?.fileUrl,
        e?.fileType,
        e?.relatedType,
        e?.relatedId,
        e?.isCover,
        e?.seq,
        e?.isActive,
        e?.createdAt,
        e?.createdBy,
        e?.updatedAt,
        e?.updatedBy
      ]);

  @override
  bool isValidKey(Object? o) => o is MediaFilesRecord;
}
