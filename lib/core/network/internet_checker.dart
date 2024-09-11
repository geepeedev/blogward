import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class InternetChecker {
  Future<bool> get isConnected;
  StreamSubscription<InternetStatus> listenForInternet();
  late bool internetAccess;
}

class InternetCheckerImpl implements InternetChecker {
  final InternetConnection internetConnection;
  StreamSubscription<InternetStatus>? streamSubscription;
  @override
  late bool internetAccess;

  InternetCheckerImpl({required this.internetConnection});
  @override
  Future<bool> get isConnected async =>
      await internetConnection.hasInternetAccess;
  // internetConnection.onStatusChange.listen((InternetStatus status) {
  //   switch (status) {
  //     case InternetStatus.connected:
  //       true;
  //       break;
  //     case InternetStatus.disconnected:
  //       false;
  //       break;
  //   }
  // });
  @override
  StreamSubscription<InternetStatus> listenForInternet() {
    // return _streamSubscription = internetConnection.onStatusChange.listen((event) { });
    return streamSubscription =
        InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          internetAccess = true;
          break;
        case InternetStatus.disconnected:
          internetAccess = false;
          break;
      }
    });
  }
}
