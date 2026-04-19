import 'package:flutter/material.dart';

class ResponsiveConfig {
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileBreakpoint &&
      MediaQuery.of(context).size.width < tabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint;

  static double getWidthScale(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobileBreakpoint) return 1.0;
    if (width < tabletBreakpoint) return 1.1;
    return 1.2;
  }
}
