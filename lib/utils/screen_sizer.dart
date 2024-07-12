import 'package:flutter/material.dart';

class ResponsiveSizer {
  static double width(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }

  static double height(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }

  static double fontSize(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }
}
