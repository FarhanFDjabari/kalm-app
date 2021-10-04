import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';

class KalmIconButton extends StatefulWidget {
  final int itemIndex;
  final int selectedIndex;
  final double width;
  final double height;
  final double? iconSize;
  final double? fontSize;
  final double? iconRadius;
  final IconData icon;
  final IconData iconSelected;
  final String label;
  final Color? primaryColor;
  final Function? onTap;

  KalmIconButton({
    required this.width,
    required this.height,
    required this.icon,
    this.primaryColor,
    this.label = "Button",
    required this.iconSelected,
    this.iconSize,
    this.fontSize,
    this.iconRadius,
    this.onTap,
    this.itemIndex = 0,
    this.selectedIndex = 0,
  });

  @override
  _KalmIconButtonState createState() => _KalmIconButtonState();
}

class _KalmIconButtonState extends State<KalmIconButton> {
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onTap != null) widget.onTap!();
      },
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 750),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: widget.iconRadius ?? 50,
              height: widget.iconRadius ?? 50,
              child: CircleAvatar(
                maxRadius: widget.iconRadius ?? 50,
                minRadius: widget.iconRadius ?? 50,
                backgroundColor: widget.itemIndex == widget.selectedIndex
                    ? widget.primaryColor
                    : accentColor,
                child: Icon(
                  widget.itemIndex == widget.selectedIndex
                      ? widget.iconSelected
                      : widget.icon,
                  size: widget.iconSize ?? 24,
                  color: widget.itemIndex == widget.selectedIndex
                      ? accentColor
                      : widget.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.label,
              style: TextStyle(
                color: widget.itemIndex == widget.selectedIndex
                    ? Colors.black
                    : Colors.grey[700],
                fontSize: widget.fontSize,
                fontWeight: widget.itemIndex == widget.selectedIndex
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
