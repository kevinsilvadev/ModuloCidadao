import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modulo_cidadao/screens/metodosPagamento.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "4",
    "ZonaAzulChannel",
    description: "notification channel",
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling bg message ${message.messageId}");
}
Future<void> saveTokenToDatabase(String placaVeiculo) async {
  // Assume user is logged in for this example
  String? token = await FirebaseMessaging.instance.getToken();
  HttpsCallable callable = FirebaseFunctions.instanceFor(region: "southamerica-east1").httpsCallable('addMessagingToken');
  final resp = await callable.call(<String, dynamic>{
    'token': token,
    'placaVeiculo':placaVeiculo
  });
  print("result: ${resp.data}");
}

Future<void> setOptions() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

