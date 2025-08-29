import 'dart:convert';

import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/provider/complaint_provider.dart';
import 'package:digitalsaathi/provider/content_provider.dart';
import 'package:digitalsaathi/provider/follow_provider.dart';
import 'package:digitalsaathi/provider/home_provider.dart';
import 'package:digitalsaathi/provider/meeeting_provider.dart';
import 'package:digitalsaathi/provider/notification_provider.dart';
import 'package:digitalsaathi/provider/poster_provider.dart';
import 'package:digitalsaathi/provider/profile_provider.dart';
import 'package:digitalsaathi/provider/progress_provider.dart';
import 'package:digitalsaathi/provider/register_provider.dart';
import 'package:digitalsaathi/provider/task_provider.dart';
import 'package:digitalsaathi/provider/theme_provider.dart';
import 'package:digitalsaathi/provider/worker_report_provider.dart';
import 'package:digitalsaathi/ui/authentication_screen/login_screen.dart';
import 'package:digitalsaathi/ui/more/chat_screen/hive_services/hive_service_init.dart';
import 'package:digitalsaathi/ui/more/meeting/meeting_screen/meeting_screen.dart';
import 'package:digitalsaathi/ui/more/poster/poster.dart';
import 'package:digitalsaathi/ui/more/poster/poster_font_size_adjuster/FontSizeController.dart';
import 'package:digitalsaathi/ui/more/task/task.dart';
import 'package:digitalsaathi/ui/splash/splash_screen.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:digitalsaathi/utils/prefrence/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'provider/login_provider.dart';

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
}

@pragma('vm:entry-point')
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HiveServiceInit.init();
  await Firebase.initializeApp();

  // await Firebase.initializeApp(
  //     options: FirebaseOptions(
  //         apiKey: "AIzaSyAh-xiux843ByHrukkX1YHCd8ndxbAxC9c",
  //         appId: "1:634317659682:web:b4ac96339f1b02eeca747b",
  //         messagingSenderId: '134614815652',
  //         projectId: "maxico-city")
  // );


  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fcmSetup();
    setFcmToken();
    init();
  }
  Future<void> init() async {
    await Prefs.init();
  }

  setFcmToken() async {
    await firebaseMessaging.requestPermission(
        badge: true, sound: true, alert: true);
    firebaseMessaging.getToken().then((token) {
      AppUrl.FCM_TOKEN = token!;
    });
  }

  void fcmSetup() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {

      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {

    Get.snackbar(
        backgroundColor: ColorUtils.colorBlack,
        colorText: ColorUtils.colorWhite,
        onTap: (v){
          onNotificationTap(message.data["type"]??"custom","0");
        },
        message.notification!.title.toString(), message.notification!.body.toString());
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      onNotificationTap(message.data["type"]??"custom",message.data["role_id"]??"0");
    });
  }

  onNotificationTap(String value,String roleId) {
    switch (value) {
      case "POSTER":
        Get.to(PosterScreen());
        break;

      case "Meeting":
        Get.to(MeetingScreen());
        break;

      case "custom":
        break;

      case "":
        break;

      default:
        Get.to(TaskScreen(initialTabIndex: int.parse(roleId),));

        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DarkThemeProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => MeetingProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => PosterProvidder()),
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
        ChangeNotifierProvider(create: (_) => ComplaintProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => WorkerReportProvider()),
        ChangeNotifierProvider(create: (_) => FollowProvider()),
        ChangeNotifierProvider(create: (_) => ContentProvider()),
      ],
      child: Builder(
          builder: (context) {
            return Consumer<DarkThemeProvider>(
              builder: (context, themeProvider, child) {
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: themeProvider.currentTheme,
                  home: const SplashScreen(),
                  builder: EasyLoading.init(),
                );
              },
            );
          }
        )
    );
  }
}

