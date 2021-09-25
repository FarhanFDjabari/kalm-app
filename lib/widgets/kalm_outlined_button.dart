import 'package:flutter/material.dart';

class KalmOutlinedButton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Widget child;
  final Color primaryColor;
  final Function() onPressed;

  KalmOutlinedButton(
      {required this.width,
      required this.height,
      required this.child,
      this.primaryColor = Colors.purple,
      required this.onPressed,
      this.borderRadius = 10});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        side: BorderSide(
          width: 2,
          color: primaryColor,
        ),
        elevation: 0,
        textStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        primary: primaryColor,
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
