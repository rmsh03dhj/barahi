import 'package:flutter/material.dart';

class Validators {
  static FormFieldValidator required({String errorText = "Required."}) {
    return (value) {
      if (value == null ||
          ((value is Iterable || value is String || value is Map) && value.length == 0)) {
        return errorText;
      }
      return null;
    };
  }

  static FormFieldValidator confirmPasswordMatchWithPassword(String matchWith) {
    return (value) {
      if (value != null && value.isNotEmpty) {
        if (value != matchWith) return "Password didn't match.";
      }
      return null;
    };
  }

  static FormFieldValidator length() {
    return (value) {
      if (value != null && value.isNotEmpty) {
        if (value.length < 8) return "Length should be greater than 8";
      }
      return null;
    };
  }

  static FormFieldValidator emailValidator() {
    return (value) {
      String emailRegex =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

      RegExp regExp = new RegExp(emailRegex);
      if (!regExp.hasMatch(value)) return "Invalid email address.";
      return null;
    };
  }
}
