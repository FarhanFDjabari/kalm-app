import 'package:flutter/material.dart';

class KalmChipButton extends StatefulWidget {
  final int? itemIndex;
  final int? currentIndex;
  final double borderRadius;
  final double width;
  final double height;
  final double textSize;
  final bool staticMode;
  final Color activeColor;
  final Color color;
  final String text;
  final void Function()? onTap;

  KalmChipButton({
    required this.borderRadius,
    required this.width,
    required this.height,
    this.staticMode = true,
    required this.activeColor,
    required this.color,
    required this.text,
    this.textSize = 16,
    this.onTap,
    this.itemIndex = 0,
    this.currentIndex = 0,
  });

  @override
  _KalmChipButtonState createState() => _KalmChipButtonState();
}

class _KalmChipButtonState extends State<KalmChipButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !widget.staticMode ? widget.onTap : () {},
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: AnimatedContainer(
        width: widget.width,
        height: widget.height,
        duration: Duration(milliseconds: 550),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: !widget.staticMode
              ? widget.itemIndex == widget.currentIndex
                  ? widget.activeColor
                  : widget.color
              : widget.activeColor,
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: !widget.staticMode
                  ? widget.itemIndex == widget.currentIndex
                      ? widget.color
                      : widget.activeColor
                  : widget.color,
              fontWeight: !widget.staticMode
                  ? widget.itemIndex == widget.currentIndex
                      ? FontWeight.w500
                      : FontWeight.normal
                  : FontWeight.normal,
              fontSize: widget.textSize,
            ),
          ),
        ),
      ),
    );
  }
}
