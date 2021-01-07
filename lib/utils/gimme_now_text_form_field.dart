import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class GimmeNowFormBuilderTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final GestureTapCallback onTap;
  final String data;
  final String label;
  final String attribute;
  final IconData suffixIcon;
  final Icon prefixIcon;
  final bool disableKeyBoardTyping;
  final int maxLines;
  final bool noUnderline;
  final List<FormFieldValidator> validators;
  final Key key;
  final FocusNode focusNode;
  final ValueChanged<String> onFieldSubmitted;
  final bool autoFocus;
  final bool obscureText;
  final bool autoCorrect;
  final bool enableSuggestions;
  final FormFieldSetter<String> onSaved;
  final TextCapitalization textCapitalization;
  final InputDecoration decoration;
  final ValueChanged onChanged;

  GimmeNowFormBuilderTextField(
      {this.key,
      @required this.attribute,
      this.controller,
      this.keyboardType,
      this.data,
      this.label,
      this.obscureText = false,
      this.onTap,
      this.maxLines = 1,
      this.suffixIcon,
      this.prefixIcon,
      this.disableKeyBoardTyping = false,
      this.noUnderline = false,
      this.validators = const [],
      this.focusNode,
      this.onFieldSubmitted,
      this.autoFocus = false,
      this.autoCorrect = true,
      this.enableSuggestions = true,
      this.onSaved,
      this.decoration,
      this.onChanged,
      this.textCapitalization = TextCapitalization.none});

  @override
  _GimmeNowFormBuilderTextFieldState createState() => _GimmeNowFormBuilderTextFieldState();
}

class _GimmeNowFormBuilderTextFieldState extends State<GimmeNowFormBuilderTextField> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      attribute: widget.attribute,
      enableSuggestions: widget.enableSuggestions,
      autocorrect: widget.autoCorrect,
      onTap: widget.onTap,
      obscureText: widget.obscureText,
      maxLines: widget.maxLines,
      focusNode: widget.focusNode ?? FocusNode(),
      autofocus: widget.autoFocus,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      readOnly: widget.disableKeyBoardTyping,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      validators: widget.validators,
      textCapitalization: widget.textCapitalization,
      onChanged: widget.onChanged,
      decoration: widget.decoration ??
          InputDecoration(
            suffixIcon: Icon(
              widget.suffixIcon,
              color: Color(0xFF808080),
            ),
            prefixIcon: widget.prefixIcon,
            labelText: widget.label,
            labelStyle: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w500),
            border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.blue)),
            focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            errorStyle: TextStyle(
              color: Colors.red,
            ),
          ),
    );
  }
}
