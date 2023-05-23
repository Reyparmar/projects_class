import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ubiza_app/my_app.dart';

Future<void> _backgroundHandler(RemoteMessage message) async {
  /*print('_____message ${message.messageId} ');
  String title = message.notification?.title ?? '';
  String body = message.notification?.body ?? '';
  if (title.isNotEmpty && body.isNotEmpty) {
    PushNotificationService.instance.showNotification(
      title,
      body,
      payload: message.data.toString(),
    );
  }*/
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  if (!kIsWeb) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }
  runApp(const MyApp());
}
