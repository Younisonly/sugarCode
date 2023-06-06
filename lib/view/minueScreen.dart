import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

var info;

class minueScreen extends StatelessWidget {

  final MenuItem currentItem;
  final ValueChanged<MenuItem>onSelectedItem;
  const minueScreen({
   required this.currentItem,
    required this.onSelectedItem
});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Container(
        width: double.infinity,

        child: Scaffold(
          backgroundColor: Colors.indigo,
          body:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Spacer(),
              ...MuenuItems.all.map(buildMenuItem).toList(),
              Spacer(flex: 2,),


            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(MenuItem item)
  {
    return ListTileTheme(
      selectedColor: Colors.white,
      child: Column(

        children: [
          SizedBox(height: 10,),
          ListTile(
            selectedTileColor: Colors.black26,
            selected: currentItem==item,
            minLeadingWidth: 20,
            leading: Icon(item.icon),
            title: Text(item.title),
            onTap: ()=> onSelectedItem(item),
          ),
        ],
      ),
    );
  }


}

class MuenuItems {
  static const home = MenuItem('الشاشة الرئيسية ', Icons.home);
  static const cumulitave_sugar =
      MenuItem('السكر التراكمي', FontAwesomeIcons.cubes);
  static const meals = MenuItem('الاطباق', Icons.restaurant_rounded);
  static const notifications = MenuItem('الإشعارات', Icons.notification_add);
  static const profile = MenuItem('إعدادات المستخدم', Icons.person);

  static const all = [
    home,
    cumulitave_sugar,
    meals,
    notifications,
    profile,
  ];
}

class MenuItem {
  final String title;
  final IconData icon;

  const MenuItem(this.title, this.icon);
}


