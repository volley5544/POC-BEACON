import 'dart:async';
import 'package:dchs_flutter_beacon/dchs_flutter_beacon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import '/backend/schema/structs/index.dart';
import '/backend/schema/events_record.dart';
import '/custom_code/event_data_model_struct_1.dart';
import '/custom_code/booth_data_model_struct_new.dart';
import '/custom_code/user_notification_data_model_struct.dart';
import '/custom_code/user_activity_data_model_struct_new.dart';
import '/custom_code/register_data_model_struct.dart';
import 'package:flutter/services.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'package:rxdart/rxdart.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import 'package:flutter/material.dart';

class MyStreamService {
  static final MyStreamService _instance = MyStreamService._internal();
  factory MyStreamService() => _instance;
  MyStreamService._internal();

  StreamSubscription<RangingResult>? _streamRanging;
  StreamSubscription? _subEvents;
  StreamSubscription? _subBooth;
  final ValueNotifier<List<String>> beaconDistance = ValueNotifier([]);
  final ValueNotifier<List<String>> beaconId = ValueNotifier([]);

  List<Map<String, dynamic>> eventDocs = [];
  List<EventDataModelStruct1> eventData = [];

  List<Map<String, dynamic>> boothDocs = [];
  List<BoothDataModelStructNew> boothData = [];

  List<Map<String, dynamic>> userNotiDocs = [];
  List<UserNotificationDataModelStruct> userNotiData = [];

  List<Map<String, dynamic>> userActivityDocs = [];
  List<UserActivityDataModelStructNew> userActivityData = [];

  List<Map<String, dynamic>> eventRegisterDocs = [];
  List<RegisterDataModelStruct> eventRegisterData = [];

  // List<String> get beaconId => _beaconId;
  // List<String> get beaconDistance => _beaconDistance;

  void startListening(Stream<RangingResult> myStream) {
    List<EventDataModelStruct1> matchingEvents = [];
    _streamRanging ??= myStream.listen((result) async {
      print('in ranging.listen');
      if (result.beacons.isNotEmpty) {
        result.beacons.sort((a, b) => a.accuracy.compareTo(b.accuracy));
        final nearest = result.beacons;
        beaconId.value = nearest.map((e) => e.proximityUUID).toList();
        ;
        beaconDistance.value =
            nearest.map((e) => e.accuracy.toStringAsFixed(2)).toList();
        ;
        FFAppState().beaconDistanceList =
            nearest.map((e) => e.accuracy.toStringAsFixed(2)).toList();
        FFAppState().beaconIdList =
            nearest.map((e) => e.proximityUUID).toList();
        // Convert beaconId + beaconDistance into a Map for easy lookup
        Map<String, double> beaconMap = {
          for (int i = 0; i < beaconId.value.length; i++)
            beaconId.value[i]: double.parse('${beaconDistance.value[i]}')
        };

        // FFAppState().beaconNameList = nearest.map((e) => e.macAddress).toList();
        //safeSetState((){});

        if (true) {
          // matchingEvents = eventData.where((event) {
          //   return event.boothList.any((booth) {
          //     final beaconDist = beaconMap['${booth.deviceUuid}'];
          //     if (beaconDist == null) return false;
          //
          //     return beaconDist
          //         booth.notificationDistance; // ✅ extra condition
          //   });
          // }).toList();

          matchingEvents = eventData
              .map((event) {
                // Filter booths by condition
                final matchedBooths = event.boothList.where((booth) {
                  final beaconDist = beaconMap['${booth.deviceUuid}'];
                  return beaconDist != null &&
                      beaconDist <= booth.notificationDistance;
                }).toList();

                // Return event with only matching booths
                return EventDataModelStruct1(
                  eventId: event.eventId,
                  eventName: event.eventName,
                  description: event.description,
                  createdBy: event.createdBy,
                  isActive: event.isActive,
                  uploadedBy: event.uploadedBy,
                  notificationFrequencyAmount:
                      event.notificationFrequencyAmount,
                  notificationFrequencyMinute:
                      event.notificationFrequencyMinute,
                  eventImageList: event.eventImageList,
                  startDatetime: event.startDatetime,
                  endDatetime: event.endDatetime,
                  uploadedAt: event.uploadedAt,
                  createdAt: event.createdAt,
                  boothList: matchedBooths, // ✅ only matched booths
                );
              })
              .where((event) =>
                  event.boothList.isNotEmpty) // keep only events with matches
              .toList();

          print("Found ${matchingEvents.length} matching events");

          if (matchingEvents.length > 0) {
            // HapticFeedback.heavyImpact();
            print('in range Beac');
            await Future.wait(
              matchingEvents.expand((event) => event.boothList
                  .map((booth) => createUserNotificationDoc(event, booth))),
            );
            // await Future.wait(
            //   matchingEvents.map((event) async {
            // Map<String,dynamic> queryNotiData = await getDataFromCollection('${event.eventId}');
            // if(queryNotiData == {}){
            //   return createUserNotificationDoc(event);
            // }
            // else{
            //   return createUserNotificationDoc(event);
            // }
            // return createUserNotificationDoc(event);
            // } ),
            // );
          } else {
            print('not in range Beac');
          }
          // List<EventDataModelStruct1> matchingEvents = eventData.where((event) {
          //   return event.boothList.any((booth) => FFAppState().beaconIdList.contains(booth.deviceUuid) && );
          // }).toList();
          //
          // print("Found ${matchingEvents.length} matching events");
        }
      }
      // handle data
    });
  }

  void listenEvent() {
    _subEvents = FirebaseFirestore.instance
        .collection('events')
        .where('is_active', isEqualTo: 0)
        .snapshots()
        .listen((snapshot) {
      eventDocs = snapshot.docs.map((d) => d.data()).toList();
      //eventData = snapshot;//EventDataModelStruct.fromMap(Map(eventDocs));
      eventData = eventDocs
          .map(
            (doc) => EventDataModelStruct1.fromMap(doc),
          )
          .toList();
      print("Collection1 updated: ${eventDocs.length} docs");
      print('object');
      print('eventName : ${eventDocs.first}');
      print('eventName : ${eventData.first.startDatetime}');
      // print('allEvent5544 : ${snapshot.length}');
    });

    // for (var doc in snapshot.docs) {
    //   print("Order: ${doc.id} => ${doc.data()}");
    // }
  }

  void listenBooth() {
    FirebaseFirestore.instance
        .collectionGroup("booths")
        .snapshots()
        .listen((snapshot) {
      boothDocs = snapshot.docs.map((d) => d.data()).toList();
      // print('volley5544123');
      // print(boothDocs.first);
      boothData = boothDocs
          .map(
            (doc) => BoothDataModelStructNew.fromMap(doc),
          )
          .toList();
      // print('Booth5544 : ${boothData[3].boothName}');
    });
  }

  void listenEventWithBooths() {
    queryEventsWithBooths5544().listen((eventList) {
      eventData = eventList;
      // print('qwofjhweoifjew : ${eventData[4].eventId}');
      // print('qwofjhweoifjew1 : ${eventData[4].boothList[2].notificationDistance}');
    });
  }

  Stream<List<EventDataModelStruct1>> queryEventsWithBooths5544() {
    final eventsStream = FirebaseFirestore.instance
        .collection("events")
        .where("is_active", isEqualTo: 0)
        .where("start_datetime", isLessThanOrEqualTo: DateTime.now())
        .where("end_datetime", isGreaterThanOrEqualTo: DateTime.now())
        .snapshots();

    final boothsStream =
        FirebaseFirestore.instance.collectionGroup("booths").snapshots();

    return Rx.combineLatest2(
      eventsStream,
      boothsStream,
      (QuerySnapshot eventSnapshot, QuerySnapshot boothSnapshot) {
        // Convert booths first
        final allBooths = boothSnapshot.docs
            .map((doc) => BoothDataModelStructNew.fromMap(
                doc.data() as Map<String, dynamic>))
            .toList();

        // Convert events and attach booths
        return eventSnapshot.docs.map((eventDoc) {
          final eventDataNew1 = EventDataModelStruct1.fromMap(
              eventDoc.data() as Map<String, dynamic>);

          final boothList = allBooths
              .where(
                  (b) => b.eventId == eventDataNew1.eventId) // join by eventId
              .toList();

          return EventDataModelStruct1(
            eventId: eventDataNew1.eventId,
            eventName: eventDataNew1.eventName,
            description: eventDataNew1.description,
            createdBy: eventDataNew1.createdBy,
            isActive: eventDataNew1.isActive,
            uploadedBy: eventDataNew1.uploadedBy,
            notificationFrequencyAmount:
                eventDataNew1.notificationFrequencyAmount,
            notificationFrequencyMinute:
                eventDataNew1.notificationFrequencyMinute,
            eventImageList: eventDataNew1.eventImageList,
            startDatetime: eventDataNew1.startDatetime,
            endDatetime: eventDataNew1.endDatetime,
            uploadedAt: eventDataNew1.uploadedAt,
            createdAt: eventDataNew1.createdAt,
            boothList: boothList,
          );
        }).toList();
      },
    );
  }

  Stream<List<EventDataModelStruct1>> queryEventsWithBooths() {
    return FirebaseFirestore.instance
        .collection("events")
        .where("is_active", isEqualTo: 0)
        .orderBy("event_id", descending: true)
        .snapshots()
        .asyncMap((eventSnapshot) async {
      List<EventDataModelStruct1> eventTemp = [];

      for (var eventDoc in eventSnapshot.docs) {
        final eventDataNew = EventDataModelStruct1.fromMap(eventDoc.data());

        // Listen to booth subcollection
        final boothSnapshot = await eventDoc.reference
            .collection("booths")
            .orderBy("booth_id", descending: true)
            .get(); // one-time read, OR replace with .snapshots() if you want nested listeners

        List<BoothDataModelStructNew> boothList = boothSnapshot.docs
            .map((doc) => BoothDataModelStructNew.fromMap(doc.data()))
            .toList();

        eventTemp.add(
          EventDataModelStruct1(
            eventId: eventDataNew.eventId,
            eventName: eventDataNew.eventName,
            description: eventDataNew.description,
            createdBy: eventDataNew.createdBy,
            isActive: eventDataNew.isActive,
            uploadedBy: eventDataNew.uploadedBy,
            notificationFrequencyAmount:
                eventDataNew.notificationFrequencyAmount,
            notificationFrequencyMinute:
                eventDataNew.notificationFrequencyMinute,
            eventImageList: eventDataNew.eventImageList,
            startDatetime: eventDataNew.startDatetime,
            endDatetime: eventDataNew.endDatetime,
            uploadedAt: eventDataNew.uploadedAt,
            createdAt: eventDataNew.createdAt,
            boothList: boothList,
          ),
        );
      }

      return eventTemp;
    });
  }

  void listenUserNotification() async {
    print('currentUserUid5544 : ${currentUserUid}');
    FirebaseFirestore.instance
        .collection("users")
        .doc("${currentUserUid}")
        .collection("notifications")
        .snapshots()
        .listen((snapshot) {
      userNotiDocs = snapshot.docs.map((d) => d.data()).toList();
      // print('userDocLength : ${snapshot.docs.map((d) => d.data()).toList()}');
      // print('volley5544123');
      // print(boothDocs.first);
      userNotiData = userNotiDocs
          .map(
            (doc) => UserNotificationDataModelStruct.fromMap(doc),
          )
          .toList();
      // print('Booth5544 : ${boothData[3].boothName}');
      // print('userNoti5544 : ${userNotiData.length}');
      List<UserNotificationDataModelStruct> filteredNotiType5544 = userNotiData
          .where(
              (noti) => noti.notiType == 'register_invite' && noti.eventId == 2)
          .toList();

      print('filteredNotiType5544 : ${filteredNotiType5544.length}');
    });
  }

  void listenUserActivity() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc("${currentUserUid}")
        .collection("UserActivity")
        .where('is_active', isEqualTo: 0)
        .snapshots()
        .listen((snapshot) {
      userActivityDocs = snapshot.docs.map((d) => d.data()).toList();
      // print('userAcDocLength : ${snapshot.docs.map((d) => d.data()).toList()}');
      // print('volley5544123');
      // print(boothDocs.first);
      userActivityData = userActivityDocs
          .map(
            (doc) => UserActivityDataModelStructNew.fromMap(doc),
          )
          .toList();
      // print('Booth5544 : ${boothData[3].boothName}');
      // print('userActivity5544 : ${userActivityData.length}');
      // print('${userActivityData.first.isSurveyed}');
      // print(
      //     'userActivity5544 survey : ${userActivityData.first.surveyData.rating}');
      print('activity : ${userActivityData.length}');
      // print('activity : ${userActivityData}');
    });
  }

  void listenEventRegister() async {
    FirebaseFirestore.instance
        .collectionGroup("register")
        .snapshots()
        .listen((snapshot) {
      eventRegisterDocs = snapshot.docs.map((d) => d.data()).toList();
      // print('userAcDocLength : ${snapshot.docs.map((d) => d.data()).toList()}');
      // print('volley5544123');
      // print(boothDocs.first);
      eventRegisterData = eventRegisterDocs
          .map(
            (doc) => RegisterDataModelStruct.fromMap(doc),
          )
          .toList();
      // print('Booth5544 : ${boothData[3].boothName}');
      // print('eventRegister5544 : ${eventRegisterData.length}');
      // print('${eventRegisterData.first.eventId}');
      // print('eventRegister5544 uid : ${eventRegisterData.first.uid}');
      print('register : ${eventRegisterData.length}');

      //filter register ว่าเคยลงทะเบียนevent_idนี้ไปหรือยัง
      List<RegisterDataModelStruct> filteredRegister5544 = eventRegisterData
          .where((register) =>
              register.eventId == 2 && register.uid == '${currentUserUid}')
          .toList();

      print('filteredRegister : ${filteredRegister5544.length}');
    });
  }

  Future createUserNotificationDoc(
      EventDataModelStruct1 event, BoothDataModelStructNew booth) async {
    // filter noitที่เป็น event_id ที่ beaconจับเจอ และ noti_type เป็นชวนลงทะเบียน
    List<UserNotificationDataModelStruct> filteredNotiType = userNotiData
        .where((noti) =>
            noti.notiType == 'register_invite' && noti.eventId == event.eventId)
        .toList();

    //filter register ว่าเคยลงทะเบียนevent_idนี้ไปหรือยัง
    List<RegisterDataModelStruct> filteredRegister = eventRegisterData
        .where((register) =>
            register.eventId == event.eventId &&
            register.uid == '${currentUserUid}')
        .toList();

    print('filteredRegister.length : ${filteredRegister.length}');
    // FFAppState().textDebug = '${filteredRegister.length}';
    print('filteredNotiType.length : ${filteredNotiType.length}');
    // FFAppState().textDebug2 = '${filteredNotiType.length}';
    // if (filteredRegister.length > 0){
    //
    // }

    //ยังไม่เคยลงทะเบียนและยังไม่เคยส่งnotiชวนลงทะเบียนกิจกรรม
    if (filteredRegister.length == 0 && filteredNotiType.length == 0) {
      // HapticFeedback.heavyImpact();
      //ส่งinapp noti ชวนลงทะเบียนกิจกรรม event_idนี้
      final notiRefRegist = FirebaseFirestore.instance
          .collection('users')
          .doc('${currentUserUid}')
          .collection('notifications');

      await notiRefRegist.add({
        'to_uid': '${currentUserUid}',
        'booth_id': '${booth.boothId}',
        'title': 'เรียนเชิญลงทะเบียนทำกิจกรรม',
        'body':
            'ขณะนี้คุณได้อยู่ใกล้กับกิจกรรม${event.eventName} ขอเรียนเชิญลงทะเบียนได้ที่บุธกิจกรรมใกล้ท่าน',
        'sent_at': FieldValue.serverTimestamp(),
        'event_id': int.parse('${event.eventId}'),
        'send_count': 1,
        'is_read': false,
        'is_deleted': false,
        'noti_type': 'register_invite',
      });

      //ส่งnoti FCM นอกแอพ ชวนลงทะเบียน event_idนี้
      triggerPushNotification(
        notificationTitle: 'เรียนเชิญลงทะเบียนทำกิจกรรม',
        notificationText:
            'ขณะนี้คุณได้อยู่ใกล้กับกิจกรรม${event.eventName} ขอเรียนเชิญลงทะเบียนได้ที่บุธกิจกรรมใกล้ท่าน',
        notificationSound: 'default',
        userRefs: [currentUserReference!],
        initialPageName: 'EventSelection',
        parameterData: {},
      );

      return;
    }

    if (filteredRegister.length == 0) {
      return;
    }

    List<UserActivityDataModelStructNew> filteredUserActivity = [];
    //filter activity เคยเล่นboothนั้นหรือยัง
    if (userActivityData.isNotEmpty) {
      filteredUserActivity = userActivityData
          .where((activity) =>
              activity.uid == '${currentUserUid}' &&
              activity.eventId == event.eventId &&
              activity.boothId == booth.boothId)
          .toList();
    }
    // FFAppState().textDebug3 = '${filteredUserActivity.length}';

    //เช็คว่าเคยเล่นbooth_idนี้หรือยัง
    if (filteredUserActivity.length != 0) {
      return;
    }

    //filter notiชวนเล่นกิจกรรม
    List<UserNotificationDataModelStruct> filteredNoti = userNotiData
        .where((noti) =>
            noti.eventId == event.eventId &&
            noti.boothId == '${booth.boothId}' &&
            noti.notiType == 'booth_invite')
        .toList();

    //เช็คว่าเคยส่งnotiชวนเล่นกิจกรรมนี้แล้ว
    if (filteredNoti.length != 0) {
      //เช็คว่าจำนวนครั้งที่ส่งnotiไปแล้ว เกินnotificationFrequencyAmountของกิจกรรม ที่setไว้มั้ย
      if (filteredNoti.first.sendCount >=
          (event.notificationFrequencyAmount != null
              ? event.notificationFrequencyAmount
              : 0)) {
        return;
      }
      //ถ้ายังส่งnotiไม่เกินจำนวนครั้ง
      else {
        DateTime nextNotiTime = filteredNoti.first.sentAt
            .add(Duration(minutes: event.notificationFrequencyMinute));
        //เช็คว่าเวลาที่ส่งnotiชวนเล่นกิจกรรมล่าสุดของevent_idนี้ + กับเวลาnotificationFrequencyMinuteที่setไว้ เลยเวลาปัจจุบันหรือยัง
        if (nextNotiTime.isAfter(Timestamp.now().toDate())) {
          return;
        }
      }
    }

    final notiRef = FirebaseFirestore.instance
        .collection('users')
        .doc('${currentUserUid}')
        .collection('notifications');

    final query = await notiRef
        .where('event_id', isEqualTo: int.parse('${event.eventId}'))
        .where('noti_type', isEqualTo: 'booth_invite')
        .where('booth_id', isEqualTo: '${booth.boothId}')
        // .where('booth_id'), isEqualTo: '${event.boothList.first}'
        .get();
    //notiกระดิ่ง (inapp)

    //เคยส่งnotiชวนเล่นกิจกรรม event_idนี้แล้ว
    if (query.docs.isNotEmpty) {
      // 👉 update noti doc
      await notiRef.doc(query.docs.first.id).set({
        'booth_id': '${booth.boothId}',
        'sent_at': FieldValue.serverTimestamp(),
        'send_count': int.parse('${query.docs.first.data()['send_count'] + 1}'),
        'is_read': false,
        'is_deleted': false,
      }, SetOptions(merge: true));
    }
    //ยังไม่เคยเคยส่งnotiชวนเล่นกิจกรรม event_idนี้
    else {
      // 👉 create new noti doc
      await notiRef.add({
        'to_uid': '${currentUserUid}',
        'booth_id': '${booth.boothId}',
        'title': 'เรียนเชิญเล่นกิจกรรม${event.eventName}',
        'body':
            'ขณะนี้คุณได้อยู่ใกล้บูธ${booth.boothName} กิจกรรม${event.eventName}แล้ว เชิญไปที่บูธเพื่อทำกรรมได้เลย',
        'sent_at': FieldValue.serverTimestamp(),
        'event_id': int.parse('${event.eventId}'),
        'send_count': 1,
        'is_read': false,
        'is_deleted': false,
        'noti_type': 'booth_invite',
      });
    }

    //noti FCM (นอกแอพ)

    //ส่ง FCM notiชวนเล่นกิจกรรม
    triggerPushNotification(
      notificationTitle: 'เรียนเชิญเล่นกิจกรรม${event.eventName}',
      notificationText:
          'ขณะนี้คุณได้อยู่ใกล้บูธ${booth.boothName} กิจกรรม${event.eventName}แล้ว เชิญไปที่บูธเพื่อทำกรรมได้เลย',
      notificationSound: 'default',
      userRefs: [currentUserReference!],
      initialPageName: 'Home',
      parameterData: {},
    );

    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc('${currentUserUid}')
    //     .collection('notifications')
    //     .add({
    //   'to_uid': '${currentUserUid}',
    //   'booth_id': '${event.boothList.first.boothId}',
    //   'title': 'เรียนเชิญเล่นกิจกรรม${event.eventName}',
    // 'body': 'ขณะนี้คุณได้อยู่ใกล้บูธ${event.boothList.first.boothName} กิจกรรม${event.eventName}แล้ว เชิญไปที่บูธเพื่อทำกรรมได้เลย',
    // 'sent_at': FieldValue.serverTimestamp(),
    // 'event_id': int.parse('${event.eventId}'),
    // 'send_count': 1,
    // });
  }

  Future updateUserNotificationDoc(EventDataModelStruct1 event) async {
    final notiRef = FirebaseFirestore.instance
        .collection('users')
        .doc('${currentUserUid}')
        .collection('notifications');

    final query = await notiRef
        .where('event_id', isEqualTo: int.parse('${event.eventId}'))
        .get();

    await notiRef.doc(query.docs.first.id).set({
      'send_count': int.parse('${query.docs.first.data()['send_count'] + 1}'),
    }, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>> getDataFromCollection(String eventId) async {
    // Add your function code here!
    Map<String, dynamic> dataOutput = {};

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection("users")
          .doc("${currentUserUid}")
          .collection("notifications")
          .where('event_id', isEqualTo: int.parse('${eventId}'))
          .get(); //.where(filterField, isEqualTo: filterValue)

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (QueryDocumentSnapshot document in documents!) {
        Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
        if (data != null) {
          dataOutput = data;
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    print('dataOutput :  $dataOutput');

    return dataOutput;
  }

  void stopListening() {
    _streamRanging?.cancel();
    _streamRanging = null;
  }

  // List<String> getBeaconIdList() {
  //   return beaconId;
  // }
  //
  // List<String> getBeaconDistanceList() {
  //   return FFAppState().beaconDistanceList;
  // }
}
