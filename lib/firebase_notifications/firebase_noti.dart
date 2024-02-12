import 'dart:math';
import 'package:expensetracker/bloc/notification/notification_bloc.dart';
import 'package:expensetracker/bloc/notification/notification_event.dart';
import 'package:expensetracker/screens/notifications/notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

final firebaseMessaging = FirebaseMessaging.instance;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void initLocalNotifications(BuildContext context, RemoteMessage message) async {
  var androidInitializationSettings =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var iosInitializationSettings = const DarwinInitializationSettings();
  var initializedSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: iosInitializationSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializedSettings,
    onDidReceiveNotificationResponse: (payload) {
      handleMessage(context, message);
      BlocProvider.of<NotificationBloc>(context).add(ClearNotification());
    },
  );
}

void firebaseInit(BuildContext context) {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print(message.notification?.title);
    print(message.notification?.body);
    if (kDebugMode) {
      print(message.notification?.title);
      print(message.notification?.body);
    }

    initLocalNotifications(context, message);
    showNotifications(message);
  });
}

Future<void> showNotifications(RemoteMessage message) async {
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    Random.secure().nextInt(10000).toString(),
    'High Importance Channels',
    importance: Importance.max,
  );
  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    channel.id.toString(),
    channel.name.toString(),
    channelDescription: 'Your channel desc',
    importance: Importance.high,
    priority: Priority.high,
    ticker: 'ticker',
  );

  NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  Future.delayed(Duration.zero, () {
    flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title.toString(),
      message.notification!.body.toString(),
      notificationDetails,
    );
  });
}

Future<String?> initNotification() async {
  final token = await firebaseMessaging.getToken();
  print(token);
  return token;
}

void handleMessage(BuildContext context, RemoteMessage message) {
  Get.to(
      () => BlocProvider(
          create: (context) => NotificationBloc(), child: notifications()),
      arguments: [
        message.notification!.title.toString(),
        message.notification!.body.toString(),
      ]);
}
