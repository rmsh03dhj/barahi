import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_app_button.dart';

class MyAppButtonFullWidth extends StatelessWidget {
  final String text;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final VoidCallback onPressed;
  final bool showCircularProgressIndicator;
  final bool showTickSymbol;

  const MyAppButtonFullWidth(
      {
     required this.text,
    required   this.onPressed,
      this.buttonColor,
      this.textColor,
      this.showCircularProgressIndicator = false,
      this.showTickSymbol = false,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: MyAppButton(
          text: text,
          buttonColor: buttonColor,
          textColor: textColor,
          borderColor: borderColor,
          onPressed: onPressed,
          showCircularProgressIndicator: showCircularProgressIndicator,
          showTickSymbol: showTickSymbol,
        ),
      ),
    );
  }
}
