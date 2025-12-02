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

  // "associated_event_id" field.
  String? _associatedEventId;
  String get associatedEventId => _associatedEventId ?? '';
  bool hasAssociatedEventId() => _associatedEventId != null;

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

  // "event_id" field.
  int? _eventId;
  int get eventId => _eventId ?? 0;
  bool hasEventId() => _eventId != null;

  // "booth_image_list" field.
  List<String>? _boothImageList;
  List<String> get boothImageList => _boothImageList ?? const [];
  bool hasBoothImageList() => _boothImageList != null;

  // "device_uuid" field.
  String? _deviceUuid;
  String get deviceUuid => _deviceUuid ?? '';
  bool hasDeviceUuid() => _deviceUuid != null;

  // "current_user_count" field.
  int? _currentUserCount;
  int get currentUserCount => _currentUserCount ?? 0;
  bool hasCurrentUserCount() => _currentUserCount != null;

  // "last_updated" field.
  DateTime? _lastUpdated;
  DateTime? get lastUpdated => _lastUpdated;
  bool hasLastUpdated() => _lastUpdated != null;

  // "notification_distance" field.
  double? _notificationDistance;
  double get notificationDistance => _notificationDistance ?? 0.0;
  bool hasNotificationDistance() => _notificationDistance != null;

  // "tx_power" field.
  double? _txPower;
  double get txPower => _txPower ?? 0.0;
  bool hasTxPower() => _txPower != null;

  // "path_loss_exponent" field.
  double? _pathLossExponent;
  double get pathLossExponent => _pathLossExponent ?? 0.0;
  bool hasPathLossExponent() => _pathLossExponent != null;

  // "smoothing_alpha" field.
  double? _smoothingAlpha;
  double get smoothingAlpha => _smoothingAlpha ?? 0.0;
  bool hasSmoothingAlpha() => _smoothingAlpha != null;

  // "max_distance_cap" field.
  double? _maxDistanceCap;
  double get maxDistanceCap => _maxDistanceCap ?? 0.0;
  bool hasMaxDistanceCap() => _maxDistanceCap != null;

  // "calibrated_at" field.
  DateTime? _calibratedAt;
  DateTime? get calibratedAt => _calibratedAt;
  bool hasCalibratedAt() => _calibratedAt != null;

  // "environment_label" field.
  String? _environmentLabel;
  String get environmentLabel => _environmentLabel ?? '';
  bool hasEnvironmentLabel() => _environmentLabel != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _boothId = castToType<int>(snapshotData['booth_id']);
    _boothName = snapshotData['booth_name'] as String?;
    _description = snapshotData['description'] as String?;
    _associatedEventId = snapshotData['associated_event_id'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as String?;
    _isActive = castToType<int>(snapshotData['is_active']);
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _updatedBy = snapshotData['updated_by'] as String?;
    _eventId = castToType<int>(snapshotData['event_id']);
    _boothImageList = getDataList(snapshotData['booth_image_list']);
    _deviceUuid = snapshotData['device_uuid'] as String?;
    _currentUserCount = castToType<int>(snapshotData['current_user_count']);
    _lastUpdated = snapshotData['last_updated'] as DateTime?;
    _notificationDistance =
        castToType<double>(snapshotData['notification_distance']);
    _txPower = castToType<double>(snapshotData['tx_power']);
    _pathLossExponent = castToType<double>(snapshotData['path_loss_exponent']);
    _smoothingAlpha = castToType<double>(snapshotData['smoothing_alpha']);
    _maxDistanceCap = castToType<double>(snapshotData['max_distance_cap']);
    _calibratedAt = snapshotData['calibrated_at'] as DateTime?;
    _environmentLabel = snapshotData['environment_label'] as String?;
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
  String? associatedEventId,
  DateTime? createdAt,
  String? createdBy,
  int? isActive,
  DateTime? updatedAt,
  String? updatedBy,
  int? eventId,
  String? deviceUuid,
  int? currentUserCount,
  DateTime? lastUpdated,
  double? notificationDistance,
  double? txPower,
  double? pathLossExponent,
  double? smoothingAlpha,
  double? maxDistanceCap,
  DateTime? calibratedAt,
  String? environmentLabel,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'booth_id': boothId,
      'booth_name': boothName,
      'description': description,
      'associated_event_id': associatedEventId,
      'created_at': createdAt,
      'created_by': createdBy,
      'is_active': isActive,
      'updated_at': updatedAt,
      'updated_by': updatedBy,
      'event_id': eventId,
      'device_uuid': deviceUuid,
      'current_user_count': currentUserCount,
      'last_updated': lastUpdated,
      'notification_distance': notificationDistance,
      'tx_power': txPower,
      'path_loss_exponent': pathLossExponent,
      'smoothing_alpha': smoothingAlpha,
      'max_distance_cap': maxDistanceCap,
      'calibrated_at': calibratedAt,
      'environment_label': environmentLabel,
    }.withoutNulls,
  );

  return firestoreData;
}

class BoothsRecordDocumentEquality implements Equality<BoothsRecord> {
  const BoothsRecordDocumentEquality();

  @override
  bool equals(BoothsRecord? e1, BoothsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.boothId == e2?.boothId &&
        e1?.boothName == e2?.boothName &&
        e1?.description == e2?.description &&
        e1?.associatedEventId == e2?.associatedEventId &&
        e1?.createdAt == e2?.createdAt &&
        e1?.createdBy == e2?.createdBy &&
        e1?.isActive == e2?.isActive &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.updatedBy == e2?.updatedBy &&
        e1?.eventId == e2?.eventId &&
        listEquality.equals(e1?.boothImageList, e2?.boothImageList) &&
        e1?.deviceUuid == e2?.deviceUuid &&
        e1?.currentUserCount == e2?.currentUserCount &&
        e1?.lastUpdated == e2?.lastUpdated &&
        e1?.notificationDistance == e2?.notificationDistance &&
        e1?.txPower == e2?.txPower &&
        e1?.pathLossExponent == e2?.pathLossExponent &&
        e1?.smoothingAlpha == e2?.smoothingAlpha &&
        e1?.maxDistanceCap == e2?.maxDistanceCap &&
        e1?.calibratedAt == e2?.calibratedAt &&
        e1?.environmentLabel == e2?.environmentLabel;
  }

  @override
  int hash(BoothsRecord? e) => const ListEquality().hash([
        e?.boothId,
        e?.boothName,
        e?.description,
        e?.associatedEventId,
        e?.createdAt,
        e?.createdBy,
        e?.isActive,
        e?.updatedAt,
        e?.updatedBy,
        e?.eventId,
        e?.boothImageList,
        e?.deviceUuid,
        e?.currentUserCount,
        e?.lastUpdated,
        e?.notificationDistance,
        e?.txPower,
        e?.pathLossExponent,
        e?.smoothingAlpha,
        e?.maxDistanceCap,
        e?.calibratedAt,
        e?.environmentLabel
      ]);

  @override
  bool isValidKey(Object? o) => o is BoothsRecord;
}
