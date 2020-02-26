import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:google_fonts/google_fonts.dart';

fontBold(double size, Color color) {
  return GoogleFonts.overpass(
      fontSize: size, fontWeight: FontWeight.w700, color: color);
}

fontSemi(double size, Color color) {
  return GoogleFonts.overpass(
      fontSize: size, fontWeight: FontWeight.w500, color: color);
}

class DefaultColors {
  static Color orange = ColorUtil.color("#fbe555");
  static Color blue = ColorUtil.color("#3e64ff");
  static Color green = ColorUtil.color("#4dd599");
  static Color orangeLight = ColorUtil.color("#fffe9a");
  static Color blueLight = ColorUtil.color("#c3f1ff");
  static Color greenLight = ColorUtil.color("#6decb9");
  static Color darken = ColorUtil.color("#323C58");
  static Color dark = ColorUtil.color("#404b69");
  static Color lighten = ColorUtil.color("#f9fbfc");
  static Color light = ColorUtil.color("#f5feff");
}

class AppDefault {
  static double margin = 10;
}