// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PaticipantsBoothDataModelStruct extends FFFirebaseStruct {
  PaticipantsBoothDataModelStruct({
    int? eventId,
    String? eventName,
    List<BoothsStruct>? booths,
    List<DataListStruct>? dataList,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _eventId = eventId,
        _eventName = eventName,
        _booths = booths,
        _dataList = dataList,
        super(firestoreUtilData);

  // "event_id" field.
  int? _eventId;
  int get eventId => _eventId ?? 0;
  set eventId(int? val) => _eventId = val;

  void incrementEventId(int amount) => eventId = eventId + amount;

  bool hasEventId() => _eventId != null;

  // "event_name" field.
  String? _eventName;
  String get eventName => _eventName ?? '';
  set eventName(String? val) => _eventName = val;

  bool hasEventName() => _eventName != null;

  // "booths" field.
  List<BoothsStruct>? _booths;
  List<BoothsStruct> get booths => _booths ?? const [];
  set booths(List<BoothsStruct>? val) => _booths = val;

  void updateBooths(Function(List<BoothsStruct>) updateFn) {
    updateFn(_booths ??= []);
  }

  bool hasBooths() => _booths != null;

  // "data_list" field.
  List<DataListStruct>? _dataList;
  List<DataListStruct> get dataList => _dataList ?? const [];
  set dataList(List<DataListStruct>? val) => _dataList = val;

  void updateDataList(Function(List<DataListStruct>) updateFn) {
    updateFn(_dataList ??= []);
  }

  bool hasDataList() => _dataList != null;

  static PaticipantsBoothDataModelStruct fromMap(Map<String, dynamic> data) =>
      PaticipantsBoothDataModelStruct(
        eventId: castToType<int>(data['event_id']),
        eventName: data['event_name'] as String?,
        booths: getStructList(
          data['booths'],
          BoothsStruct.fromMap,
        ),
        dataList: getStructList(
          data['data_list'],
          DataListStruct.fromMap,
        ),
      );

  static PaticipantsBoothDataModelStruct? maybeFromMap(dynamic data) => data
          is Map
      ? PaticipantsBoothDataModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'event_id': _eventId,
        'event_name': _eventName,
        'booths': _booths?.map((e) => e.toMap()).toList(),
        'data_list': _dataList?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'event_id': serializeParam(
          _eventId,
          ParamType.int,
        ),
        'event_name': serializeParam(
          _eventName,
          ParamType.String,
        ),
        'booths': serializeParam(
          _booths,
          ParamType.DataStruct,
          isList: true,
        ),
        'data_list': serializeParam(
          _dataList,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static PaticipantsBoothDataModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PaticipantsBoothDataModelStruct(
        eventId: deserializeParam(
          data['event_id'],
          ParamType.int,
          false,
        ),
        eventName: deserializeParam(
          data['event_name'],
          ParamType.String,
          false,
        ),
        booths: deserializeStructParam<BoothsStruct>(
          data['booths'],
          ParamType.DataStruct,
          true,
          structBuilder: BoothsStruct.fromSerializableMap,
        ),
        dataList: deserializeStructParam<DataListStruct>(
          data['data_list'],
          ParamType.DataStruct,
          true,
          structBuilder: DataListStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'PaticipantsBoothDataModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PaticipantsBoothDataModelStruct &&
        eventId == other.eventId &&
        eventName == other.eventName &&
        listEquality.equals(booths, other.booths) &&
        listEquality.equals(dataList, other.dataList);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([eventId, eventName, booths, dataList]);
}

PaticipantsBoothDataModelStruct createPaticipantsBoothDataModelStruct({
  int? eventId,
  String? eventName,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PaticipantsBoothDataModelStruct(
      eventId: eventId,
      eventName: eventName,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PaticipantsBoothDataModelStruct? updatePaticipantsBoothDataModelStruct(
  PaticipantsBoothDataModelStruct? paticipantsBoothDataModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    paticipantsBoothDataModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPaticipantsBoothDataModelStructData(
  Map<String, dynamic> firestoreData,
  PaticipantsBoothDataModelStruct? paticipantsBoothDataModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (paticipantsBoothDataModel == null) {
    return;
  }
  if (paticipantsBoothDataModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      paticipantsBoothDataModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final paticipantsBoothDataModelData =
      getPaticipantsBoothDataModelFirestoreData(
          paticipantsBoothDataModel, forFieldValue);
  final nestedData =
      paticipantsBoothDataModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      paticipantsBoothDataModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPaticipantsBoothDataModelFirestoreData(
  PaticipantsBoothDataModelStruct? paticipantsBoothDataModel, [
  bool forFieldValue = false,
]) {
  if (paticipantsBoothDataModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(paticipantsBoothDataModel.toMap());

  // Add any Firestore field values
  paticipantsBoothDataModel.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPaticipantsBoothDataModelListFirestoreData(
  List<PaticipantsBoothDataModelStruct>? paticipantsBoothDataModels,
) =>
    paticipantsBoothDataModels
        ?.map((e) => getPaticipantsBoothDataModelFirestoreData(e, true))
        .toList() ??
    [];
