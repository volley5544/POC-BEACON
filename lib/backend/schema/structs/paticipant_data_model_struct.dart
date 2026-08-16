// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class PaticipantDataModelStruct extends FFFirebaseStruct {
  PaticipantDataModelStruct({
    int? count,
    String? boothName,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _count = count,
        _boothName = boothName,
        super(firestoreUtilData);

  // "count" field.
  int? _count;
  int get count => _count ?? 0;
  set count(int? val) => _count = val;

  void incrementCount(int amount) => count = count + amount;

  bool hasCount() => _count != null;

  // "boothName" field.
  String? _boothName;
  String get boothName => _boothName ?? '';
  set boothName(String? val) => _boothName = val;

  bool hasBoothName() => _boothName != null;

  static PaticipantDataModelStruct fromMap(Map<String, dynamic> data) =>
      PaticipantDataModelStruct(
        count: castToType<int>(data['count']),
        boothName: data['boothName'] as String?,
      );

  static PaticipantDataModelStruct? maybeFromMap(dynamic data) => data is Map
      ? PaticipantDataModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'count': _count,
        'boothName': _boothName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'count': serializeParam(
          _count,
          ParamType.int,
        ),
        'boothName': serializeParam(
          _boothName,
          ParamType.String,
        ),
      }.withoutNulls;

  static PaticipantDataModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PaticipantDataModelStruct(
        count: deserializeParam(
          data['count'],
          ParamType.int,
          false,
        ),
        boothName: deserializeParam(
          data['boothName'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PaticipantDataModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PaticipantDataModelStruct &&
        count == other.count &&
        boothName == other.boothName;
  }

  @override
  int get hashCode => const ListEquality().hash([count, boothName]);
}

PaticipantDataModelStruct createPaticipantDataModelStruct({
  int? count,
  String? boothName,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PaticipantDataModelStruct(
      count: count,
      boothName: boothName,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PaticipantDataModelStruct? updatePaticipantDataModelStruct(
  PaticipantDataModelStruct? paticipantDataModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    paticipantDataModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPaticipantDataModelStructData(
  Map<String, dynamic> firestoreData,
  PaticipantDataModelStruct? paticipantDataModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (paticipantDataModel == null) {
    return;
  }
  if (paticipantDataModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && paticipantDataModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final paticipantDataModelData =
      getPaticipantDataModelFirestoreData(paticipantDataModel, forFieldValue);
  final nestedData =
      paticipantDataModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      paticipantDataModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPaticipantDataModelFirestoreData(
  PaticipantDataModelStruct? paticipantDataModel, [
  bool forFieldValue = false,
]) {
  if (paticipantDataModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(paticipantDataModel.toMap());

  // Add any Firestore field values
  mapToFirestore(paticipantDataModel.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPaticipantDataModelListFirestoreData(
  List<PaticipantDataModelStruct>? paticipantDataModels,
) =>
    paticipantDataModels
        ?.map((e) => getPaticipantDataModelFirestoreData(e, true))
        .toList() ??
    [];
