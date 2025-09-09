import 'package:cloud_firestore/cloud_firestore.dart';

class UserNotificationDataModelStruct {
  final String toUid;
  final String boothId;
  final String title;
  final String body;
  final DateTime sentAt;
  final int eventId;
  final int sendCount;
  final String notiType;

  UserNotificationDataModelStruct({
    required this.toUid,
    required this.boothId,
    required this.title,
    required this.body,
    required this.sentAt,
    required this.eventId,
    required this.sendCount,
    required this.notiType,
  });

  factory UserNotificationDataModelStruct.fromMap(Map<String, dynamic> map) {
    return UserNotificationDataModelStruct(
      toUid: map['to_uid'] ?? '',
      boothId: map['booth_id'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      sentAt: map['sent_at'] != null
          ? map['sent_at'].toDate()
          : Timestamp.now().toDate(),
      eventId: map['event_id'] ?? 0,
      sendCount: map['send_count'] ?? 0,
      notiType: map['noti_type'] ?? '',
    );
  }
}
