import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ZoomDrawer.dart';
import 'auth.dart';
import '../view/login_screen.dart';

class ControlView extends GetWidget<Auth> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Get.put(Auth(), permanent: true);
      return (Get.find<Auth>().user == null)
          ? LoginScreen()
          : HomeDrawer();
    });
  }


}
