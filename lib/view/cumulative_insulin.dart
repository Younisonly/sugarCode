import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/constants.dart';
import 'menuWidget.dart';

class cumulativeInsulin extends StatefulWidget {
  @override
  _cumulativeInsulinState createState() => _cumulativeInsulinState();
}

class _cumulativeInsulinState extends State<cumulativeInsulin> {
  List<InsulinEntry> insulinList = [];

  @override
  void initState() {
    super.initState();
    getInsulinList();
  }

  Future<void> getInsulinList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? stringList = prefs.getStringList('insuList');
    if (stringList != null) {
      setState(() {
        insulinList = stringList.map((string) => InsulinEntry.fromString(string)).toList();
      });
    }
  }
  double totalGlucoseLevel = 0;
  double totalReadings = 0;
  double calculateAlSukarLitraky() {

    for (InsulinEntry entry in insulinList) {
      // Assume blood glucose level is equal to insulin value
      totalGlucoseLevel += entry.insulin;
      totalReadings += 1;
    }
    double averageGlucoseLevel = totalGlucoseLevel / totalReadings;
    double hba1c = (averageGlucoseLevel + 46.7) / 28.7;
    return hba1c;
  }
  void showAlSukarLitrakyDialog() {
    double alSukarLitraky = calculateAlSukarLitraky();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.only(
              left: 0, right: 0, top: 0, bottom: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
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
                children:  [
                  SizedBox(width: 10),
                  Text("السكر لتراكمي",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white)),
                ],
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
          children: [
              Image.asset(
                'assets/images/doctor.png',
                width: 120,
                height: 112,
              ),
            Text( " متوسط القراءت هو:  ${(totalGlucoseLevel / totalReadings).toString()}"),

            Text("  السكر التراكمي هو:${alSukarLitraky.toStringAsFixed(2)}"),

            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
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
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('السكر التراكمي'),
        centerTitle: true,
        leading: MenuWidget(),
        backgroundColor: primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Container with image and text
          Container(
            height: 200,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              ),
           
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Image.asset('assets/images/certificate.png', width: 120, height: 120,),
                Text(
                'مرحبا, هنا يمكنك حساب السكر التراكمي بالنسبه لمتوسط القراءت!',
                style: TextStyle(
                  fontSize: 12,

                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                  textAlign: TextAlign.center,
              ),
              ], 
            ),
          ),
          // Table of insulin values
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('التاريخ')),
                  DataColumn(label: Text('القراءة')),
                ],
                rows: insulinList.map((entry) {
                  return DataRow(cells: [
                    DataCell(Text(entry.date)),
                    DataCell(Text(entry.insulin.toString())),
                  ]);
                }).toList(),
              ),
            ),
          ),
          // Button to calculate السكر لتراكمي
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
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
              onPressed: showAlSukarLitrakyDialog,
              child: Text('حساب السكر لتراكمي'),
            ),
          ),
        ],
      ),
    );
  }
}

class InsulinEntry {
  final String date;
  final double insulin;
  final int timestamp;

  InsulinEntry({
    required this.date,
    required this.insulin,
    required this.timestamp,
  });

  factory InsulinEntry.fromString(String string) {
    List<String> parts = string.split(',');
    return InsulinEntry(
      date: parts[0],
      insulin: double.parse(parts[1]),
      timestamp: int.parse(parts[2]),
    );
  }

  @override
  String toString() {
    return '$date, $insulin, $timestamp';
  }
}


