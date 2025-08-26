import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationsRecord extends FirestoreRecord {
  NotificationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "to_uid" field.
  String? _toUid;
  String get toUid => _toUid ?? '';
  bool hasToUid() => _toUid != null;

  // "booth_id" field.
  String? _boothId;
  String get boothId => _boothId ?? '';
  bool hasBoothId() => _boothId != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "body" field.
  String? _body;
  String get body => _body ?? '';
  bool hasBody() => _body != null;

  // "sent_at" field.
  DateTime? _sentAt;
  DateTime? get sentAt => _sentAt;
  bool hasSentAt() => _sentAt != null;

  // "event_id" field.
  int? _eventId;
  int get eventId => _eventId ?? 0;
  bool hasEventId() => _eventId != null;

  // "send_count" field.
  int? _sendCount;
  int get sendCount => _sendCount ?? 0;
  bool hasSendCount() => _sendCount != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _toUid = snapshotData['to_uid'] as String?;
    _boothId = snapshotData['booth_id'] as String?;
    _title = snapshotData['title'] as String?;
    _body = snapshotData['body'] as String?;
    _sentAt = snapshotData['sent_at'] as DateTime?;
    _eventId = castToType<int>(snapshotData['event_id']);
    _sendCount = castToType<int>(snapshotData['send_count']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('notifications')
          : FirebaseFirestore.instance.collectionGroup('notifications');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('notifications').doc(id);

  static Stream<NotificationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NotificationsRecord.fromSnapshot(s));

  static Future<NotificationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NotificationsRecord.fromSnapshot(s));

  static NotificationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NotificationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotificationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotificationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotificationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotificationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNotificationsRecordData({
  String? toUid,
  String? boothId,
  String? title,
  String? body,
  DateTime? sentAt,
  int? eventId,
  int? sendCount,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'to_uid': toUid,
      'booth_id': boothId,
      'title': title,
      'body': body,
      'sent_at': sentAt,
      'event_id': eventId,
      'send_count': sendCount,
    }.withoutNulls,
  );

  return firestoreData;
}

class NotificationsRecordDocumentEquality
    implements Equality<NotificationsRecord> {
  const NotificationsRecordDocumentEquality();

  @override
  bool equals(NotificationsRecord? e1, NotificationsRecord? e2) {
    return e1?.toUid == e2?.toUid &&
        e1?.boothId == e2?.boothId &&
        e1?.title == e2?.title &&
        e1?.body == e2?.body &&
        e1?.sentAt == e2?.sentAt &&
        e1?.eventId == e2?.eventId &&
        e1?.sendCount == e2?.sendCount;
  }

  @override
  int hash(NotificationsRecord? e) => const ListEquality().hash([
        e?.toUid,
        e?.boothId,
        e?.title,
        e?.body,
        e?.sentAt,
        e?.eventId,
        e?.sendCount
      ]);

  @override
  bool isValidKey(Object? o) => o is NotificationsRecord;
}
