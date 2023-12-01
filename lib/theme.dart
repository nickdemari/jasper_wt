import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

final theme = ThemeData(
  scaffoldBackgroundColor: ColorPallate.cultured,
  textTheme: GoogleFonts.assistantTextTheme(),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: ColorPallate.cultured,
    ),
    backgroundColor: ColorPallate.charcoal,
    titleTextStyle: TextStyle(
      color: ColorPallate.cultured,
      fontSize: 22,
    ),
    toolbarTextStyle: TextStyle(
      color: ColorPallate.cultured,
    ),
  ),
);

class ColorPallate {
  static HexColor orangeRedCrayola = HexColor('#FE5F55');
  static HexColor brandingGreen = HexColor('#37AA05');
  static HexColor charcoal = HexColor('#2E4057');
  static HexColor ming = HexColor('#23656C');
  static HexColor cultured = HexColor('#F2F8F8');
  static HexColor beige = HexColor('#EEF5DB');
}

/// A [TextStyle] static class for the [TextField]s in the app.
/// This is a copy of the [TextStyle] class in the [Material] library.
/// `fontSize` is set to `18` and `color` is set to `Colors.black`.
class TextStyles {
  static const TextStyle display1 = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const TextStyle display2 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const TextStyle display3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const TextStyle display4 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const TextStyle headline = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const TextStyle title = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const TextStyle subhead = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const TextStyle body1 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
}
