// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> checkIfEventIdExists(String? collection, String? doc,
    String? subCollection, int? eventId, String? uid, int? isActive) async {
  if (collection == null || doc == null || subCollection == null) {
    print("Invalid parameters");
    return false;
  }

  try {
    // Reference to the sub-collection
    final ref = FirebaseFirestore.instance
        .collection(collection)
        .doc(doc)
        .collection(subCollection);

    final allDocsSnapshot = await ref.get();
    if (allDocsSnapshot.docs.isEmpty) {
      print("Sub-collection is empty");
      return false;
    }

    final querySnapshot = await ref
        .where('event_id', isEqualTo: eventId)
        .where('uid', isEqualTo: uid)
        .where('is_active', isEqualTo: isActive)
        .get();

    // Return true if any document matches
    return querySnapshot.docs.isNotEmpty;
  } catch (e) {
    print("Error checking event_id: $e");
    return false;
  }
}
