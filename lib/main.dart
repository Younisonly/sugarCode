import 'package:Sugary/view/add.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'firebase_options.dart';
import 'view_model/auth.dart';
import 'view_model/controller.dart';

void main() async {


  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: "basic_channel",
          channelName: 'Basic notifications',
          channelDescription: 'notification channel for basic test',
        ),
      ],
      debug: true);

  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize locale data for Arabic language
  await initializeDateFormatting('ar_SA');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      getPages: [
        GetPage(name: '/add', page: () => AddScreen()),
      ],
      debugShowCheckedModeBanner: false,
      textDirection: TextDirection.rtl,
      home: Scaffold(
        body: GetBuilder<Auth>(
          init: Get.put(Auth()),
          builder: (value) => ControlView(),
        ),
      ),
    );
  }
}
