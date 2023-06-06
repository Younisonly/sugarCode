import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final String text;
  final Color foreColor;
  final Function onPressing;
  final double fontSizes;

   const CustomButton(
      {super.key, required this.color,
      required this.text,
        required this.onPressing,
      required this.foreColor,
      required this.fontSizes});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressing(),

          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.0)),
            alignment: Alignment.center,
            backgroundColor: color,
          ),
            child :Padding(
              padding: const EdgeInsets.only(
                  top: 7, right: 80, left: 80, bottom: 7),
              child: CustomText(
                  color: foreColor,
                  alignment: Alignment.center,
                  fontSize: fontSizes,
                  text: text),
            ),
        );
  }
}
