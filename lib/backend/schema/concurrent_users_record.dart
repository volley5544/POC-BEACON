import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ConcurrentUsersRecord extends FirestoreRecord {
  ConcurrentUsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "record_id" field.
  String? _recordId;
  String get recordId => _recordId ?? '';
  bool hasRecordId() => _recordId != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  // "uids" field.
  String? _uids;
  String get uids => _uids ?? '';
  bool hasUids() => _uids != null;

  // "user_count" field.
  int? _userCount;
  int get userCount => _userCount ?? 0;
  bool hasUserCount() => _userCount != null;

  // "event_id" field.
  int? _eventId;
  int get eventId => _eventId ?? 0;
  bool hasEventId() => _eventId != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _recordId = snapshotData['record_id'] as String?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _uids = snapshotData['uids'] as String?;
    _userCount = castToType<int>(snapshotData['user_count']);
    _eventId = castToType<int>(snapshotData['event_id']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('concurrent_users')
          : FirebaseFirestore.instance.collectionGroup('concurrent_users');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('concurrent_users').doc(id);

  static Stream<ConcurrentUsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ConcurrentUsersRecord.fromSnapshot(s));

  static Future<ConcurrentUsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ConcurrentUsersRecord.fromSnapshot(s));

  static ConcurrentUsersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ConcurrentUsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ConcurrentUsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ConcurrentUsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ConcurrentUsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ConcurrentUsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createConcurrentUsersRecordData({
  String? recordId,
  DateTime? timestamp,
  String? uids,
  int? userCount,
  int? eventId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'record_id': recordId,
      'timestamp': timestamp,
      'uids': uids,
      'user_count': userCount,
      'event_id': eventId,
    }.withoutNulls,
  );

  return firestoreData;
}

class ConcurrentUsersRecordDocumentEquality
    implements Equality<ConcurrentUsersRecord> {
  const ConcurrentUsersRecordDocumentEquality();

  @override
  bool equals(ConcurrentUsersRecord? e1, ConcurrentUsersRecord? e2) {
    return e1?.recordId == e2?.recordId &&
        e1?.timestamp == e2?.timestamp &&
        e1?.uids == e2?.uids &&
        e1?.userCount == e2?.userCount &&
        e1?.eventId == e2?.eventId;
  }

  @override
  int hash(ConcurrentUsersRecord? e) => const ListEquality()
      .hash([e?.recordId, e?.timestamp, e?.uids, e?.userCount, e?.eventId]);

  @override
  bool isValidKey(Object? o) => o is ConcurrentUsersRecord;
}
