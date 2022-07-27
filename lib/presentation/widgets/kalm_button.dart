import 'package:flutter/material.dart';

class KalmButton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Widget child;
  final Color? primaryColor;
  final Function() onPressed;

  KalmButton(
      {required this.width,
      required this.height,
      required this.child,
      this.primaryColor,
      required this.onPressed,
      this.borderRadius = 10});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        primary: primaryColor,
        elevation: 0,
        textStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
