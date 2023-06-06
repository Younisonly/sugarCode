import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubmetInfoModel extends GetxController {
  var productName,  productCarb, ProductImage, barcode, productAmount;
  var MealName,  MealCategory, MealImage, Mealcarb, MealAmount;
  List<String> categoryItems=["فطور","غداء" , "عشاء"];
  final imagePicker = ImagePicker();

  checkIfAllowed() async {

   await  AwesomeNotifications().isNotificationAllowed().then((isAllowed)
    async {
      if(!isAllowed){
       await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });


  }
  @override
  void onInit() {
    update();
    checkIfAllowed();
    getCurrentInsulin();
    progressValueCalc();
    progressColorCalc();
    displyMealImage();
    DisplayProImage();
    update();
  }

  Widget displyMealImage() {
      if (MealImage == null) {
      return Image.asset(
        "assets/images/no_Image.jpg",
        fit: BoxFit.contain,
      );
    }
      else {
      return Image.file(
        MealImage,
        fit: BoxFit.contain,
      );
    }

  }
  Widget DisplayProImage(){
    if (ProductImage == null) {
      return Image.asset(
        "assets/images/no_Image.jpg",
        fit: BoxFit.contain,
      );
    }
    else {
      return Image.file(
        ProductImage,
        fit: BoxFit.contain,
      );
    }
  }
  choseMealFromCamera() async {
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
        MealImage = File(pickedImage.path);
        displyMealImage();
    update();}
  }
  choseProIMageCam() async {
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      ProductImage = File(pickedImage.path);
      DisplayProImage();
      update();
    }

  }
  choseMealFromgallery() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
        MealImage = File(pickedImage.path);
    }
    update();
  }
  choseProIMageGal() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      ProductImage = File(pickedImage.path);
      update();
    }
  }
  Widget barcodeValue() {
    update();
    if (barcode == null || barcode == '-1') {
      return Text('No barcode!');
    } else {
      return Text(barcode);
    }

  }
  Future barcodeReader() async {
    barcode = await FlutterBarcodeScanner.scanBarcode(
        "#000000", "Cancel", true, ScanMode.BARCODE);
    barcodeValue();
    update();
  }
   SelectedCategory(var x) {
   MealCategory = x;
   update();
  }
  submitProduct() async {
    try {
      if (productName == null || productName == "") {
        Get.snackbar(
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          "حقل فارغ!",
          "حقل اللاسم يجب ان لا يكون فارغا!ً",
          colorText: Colors.redAccent,
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      else if (productCarb == null) {
        Get.snackbar(
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          "حقل فارغ!",
          "حقل الكربوهيدرات يجب ان لا يكون فارغا!ً",
          colorText: Colors.redAccent,
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      else if (ProductImage == null) {
        Get.snackbar(
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          "حقل فارغ!",
          "حقل الصورة يجب ان لا يكون فارغا!ً",
          colorText: Colors.redAccent,
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      else if (barcode == null) {
        Get.snackbar(
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          "حقل فارغ!",
          " يجب اختيار رقم تسلسلي للمنتج (barcode)!",
          colorText: Colors.redAccent,
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }

      else {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;

        // Check if there are any existing documents with the same name
        final QuerySnapshot existingProducts = await firestore
            .collection('Products')
            .where('name', isEqualTo: productName)
            .get();

        if (existingProducts.docs.isNotEmpty) {
          Get.snackbar(
            icon: const Icon(
              Icons.error,
              color: Colors.red,
            ),
            "اسم المنتج موجود مسبقاً!",
            "يوجد منتج بنفس الاسم في قاعدة البيانات.",
            colorText: Colors.redAccent,
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        else {
          // Upload the product image to Firebase Storage
          var imageURL;
          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDirImages = referenceRoot.child('');
          Reference referenceImageToUpload =
          referenceDirImages.child(productName);
          await referenceImageToUpload.putFile(File(ProductImage.path));
          await referenceImageToUpload.getDownloadURL().then((value) {
            imageURL = value;
          });

          // Add the product to the Firebase collection
          await firestore.collection('Products').add({
            'name': productName,
            'image': imageURL,
            'amount':productAmount,
            'barcode': barcode,
            'Carb': productCarb,
            'type': "منتج",
            'ProductID': FirebaseFirestore.instance.collection('Products').doc().id,
          });

          // Show success message using GetX package
          Get.snackbar(
            icon: const Icon(
              Icons.done_all,
              color: Colors.green,
            ),
            "تمت العملية بنجاح",
            "تمت إضافة منتج الى قاعدة البيانات!",
            colorText: Colors.green,
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        icon: Icon(Icons.error),
        'حدث خطاء اثناء إضافه منتج!',
        e.toString(),
        backgroundColor: Colors.white,
        colorText: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  submitMeal() async {
    try {
      if (MealName == null || MealName == "") {
        Get.snackbar(
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          "حقل فارغ!",
          "حقل اللاسم يجب ان لا يكون فارغا!ً",
          colorText: Colors.redAccent,
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      else if (MealCategory == null) {
        Get.snackbar(
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          "حقل فارغ!",
          "حقل التصنيف يجب ان لا يكون فارغا!ً",
          colorText: Colors.redAccent,
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      else if (MealImage == null) {
        Get.snackbar(
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          "حقل فارغ!",
          "حقل الصورة يجب ان لا يكون فارغا!ً",
          colorText: Colors.redAccent,
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      else if (Mealcarb == null) {
        Get.snackbar(
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          "حقل فارغ!",
          "حقل الكربوهيدرات يجب ان لا يكون فارغا!ً",
          colorText: Colors.redAccent,
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      else if (MealAmount == null) {
        Get.snackbar(
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          "حقل فارغ!",
          "حقل الكمية يجب ان لا يكون فارغا!ً",
          colorText: Colors.redAccent,
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }

      else {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;

        // Check if there are any existing documents with the same name
        final QuerySnapshot existingProducts = await firestore
            .collection('Meals')
            .where('name', isEqualTo: MealName)
            .get();

        if (existingProducts.docs.isNotEmpty) {
          Get.snackbar(
            icon: const Icon(
              Icons.error,
              color: Colors.red,
            ),
            "اسم الطبق موجود مسبقاً!",
            "يوجد طبق بنفس الاسم في قاعدة البيانات.",
            colorText: Colors.redAccent,
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        else {
        var imageURL;
        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference referenceDirImages = referenceRoot.child('');
        Reference referenceImageToUpload =
        referenceDirImages.child(MealName);
        await referenceImageToUpload.putFile(File(MealImage.path));
        final FirebaseFirestore firestore = FirebaseFirestore.instance;

        await referenceImageToUpload.getDownloadURL().then((value) {
          imageURL = value;
        });
        await firestore.collection('Meals').add({
          'name': MealName,
          'Carb':Mealcarb,
          'amount':MealAmount,
          'type':"الطبق",
          'image': imageURL,
          'category':MealCategory,
          'MealID':FirebaseFirestore.instance.collection('Meal').doc().id,
        });
        Get.snackbar(
          icon: const Icon(
            Icons.done_all,
            color: Colors.green,
          ),
          "تمت العمليه بنجاح!",
          "تمت إضافة طبق الى قاعدة البيانات!",
          colorText: Colors.green,
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }}
    catch (e) {
      Get.snackbar(
        icon: Icon(Icons.error),
        'حدث خطاء اثناء إضافة طبق!',
        e.toString(),
        backgroundColor: Colors.white,
        colorText: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

    int currentInsulin=1;
  var   insuDate=DateTime.now();



// Get the current insulin value from shared preferences
  Future<void> getCurrentInsulin() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      currentInsulin = (prefs.getDouble('currentInsulin') ?? 1).toInt();
      int millisecondsSinceEpoch = prefs.getInt('insuDate') ?? DateTime.now().millisecondsSinceEpoch;
      insuDate = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
      print('Current insulin: $currentInsulin');
      print('Last insulin date: $insuDate');
      update();
    } catch (e) {
      print('Error retrieving data from SharedPreferences+++++++: $e');
    }
  }
  Future<void> updateInsulinValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Get the current list of insulin values from SharedPreferences
    List<String>? insuList = prefs.getStringList('insuList');
    // If the list doesn't exist yet, create a new empty list
    if (insuList == null ) {
      insuList = [];
    }
    // Check if an entry for today already exists in the list
    bool entryExists = false;
    String today = DateTime.now().toString().substring(0, 10);
    for (int i = 0; i < insuList.length; i++) {
      if (insuList[i].startsWith(today)) {
        // Update the existing entry with the current insulin value
        insuList[i] = "$today,${currentInsulin.toDouble()},${DateTime.now().millisecondsSinceEpoch}";
        entryExists = true;
        break;
      }
    }

    // If no entry for today exists, add a new entry to the list
    if (!entryExists) {
      String insulinEntry = "$today,${currentInsulin.toDouble()},${DateTime.now().millisecondsSinceEpoch}";
      insuList.add(insulinEntry);
    }

    // Store the updated list in SharedPreferences
    prefs.setStringList('insuList', insuList);

    // Update other properties as before
    prefs.setDouble('currentInsulin', currentInsulin.toDouble());
    prefs.setInt('insuDate', DateTime.now().millisecondsSinceEpoch);

    insuDate = DateTime.now();
    progressValueCalc();
    progressColorCalc();
    print(insuList);
  }


   newInsulinValue(String value) {
    currentInsulin = int.parse(value);
  }

   double progressValueCalc (){
    return (currentInsulin - 1) / (350 - 1);
  }
 Color progressColorCalc (){
    double progressValue = (currentInsulin - 1) / (350 - 1);
    if (progressValue <= 0.22636103151862463) {
      return Colors.yellow.shade300;
    } else if (progressValue <= 0.5128939828080229) {
      return Colors.green;
    } else {
       return Colors.red;
    }
  }

  String state(){
    checkIfAllowed();

    if (currentInsulin<=80){
      return 'منخفض جدا';
    }
    else if (currentInsulin<=180){
      return 'في النطاق';
    }
    else {
      return 'مرتفع ';
    }
  }

  Color text_color(){
    if (currentInsulin<=80){
      return Colors.redAccent;
    }
    else if (currentInsulin<=180){
      return Colors.green;
    }
    else {
      return Colors.redAccent;
    }
  }

}






