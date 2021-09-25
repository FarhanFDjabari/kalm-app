import 'package:flutter/material.dart';

class KalmChipButton extends StatefulWidget {
  final double borderRadius;
  final double width;
  final double height;
  final double textSize;
  final bool staticMode;
  final Color activeColor;
  final Color color;
  final String text;
  final void Function()? callback;

  KalmChipButton({
    required this.borderRadius,
    required this.width,
    required this.height,
    this.staticMode = true,
    required this.activeColor,
    required this.color,
    required this.text,
    this.textSize = 16,
    this.callback,
  });

  @override
  _KalmChipButtonState createState() => _KalmChipButtonState();
}

class _KalmChipButtonState extends State<KalmChipButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !widget.staticMode
          ? () {
              isSelected = !isSelected;
              setState(() {});
              widget.callback!();
            }
          : () {},
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: AnimatedContainer(
        width: widget.width,
        height: widget.height,
        duration: Duration(milliseconds: 550),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: !widget.staticMode
              ? isSelected
                  ? widget.activeColor
                  : widget.color
              : widget.activeColor,
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: !widget.staticMode
                  ? isSelected
                      ? widget.color
                      : widget.activeColor
                  : widget.color,
              fontWeight: !widget.staticMode
                  ? isSelected
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
