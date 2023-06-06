import 'package:Sugary/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../view_model/ZoomDrawer.dart';
import '../widgets/constants.dart';
import '../widgets/custom_text.dart';
import 'minueScreen.dart' as MenuItem;
import 'minueScreen.dart';

class DetailsScreen extends StatelessWidget {
  final Map<dynamic, dynamic> model;

  const DetailsScreen({super.key, required this.model});

  @override
  build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            model['name'],
            style: const TextStyle(fontSize: 16),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(0, 6), // Shadow position
                    ),
                  ],
                ),
                width: 250,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect (
                    child: Image.network(
                      model['image'],
                      fit: BoxFit.fitHeight,
                    ),
                    borderRadius: BorderRadius.circular(50),

                  ),
                )),
            const SizedBox(
              height: 30,
            ),
            HasCategory(),
            const SizedBox(height: 10),
            Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromRGBO(248, 247, 238, 1),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(0, 4), // Shadow position
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Image.asset('assets/images/receptionist.png', width: 90,height: 95,),
                            const SizedBox(
                              height: 10,
                            ),
                            Text.rich(TextSpan(
                                text: " هذا ${model['type']}",
                                children: [
                                  const TextSpan(text: " يحتوي "),
                                  TextSpan(
                                      text: " ${model['Carb']}g",
                                      style:
                                          const TextStyle(color: Colors.red)),
                                   TextSpan(text: " كربوهيدرات لكل ${model['amount']} "),
                                ])),
                          ],
                        ),
                      ),
                    )
                  ],
                ))
          ],
        )));
  }

  Widget HasCategory() {
    if (model['type'] == 'الطبق') {
      return Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: CustomText(
              text: " الصنف: ",
              fontSize: 14,
            ),
          ),
          CustomText(
            text: "  ${model['category'] ?? ""}",
            fontSize: 14,
            color: primaryColor,
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
