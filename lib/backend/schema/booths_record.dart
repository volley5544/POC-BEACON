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

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  bool hasId() => _id != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "visitor_count" field.
  int? _visitorCount;
  int get visitorCount => _visitorCount ?? 0;
  bool hasVisitorCount() => _visitorCount != null;

  // "last_updated" field.
  DateTime? _lastUpdated;
  DateTime? get lastUpdated => _lastUpdated;
  bool hasLastUpdated() => _lastUpdated != null;

  void _initializeFields() {
    _id = snapshotData['id'] as String?;
    _name = snapshotData['name'] as String?;
    _location = snapshotData['location'] as LatLng?;
    _description = snapshotData['description'] as String?;
    _visitorCount = castToType<int>(snapshotData['visitor_count']);
    _lastUpdated = snapshotData['last_updated'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Booths');

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
  String? id,
  String? name,
  LatLng? location,
  String? description,
  int? visitorCount,
  DateTime? lastUpdated,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'id': id,
      'name': name,
      'location': location,
      'description': description,
      'visitor_count': visitorCount,
      'last_updated': lastUpdated,
    }.withoutNulls,
  );

  return firestoreData;
}

class BoothsRecordDocumentEquality implements Equality<BoothsRecord> {
  const BoothsRecordDocumentEquality();

  @override
  bool equals(BoothsRecord? e1, BoothsRecord? e2) {
    return e1?.id == e2?.id &&
        e1?.name == e2?.name &&
        e1?.location == e2?.location &&
        e1?.description == e2?.description &&
        e1?.visitorCount == e2?.visitorCount &&
        e1?.lastUpdated == e2?.lastUpdated;
  }

  @override
  int hash(BoothsRecord? e) => const ListEquality().hash([
        e?.id,
        e?.name,
        e?.location,
        e?.description,
        e?.visitorCount,
        e?.lastUpdated
      ]);

  @override
  bool isValidKey(Object? o) => o is BoothsRecord;
}
