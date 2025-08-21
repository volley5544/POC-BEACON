import 'dart:async';

class MyStreamService {
  static final MyStreamService _instance = MyStreamService._internal();
  factory MyStreamService() => _instance;
  MyStreamService._internal();

  StreamSubscription? _subscription;

  void startListening(Stream<String> myStream) {
    _subscription ??= myStream.listen((data) {
      print("Received: $data");
      // handle data
    });
  }

  void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }
}
