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
  Color orange = ColorUtil.color("#FF983E");
  Color blue = ColorUtil.color("#778CFD");
  Color green = ColorUtil.color("#7AFF76");
  Color orangeLight = ColorUtil.color("#FAD379");
  Color blueLight = ColorUtil.color("#B9C5FF");
  Color greenLight = ColorUtil.color("#FAD379");
}

class AppDefault {
  final margin = 10;
}