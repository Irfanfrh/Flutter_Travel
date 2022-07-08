import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';

initializeNotification()async{
  final fcm = FirebaseMessaging.instance;

  try {
    if(Platform.isAndroid){
      await fcm.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      await fcm.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );


      FirebaseMessaging.onMessage.listen(_onMessage);
      FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_onOpened);
      debugPrint("Token: ${(fcm.getToken()).toString()}");

    } 
  } catch (e) {
    debugPrint(e.toString());
  }
  final message = await fcm.getInitialMessage();
  if (message != null){
    final data = message.data;
    debugPrint("Kamu bisa melakukan apapun pada data! $data");
  }
}

void _onMessage(RemoteMessage message){
  debugPrint("Kamu menerima pesan! ${message.notification?.title}");
  debugPrint("${message.notification?.body}");
}
Future<void> _onBackgroundMessage(RemoteMessage message) async {
  debugPrint("Kamu menerima pesan! ${message.notification?.body}");
}

void _onOpened(RemoteMessage message) async {
  final data = message.data;
  debugPrint("Kamu bisa melakukan apapun pada data! $data");
}