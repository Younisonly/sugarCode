import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/constants.dart';

class CorrectiveDose extends StatefulWidget {
  const CorrectiveDose({Key? key}) : super(key: key);

  @override
  _CorrectiveDoseState createState() => _CorrectiveDoseState();
}

class _CorrectiveDoseState extends State<CorrectiveDose> {
  final TextEditingController correctiveFactorController =
  TextEditingController();
  final TextEditingController goalController = TextEditingController();
  final TextEditingController insulinController = TextEditingController();
  final TextEditingController correctiveDoseController =
  TextEditingController();

  @override
  void dispose() {
    correctiveFactorController.dispose();
    goalController.dispose();
    insulinController.dispose();
    correctiveDoseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('حساب الجرعة التصحيحية'),
        centerTitle: true,
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(

                decoration: BoxDecoration(

                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(children:[
                     Image.asset("assets/images/blood.png", width: 120,height:120 ,),
                    Text(
                      "مرحبا, يمكنك حساب الجرعة التصحيحيه عن طريق ملأ الحقول في الاسفل.",
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 12),
                    ),
  ] ),
                ),
              ),

              const Divider(thickness: 2),
              const SizedBox(height: 30),
              TextField(
                controller: correctiveFactorController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'معامل التصحيح',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: goalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'الهدف',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: insulinController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'نسبة السكر',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  double correctiveFactor =
                      double.tryParse(correctiveFactorController.text) ?? 0.0;
                  double goal = double.tryParse(goalController.text) ?? 0.0;
                  double currentInsulin =
                      double.tryParse(insulinController.text) ?? 0.0;
                  double correctiveResult =
                      (currentInsulin - goal) / correctiveFactor;
                  setState(() {
                    if (correctiveResult < 0) {
                      correctiveDoseController.text = "تاكد من المدخلات";
                    } else if (correctiveFactor == 0.0 ||
                        goal == 0.0 ||
                        currentInsulin == 0.0) {
                      correctiveDoseController.text = "!لا يمكن حساب الحقول الفارغة";
                    } else {
                      correctiveDoseController.text =
                          "الجرعة التصحيحية هي: " +
                              correctiveResult.toStringAsFixed(1);
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
                                  correctiveDoseController.text,
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
                decoration: BoxDecoration(
                ),
                child: Text(correctiveDoseController.text,
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