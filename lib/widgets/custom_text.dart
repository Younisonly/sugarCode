import 'package:flutter/material.dart';


class CustomText extends StatelessWidget {
final String text;
final double hight;
final double fontSize;
final Color color;
final Alignment alignment;

const CustomText({super.key, this.fontSize= 16,this.text = '',this.color = Colors.black,
  this.alignment=Alignment.topLeft,  this.hight=1,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
     child: Text(text,
        style: TextStyle(
          height: hight,
          color: color,fontSize: fontSize,
        ),
      ),
    );
  }
}
