// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class SurveyDataModelStruct extends FFFirebaseStruct {
  SurveyDataModelStruct({
    int? surveyId,
    String? uid,
    int? eventId,
    int? boothId,
    int? rating,
    String? feedback,
    DateTime? createdAt,
    String? createdBy,
    int? isActive,
    DateTime? updatedAt,
    String? updatedBy,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _surveyId = surveyId,
        _uid = uid,
        _eventId = eventId,
        _boothId = boothId,
        _rating = rating,
        _feedback = feedback,
        _createdAt = createdAt,
        _createdBy = createdBy,
        _isActive = isActive,
        _updatedAt = updatedAt,
        _updatedBy = updatedBy,
        super(firestoreUtilData);

  // "survey_id" field.
  int? _surveyId;
  int get surveyId => _surveyId ?? 0;
  set surveyId(int? val) => _surveyId = val;

  void incrementSurveyId(int amount) => surveyId = surveyId + amount;

  bool hasSurveyId() => _surveyId != null;

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

  // "booth_id" field.
  int? _boothId;
  int get boothId => _boothId ?? 0;
  set boothId(int? val) => _boothId = val;

  void incrementBoothId(int amount) => boothId = boothId + amount;

  bool hasBoothId() => _boothId != null;

  // "rating" field.
  int? _rating;
  int get rating => _rating ?? 0;
  set rating(int? val) => _rating = val;

  void incrementRating(int amount) => rating = rating + amount;

  bool hasRating() => _rating != null;

  // "feedback" field.
  String? _feedback;
  String get feedback => _feedback ?? '';
  set feedback(String? val) => _feedback = val;

  bool hasFeedback() => _feedback != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  set createdBy(String? val) => _createdBy = val;

  bool hasCreatedBy() => _createdBy != null;

  // "is_active" field.
  int? _isActive;
  int get isActive => _isActive ?? 0;
  set isActive(int? val) => _isActive = val;

  void incrementIsActive(int amount) => isActive = isActive + amount;

  bool hasIsActive() => _isActive != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  set updatedAt(DateTime? val) => _updatedAt = val;

  bool hasUpdatedAt() => _updatedAt != null;

  // "updated_by" field.
  String? _updatedBy;
  String get updatedBy => _updatedBy ?? '';
  set updatedBy(String? val) => _updatedBy = val;

  bool hasUpdatedBy() => _updatedBy != null;

  static SurveyDataModelStruct fromMap(Map<String, dynamic> data) =>
      SurveyDataModelStruct(
        surveyId: castToType<int>(data['survey_id']),
        uid: data['uid'] as String?,
        eventId: castToType<int>(data['event_id']),
        boothId: castToType<int>(data['booth_id']),
        rating: castToType<int>(data['rating']),
        feedback: data['feedback'] as String?,
        createdAt: data['created_at'] as DateTime?,
        createdBy: data['created_by'] as String?,
        isActive: castToType<int>(data['is_active']),
        updatedAt: data['updated_at'] as DateTime?,
        updatedBy: data['updated_by'] as String?,
      );

  static SurveyDataModelStruct? maybeFromMap(dynamic data) => data is Map
      ? SurveyDataModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'survey_id': _surveyId,
        'uid': _uid,
        'event_id': _eventId,
        'booth_id': _boothId,
        'rating': _rating,
        'feedback': _feedback,
        'created_at': _createdAt,
        'created_by': _createdBy,
        'is_active': _isActive,
        'updated_at': _updatedAt,
        'updated_by': _updatedBy,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'survey_id': serializeParam(
          _surveyId,
          ParamType.int,
        ),
        'uid': serializeParam(
          _uid,
          ParamType.String,
        ),
        'event_id': serializeParam(
          _eventId,
          ParamType.int,
        ),
        'booth_id': serializeParam(
          _boothId,
          ParamType.int,
        ),
        'rating': serializeParam(
          _rating,
          ParamType.int,
        ),
        'feedback': serializeParam(
          _feedback,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
        'created_by': serializeParam(
          _createdBy,
          ParamType.String,
        ),
        'is_active': serializeParam(
          _isActive,
          ParamType.int,
        ),
        'updated_at': serializeParam(
          _updatedAt,
          ParamType.DateTime,
        ),
        'updated_by': serializeParam(
          _updatedBy,
          ParamType.String,
        ),
      }.withoutNulls;

  static SurveyDataModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      SurveyDataModelStruct(
        surveyId: deserializeParam(
          data['survey_id'],
          ParamType.int,
          false,
        ),
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
        boothId: deserializeParam(
          data['booth_id'],
          ParamType.int,
          false,
        ),
        rating: deserializeParam(
          data['rating'],
          ParamType.int,
          false,
        ),
        feedback: deserializeParam(
          data['feedback'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.DateTime,
          false,
        ),
        createdBy: deserializeParam(
          data['created_by'],
          ParamType.String,
          false,
        ),
        isActive: deserializeParam(
          data['is_active'],
          ParamType.int,
          false,
        ),
        updatedAt: deserializeParam(
          data['updated_at'],
          ParamType.DateTime,
          false,
        ),
        updatedBy: deserializeParam(
          data['updated_by'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SurveyDataModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SurveyDataModelStruct &&
        surveyId == other.surveyId &&
        uid == other.uid &&
        eventId == other.eventId &&
        boothId == other.boothId &&
        rating == other.rating &&
        feedback == other.feedback &&
        createdAt == other.createdAt &&
        createdBy == other.createdBy &&
        isActive == other.isActive &&
        updatedAt == other.updatedAt &&
        updatedBy == other.updatedBy;
  }

  @override
  int get hashCode => const ListEquality().hash([
        surveyId,
        uid,
        eventId,
        boothId,
        rating,
        feedback,
        createdAt,
        createdBy,
        isActive,
        updatedAt,
        updatedBy
      ]);
}

SurveyDataModelStruct createSurveyDataModelStruct({
  int? surveyId,
  String? uid,
  int? eventId,
  int? boothId,
  int? rating,
  String? feedback,
  DateTime? createdAt,
  String? createdBy,
  int? isActive,
  DateTime? updatedAt,
  String? updatedBy,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SurveyDataModelStruct(
      surveyId: surveyId,
      uid: uid,
      eventId: eventId,
      boothId: boothId,
      rating: rating,
      feedback: feedback,
      createdAt: createdAt,
      createdBy: createdBy,
      isActive: isActive,
      updatedAt: updatedAt,
      updatedBy: updatedBy,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SurveyDataModelStruct? updateSurveyDataModelStruct(
  SurveyDataModelStruct? surveyDataModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    surveyDataModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSurveyDataModelStructData(
  Map<String, dynamic> firestoreData,
  SurveyDataModelStruct? surveyDataModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (surveyDataModel == null) {
    return;
  }
  if (surveyDataModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && surveyDataModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final surveyDataModelData =
      getSurveyDataModelFirestoreData(surveyDataModel, forFieldValue);
  final nestedData =
      surveyDataModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = surveyDataModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSurveyDataModelFirestoreData(
  SurveyDataModelStruct? surveyDataModel, [
  bool forFieldValue = false,
]) {
  if (surveyDataModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(surveyDataModel.toMap());

  // Add any Firestore field values
  mapToFirestore(surveyDataModel.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSurveyDataModelListFirestoreData(
  List<SurveyDataModelStruct>? surveyDataModels,
) =>
    surveyDataModels
        ?.map((e) => getSurveyDataModelFirestoreData(e, true))
        .toList() ??
    [];
