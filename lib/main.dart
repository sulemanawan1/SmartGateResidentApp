import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:userapp/Routes/routes_managment.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:userapp/Routes/set_routes.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
const String YOUR_APP_KEY = '3c358bce6465e1821b3b';
late PusherClient pusher;

main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings("@mipmap/ic_launcher");

  // final DarwinInitializationSettings initializationSettingsDarwin =
  // DarwinInitializationSettings(
  //   requestAlertPermission: true,
  //   requestSoundPermission: true,
  //   defaultPresentBadge: true,
  //   defaultPresentSound: true,
  //   requestBadgePermission: true
  //
  //
  //     );

  InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    // iOS:  initializationSettingsDarwin
  );
  bool? initialized = await flutterLocalNotificationsPlugin
      .initialize(initializationSettings,
          onDidReceiveNotificationResponse: (NotificationResponse e) {
    print(e.payload);
  });
  print(initialized.toString());

  // flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

  runApp(MyApp());
}

// void onDidReceiveLocalNotification(
//     int id, String title, String body, String payload) async {
//   // display a dialog with the notification details, tap ok to go to another page
//   showDialog(
//     context: context,
//     builder: (BuildContext context) => CupertinoAlertDialog(
//       title: Text(title),
//       content: Text(body),
//       actions: [
//         CupertinoDialogAction(
//           isDefaultAction: true,
//           child: Text('Ok'),
//           onPressed: () async {
//             Navigator.of(context, rootNavigator: true).pop();
//             await Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => SecondScreen(payload),
//               ),
//              );
//           },
//         )
//       ],
//     ),
//    );
// }

void checkForNotifications() async {
  NotificationAppLaunchDetails? no =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  print(no?.notificationResponse?.payload);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("s" + message.from.toString());
  print("s" + message.category.toString());
  print("s" + message.data.toString());

  print("Handling a background message: ${message}");

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    Get.toNamed(splashscreen);
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Handle the received message
    Get.toNamed(splashscreen);
  });
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
    //     AndroidFlutterLocalNotificationsPlugin>()!.requestPermission();
    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;

      print('Fire Base token');
      print('--------');
      print(token);
      print('--------');
    });
    checkForNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: splashscreen,
      getPages: RouteManagement.getPages(),
    );
  }
}
