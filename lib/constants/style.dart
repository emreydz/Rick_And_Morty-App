import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle googlefonts() {
  return GoogleFonts.shadowsIntoLight(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      shadows: [
        const Shadow(
          blurRadius: 3,
        )
      ]);
}

TextStyle textstyle20() {
  return TextStyle(
      fontFamily: 'RickandMorty', fontSize: 20, fontWeight: FontWeight.bold);
}

TextStyle fontsyakinda() {
  return GoogleFonts.shadowsIntoLight(
      fontSize: 45, fontWeight: FontWeight.w500, color: Colors.black);
}

TextStyle textstyle26() {
  return TextStyle(
      fontFamily: 'RickandMorty', fontSize: 26, fontWeight: FontWeight.bold);
}

TextStyle googlefonts28() {
  return GoogleFonts.shadowsIntoLight(
      fontSize: 28, fontWeight: FontWeight.w500, color: Colors.black);
}
