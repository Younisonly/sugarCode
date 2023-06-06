import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../model/submetINFO.dart';
import '../widgets/constants.dart';
import '../widgets/custom_text.dart';

class AddScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKeyPro = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyMeal = GlobalKey<FormState>();
  final List<Widget> myTabs = [
     Tab(
      child:
      Row(children: [
        Icon(Icons.add_shopping_cart_outlined, color: Colors.white),
        SizedBox(width: 15,),
        Text('أضف منتج'),
      ],),
    ),
     Tab(
      child: Row(children: [
        Icon(Icons.fastfood_outlined, color: Colors.white),
        SizedBox(width: 15,),
        Text('أضف طبق'),
      ]),
    ),
  ];


  void resetFields(SubmetInfoModel controller) {
    controller.productName = '';
    controller.productCarb = '0';
    controller.ProductImage = null;
    controller.barcode = null;
    _formKeyPro.currentState?.reset();

    controller.MealName = '';
    controller.MealCategory = '';
    controller.MealImage = null;
    controller.Mealcarb = '0';
    _formKeyMeal.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubmetInfoModel>(
        init: SubmetInfoModel(),
        builder: (controller) => DefaultTabController(
              length: myTabs.length,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'أضف',
                    style: TextStyle(color: Colors.white),
                  ),
                  centerTitle: true,
                  backgroundColor: primaryColor,
                  elevation: 0,
                  bottom: TabBar(
                    onTap: (index){
                    },
                    tabs: myTabs,
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white.withOpacity(0.7),
                    indicatorColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                ),
                body: TabBarView(
                  children: [
                    // Content of the "Add Product" tab
                    Form(
                      key: _formKeyPro,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            CustomText(
                              text: 'اسم المنتج',
                              fontSize: 14,
                              color: Colors.grey[800]!,
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                maxLength: 15,
                                onSaved: (value) =>
                                    {controller.productName = value!},
                                decoration: InputDecoration(
                                  labelText: 'ادخل اسم المنتج',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            CustomText(
                              text: 'الكربوهيدرات',
                              fontSize: 16,
                              color: Colors.grey[800]!,
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                maxLength: 15,
                                onSaved: (value) =>
                                    {controller.productCarb = value!},
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'أدخل نسبة الكربوهيدرات',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ), const SizedBox(height: 30),
                            CustomText(
                              text: 'الكمية',
                              fontSize: 16,
                              color: Colors.grey[800]!,
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                onSaved: (value) =>
                                {controller.productAmount = value!},
                                decoration: InputDecoration(
                                  labelText: 'أدخل الكمية',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(170),
                                  border: Border.all(color: primaryColor)),
                              width: MediaQuery.of(context).size.width - 130,
                              height: 170,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: ClipRRect(child: controller.DisplayProImage(), borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 90,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      controller.choseProIMageGal();
                                    },
                                    icon: const Icon(
                                      Icons.add_photo_alternate_rounded,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Container(
                                  width: 90,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      controller.choseProIMageCam();
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_rounded,
                                      color: primaryColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 90,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      controller.barcodeReader();
                                    },
                                    icon: const FaIcon(
                                      FontAwesomeIcons.barcode,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                controller.barcodeValue(),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  _formKeyPro.currentState?.save();
                                  if (_formKeyPro.currentState!.validate()) {
                                    controller.submitProduct();
                                  }
                                },
                                style: TextButton.styleFrom(
                                  // minimumSize: Size(80, 50),
                                  maximumSize: const Size(200, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  backgroundColor: primaryColor,
                                ),
                                child: const CustomText(
                                  alignment: Alignment.center,
                                  text: 'أضف منتج',
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Content of the "Add Meal" tab
                    Form(
                      key: _formKeyMeal,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            CustomText(
                              text: 'اسم الطبق',
                              fontSize: 16,
                              color: Colors.grey[800]!,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              maxLength: 15,
                              onSaved: (value) =>
                                  {controller.MealName = value!},
                              decoration: InputDecoration(
                                labelText: ' ادخل اسم الطبق',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                const SizedBox(width: 20),
                                CustomText(
                                  text: 'التصنيف',
                                  fontSize: 16,
                                  color: Colors.grey[800]!,
                                ),
                                const SizedBox(width: 45),
                                DropdownButton(
                                  hint: const CustomText(
                                    text: 'اختر تصنيف',
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                  icon: const Icon(Icons.arrow_drop_down),
                                  onChanged: (newValue) {
                                    controller.SelectedCategory(newValue);
                                  },
                                  value: controller.MealCategory,
                                  items:
                                      controller.categoryItems.map((valueItem) {
                                    return DropdownMenuItem(
                                      value: valueItem,
                                      child: Text(valueItem),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(170),
                                  border: Border.all(color: Colors.black)),
                              width: MediaQuery.of(context).size.width - 130,
                              height: 170,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: ClipRRect(child: controller.displyMealImage(), borderRadius: BorderRadius.circular(50),),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 90,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      controller.choseMealFromgallery();
                                    },
                                    icon: const Icon(
                                      Icons.add_photo_alternate_rounded,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Container(
                                  width: 90,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      controller.choseMealFromCamera();
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_rounded,
                                      color: primaryColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 30),
                            CustomText(
                              text: 'الكربوهيدرات',
                              fontSize: 16,
                              color: Colors.grey[800]!,
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                maxLength: 15,
                                onSaved: (value) =>
                                    {controller.Mealcarb = value!},
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'أدخل نسبة الكربوهيدرات',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(height: 30),
                            CustomText(
                              text: 'الكمية',
                              fontSize: 16,
                              color: Colors.grey[800]!,
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                onSaved: (value) =>
                                {controller.MealAmount = value!},
                                decoration: InputDecoration(
                                  labelText: 'أدخل الكمية',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () {

                                _formKeyMeal.currentState?.save();
                                  if (_formKeyMeal.currentState!.validate()) {
                                    controller.submitMeal();
                                  }
                                },
                                style: TextButton.styleFrom(
                                  // minimumSize: Size(80, 50),
                                  maximumSize: const Size(200, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  backgroundColor: primaryColor,
                                ),
                                child: const CustomText(
                                  alignment: Alignment.center,
                                  text: 'أضف طبق',
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
