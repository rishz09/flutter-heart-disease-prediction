//ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

InputDecoration decorationfunction([String? hintText]) {
  if (hintText == null) {
    return InputDecoration(
      //hintText: 'Email',
      fillColor: Colors.white,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pinkAccent, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pinkAccent, width: 2),
      ),
    );
  }

  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(fontSize: 15),
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pinkAccent, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pinkAccent, width: 2),
    ),
  );
}

BoxDecoration paramDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: Colors.pinkAccent,
      width: 2,
    ),
  );
}
