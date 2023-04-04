import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF333333,
    {
      50: Color(0xFFEFEFEF),
      100: Color(0xFFD6D6D6),
      200: Color(0xFFBFBFBF),
      300: Color(0xFFA8A8A8),
      400: Color(0xFF939393),
      500: Color(0xFF7F7F7F),
      600: Color(0xFF6B6B6B),
      700: Color(0xFF575757),
      800: Color(0xFF434343),
      900: Color(0xFF2F2F2F),
    },
  );

  static const Color backgroundColor = Color(0xFFF2F2F2);

  static const Color inputBorderColor = Color(0xFFE5E5E5);

  static final Color hintColor = primarySwatch.shade800;

  static final Color buttonColor = primarySwatch.shade900;

  static const Color aiBubble = Color(0xFFE1E1E1);

  static final Color userBubble = primarySwatch.shade500;
}
