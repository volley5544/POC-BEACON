import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBkaSEMeo0O1UzNr51f_K0XUu8n_iR27jA",
            authDomain: "poc-beacon-firebase.firebaseapp.com",
            projectId: "poc-beacon-firebase",
            storageBucket: "poc-beacon-firebase.firebasestorage.app",
            messagingSenderId: "166354661539",
            appId: "1:166354661539:web:a8dcf74a553cfda1ba4f16",
            measurementId: "G-J0V42CVK7F"));
  } else {
    await Firebase.initializeApp();
  }
}
