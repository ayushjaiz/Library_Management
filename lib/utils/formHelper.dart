import 'package:flutter/material.dart';

class customDecoration {
  static InputDecoration customInputDecoration(String text, IconData iconData) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      hintText: text,
      prefixIcon: Icon(iconData),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2,
          )),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          )),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          )),
    );
  }
}

