import 'dart:convert';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start RAS Group Code

class RasGroup {
  static String getBaseUrl() => 'https://2079ce79bd0a.ngrok-free.app';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer test-token-123456789',
  };
  static GetEventByIdCall getEventByIdCall = GetEventByIdCall();
  static GetAllBoothsCall getAllBoothsCall = GetAllBoothsCall();
  static SummaryParticipantsBoothCall summaryParticipantsBoothCall =
      SummaryParticipantsBoothCall();
  static ReportSurveyByBoothDetailsCall reportSurveyByBoothDetailsCall =
      ReportSurveyByBoothDetailsCall();
  static SummarizeDashboardCall summarizeDashboardCall =
      SummarizeDashboardCall();
  static SurveyGetActivityCall surveyGetActivityCall = SurveyGetActivityCall();
  static UpdateEventByIdCall updateEventByIdCall = UpdateEventByIdCall();
  static CreateEventCall createEventCall = CreateEventCall();
  static UpdateBoothsCall updateBoothsCall = UpdateBoothsCall();
  static CreateBoothsCall createBoothsCall = CreateBoothsCall();
  static UploadFileCall uploadFileCall = UploadFileCall();
  static GetMediaFilesByRelatedCall getMediaFilesByRelatedCall =
      GetMediaFilesByRelatedCall();
  static UpdateEventCall updateEventCall = UpdateEventCall();
}

class GetEventByIdCall {
  Future<ApiCallResponse> call({
    String? authToken = 'test-token-123456789',
    String? docRef = '220bb192-0cc0-4180-b1bc-9e6ba3261e50',
  }) async {
    final baseUrl = RasGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getEventById',
      apiUrl: '${baseUrl}/events/event',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer test-token-123456789',
      },
      params: {
        'doc_ref': "220bb192-0cc0-4180-b1bc-9e6ba3261e50",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetAllBoothsCall {
  Future<ApiCallResponse> call({
    String? authToken = 'test-token-123456789',
    String? eventRef = '10b6e505-bba3-4079-bc7f-24cf07cb0ecf',
  }) async {
    final baseUrl = RasGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "event_ref": "${escapeStringForJson(eventRef)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getAllBooths',
      apiUrl: '${baseUrl}/booths',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer test-token-123456789',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status_code''',
      ));
  String? statusMessage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.status_message''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.description''',
      ));
  List<BoothDataModelStruct>? data(dynamic response) => (getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => BoothDataModelStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
  List<String>? boothDocRef(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? boothId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].booth_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? boothName(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].booth_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? boothDescription(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? notificationDistance(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].notification_distance''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List? associateEeventId(dynamic response) => getJsonField(
        response,
        r'''$.data[:].associated_event_id''',
        true,
      ) as List?;
  List<String>? createdAt(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].created_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? createdBy(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].created_by''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? isActive(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_active''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? updatedAt(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].updated_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? eventId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? updatedBy(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].updated_by''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? imagesObject(dynamic response) => getJsonField(
        response,
        r'''$.data[:].images''',
        true,
      ) as List?;
  String? imagesId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].id''',
      ));
  List<String>? imagesStatus(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  String? imagesFilename(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].file_name''',
      ));
  String? imagesFileurl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].file_url''',
      ));
  String? imagesFiletype(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].file_type''',
      ));
  int? imagesSeq(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].images[:].seq''',
      ));
  bool? imagesIsCover(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data[:].images[:].is_cover''',
      ));
  int? imagesIsActive(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].images[:].is_active''',
      ));
}

class SummaryParticipantsBoothCall {
  Future<ApiCallResponse> call({
    String? authToken = 'test-token-123456789',
    String? eventRef = 'YWMyuNxPlLwB7prVc920',
  }) async {
    final baseUrl = RasGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "event_ref": "${escapeStringForJson(eventRef)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'summaryParticipantsBooth',
      apiUrl: '${baseUrl}/activities/summary-participants-booth',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer test-token-123456789',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status_code''',
      ));
  String? statusMessage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.status_message''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.description''',
      ));
  PaticipantsBoothDataModelStruct? data(dynamic response) =>
      PaticipantsBoothDataModelStruct.maybeFromMap(getJsonField(
        response,
        r'''$.data''',
      ));
  List<String>? boothDocRef(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? boothId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].booth_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? boothName(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].booth_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? boothDescription(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? notificationDistance(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].notification_distance''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List? associateEeventId(dynamic response) => getJsonField(
        response,
        r'''$.data[:].associated_event_id''',
        true,
      ) as List?;
  List<String>? createdAt(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].created_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? createdBy(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].created_by''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? isActive(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_active''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? updatedAt(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].updated_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? eventId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? updatedBy(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].updated_by''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? imagesObject(dynamic response) => getJsonField(
        response,
        r'''$.data[:].images''',
        true,
      ) as List?;
  String? imagesId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].id''',
      ));
  List<String>? imagesStatus(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  String? imagesFilename(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].file_name''',
      ));
  String? imagesFileurl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].file_url''',
      ));
  String? imagesFiletype(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].file_type''',
      ));
  int? imagesSeq(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].images[:].seq''',
      ));
  bool? imagesIsCover(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data[:].images[:].is_cover''',
      ));
  int? imagesIsActive(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].images[:].is_active''',
      ));
  List? sumBoothArr(dynamic response) => getJsonField(
        response,
        r'''$.data.booths''',
        true,
      ) as List?;
  List<int>? sumBoothId(dynamic response) => (getJsonField(
        response,
        r'''$.data.booths[:].booth_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? sumBoothName(dynamic response) => (getJsonField(
        response,
        r'''$.data.booths[:].booth_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? sumPerson(dynamic response) => (getJsonField(
        response,
        r'''$.data.booths[:].total_participants''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? boothidlist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].booth_id_list''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List? datalist(dynamic response) => getJsonField(
        response,
        r'''$.data.data_list''',
        true,
      ) as List?;
  List<String>? boothnamelist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].booth_name_list''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? colorslist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].colors''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? seqlist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].index_seq''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? totalparticipantslist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].total_participants_list''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class ReportSurveyByBoothDetailsCall {
  Future<ApiCallResponse> call({
    String? authToken = 'test-token-123456789',
    String? eventRef = 'YWMyuNxPlLwB7prVc920',
  }) async {
    final baseUrl = RasGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "event_ref": "${escapeStringForJson(eventRef)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'reportSurveyByBoothDetails',
      apiUrl: '${baseUrl}/survey/booths/details',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer test-token-123456789',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status_code''',
      ));
  String? statusMessage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.status_message''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.description''',
      ));
  PaticipantsBoothDataModelStruct? data(dynamic response) =>
      PaticipantsBoothDataModelStruct.maybeFromMap(getJsonField(
        response,
        r'''$.data''',
      ));
  List<String>? boothDocRef(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? boothId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].booth_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? boothName(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].booth_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? boothDescription(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? notificationDistance(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].notification_distance''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List? associateEeventId(dynamic response) => getJsonField(
        response,
        r'''$.data[:].associated_event_id''',
        true,
      ) as List?;
  List<String>? createdAt(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].created_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? createdBy(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].created_by''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? isActive(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_active''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? updatedAt(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].updated_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? eventId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? updatedBy(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].updated_by''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? imagesObject(dynamic response) => getJsonField(
        response,
        r'''$.data[:].images''',
        true,
      ) as List?;
  String? imagesId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].id''',
      ));
  List<String>? imagesStatus(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  String? imagesFilename(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].file_name''',
      ));
  String? imagesFileurl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].file_url''',
      ));
  String? imagesFiletype(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].file_type''',
      ));
  int? imagesSeq(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].images[:].seq''',
      ));
  bool? imagesIsCover(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data[:].images[:].is_cover''',
      ));
  int? imagesIsActive(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].images[:].is_active''',
      ));
  List? sumBoothArr(dynamic response) => getJsonField(
        response,
        r'''$.data.booths''',
        true,
      ) as List?;
  List<int>? sumBoothId(dynamic response) => (getJsonField(
        response,
        r'''$.data.booths[:].booth_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? sumBoothName(dynamic response) => (getJsonField(
        response,
        r'''$.data.booths[:].booth_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? sumPerson(dynamic response) => (getJsonField(
        response,
        r'''$.data.booths[:].total_participants''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? boothidlist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].booth_id_list''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List? datalist(dynamic response) => getJsonField(
        response,
        r'''$.data.data_list''',
        true,
      ) as List?;
  List<String>? boothnamelist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].booth_name_list''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? colorslist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].colors''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? seqlist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].index_seq''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? totalparticipantslist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].total_participants_list''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class SummarizeDashboardCall {
  Future<ApiCallResponse> call({
    String? authToken = 'test-token-123456789',
    String? eventRef = 'YWMyuNxPlLwB7prVc920',
    String? startDatetime = '1756807778',
    String? endDatetime = '1756868400',
  }) async {
    final baseUrl = RasGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "event_ref": "${escapeStringForJson(eventRef)}",
  "start_datetime": "${escapeStringForJson(startDatetime)}",
  "end_datetime": "${escapeStringForJson(endDatetime)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'summarizeDashboard',
      apiUrl: '${baseUrl}/activities/summary-dashboard',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer test-token-123456789',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status_code''',
      ));
  String? statusMessage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.status_message''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.description''',
      ));
  PaticipantsBoothDataModelStruct? data(dynamic response) =>
      PaticipantsBoothDataModelStruct.maybeFromMap(getJsonField(
        response,
        r'''$.data''',
      ));
  List<String>? boothDocRef(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? boothId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].booth_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? boothName(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].booth_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? boothDescription(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? notificationDistance(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].notification_distance''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List? associateEeventId(dynamic response) => getJsonField(
        response,
        r'''$.data[:].associated_event_id''',
        true,
      ) as List?;
  List<String>? createdAt(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].created_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? createdBy(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].created_by''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? isActive(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_active''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? updatedAt(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].updated_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? eventId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? updatedBy(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].updated_by''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? imagesObject(dynamic response) => getJsonField(
        response,
        r'''$.data[:].images''',
        true,
      ) as List?;
  String? imagesId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].id''',
      ));
  List<String>? imagesStatus(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  String? imagesFilename(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].file_name''',
      ));
  String? imagesFileurl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].file_url''',
      ));
  String? imagesFiletype(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].file_type''',
      ));
  int? imagesSeq(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].images[:].seq''',
      ));
  bool? imagesIsCover(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data[:].images[:].is_cover''',
      ));
  int? imagesIsActive(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].images[:].is_active''',
      ));
  List? sumBoothArr(dynamic response) => getJsonField(
        response,
        r'''$.data.booths''',
        true,
      ) as List?;
  List<int>? sumBoothId(dynamic response) => (getJsonField(
        response,
        r'''$.data.booths[:].booth_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? sumBoothName(dynamic response) => (getJsonField(
        response,
        r'''$.data.booths[:].booth_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? sumPerson(dynamic response) => (getJsonField(
        response,
        r'''$.data.booths[:].total_participants''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? boothidlist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].booth_id_list''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List? datalist(dynamic response) => getJsonField(
        response,
        r'''$.data.data_list''',
        true,
      ) as List?;
  List<String>? boothnamelist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].booth_name_list''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? colorslist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].colors''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? seqlist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].index_seq''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? totalparticipantslist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].total_participants_list''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<BoothsStruct>? dashboard(dynamic response) => (getJsonField(
        response,
        r'''$.data.booths''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => BoothsStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
}

class SurveyGetActivityCall {
  Future<ApiCallResponse> call({
    String? authToken = 'test-token-123456789',
    String? eventRef = 'YWMyuNxPlLwB7prVc920',
    String? uid = 'm01gNYT1qqbOL1emlEPF4uc2b8F3',
  }) async {
    final baseUrl = RasGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "event_ref": "${escapeStringForJson(eventRef)}",
  "uid": "${escapeStringForJson(uid)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'surveyGetActivity',
      apiUrl: '${baseUrl}/activities/user',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer test-token-123456789',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status_code''',
      ));
  String? statusMessage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.status_message''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.description''',
      ));
  List<BoothDataModelStruct>? data(dynamic response) => (getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => BoothDataModelStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
  List<String>? boothDocRef(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? boothId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].booth_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? boothName(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].booth_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? boothDescription(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? notificationDistance(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].notification_distance''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List? associateEeventId(dynamic response) => getJsonField(
        response,
        r'''$.data[:].associated_event_id''',
        true,
      ) as List?;
  List<String>? createdAt(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].created_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? createdBy(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].created_by''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? isActive(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_active''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? updatedAt(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].updated_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? eventId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? updatedBy(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].updated_by''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? imagesObject(dynamic response) => getJsonField(
        response,
        r'''$.data[:].images''',
        true,
      ) as List?;
  String? imagesId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].id''',
      ));
  List<String>? imagesStatus(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  String? imagesFilename(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].file_name''',
      ));
  String? imagesFileurl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].file_url''',
      ));
  String? imagesFiletype(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].images[:].file_type''',
      ));
  int? imagesSeq(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].images[:].seq''',
      ));
  bool? imagesIsCover(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data[:].images[:].is_cover''',
      ));
  int? imagesIsActive(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].images[:].is_active''',
      ));
  List<BoothDataModelStruct>? sumBoothArr(dynamic response) => (getJsonField(
        response,
        r'''$.data.booths''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => BoothDataModelStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
  List<int>? sumBoothId(dynamic response) => (getJsonField(
        response,
        r'''$.data.booths[:].booth_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? sumBoothName(dynamic response) => (getJsonField(
        response,
        r'''$.data.booths[:].booth_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? sumPerson(dynamic response) => (getJsonField(
        response,
        r'''$.data.booths[:].total_participants''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? boothidlist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].booth_id_list''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List? datalist(dynamic response) => getJsonField(
        response,
        r'''$.data.data_list''',
        true,
      ) as List?;
  List<String>? boothnamelist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].booth_name_list''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? totalparticipantslist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].total_participants_list''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? colorslist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].colors''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? seqlist(dynamic response) => (getJsonField(
        response,
        r'''$.data.data_list[:].index_seq''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
}

class UpdateEventByIdCall {
  Future<ApiCallResponse> call({
    String? authToken = 'test-token-123456789',
    String? docRef = '220bb192-0cc0-4180-b1bc-9e6ba3261e50',
    String? eventName = 'กิจกรรมใหม่',
    String? description = 'กิจกรรมใหม่222',
    int? notificationFrequencyAmount = 1,
    int? notificationFrequencyMinute = 2,
    String? startDatetime = '2025-02-05T10:00:00Z',
    String? endDatetime = '2025-02-10T10:00:00Z',
    int? isActive = 0,
    String? updatedBy = 'users/m01gNYT1qqbOL1emlEPF4uc2b8F3',
  }) async {
    final baseUrl = RasGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "doc_ref": "c169206d-5d48-424b-a8b2-29cab964649c",
  "event_name": "กิจกรรมใหม่",
  "description": "อธิบายกิจกรรมใหม่",
  "start_datetime": "2025-02-10T10:00:00Z",
  "end_datetime": "2025-02-10T18:00:00Z",
  "updated_by": "users/m01gNYT1qqbOL1emlEPF4uc2b8F3",
  "is_active": 0,
  "notification_frequency_amount": 3,
  "notification_frequency_minute": 6
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateEventById',
      apiUrl: '${baseUrl}/events/event',
      callType: ApiCallType.PUT,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer test-token-123456789',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateEventCall {
  Future<ApiCallResponse> call({
    String? authToken = 'test-token-123456789',
    String? eventName = 'กิจกรรมใหม่',
    String? description = 'อธิบายกิจกรรมใหม่',
    String? startDatetime = '2025-02-10T10:00:00Z',
    String? endDatetime = '2025-02-10T18:00:00Z',
    int? notificationFrequencyAmount = 3,
    int? notificationFrequencyMinute = 6,
    int? isActive = 0,
    String? createdBy = 'users/m01gNYT1qqbOL1emlEPF4uc2b8F3',
    String? updatedBy = 'users/m01gNYT1qqbOL1emlEPF4uc2b8F3',
  }) async {
    final baseUrl = RasGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "event_name": "${escapeStringForJson(eventName)}",
  "description": "${escapeStringForJson(description)}",
  "start_datetime": "${escapeStringForJson(startDatetime)}",
  "end_datetime": "${escapeStringForJson(endDatetime)}",
  "created_by": "${escapeStringForJson(createdBy)}",
  "is_active": ${isActive},
  "notification_frequency_amount": ${notificationFrequencyAmount},
  "notification_frequency_minute": ${notificationFrequencyMinute}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createEvent',
      apiUrl: '${baseUrl}/events',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer test-token-123456789',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status_code''',
      ));
  String? statusMessage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.status_message''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.description''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  int? eventId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.event_id''',
      ));
  String? eventDocRef(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.event_doc_ref''',
      ));
  String? eventDocRefPath(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.event_doc_ref_path''',
      ));
  int? isActive(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.is_active''',
      ));
  String? createdAt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.created_at''',
      ));
  String? createdBy(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.created_by''',
      ));
}

class UpdateBoothsCall {
  Future<ApiCallResponse> call({
    String? authToken = 'test-token-123456789',
    String? boothName = 'บูธใหม่',
    String? description = 'อธิบายบูธใหม่',
    int? notificationDistance = 3,
    int? isActive = 0,
    String? updatedBy = 'users/m01gNYT1qqbOL1emlEPF4uc2b8F3',
    String? eventRef = '10b6e505-bba3-4079-bc7f-24cf07cb0ecf',
    String? boothRef = '804a7646-6139-4196-8650-d764dd9d37e1',
  }) async {
    final baseUrl = RasGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "booth_name": "${escapeStringForJson(boothName)}",
  "description": "${escapeStringForJson(description)}",
  "notification_distance": ${notificationDistance},
  "is_active": ${isActive},
  "updated_by": "${escapeStringForJson(updatedBy)}",
  "event_ref": "${escapeStringForJson(eventRef)}",
  "booth_ref": "${escapeStringForJson(boothRef)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateBooths',
      apiUrl: '${baseUrl}/booths',
      callType: ApiCallType.PUT,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer test-token-123456789',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status_code''',
      ));
  String? statusMessage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.status_message''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.description''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  int? eventId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.event_id''',
      ));
  String? eventDocRef(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.event_doc_ref''',
      ));
  String? eventDocRefPath(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.event_doc_ref_path''',
      ));
  int? isActive(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.is_active''',
      ));
  String? createdAt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.created_at''',
      ));
  String? createdBy(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.created_by''',
      ));
}

class CreateBoothsCall {
  Future<ApiCallResponse> call({
    String? authToken = 'test-token-123456789',
    String? boothName = 'บูธใหม่',
    String? description = 'อธิบายบูธใหม่',
    int? notificationDistance = 3,
    int? isActive = 0,
    String? createdBy = 'users/m01gNYT1qqbOL1emlEPF4uc2b8F3',
    String? eventRef = '10b6e505-bba3-4079-bc7f-24cf07cb0ecf',
  }) async {
    final baseUrl = RasGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "booth_name": "${escapeStringForJson(boothName)}",
  "description": "${escapeStringForJson(description)}",
  "notification_distance": ${notificationDistance},
  "is_active": ${isActive},
  "created_by": "${escapeStringForJson(createdBy)}",
  "event_ref": "${escapeStringForJson(eventRef)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createBooths',
      apiUrl: '${baseUrl}/booths/new',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer test-token-123456789',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status_code''',
      ));
  String? statusMessage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.status_message''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.description''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  int? eventId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.event_id''',
      ));
  String? eventDocRef(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.event_doc_ref''',
      ));
  String? eventDocRefPath(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.event_doc_ref_path''',
      ));
  int? isActive(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.is_active''',
      ));
  String? createdAt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.created_at''',
      ));
  String? createdBy(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.created_by''',
      ));
}

class UploadFileCall {
  Future<ApiCallResponse> call({
    List<FFUploadedFile>? fileUrlList,
    String? relatedType = 'events',
    int? relatedId = 14,
    String? relatedDocRef = '/events/10b6e505-bba3-4079-bc7f-24cf07cb0ecf',
  }) async {
    final baseUrl = RasGroup.getBaseUrl();
    final fileUrl = fileUrlList ?? [];

    return ApiManager.instance.makeApiCall(
      callName: 'uploadFile',
      apiUrl: '${baseUrl}/media-files/upload',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer test-token-123456789',
      },
      params: {
        'file_url': fileUrl,
        'related_type': relatedType,
        'related_id': relatedId,
        'related_doc_ref': relatedDocRef,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetMediaFilesByRelatedCall {
  Future<ApiCallResponse> call({
    String? relatedType = 'events',
    String? relatedId = '14',
    int? seq = 1,
  }) async {
    final baseUrl = RasGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "related_type": "${escapeStringForJson(relatedType)}",
  "related_id": "${escapeStringForJson(relatedId)}",
  "seq": ${seq}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getMediaFilesByRelated',
      apiUrl: '${baseUrl}/media-files/related',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer test-token-123456789',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateEventCall {
  Future<ApiCallResponse> call({
    String? authToken = 'test-token-123456789',
    String? eventName = 'กิจกรรมใหม่',
    String? description = 'อธิบายกิจกรรมใหม่',
    String? startDatetime = '2025-02-10T10:00:00Z',
    String? endDatetime = '2025-02-10T18:00:00Z',
    int? notificationFrequencyAmount = 3,
    int? notificationFrequencyMinute = 6,
    int? isActive = 0,
    String? updatedBy = 'users/m01gNYT1qqbOL1emlEPF4uc2b8F3',
    String? docRef = 'c169206d-5d48-424b-a8b2-29cab964649c',
  }) async {
    final baseUrl = RasGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "event_name": "${escapeStringForJson(eventName)}",
  "description": "${escapeStringForJson(description)}",
  "start_datetime": "${escapeStringForJson(startDatetime)}",
  "end_datetime": "${escapeStringForJson(endDatetime)}",
  "updated_by": "${escapeStringForJson(updatedBy)}",
  "is_active": ${isActive},
  "notification_frequency_amount": ${notificationFrequencyAmount},
  "notification_frequency_minute": ${notificationFrequencyMinute},
  "doc_ref": "${escapeStringForJson(docRef)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateEvent',
      apiUrl: '${baseUrl}/events/event?doc_ref=${docRef}',
      callType: ApiCallType.PUT,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer test-token-123456789',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status_code''',
      ));
  String? statusMessage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.status_message''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.description''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  int? eventId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.event_id''',
      ));
  String? eventDocRef(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.event_doc_ref''',
      ));
  String? eventDocRefPath(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.event_doc_ref_path''',
      ));
  int? isActive(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.is_active''',
      ));
  String? updatedAt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.updated_at''',
      ));
  String? updatedBy(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.updated_by''',
      ));
}

/// End RAS Group Code

class TestApiCallCall {
  static Future<ApiCallResponse> call({
    String? text = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'testApiCall',
      apiUrl: 'api.test.com/',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class TestAPICall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'testAPI',
      apiUrl: 'https://green-cars-hear.loca.lt/activities/user',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
