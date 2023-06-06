import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/constants.dart';

class insulinToCarb extends StatefulWidget {
  const insulinToCarb({Key? key}) : super(key: key);

  @override
  _insulinToCarbState createState() => _insulinToCarbState();
}

class _insulinToCarbState extends State<insulinToCarb> {
  final TextEditingController carbFactorController = TextEditingController();
  final TextEditingController carbIntakeController = TextEditingController();
  final TextEditingController insulinController = TextEditingController();
  final TextEditingController carbDoseController = TextEditingController();

  @override
  void dispose() {
    carbFactorController.dispose();
    carbIntakeController.dispose();
    insulinController.dispose();
    carbDoseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('حساب الكربوهيدرات'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/nutritionist.png",
                        width: 120,
                        height: 120,
                      ),
                      Text(
                        "مرحبا, يمكن حساب الإنسولين بالنسبة للكربوهيدرات, عن طريق ملأ الحقول في الاسفل.",
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 12,

                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(thickness: 2),
              const SizedBox(height: 30),
              TextField(
                controller: carbFactorController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                decoration: InputDecoration(
                  labelText: 'معامل الكربوهيدرات',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: carbIntakeController,
                keyboardType: TextInputType.number,
                maxLength: 4,

                decoration: InputDecoration(
                  labelText: 'كمية الكربوهيدرات ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  double carbFactor =
                      double.tryParse(carbFactorController.text) ?? 0.0;
                  double carbIntake =
                      double.tryParse(carbIntakeController.text) ?? 0.0;
                  double InsulinUnits = carbIntake / carbFactor ;
                  setState(() {
                    if (InsulinUnits.isNaN) {
                      carbDoseController.text = "!لا يمكن حساب الحقول الفارغة ";
                    } else if (carbFactor == 0.0 ||
                        carbIntake == 0.0
                        ) {
                      carbDoseController.text = "لا يمكن حساب الحقول الفارغة!";
                    }
                    else {
                      carbDoseController.text =
                          "عدد وحدات الإنسولين هي: " +
                              InsulinUnits.toStringAsFixed(1);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            titlePadding: const EdgeInsets.only(
                                left: 0, right: 0, top: 0, bottom: 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/doctor.png',
                                  width: 120,
                                  height: 112,
                                ),
                                Text(
                                  carbDoseController.text,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
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
                                  child: const Text('حسناً'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.zero,
                  primary: const Color.fromRGBO(50, 205, 50, 1),
                  elevation: 0,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const SizedBox(
                  height: 50,
                  width: 130,
                  child: Center(child: Text('أحسب')),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(),
                child: Text(
                  carbDoseController.text,
                  textDirection: TextDirection.rtl,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}