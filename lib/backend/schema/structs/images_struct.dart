// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ImagesStruct extends FFFirebaseStruct {
  ImagesStruct({
    String? id,
    String? fileName,
    String? fileUrl,
    String? fileType,
    int? seq,
    bool? isCover,
    int? isActive,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _fileName = fileName,
        _fileUrl = fileUrl,
        _fileType = fileType,
        _seq = seq,
        _isCover = isCover,
        _isActive = isActive,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "file_name" field.
  String? _fileName;
  String get fileName => _fileName ?? '';
  set fileName(String? val) => _fileName = val;

  bool hasFileName() => _fileName != null;

  // "file_url" field.
  String? _fileUrl;
  String get fileUrl => _fileUrl ?? '';
  set fileUrl(String? val) => _fileUrl = val;

  bool hasFileUrl() => _fileUrl != null;

  // "file_type" field.
  String? _fileType;
  String get fileType => _fileType ?? '';
  set fileType(String? val) => _fileType = val;

  bool hasFileType() => _fileType != null;

  // "seq" field.
  int? _seq;
  int get seq => _seq ?? 0;
  set seq(int? val) => _seq = val;

  void incrementSeq(int amount) => seq = seq + amount;

  bool hasSeq() => _seq != null;

  // "is_cover" field.
  bool? _isCover;
  bool get isCover => _isCover ?? false;
  set isCover(bool? val) => _isCover = val;

  bool hasIsCover() => _isCover != null;

  // "is_active" field.
  int? _isActive;
  int get isActive => _isActive ?? 0;
  set isActive(int? val) => _isActive = val;

  void incrementIsActive(int amount) => isActive = isActive + amount;

  bool hasIsActive() => _isActive != null;

  static ImagesStruct fromMap(Map<String, dynamic> data) => ImagesStruct(
        id: data['id'] as String?,
        fileName: data['file_name'] as String?,
        fileUrl: data['file_url'] as String?,
        fileType: data['file_type'] as String?,
        seq: castToType<int>(data['seq']),
        isCover: data['is_cover'] as bool?,
        isActive: castToType<int>(data['is_active']),
      );

  static ImagesStruct? maybeFromMap(dynamic data) =>
      data is Map ? ImagesStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'file_name': _fileName,
        'file_url': _fileUrl,
        'file_type': _fileType,
        'seq': _seq,
        'is_cover': _isCover,
        'is_active': _isActive,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'file_name': serializeParam(
          _fileName,
          ParamType.String,
        ),
        'file_url': serializeParam(
          _fileUrl,
          ParamType.String,
        ),
        'file_type': serializeParam(
          _fileType,
          ParamType.String,
        ),
        'seq': serializeParam(
          _seq,
          ParamType.int,
        ),
        'is_cover': serializeParam(
          _isCover,
          ParamType.bool,
        ),
        'is_active': serializeParam(
          _isActive,
          ParamType.int,
        ),
      }.withoutNulls;

  static ImagesStruct fromSerializableMap(Map<String, dynamic> data) =>
      ImagesStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        fileName: deserializeParam(
          data['file_name'],
          ParamType.String,
          false,
        ),
        fileUrl: deserializeParam(
          data['file_url'],
          ParamType.String,
          false,
        ),
        fileType: deserializeParam(
          data['file_type'],
          ParamType.String,
          false,
        ),
        seq: deserializeParam(
          data['seq'],
          ParamType.int,
          false,
        ),
        isCover: deserializeParam(
          data['is_cover'],
          ParamType.bool,
          false,
        ),
        isActive: deserializeParam(
          data['is_active'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'ImagesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ImagesStruct &&
        id == other.id &&
        fileName == other.fileName &&
        fileUrl == other.fileUrl &&
        fileType == other.fileType &&
        seq == other.seq &&
        isCover == other.isCover &&
        isActive == other.isActive;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, fileName, fileUrl, fileType, seq, isCover, isActive]);
}

ImagesStruct createImagesStruct({
  String? id,
  String? fileName,
  String? fileUrl,
  String? fileType,
  int? seq,
  bool? isCover,
  int? isActive,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ImagesStruct(
      id: id,
      fileName: fileName,
      fileUrl: fileUrl,
      fileType: fileType,
      seq: seq,
      isCover: isCover,
      isActive: isActive,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ImagesStruct? updateImagesStruct(
  ImagesStruct? images, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    images
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addImagesStructData(
  Map<String, dynamic> firestoreData,
  ImagesStruct? images,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (images == null) {
    return;
  }
  if (images.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && images.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final imagesData = getImagesFirestoreData(images, forFieldValue);
  final nestedData = imagesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = images.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getImagesFirestoreData(
  ImagesStruct? images, [
  bool forFieldValue = false,
]) {
  if (images == null) {
    return {};
  }
  final firestoreData = mapToFirestore(images.toMap());

  // Add any Firestore field values
  mapToFirestore(images.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getImagesListFirestoreData(
  List<ImagesStruct>? imagess,
) =>
    imagess?.map((e) => getImagesFirestoreData(e, true)).toList() ?? [];
