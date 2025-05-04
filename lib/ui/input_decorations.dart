import 'package:flutter/material.dart';

class InputDecortions {
  static InputDecoration authInputDecoration({
    required String hinText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFEFB3C5)),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE773A2), width: 2),
      ),
      hintText: hinText,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.grey),
      prefixIcon:
          prefixIcon != null
              ? Icon(prefixIcon, color: Color(0xFFE773A2))
              : null,
    );
  }
}
