import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/user_model.dart';
import '../helper/Inserting.dart';
import '../widgets/constants.dart';
import 'Controller.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Auth extends GetxController {
  dynamic email, password, name, OldPassword, NewPassword;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _user = Rxn<User>();
  var Type;
  get user => _user.value?.email;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    update();
    _user.bindStream(_auth.authStateChanges());
  }

  void signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

    await  storeUserData(email:email );

      Get.offAll( ControlView());
      update();
    } catch (e) {
      Get.snackbar(
        icon: const Icon(Icons.error),
        'Error login account',
        e.toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future createUserWithEmailAndPassword() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        UserModel userModel = UserModel(
            email: user.user?.email,
            name: name,
            userId: user.user?.uid);
        await FireStoreUser().addUserToFireStore(userModel);
      });
      storeUserData(email:email );
      Get.offAll( ControlView());
      update();
    } catch (e) {
      Get.snackbar(
        icon: const Icon(Icons.error),
        'Error registering account',
        e.toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }



  Future<void> storeUserData({required String email,}) async {
    var UserInfo, name;

   await FirebaseFirestore.instance.collection('Users').where(
        'email', isEqualTo: email).get().then((value) {
      UserInfo = value.docs[0].data();
      Type = UserInfo['type'].toString();
      name = UserInfo['name'].toString();
          });

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('email', email);
    await prefs.setString('name', name??'');
    await prefs.setString('type', Type??'');



  }
}
