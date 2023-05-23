import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:mate/app_route/app_router.dart';
import 'package:mate/repository/api_service/api.dart';
import 'package:mate/src/designs/dashboard/chat_list/chat_screen/chat_args.dart';
import 'package:mate/src/utils/shared_pre.dart';

const String channelName = "CheckMate";
const String channelId = "zone.check.mate";

AndroidNotificationChannel channel = const AndroidNotificationChannel(
  channelId, channelName,
  importance: Importance.max,
  //sound: RawResourceAndroidNotificationSound('notification'),
);

class FirebaseService {
  FirebaseService._();

  static final instance = FirebaseService._();

  final FlutterLocalNotificationsPlugin localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // For iOS request permission first.
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (int? id, String? title, String? body, String? payload) {
        //FBNotification.showNotification(title, body);
      },
    );
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) async {
        Map getPayload = jsonDecode(response.payload ?? '');
        String payload = '';
        String type = '';
        if (getPayload.containsKey("payload")) {
          ///payload
          payload = getPayload["payload"];
        } else if (getPayload.containsKey("type")) {
          ///type
          type = getPayload["type"];
        }
        bool isLogin = await SharedPre.getBoolValue(SharedPre.isLogin);
        if (isLogin) {
          if (payload.isNotEmpty) {
            openChatScreen(payload);
          } else if (type == 'match') {
            router.pushNamed(dashboardView, extra: 2);
          } else if (type == 'match-request') {
            router.pushNamed(dashboardView, extra: 3);
          }
        }
      },
    );
    localNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    await localNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    try {
      FirebaseMessaging.instance.getToken().then((token) {
        SharedPre.setValue(key: SharedPre.fcmToken, value: token);
      });
      FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
        SharedPre.setValue(key: SharedPre.fcmToken, value: token);
        if (await SharedPre.getBoolValue(SharedPre.isLogin)) {
          Api().sendFcmTokenToServerApi(fcmToken: token);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        debugPrint("---onMessage--------");
        String title = message.notification?.title ?? '';
        String body = message.notification?.body ?? '';
        if (title.isNotEmpty && body.isNotEmpty) {
          showNotification(
            title,
            body,
            payload: jsonEncode(message.data),
          );
        }
      },
    );

    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) async {
        if (message != null) {
          String? payload = message.data['payload'];
          var type = message.data['type'];
          bool isLogin = await SharedPre.getBoolValue(SharedPre.isLogin);
          if (isLogin) {
            if (payload?.isNotEmpty ?? false) {
              openChatScreen(payload ?? '');
            } else if (type == 'match') {
              router.goNamed(dashboardView, extra: 2);
            } else if (type == 'match-request') {
              router.goNamed(dashboardView, extra: 3);
            }
          }
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) async {
        String payload = message.data['payload'];
        String type = message.data['type'];
        bool isLogin = await SharedPre.getBoolValue(SharedPre.isLogin);
        if (isLogin) {
          if (payload.isNotEmpty) {
            openChatScreen(payload);
          } else if (type == 'match') {
            router.pushNamed(dashboardView, extra: 2);
          } else if (type == 'match-request') {
            router.pushNamed(dashboardView, extra: 3);
          }
        }
      },
    );
  }

  void openChatScreen(String payload) {
    router.pushNamed(
      chatScreenView,
      extra: chatArgsFromJson(payload),
    );
  }

  void showNotification(String title, String body, {String? payload}) async {
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        importance: Importance.max,
        priority: Priority.high,
        icon: 'app_icon',
        playSound: true,
        showWhen: true,
        enableVibration: true,
        channelShowBadge: true,
        visibility: NotificationVisibility.public,
        autoCancel: true,
      ),
      iOS: DarwinNotificationDetails(
        presentSound: true,
        presentAlert: true,
        presentBadge: true,
      ),
    );
    await localNotificationsPlugin.show(
      Random().nextInt(4),
      title,
      body,
      platformChannelSpecifics,
      payload: payload ?? '',
    );
  }

  Future<void> sendNotification({
    required String fcmToken,
    required String senderName,
    required String msg,
    required String senderImage,
    required String senderId,
    required String chatRoomId,
  }) async {
    try {
      var token =
          "Key=AAAAMRTJytA:APA91bHbbIdqu4YgZ9_7lqajD1NRzM6OWptQEAicGAbPXs4F4KnKbPMx3w6JhISTWbqWH01wiigcmdDA2lzFLc-BTq5Vw0OHG78I_SqGm7tW5zm0OdrNR9DEF4J3q1guR3Z15rMcOa8B";

      await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token,
        },
        body: jsonEncode(
          {
            "to": fcmToken,
            "notification": {
              "title": "New message from ${senderName}",
              "body": msg,
            },
            "data": {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "status": "done",
              "title": "New message from ${senderName}",
              "body": msg,
              "payload": ChatArgs(
                peerId: senderId,
                chatRoomId: chatRoomId,
                // from: 1,
              ).toJson(),
            },
            "priority": "high",
          },
        ),
      );
    } catch (e) {
      debugPrint("--FLUTTER_NOTIFICATION-catch---${e}--------");
    }
  }

  Future<String?> getFcmToken() async {
    String? fcmToken;
    FirebaseMessaging.instance.getToken().then((token) {
      fcmToken = token;
    });
    return fcmToken;
  }
}
