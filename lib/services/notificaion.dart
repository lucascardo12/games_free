import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

class NotificFCM extends GetxService {
  String? token;
  late Stream<String> tokenStream;
  Future<NotificFCM> inicia() async {
    await Firebase.initializeApp();
    await AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        'resource://drawable/launcher_icon',
        [
          NotificationChannel(
              channelKey: 'Geral',
              channelName: 'Notificações em geral',
              channelDescription: 'Notificações Basicas em geral',
              defaultColor: Colors.white,
              ledColor: Colors.white)
        ]);

    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        // Insert here your friendly dialog box before call the request method
        // This is very important to not harm the user experience
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    firebaseMessaging();
    return this;
  }

  Future<void> showFullScreenNotification(
      {required int id, required String title, required String body}) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'Geral',
        title: title,
        body: body,
      ),
    );
  }

  void notificacaoDeToque() {
    AwesomeNotifications().actionStream.listen((receivedNotification) {
      Get.toNamed('/NotificationPage', arguments: {
        "receive": receivedNotification
      } // your page params. I recommend to you to pass all *receivedNotification* object
          );
    });
  }

  void setToken(String? ptoken) {
    token = ptoken ?? "";
  }

  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }

  firebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data['msgId']}');

      if (message.notification != null) {
        showFullScreenNotification(
            title: message.notification!.title!,
            body: message.notification!.body!,
            id: int.parse(message.data['msgId']));
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future<void> gettoken() async {
    await FirebaseMessaging.instance.getToken().then(setToken);
    tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    tokenStream.listen(setToken);
    print('FCM Token: $token');
  }
}
