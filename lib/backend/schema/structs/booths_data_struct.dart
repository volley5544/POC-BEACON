// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class BoothsDataStruct extends FFFirebaseStruct {
  BoothsDataStruct({
    int? boothId,
    int? point,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _boothId = boothId,
        _point = point,
        super(firestoreUtilData);

  // "booth_id" field.
  int? _boothId;
  int get boothId => _boothId ?? 0;
  set boothId(int? val) => _boothId = val;

  void incrementBoothId(int amount) => boothId = boothId + amount;

  bool hasBoothId() => _boothId != null;

  // "point" field.
  int? _point;
  int get point => _point ?? 0;
  set point(int? val) => _point = val;

  void incrementPoint(int amount) => point = point + amount;

  bool hasPoint() => _point != null;

  static BoothsDataStruct fromMap(Map<String, dynamic> data) =>
      BoothsDataStruct(
        boothId: castToType<int>(data['booth_id']),
        point: castToType<int>(data['point']),
      );

  static BoothsDataStruct? maybeFromMap(dynamic data) => data is Map
      ? BoothsDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'booth_id': _boothId,
        'point': _point,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'booth_id': serializeParam(
          _boothId,
          ParamType.int,
        ),
        'point': serializeParam(
          _point,
          ParamType.int,
        ),
      }.withoutNulls;

  static BoothsDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      BoothsDataStruct(
        boothId: deserializeParam(
          data['booth_id'],
          ParamType.int,
          false,
        ),
        point: deserializeParam(
          data['point'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'BoothsDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BoothsDataStruct &&
        boothId == other.boothId &&
        point == other.point;
  }

  @override
  int get hashCode => const ListEquality().hash([boothId, point]);
}

BoothsDataStruct createBoothsDataStruct({
  int? boothId,
  int? point,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    BoothsDataStruct(
      boothId: boothId,
      point: point,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

BoothsDataStruct? updateBoothsDataStruct(
  BoothsDataStruct? boothsData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    boothsData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addBoothsDataStructData(
  Map<String, dynamic> firestoreData,
  BoothsDataStruct? boothsData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (boothsData == null) {
    return;
  }
  if (boothsData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && boothsData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final boothsDataData = getBoothsDataFirestoreData(boothsData, forFieldValue);
  final nestedData = boothsDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = boothsData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getBoothsDataFirestoreData(
  BoothsDataStruct? boothsData, [
  bool forFieldValue = false,
]) {
  if (boothsData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(boothsData.toMap());

  // Add any Firestore field values
  mapToFirestore(boothsData.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getBoothsDataListFirestoreData(
  List<BoothsDataStruct>? boothsDatas,
) =>
    boothsDatas?.map((e) => getBoothsDataFirestoreData(e, true)).toList() ?? [];
