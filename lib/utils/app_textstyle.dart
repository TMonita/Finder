import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  //headings
  static TextStyle h1 = GoogleFonts.redHatDisplay(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h2 = GoogleFonts.redHatDisplay(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h3 = GoogleFonts.redHatDisplay(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static TextStyle h4 = GoogleFonts.redHatDisplay(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  //body text
  static TextStyle bodyLarge = GoogleFonts.redHatDisplay(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static TextStyle body2ndLarge = GoogleFonts.redHatDisplay(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  static TextStyle bodyMedium = GoogleFonts.redHatDisplay(
    fontSize: 10,
    fontWeight: FontWeight.bold,
  );
  static TextStyle body2ndMedium = GoogleFonts.redHatDisplay(
    fontSize: 11,
    fontWeight: FontWeight.bold,
  );
  static TextStyle bodySmall = GoogleFonts.redHatDisplay(
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );
  static TextStyle bodyLight = GoogleFonts.redHatDisplay(
    fontSize: 10,
    fontWeight: FontWeight.w200,
  );
  static TextStyle hintText = GoogleFonts.redHatDisplay(
    fontSize: 10,
    fontWeight: FontWeight.w100,
  );

  static TextStyle headingWithColor(bool showFound) {
    return GoogleFonts.redHatDisplay(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: !showFound ? const Color(0xFF274C77) : Colors.grey,
    );
  }
}
