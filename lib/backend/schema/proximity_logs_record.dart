import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProximityLogsRecord extends FirestoreRecord {
  ProximityLogsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "log_id" field.
  String? _logId;
  String get logId => _logId ?? '';
  bool hasLogId() => _logId != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "detect_timestamp" field.
  DateTime? _detectTimestamp;
  DateTime? get detectTimestamp => _detectTimestamp;
  bool hasDetectTimestamp() => _detectTimestamp != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "event_id" field.
  int? _eventId;
  int get eventId => _eventId ?? 0;
  bool hasEventId() => _eventId != null;

  // "booth_id" field.
  int? _boothId;
  int get boothId => _boothId ?? 0;
  bool hasBoothId() => _boothId != null;

  // "distance" field.
  double? _distance;
  double get distance => _distance ?? 0.0;
  bool hasDistance() => _distance != null;

  // "rssi" field.
  double? _rssi;
  double get rssi => _rssi ?? 0.0;
  bool hasRssi() => _rssi != null;

  // "device_model" field.
  String? _deviceModel;
  String get deviceModel => _deviceModel ?? '';
  bool hasDeviceModel() => _deviceModel != null;

  // "os_version" field.
  String? _osVersion;
  String get osVersion => _osVersion ?? '';
  bool hasOsVersion() => _osVersion != null;

  // "device_brand" field.
  String? _deviceBrand;
  String get deviceBrand => _deviceBrand ?? '';
  bool hasDeviceBrand() => _deviceBrand != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _logId = snapshotData['log_id'] as String?;
    _uid = snapshotData['uid'] as String?;
    _detectTimestamp = snapshotData['detect_timestamp'] as DateTime?;
    _status = snapshotData['status'] as String?;
    _eventId = castToType<int>(snapshotData['event_id']);
    _boothId = castToType<int>(snapshotData['booth_id']);
    _distance = castToType<double>(snapshotData['distance']);
    _rssi = castToType<double>(snapshotData['rssi']);
    _deviceModel = snapshotData['device_model'] as String?;
    _osVersion = snapshotData['os_version'] as String?;
    _deviceBrand = snapshotData['device_brand'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('proximity_logs')
          : FirebaseFirestore.instance.collectionGroup('proximity_logs');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('proximity_logs').doc(id);

  static Stream<ProximityLogsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ProximityLogsRecord.fromSnapshot(s));

  static Future<ProximityLogsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ProximityLogsRecord.fromSnapshot(s));

  static ProximityLogsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ProximityLogsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ProximityLogsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ProximityLogsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ProximityLogsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ProximityLogsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createProximityLogsRecordData({
  String? logId,
  String? uid,
  DateTime? detectTimestamp,
  String? status,
  int? eventId,
  int? boothId,
  double? distance,
  double? rssi,
  String? deviceModel,
  String? osVersion,
  String? deviceBrand,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'log_id': logId,
      'uid': uid,
      'detect_timestamp': detectTimestamp,
      'status': status,
      'event_id': eventId,
      'booth_id': boothId,
      'distance': distance,
      'rssi': rssi,
      'device_model': deviceModel,
      'os_version': osVersion,
      'device_brand': deviceBrand,
    }.withoutNulls,
  );

  return firestoreData;
}

class ProximityLogsRecordDocumentEquality
    implements Equality<ProximityLogsRecord> {
  const ProximityLogsRecordDocumentEquality();

  @override
  bool equals(ProximityLogsRecord? e1, ProximityLogsRecord? e2) {
    return e1?.logId == e2?.logId &&
        e1?.uid == e2?.uid &&
        e1?.detectTimestamp == e2?.detectTimestamp &&
        e1?.status == e2?.status &&
        e1?.eventId == e2?.eventId &&
        e1?.boothId == e2?.boothId &&
        e1?.distance == e2?.distance &&
        e1?.rssi == e2?.rssi &&
        e1?.deviceModel == e2?.deviceModel &&
        e1?.osVersion == e2?.osVersion &&
        e1?.deviceBrand == e2?.deviceBrand;
  }

  @override
  int hash(ProximityLogsRecord? e) => const ListEquality().hash([
        e?.logId,
        e?.uid,
        e?.detectTimestamp,
        e?.status,
        e?.eventId,
        e?.boothId,
        e?.distance,
        e?.rssi,
        e?.deviceModel,
        e?.osVersion,
        e?.deviceBrand
      ]);

  @override
  bool isValidKey(Object? o) => o is ProximityLogsRecord;
}
