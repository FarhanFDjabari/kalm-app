import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:kalm/styles/kalm_theme.dart';

class DashedButtonIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final double borderRadius;
  final Function callback;
  final EdgeInsetsGeometry? padding;

  DashedButtonIcon({
    required this.text,
    required this.icon,
    required this.borderRadius,
    required this.callback,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(borderRadius),
        color: secondaryText,
        dashPattern: [6, 3],
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          child: Container(
            margin: padding ?? EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 45,
                  color: secondaryText,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    color: secondaryText,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
