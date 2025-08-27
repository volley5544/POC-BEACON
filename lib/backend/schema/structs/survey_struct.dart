// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SurveyStruct extends FFFirebaseStruct {
  SurveyStruct({
    String? uid,
    int? eventId,
    String? comment,
    List<BoothsDataStruct>? boothsData,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _uid = uid,
        _eventId = eventId,
        _comment = comment,
        _boothsData = boothsData,
        super(firestoreUtilData);

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  set uid(String? val) => _uid = val;

  bool hasUid() => _uid != null;

  // "event_id" field.
  int? _eventId;
  int get eventId => _eventId ?? 0;
  set eventId(int? val) => _eventId = val;

  void incrementEventId(int amount) => eventId = eventId + amount;

  bool hasEventId() => _eventId != null;

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  set comment(String? val) => _comment = val;

  bool hasComment() => _comment != null;

  // "booths_data" field.
  List<BoothsDataStruct>? _boothsData;
  List<BoothsDataStruct> get boothsData => _boothsData ?? const [];
  set boothsData(List<BoothsDataStruct>? val) => _boothsData = val;

  void updateBoothsData(Function(List<BoothsDataStruct>) updateFn) {
    updateFn(_boothsData ??= []);
  }

  bool hasBoothsData() => _boothsData != null;

  static SurveyStruct fromMap(Map<String, dynamic> data) => SurveyStruct(
        uid: data['uid'] as String?,
        eventId: castToType<int>(data['event_id']),
        comment: data['comment'] as String?,
        boothsData: getStructList(
          data['booths_data'],
          BoothsDataStruct.fromMap,
        ),
      );

  static SurveyStruct? maybeFromMap(dynamic data) =>
      data is Map ? SurveyStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'uid': _uid,
        'event_id': _eventId,
        'comment': _comment,
        'booths_data': _boothsData?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'uid': serializeParam(
          _uid,
          ParamType.String,
        ),
        'event_id': serializeParam(
          _eventId,
          ParamType.int,
        ),
        'comment': serializeParam(
          _comment,
          ParamType.String,
        ),
        'booths_data': serializeParam(
          _boothsData,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static SurveyStruct fromSerializableMap(Map<String, dynamic> data) =>
      SurveyStruct(
        uid: deserializeParam(
          data['uid'],
          ParamType.String,
          false,
        ),
        eventId: deserializeParam(
          data['event_id'],
          ParamType.int,
          false,
        ),
        comment: deserializeParam(
          data['comment'],
          ParamType.String,
          false,
        ),
        boothsData: deserializeStructParam<BoothsDataStruct>(
          data['booths_data'],
          ParamType.DataStruct,
          true,
          structBuilder: BoothsDataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'SurveyStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SurveyStruct &&
        uid == other.uid &&
        eventId == other.eventId &&
        comment == other.comment &&
        listEquality.equals(boothsData, other.boothsData);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([uid, eventId, comment, boothsData]);
}

SurveyStruct createSurveyStruct({
  String? uid,
  int? eventId,
  String? comment,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SurveyStruct(
      uid: uid,
      eventId: eventId,
      comment: comment,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SurveyStruct? updateSurveyStruct(
  SurveyStruct? survey, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    survey
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSurveyStructData(
  Map<String, dynamic> firestoreData,
  SurveyStruct? survey,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (survey == null) {
    return;
  }
  if (survey.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && survey.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final surveyData = getSurveyFirestoreData(survey, forFieldValue);
  final nestedData = surveyData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = survey.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSurveyFirestoreData(
  SurveyStruct? survey, [
  bool forFieldValue = false,
]) {
  if (survey == null) {
    return {};
  }
  final firestoreData = mapToFirestore(survey.toMap());

  // Add any Firestore field values
  survey.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSurveyListFirestoreData(
  List<SurveyStruct>? surveys,
) =>
    surveys?.map((e) => getSurveyFirestoreData(e, true)).toList() ?? [];
