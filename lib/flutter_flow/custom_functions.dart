import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

String? combineTextFullname(
  String? firstname,
  String? lastname,
) {
  String outputText = 'ชื่อลูกค้า : ${firstname!} ${lastname!}';

  return outputText;
}

DateTime? parseStringToDatetime(String? datetimeString) {
  return DateTime.parse(datetimeString!);
}

int? incrementByOne(int value) {
  return value + 1;
}

String? stringToImgPath(String? input) {
  return '${input!}';
}

List<String>? combine2ImagePathList(
  List<String>? list1,
  List<String>? list2,
) {
  List<String> outputList = list1! + list2!;
  return outputList;
}

List<String>? convertListStringToListImgPath(List<String>? inputList) {
  return inputList!;
}

int getCurrentTimestamp(String type) {
  final now = DateTime.now();

  if (type.toLowerCase() == 'seconds') {
    return now.millisecondsSinceEpoch ~/ 1000;
  } else if (type.toLowerCase() == 'microseconds') {
    return now.microsecondsSinceEpoch;
  } else {
    return now.millisecondsSinceEpoch;
  }
}

DateTimeRange? newCustomFunction(
  DateTime? startDate,
  DateTime? endDate,
) {
  return DateTimeRange(start: startDate!, end: endDate!);
}

int? returnIndexValueInList(
  List<String>? inputList,
  String? value,
) {
  return inputList!.indexOf(value!);
}

String? returnTextInList(List<String>? inputList) {
  String output = '';
  if (inputList!.length == 0) {
    return 'empty';
  }
  for (int i = 0; i < inputList!.length; i++) {
    output = output + '${inputList![i]}\n';
  }
  return output;
}

List<String>? generateDefaultList(
  String? defaultValue,
  int? length,
) {
  List<String> outputList = List.filled(length!, "${defaultValue!}");

  return outputList;
}
