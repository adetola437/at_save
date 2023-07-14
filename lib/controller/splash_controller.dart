import 'package:at_save/controller/onboarding_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

import '../shared_preferences/session_manager.dart';
import '../view/screens/splash_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashController createState() => SplashController();
}

class SplashController extends State<Splash> {
  //initializing local settings to acess device settings
  SessionManager manager = SessionManager();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    delay();
    requestPermission();
    getToken();
    getMytoken();
    initInfo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

//get the device token from shared preferences
  getMytoken() async {
    var token = await manager.getMessagingToken();
    print(token);
  }

//delay the splash screen
  wait() async {
    await Future.delayed(const Duration(seconds: 2), () async {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const OnboardingScreen(),
      ));
    });
  }

  /// handles getting permission from user for app to acces device notification
  void requestPermission() async {
    FirebaseMessaging message = FirebaseMessaging.instance;
    NotificationSettings settings = await message.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission'); //when the user accepts the prompt
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional authorization');
    } else {
      print('User declined');
    }
  }

// hanldes getting the device toe\ken from the device and saving the token in shared preferences
  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      print(value);
      manager.saveMessagingToken(value!);
    });
  }

  void initInfo() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iOSInitialize,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        try {} catch (e) {}
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a foreground notification:');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      displayNotification(message);

      // BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      //     message.notification!.body.toString(),
      //     htmlFormatBigText: true,
      //     contentTitle: message.notification!.title.toString(),
      //     htmlFormatContentTitle: true);

      // AndroidNotificationDetails androidPlatform = AndroidNotificationDetails(
      //     'dbfood', 'dbfood',
      //     importance: Importance.high,
      //     styleInformation: bigTextStyleInformation,
      //     playSound: true);
      // NotificationDetails platformChannel = NotificationDetails(
      //     android: androidPlatform, iOS: const DarwinNotificationDetails());
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('User tapped on the notification:');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
    });

    // Handle the initial notification when the app is launched from a terminated state
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      print('App launched from a terminated state:');
      print('Title: ${initialMessage.notification?.title}');
      print('Body: ${initialMessage.notification?.body}');
    }
  }

  /// displays the notificstion even when the app is in foreground
  Future<void> displayNotification(RemoteMessage message) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_id',
      'Channel Name',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: const DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
    );
  }

  delay() async {
    await Future.delayed(const Duration(seconds: 2), () async {
      bool? status = await manager.seenOnboardingScreen();
      if (status == true) {
        context.go('/welcome');
      } else {
        context.go('/onBoarding');
      }

      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //   builder: (context) => const OnboardingScreen(),
      // ));
    });
  }

  @override
  Widget build(BuildContext context) => SplashScreen(this);
}
