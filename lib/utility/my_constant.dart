import 'package:flutter/material.dart';

class MyConstant {
  // Field
  static Color bgColor = const Color.fromARGB(255, 12, 119, 16);
  static Color dark = const Color.fromARGB(255, 39, 23, 9);
  static Color active = const Color.fromARGB(255, 201, 13, 76);

  // Method
  BoxDecoration basicBox() {
    return BoxDecoration(color: bgColor.withOpacity(0.3));
  }

  TextStyle h1Style() {
    return TextStyle(
      fontSize: 36,
      color: dark,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle h2Style() {
    return TextStyle(
      fontSize: 18,
      color: dark,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle h3Style() {
    return TextStyle(
      fontSize: 14,
      color: dark,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle h3ActiveStyle() {
    return TextStyle(
      fontSize: 16,
      color: active,
      fontWeight: FontWeight.w500,
    );
  }
}
