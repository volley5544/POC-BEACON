// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class BeaconDataModelStruct extends FFFirebaseStruct {
  BeaconDataModelStruct({
    String? beaconId,
    String? beaconName,
    String? distance,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _beaconId = beaconId,
        _beaconName = beaconName,
        _distance = distance,
        super(firestoreUtilData);

  // "beaconId" field.
  String? _beaconId;
  String get beaconId => _beaconId ?? '';
  set beaconId(String? val) => _beaconId = val;

  bool hasBeaconId() => _beaconId != null;

  // "beaconName" field.
  String? _beaconName;
  String get beaconName => _beaconName ?? '';
  set beaconName(String? val) => _beaconName = val;

  bool hasBeaconName() => _beaconName != null;

  // "distance" field.
  String? _distance;
  String get distance => _distance ?? '';
  set distance(String? val) => _distance = val;

  bool hasDistance() => _distance != null;

  static BeaconDataModelStruct fromMap(Map<String, dynamic> data) =>
      BeaconDataModelStruct(
        beaconId: data['beaconId'] as String?,
        beaconName: data['beaconName'] as String?,
        distance: data['distance'] as String?,
      );

  static BeaconDataModelStruct? maybeFromMap(dynamic data) => data is Map
      ? BeaconDataModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'beaconId': _beaconId,
        'beaconName': _beaconName,
        'distance': _distance,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'beaconId': serializeParam(
          _beaconId,
          ParamType.String,
        ),
        'beaconName': serializeParam(
          _beaconName,
          ParamType.String,
        ),
        'distance': serializeParam(
          _distance,
          ParamType.String,
        ),
      }.withoutNulls;

  static BeaconDataModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      BeaconDataModelStruct(
        beaconId: deserializeParam(
          data['beaconId'],
          ParamType.String,
          false,
        ),
        beaconName: deserializeParam(
          data['beaconName'],
          ParamType.String,
          false,
        ),
        distance: deserializeParam(
          data['distance'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'BeaconDataModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BeaconDataModelStruct &&
        beaconId == other.beaconId &&
        beaconName == other.beaconName &&
        distance == other.distance;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([beaconId, beaconName, distance]);
}

BeaconDataModelStruct createBeaconDataModelStruct({
  String? beaconId,
  String? beaconName,
  String? distance,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    BeaconDataModelStruct(
      beaconId: beaconId,
      beaconName: beaconName,
      distance: distance,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

BeaconDataModelStruct? updateBeaconDataModelStruct(
  BeaconDataModelStruct? beaconDataModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    beaconDataModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addBeaconDataModelStructData(
  Map<String, dynamic> firestoreData,
  BeaconDataModelStruct? beaconDataModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (beaconDataModel == null) {
    return;
  }
  if (beaconDataModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && beaconDataModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final beaconDataModelData =
      getBeaconDataModelFirestoreData(beaconDataModel, forFieldValue);
  final nestedData =
      beaconDataModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = beaconDataModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getBeaconDataModelFirestoreData(
  BeaconDataModelStruct? beaconDataModel, [
  bool forFieldValue = false,
]) {
  if (beaconDataModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(beaconDataModel.toMap());

  // Add any Firestore field values
  mapToFirestore(beaconDataModel.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getBeaconDataModelListFirestoreData(
  List<BeaconDataModelStruct>? beaconDataModels,
) =>
    beaconDataModels
        ?.map((e) => getBeaconDataModelFirestoreData(e, true))
        .toList() ??
    [];
