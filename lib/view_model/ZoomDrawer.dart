import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../view/Meals.dart';
import '../view/cumulative_insulin.dart';
import '../view/home_screen.dart';
import '../view/minueScreen.dart' as MenuItem;
import '../view/notifications.dart';
import '../view/profile.dart';

class HomeDrawer extends StatefulWidget {

  @override
  _homeDrawerState createState() => _homeDrawerState();
}

class _homeDrawerState extends State<HomeDrawer> {
  MenuItem.MenuItem currentItem = MenuItem.MuenuItems.home;


  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      isRtl: true,
      borderRadius: 40,

      showShadow: true,
      angle: -10,
      slideWidth: MediaQuery.of(context).size.width * 0.8,
      drawerShadowsBackgroundColor: Color.fromRGBO(22, 160, 133, 1.0),
      menuScreen:  Builder(
          builder: (BuildContext context) {
            return MenuItem.minueScreen(
                currentItem: currentItem,
                onSelectedItem: (item) {
                  setState(() {
                    currentItem = (item);
                    ZoomDrawer.of(context)!.close();
                  });
                });
          },
        ),

      mainScreen: getScreen(),
    );
  }

  Widget getScreen() {
    switch (currentItem) {
      case MenuItem.MuenuItems.home:
        return HomeScreen();
      case MenuItem.MuenuItems.cumulitave_sugar:
        return cumulativeInsulin();
      case MenuItem.MuenuItems.meals:
        return Meals();
      case MenuItem.MuenuItems.notifications:
        return Notifications();
      default:
        return profile();

    }
  }



}
