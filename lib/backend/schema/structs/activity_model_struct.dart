// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ActivityModelStruct extends FFFirebaseStruct {
  ActivityModelStruct({
    int? boothId,
    List<ActivityModelStruct>? boothName,
    List<ActivityModelStruct>? totalParticipants,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _boothId = boothId,
        _boothName = boothName,
        _totalParticipants = totalParticipants,
        super(firestoreUtilData);

  // "booth_id" field.
  int? _boothId;
  int get boothId => _boothId ?? 0;
  set boothId(int? val) => _boothId = val;

  void incrementBoothId(int amount) => boothId = boothId + amount;

  bool hasBoothId() => _boothId != null;

  // "booth_name" field.
  List<ActivityModelStruct>? _boothName;
  List<ActivityModelStruct> get boothName => _boothName ?? const [];
  set boothName(List<ActivityModelStruct>? val) => _boothName = val;

  void updateBoothName(Function(List<ActivityModelStruct>) updateFn) {
    updateFn(_boothName ??= []);
  }

  bool hasBoothName() => _boothName != null;

  // "total_participants" field.
  List<ActivityModelStruct>? _totalParticipants;
  List<ActivityModelStruct> get totalParticipants =>
      _totalParticipants ?? const [];
  set totalParticipants(List<ActivityModelStruct>? val) =>
      _totalParticipants = val;

  void updateTotalParticipants(Function(List<ActivityModelStruct>) updateFn) {
    updateFn(_totalParticipants ??= []);
  }

  bool hasTotalParticipants() => _totalParticipants != null;

  static ActivityModelStruct fromMap(Map<String, dynamic> data) =>
      ActivityModelStruct(
        boothId: castToType<int>(data['booth_id']),
        boothName: getStructList(
          data['booth_name'],
          ActivityModelStruct.fromMap,
        ),
        totalParticipants: getStructList(
          data['total_participants'],
          ActivityModelStruct.fromMap,
        ),
      );

  static ActivityModelStruct? maybeFromMap(dynamic data) => data is Map
      ? ActivityModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'booth_id': _boothId,
        'booth_name': _boothName?.map((e) => e.toMap()).toList(),
        'total_participants':
            _totalParticipants?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'booth_id': serializeParam(
          _boothId,
          ParamType.int,
        ),
        'booth_name': serializeParam(
          _boothName,
          ParamType.DataStruct,
          isList: true,
        ),
        'total_participants': serializeParam(
          _totalParticipants,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static ActivityModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      ActivityModelStruct(
        boothId: deserializeParam(
          data['booth_id'],
          ParamType.int,
          false,
        ),
        boothName: deserializeStructParam<ActivityModelStruct>(
          data['booth_name'],
          ParamType.DataStruct,
          true,
          structBuilder: ActivityModelStruct.fromSerializableMap,
        ),
        totalParticipants: deserializeStructParam<ActivityModelStruct>(
          data['total_participants'],
          ParamType.DataStruct,
          true,
          structBuilder: ActivityModelStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ActivityModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ActivityModelStruct &&
        boothId == other.boothId &&
        listEquality.equals(boothName, other.boothName) &&
        listEquality.equals(totalParticipants, other.totalParticipants);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([boothId, boothName, totalParticipants]);
}

ActivityModelStruct createActivityModelStruct({
  int? boothId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ActivityModelStruct(
      boothId: boothId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ActivityModelStruct? updateActivityModelStruct(
  ActivityModelStruct? activityModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    activityModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addActivityModelStructData(
  Map<String, dynamic> firestoreData,
  ActivityModelStruct? activityModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (activityModel == null) {
    return;
  }
  if (activityModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && activityModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final activityModelData =
      getActivityModelFirestoreData(activityModel, forFieldValue);
  final nestedData =
      activityModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = activityModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getActivityModelFirestoreData(
  ActivityModelStruct? activityModel, [
  bool forFieldValue = false,
]) {
  if (activityModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(activityModel.toMap());

  // Add any Firestore field values
  activityModel.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getActivityModelListFirestoreData(
  List<ActivityModelStruct>? activityModels,
) =>
    activityModels
        ?.map((e) => getActivityModelFirestoreData(e, true))
        .toList() ??
    [];
