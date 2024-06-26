import 'package:flutter/material.dart';

class MaterialColors {
  static const MaterialColor deepOrange = MaterialColor(
    _deepOrangePrimaryValue,
    <int, Color>{
      50: Color(0xFFFBE9E7),
      100: Color(0xFFFFCCBC),
      200: Color(0xFFFFAB91),
      300: Color(0xFFFF8A65),
      400: Color(0xFFFF7043),
      500: Color(_deepOrangePrimaryValue),
      600: Color(0xFFF4511E),
      700: Color(0xFFE64A19),
      800: Color(0xFFD84315),
      900: Color(0xFFBF360C),
    },
  );
  static const int _deepOrangePrimaryValue = 0xFFFF5722;
} 

//  static const MaterialColor deepPurple = MaterialColor(
//     _deepPurplePrimaryValue,
//     <int, Color>{
//       50: Color(0xFFEDE7F6),
//       100: Color(0xFFD1C4E9),
//       200: Color(0xFFB39DDB),
//       300: Color(0xFF9575CD),
//       400: Color(0xFF7E57C2),
//       500: Color(_deepPurplePrimaryValue),
//       600: Color(0xFF5E35B1),
//       700: Color(0xFF512DA8),
//       800: Color(0xFF4527A0),
//       900: Color(0xFF311B92),
//     },
//   );
//   static const int _deepPurplePrimaryValue = 0xFF673AB7;