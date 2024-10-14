import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';

//top level
@pragma('vm:entry-point')
Future<void> onBackgroundMessage(RemoteMessage message) async {
  /// It's a custom function that prints to the console.
  // printDebugs(" background $message ${DateTime.now()}");
  // AwesomeNotifications().incrementGlobalBadgeCounter();
  // var count = await AwesomeNotifications().getGlobalBadgeCounter();
  // GFI<HomePageState>()?.badgeCount.value = count;
  // NotificationService.stream.add(count);
}

class FirebaseMessages {
  Future init() async {
    if (GetPlatform.isDesktop) return;

    var token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      GFI<GE>()?.user_updateToken(token);
    }
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      print(event);
      GFI<GE>()?.user_updateToken(event);
    });
    if (kDebugMode) {
      print(
          "////////////////////////////////// firebase token ///////////////////////////////////");
      print(token);
    }

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  }

  _handleForegroundMessage(RemoteMessage message) async {
    //handled internally for ios, not for android
    // if (GetPlatform.isAndroid) NotificationService.handleNotification(message);
    // AwesomeNotifications().incrementGlobalBadgeCounter();
    // var count = await notiService.noti.getGlobalBadgeCounter();
    // NotificationService.stream.add(count);
  }

  _handleMessageOpenedApp(RemoteMessage message) async {
    var map = Map<String, String>.from(message.data);
    // NotificationService.handlePressed(map);
    // var count = await notiService.noti.getGlobalBadgeCounter();
    // NotificationService.stream.add(count);
  }
}

FirebaseMessages _firebaseMessages = FirebaseMessages();
FirebaseMessages get fbMessagesService => _firebaseMessages;
