// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:timezone/timezone.dart' ;
// import 'package:timezone/data/latest.dart' ;
// import '../widgets/constants.dart';
//
// class notifications extends StatefulWidget {
//   @override
//   _notificationsState createState() => _notificationsState();
// }
//
// class _notificationsState extends State<notifications> {
//   late SharedPreferences _prefs;
//    var selectedTime;
//   late Timer _timer;
//   bool _showButton = false;
//   int _notificationCount = 0;
//
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   @override
//   void initState() {
//     super.initState();
//     loadSharedPreferences();
//     initializeNotifications();
//     startTimer();
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
// // ...
//
//   loadSharedPreferences() async {
//     _prefs = await SharedPreferences.getInstance();
//     String? timeString = await _prefs.getString('selected_time');
//     if (timeString != null && timeString.isNotEmpty) {
//       final dateFormat = DateFormat('h:mm a');
//       final parsedTime = dateFormat.parse(timeString);
//       final now = DateTime.now();
//       setState(() {
//         selectedTime = DateTime(
//           now.year,
//           now.month,
//           now.day,
//           parsedTime.hour,
//           parsedTime.minute,
//         );
//       });
//     } else {
//       setState(() {
//         selectedTime = null;
//       });
//     }
//   }
//
//   Future<void> initializeNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('app_icon');
//      IOSInitializationSettings initializationSettingsIOS =
//     IOSInitializationSettings(
//         onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
//      InitializationSettings initializationSettings =
//     InitializationSettings(
//         android: initializationSettingsAndroid,
//         iOS: initializationSettingsIOS);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: _onSelectNotification);
//   }
//
//   Future<void> _scheduleNotifications() async {
//     for (int i = 1; i <= 5; i++) {
//       final NotificationDetails notificationDetails = NotificationDetails(
//           android: AndroidNotificationDetails(
//               'channel_id', 'channel_name', 'channel_description',
//               importance: Importance.max,
//               priority: Priority.high,
//               showWhen: false,
//               icon: 'app_icon'));
//
//
//       await flutterLocalNotificationsPlugin.zonedSchedule(
//         i,
//         'Next Dose',
//         'It is time for your next dose',
//         TZDateTime.from(_getNextNotificationTime(i), tz.guess()),
//         notificationDetails,
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents: DateTimeComponents.time,
//       );
//     }
//   }
//
//   Future<void> _cancelNotifications() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }
//
//   void startTimer() {
//     const oneMinute = Duration(minutes: 1);
//     _timer = Timer.periodic(oneMinute, (timer) {
//       final now = DateTime.now();
//       if (now.hour == selectedTime.hour && now.minute == selectedTime.minute) {
//         setState(() {
//           _showButton = true;
//         });
//         _cancelNotifications();
//       }
//     });
//   }
//
//   Future<void> _onSelectNotification(String? payload) async {
//     debugPrint('Notification clicked: $payload');
//   }
//
//   Future<void> _onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     debugPrint('Notification received: $payload');
//   }
//
//   DateTime _getNextNotificationTime(int count) {
//     return selectedTime.add(Duration(minutes: 15 * count));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: primaryColor,
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//             const Text('الإشعارات'),
//               const SizedBox(width: 10,),
//               const Icon(Icons.notifications),
//
//             ],),
//           // centerTitle: true,
//         ),
//       body:SingleChildScrollView(
//           child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         decoration: const BoxDecoration(),
//                         child: Padding(
//                           padding: const EdgeInsets.all(15),
//                           child: Column(children: [
//                             Image.asset(
//                               "assets/images/appointment.png",
//                               width: 140,
//                               height: 140,
//                             ),
//                             SizedBox(height: 20,),
//                              Text(
//                               "مرحبا، هل حان وقت اخذ الجرعة؟ ستصلك اشعارات عند موعد اخذها.",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(fontSize: 12),
//                             ),
//                           ]),
//                         ),
//                       ),
//
//                       SizedBox(height: 40,),
//                       Container(
//                         padding:
//                         const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                         decoration: BoxDecoration(
//                           color: primaryColor,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Row(
//                           children: [
//                             SizedBox(width: 16),
//                             Text('الجرعه التاليه في: ', style: TextStyle(color: Colors.white),),
//                             SizedBox(width: 20,),
//                             Icon(Icons.access_time, color: Colors.white,),
//                             SizedBox(width: 10,),
//                             Text('${DateFormat(' hh:mm a', 'ar_SA').format(selectedTime)}',  style: TextStyle(color: Colors.white))
//
//
//                           ],
//                         ),
//                       ),
//                       Visibility(
//                         visible: _showButton,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               _showButton = false;
//                             });
//                             _scheduleNotifications();
//                           },
//                           child: Text('تم'),
//                         ),
//                       ),
//                     ]))),
//
//     );
//   }
// }

import 'dart:async';
import 'package:Sugary/view/profile.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/constants.dart';
import 'menuWidget.dart';


class Notifications extends StatelessWidget {

  Widget build(BuildContext context) {
    return GetBuilder<notesController>(
        init: notesController(),
        builder: (controller)=> Scaffold(
      appBar: AppBar(
        leading: MenuWidget(),
        backgroundColor: primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('الإشعارات'),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.notifications),
          ],
        ),
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(children: [
                    Image.asset(
                      "assets/images/appointment.png",
                      width: 140,
                      height: 140,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "مرحبا، هل حان وقت اخذ الجرعة؟ ستصلك اشعارات عند موعد اخذها.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ]),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        const Text(
                          'الجرعه التاليه في: ',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(
                          Icons.access_time,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        checkTime(controller.selectedTime)
                      ],
                    ),
                    Visibility(
                      visible: controller._showButton,
                      child: ElevatedButton(
                        onPressed: () {

                            controller._showButton = false;

                          controller._cancelNotifications();
                          controller.update();
                        },
                        child: const Text('لقد اخذتها'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Icon(Icons.notification_important_outlined),
              Text(
                "يمكنك تعيين وقت التنبيه من إعدادات المستخدم!",
                style: TextStyle(fontSize: 12),
              ),

            ],
          ),
        ),
      ),
    ));
  }

  Widget checkTime(var selectedTime) {

    if (selectedTime == null) {
      return const Flexible(
        child: Text(
          'لم يتم تحديد وقت للتنبيهات!',
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return Text(
        '${DateFormat(' hh:mm a', 'ar_SA').format(selectedTime)}',
        style: const TextStyle(color: Colors.white),
      );
    }
  }
}
class notesController extends GetxController {

  late SharedPreferences _prefs;
  var selectedTime;
  late Timer _timer;
  bool _showButton = false;
@override
  void onInit() {
  loadSharedPreferences();
  startTimer();
  super.onInit();
  update();
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  loadSharedPreferences()  async {
      _prefs = await SharedPreferences.getInstance();
      String? timeString = await _prefs.getString('selected_time');
      if (timeString != null && timeString.isNotEmpty) {
        final dateFormat = DateFormat('h:mm a');
        final parsedTime = dateFormat.parse(timeString);
        final now = DateTime.now();
          selectedTime = DateTime(
            now.year,
            now.month,
            now.day,
            parsedTime.hour,
            parsedTime.minute,
          );

      } else {

          selectedTime = null;

      }
    update();

  }

  Future<void> _scheduleNotifications() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: 'basic_channel',
        title: 'وقت أخذ الجرعة',
        body: 'لقد حان الوقت لأخذ الجرعة اليومية',
        color: const Color(0xff00bcd4),
        backgroundColor: const Color(0xffb2ebf2),
        // payload: {'route': '/notifications'},
        displayOnForeground: true,
        displayOnBackground: true,
        locked: true,
      ),
    );


  }

  Future<void> _cancelNotifications() async {
    await AwesomeNotifications().cancelAll();
  }

  void startTimer() {
    const oneMinute = Duration(minutes: 1);
    _timer = Timer.periodic(oneMinute, (timer) {
      final now = DateTime.now();
      if (now.hour == selectedTime.hour && now.minute == selectedTime.minute) {

          _showButton = true;

        _scheduleNotifications();
        _timer.cancel();
        update();
      }
    });
  }

}

