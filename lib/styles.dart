library styles;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Map<String, String?> appFonts = {
  "Roboto": GoogleFonts.roboto().fontFamily,
  "PS2P": GoogleFonts.pressStart2p().fontFamily,
  "Lato": GoogleFonts.lato().fontFamily,
};

Map<String, Color> appColors = {
  "primary": const Color.fromRGBO(255, 255, 255, 1),
  "primary.6": const Color.fromRGBO(255, 255, 255, 0.6),
  "accent": const Color.fromRGBO(234, 81, 81, 1),
  "black": const Color.fromRGBO(30, 30, 30, 1),
  "black.25": const Color.fromRGBO(0, 0, 0, 0.25),
  "grey238": const Color.fromRGBO(238, 238, 238, 1),
  "grey242": const Color.fromRGBO(242, 242, 242, 1),
  "grey210": const Color.fromRGBO(210, 210, 210, 1),
  "grey197": const Color.fromRGBO(197, 197, 197, 1),
  "grey174": const Color.fromRGBO(174, 174, 174, 1),
  "grey130": const Color.fromRGBO(130, 130, 130, 1),
  "grey89": const Color.fromRGBO(89, 89, 89, 1),
  "white.12": const Color.fromRGBO(251, 244, 244, .12),
  "purple": const Color.fromRGBO(78, 50, 254, 1),
  "gold": const Color.fromRGBO(255, 215, 0, 1),
};

BoxShadow defaultBoxShadow = BoxShadow(
  color: appColors['black.25']!,
  offset: const Offset(0, 4),
  blurRadius: 6,
);

TextStyle getTextStyle({
  required String textColor,
  required String fontFamily,
  required int fontWeight,
  required double fontSize,
  textShadow,
  fontStyle = FontStyle.normal,
}) {
  List<FontWeight> fontWeights = [
    FontWeight.w100,
    FontWeight.w200,
    FontWeight.w300,
    FontWeight.w400,
    FontWeight.w500,
    FontWeight.w600,
    FontWeight.w700,
    FontWeight.w800,
    FontWeight.w900
  ];

  return TextStyle(
    color: appColors[textColor],
    fontFamily: appFonts[fontFamily],
    fontWeight: fontWeights[fontWeight ~/ 100 - 1],
    fontSize: fontSize,
    shadows: textShadow == null ? [] : [textShadow],
    fontStyle: fontStyle,
  );
}
