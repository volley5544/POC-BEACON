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
import 'package:flutter/services.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'package:rxdart/rxdart.dart';

class MyStreamService {
  static final MyStreamService _instance = MyStreamService._internal();
  factory MyStreamService() => _instance;
  MyStreamService._internal();

  StreamSubscription<RangingResult>? _streamRanging;
  StreamSubscription? _subEvents;
  StreamSubscription? _subBooth;
  List<String> beaconId = [];
  List<String> beaconDistance = [];

  List<Map<String, dynamic>> eventDocs = [];
  List<EventDataModelStruct1> eventData = [];

  List<Map<String, dynamic>> boothDocs = [];
  List<BoothDataModelStructNew> boothData = [];

  List<Map<String, dynamic>> userNotiDocs = [];
  List<UserNotificationDataModelStruct> userNotiData = [];

  void startListening(Stream<RangingResult> myStream) {
    List<EventDataModelStruct1> matchingEvents = [];
    _streamRanging ??= myStream.listen((result) async {
      print('in ranging.listen');
      if (result.beacons.isNotEmpty) {
        result.beacons.sort((a, b) => a.accuracy.compareTo(b.accuracy));
        final nearest = result.beacons;
        beaconId = nearest.map((e) => e.proximityUUID).toList();
        ;
        beaconDistance =
            nearest.map((e) => e.accuracy.toStringAsFixed(2)).toList();
        ;
        FFAppState().beaconDistanceList =
            nearest.map((e) => e.accuracy.toStringAsFixed(2)).toList();
        FFAppState().beaconIdList =
            nearest.map((e) => e.proximityUUID).toList();
        // Convert beaconId + beaconDistance into a Map for easy lookup
        Map<String, double> beaconMap = {
          for (int i = 0; i < beaconId.length; i++)
            beaconId[i]: double.parse('${beaconDistance[i]}')
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
            HapticFeedback.heavyImpact();
            print('in range Beac');
            await Future.wait(
              matchingEvents.map((event) => createUserNotificationDoc(event)),
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
      print('userDocLength : ${snapshot.docs.map((d) => d.data()).toList()}');
      // print('volley5544123');
      // print(boothDocs.first);
      userNotiData = userNotiDocs
          .map(
            (doc) => UserNotificationDataModelStruct.fromMap(doc),
          )
          .toList();
      // print('Booth5544 : ${boothData[3].boothName}');
      print('userNoti5544 : ${userNotiData.length}');
    });
  }

  Future createUserNotificationDoc(EventDataModelStruct1 event) async {
    List<UserNotificationDataModelStruct> filteredNoti =
        userNotiData.where((noti) => noti.eventId == event.eventId).toList();

    if (filteredNoti.length != 0) {
      if (filteredNoti.first.sendCount >=
          (event.notificationFrequencyAmount != null
              ? event.notificationFrequencyAmount
              : 0)) {
        return;
      } else {
        DateTime nextNotiTime = filteredNoti.first.sentAt
            .add(Duration(minutes: event.notificationFrequencyMinute));

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
        // .where('booth_id'), isEqualTo: '${event.boothList.first}'
        .get();
    if (query.docs.isNotEmpty) {
      // 👉 update first doc
      await notiRef.doc(query.docs.first.id).set({
        'booth_id': '${event.boothList.first.boothId}',
        'sent_at': FieldValue.serverTimestamp(),
        'send_count': int.parse('${query.docs.first.data()['send_count'] + 1}'),
        'is_read': false,
        'is_deleted': false,
      }, SetOptions(merge: true));
    } else {
      // 👉 create new doc
      await notiRef.add({
        'to_uid': '${currentUserUid}',
        'booth_id': '${event.boothList.first.boothId}',
        'title': 'เรียนเชิญเล่นกิจกรรม${event.eventName}',
        'body':
            'ขณะนี้คุณได้อยู่ใกล้บูธ${event.boothList.first.boothName} กิจกรรม${event.eventName}แล้ว เชิญไปที่บูธเพื่อทำกรรมได้เลย',
        'sent_at': FieldValue.serverTimestamp(),
        'event_id': int.parse('${event.eventId}'),
        'send_count': 1,
        'is_read': false,
        'is_deleted': false,
      });
    }

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
}
