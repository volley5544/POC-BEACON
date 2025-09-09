import 'package:cloud_firestore/cloud_firestore.dart';
import '/flutter_flow/lat_lng.dart';

class SurveyDataModelStructNew {
  final int surveyId;
  final String uid;
  final int eventId;
  final int boothId;
  final int rating;
  final String feedback;
  final DateTime createdAt;
  final String createdBy;
  final int isActive;
  final DateTime updatedAt;
  final String updatedBy;

  SurveyDataModelStructNew({
    required this.surveyId,
    required this.uid,
    required this.eventId,
    required this.boothId,
    required this.rating,
    required this.feedback,
    required this.createdAt,
    required this.createdBy,
    required this.isActive,
    required this.updatedAt,
    required this.updatedBy,
  });

  factory SurveyDataModelStructNew.fromMap(Map<String, dynamic> map) {
    return SurveyDataModelStructNew(
      surveyId: map['survey_id'] ?? 0,
      uid: map['uid'] ?? '',
      eventId: map['event_id'] ?? 0,
      boothId: map['booth_id'] ?? 0,
      rating: map['rating'] ?? 0,
      feedback: map['feedback'] ?? '',
      createdAt: map['created_at'] != null
          ? map['created_at'].toDate()
          : Timestamp.now().toDate(),
      createdBy: map['created_by'] ?? '',
      isActive: map['is_active'] ?? 0,
      updatedAt: map['updated_at'] != null
          ? map['updated_at'].toDate()
          : Timestamp.now().toDate(),
      updatedBy: map['updated_by'] ?? '',
    );
  }
}
