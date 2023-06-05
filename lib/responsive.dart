import 'package:flutter/material.dart';

class Responsive extends StatefulWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 576;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 576 &&
          MediaQuery.of(context).size.width <= 992;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 992;

  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width > 992) {
      return widget.desktop;
    } else if (size.width >= 576 && widget.tablet != null) {
      return widget.tablet!;
    } else {
      return widget.mobile;
    }
  }
}
