import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;
  final Color borderColor;
  final VoidCallback onPressed;
  final bool showCircularProgressIndicator;
  final bool showTickSymbol;

  const MyAppButton(
      {Key key,
      this.text,
      this.onPressed,
      this.buttonColor,
      this.textColor,
      this.showCircularProgressIndicator = false,
      this.showTickSymbol = false,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 0.0,
      color: buttonColor ?? Colors.teal,
      textColor: textColor ?? Colors.white,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor ?? Colors.teal),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: showCircularProgressIndicator
          ? Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
              child: Container(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )))
          : showTickSymbol
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                  child: Container(
                    height: 20,
                    width: 20,
                    child: Icon(Icons.check),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
    );
  }
}
