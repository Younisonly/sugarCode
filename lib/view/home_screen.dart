import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/submetINFO.dart';
import '../widgets/constants.dart';
import 'Details_Screen.dart';
import 'corrictive_dose.dart';
import 'insulin_to_carb.dart';
import 'menuWidget.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Sugary'),
        centerTitle: true,
       leading: MenuWidget(),
        actions: [
          IconButton(onPressed:()=> readBarcode(), icon: FaIcon(FontAwesomeIcons.barcode))
        ],
      ),
      body: GetBuilder<SubmetInfoModel>(
        init: SubmetInfoModel(),
        builder: (controller) => SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              CircularPercentIndicator(
                animation: true,
                animationDuration: 1000,
                radius: 80.0,
                lineWidth: 13.0,
                percent: controller.progressValueCalc(),
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  controller.currentInsulin.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                backgroundColor: Colors.grey[300]!,
                progressColor: controller.progressColorCalc(),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text.rich(TextSpan(
                    text: ' مرحبا,نسبة السكر ',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    children: [
                      TextSpan(
                          text: controller.state(),
                          style: TextStyle(color: controller.text_color()))
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            // adjust the value to your desired radius
                            child: Image.asset('assets/images/insulin.png',
                                width: 40, height: 40),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'آخر قراءة كانت في ${DateFormat('dd MMMM yyyy، hh:mm a', 'ar_SA').format(controller.insuDate)}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                          const SizedBox(width: 5),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              titlePadding: const EdgeInsets.only(
                                  left: 0, right: 0, top: 0, bottom: 30),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: Container(
                                decoration: const BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.refresh, color: Colors.white),
                                      SizedBox(width: 10),
                                      Text('تحديث قراءة السكر',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                              content: Form(
                                key: _formKey,
                                child: TextFormField(
                                  controller: _controller,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.local_hospital,
                                        color: primaryColor),
                                    labelText: 'قراءة السكرالحالي',
                                    hintText: 'أدخل السكر الحالي',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'يرجى إدخال السكر الحالي';
                                    }
                                    int? insulinValue = int.tryParse(value);
                                    if (insulinValue == null ||
                                        insulinValue < 1 ||
                                        insulinValue > 350) {
                                      return 'الرجاء إدخال عدد بين 1 و 350';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    controller.newInsulinValue(value);
                                  },
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('إلغاء',
                                      style: TextStyle(color: primaryColor)),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      controller.updateInsulinValue();
                                      controller.getCurrentInsulin();
                                      Navigator.of(context).pop();
                                      controller.update();
                                    }
                                  },
                                  icon: const Icon(Icons.save),
                                  label: const Text('حفظ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(primaryColor),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text('تحديث'),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  // Get.to(insulinToCarb());
                  Get.to(insulinToCarb());
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, bottom: 15, top: 15),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(22, 160, 133, 1.0),
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
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/carbohydrates.png',
                              fit: BoxFit.cover,
                              width: 40,
                              height: 40,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'حساب الكربوهيدرات',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(CorrectiveDose());
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, bottom: 15, top: 15),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(87, 88, 187, 1.0),
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
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/vaccine.png',
                              fit: BoxFit.cover,
                              width: 40,
                              height: 40,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'حساب الجرعة التحيحية',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
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
      ),
    );
  }




   readBarcode() async {
    var barcode = await FlutterBarcodeScanner.scanBarcode(
      "#000000",
      "Cancel",
      true,
      ScanMode.BARCODE,
    );
    var value = await FirebaseFirestore.instance
        .collection('Products')
        .where('barcode', isEqualTo: barcode)
        .get();
    if (barcode == -1 || barcode == "-1") {
      return HomeScreen();
    }
    else if (value.docs.isNotEmpty) {
      var model = value.docs[0].data() as Map<dynamic, dynamic>;
      Get.to(DetailsScreen(model: model));
    }
    else {
      print(value.docs[0].data() as Map<dynamic, dynamic>);
      Get.snackbar(
        icon: const Icon(
          Icons.error_outline,
          color: Colors.redAccent,
        ),
        "لايوجد تطابق!",
        "لا يوجد منتج مخزن يطابق هذا المنتج!",
        colorText: primaryColor,
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

}
