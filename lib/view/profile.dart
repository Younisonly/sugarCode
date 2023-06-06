import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../widgets/constants.dart';
import '../widgets/custom_text.dart';
import 'login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'menuWidget.dart';
class profile extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Users_Info>(
        init: Users_Info(),
        builder: (controller)=>
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: MenuWidget(),
            title: const Text(
              "اعدادات المستخدم",
              style: TextStyle(fontSize: 16),
            ),
            backgroundColor: primaryColor,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconButton(
                    onPressed: () {
                      _auth.signOut();
                      Get.offAll(LoginScreen());
                    },
                    icon: const FaIcon(
                      Icons.logout_sharp,
                      color: Colors.white,
                    )),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'assets/images/process.png',
                  width: 140,
                  height: 140,
                ),
                const Text(
                  "مرحبا,",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    'هنا تعرض بيانات المستخدم الحالي, ايضا يمكنك تغيير وقت التنبيهات عن طريق ضغط الزر في الاسفل.',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(0, 6), // Shadow position
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                color: primaryColor,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                "${controller.info['name'].toString()}",
                                style: const TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.email_outlined,
                                color: primaryColor,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              CustomText(
                                text: "${controller.info['email'].toString()}",
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    controller.showDialog(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30,bottom: 15,top: 15),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(22, 160, 133,1.0),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.timer_outlined, color: Colors.white,),
                            SizedBox(width: 10,),
                            Text(
                              'تعديل اوقات التنبيهات',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );

  }
}

class Users_Info extends GetxController {

  var info={};

  Users_Info() {
    getUserData();
    update();
  }

   getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final email = await prefs.getString('email') ?? '';
      final name = await prefs.getString('name') ?? '';
      final type = await prefs.getString('type') ?? '';
print ('+++++++++++++++++++++++++++++++++');
       info= {'email': email, 'name': name, 'type': type};
       print(info);

    } catch (error) {
       print('Error getting user data: $error');

    }
    update();
  }

  final TextEditingController timeController = TextEditingController();
  TimeOfDay selectedTime=TimeOfDay.now();

  @override
  void onInit() {
    _loadTime();
    super.onInit();
  }

  void showDialog(BuildContext  context) {
    Get.dialog(

      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/order.png', width: 120,height: 120,),
             Text("حدد وقت اخذ الجرعة لتحصل على تنبيهات!", textAlign: TextAlign.center,),
              const SizedBox(height: 16.0),
              TextField(
                controller: timeController,
                readOnly: true,
                onTap: _selectTime,
                decoration: const InputDecoration(
                  labelText: 'Time',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(children: [
                TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('إلغاء',
                    style: TextStyle(color: primaryColor)),
              ),
                ElevatedButton(
                  onPressed: () {
                     _saveTime();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('حفظ'),
                ),
              ],),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: selectedTime,
    );
    if (picked != null) {
      selectedTime = picked;
      final String formattedTime = selectedTime.format(Get.context!);
      timeController.text = formattedTime;
    }
  }

  Future<void> _saveTime() async {
    if (selectedTime == null) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_time', selectedTime.format(Get.context!));
    Get.back();
  }

  Future<void> _loadTime() async {
    final prefs = await SharedPreferences.getInstance();
    final timeString = prefs.getString('selected_time');
    if (timeString != null) {
      selectedTime = TimeOfDay(
        hour: int.parse(timeString.split(':')[0]),
        minute: int.parse(timeString.split(':')[1]),
      );
      timeController.text = selectedTime.format(Get.context!);
    }
  }
}
