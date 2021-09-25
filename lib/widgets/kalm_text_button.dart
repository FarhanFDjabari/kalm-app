import 'package:flutter/material.dart';

class KalmTextButton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Widget child;
  final Color? primaryColor;
  final Function() onPressed;

  KalmTextButton(
      {required this.width,
      required this.height,
      required this.child,
      this.primaryColor,
      required this.onPressed,
      this.borderRadius = 10});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        primary: primaryColor,
        textStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        elevation: 0,
        visualDensity: VisualDensity.compact,
      ),
      child: SizedBox(
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}
