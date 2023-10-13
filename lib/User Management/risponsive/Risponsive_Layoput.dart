import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Responsive extends StatelessWidget {
  final Widget mobilebody;
  final Widget desktopbody;

  const Responsive(
      {super.key, required this.mobilebody, required this.desktopbody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, Constraints) {
        if (Constraints.maxWidth < 600) {
          return mobilebody;
        } else {
          return desktopbody;

        }
      },
    );
  }
}
