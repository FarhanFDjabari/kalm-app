import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';

class KalmIconButton extends StatefulWidget {
  final double width;
  final double height;
  final double? iconSize;
  final double? fontSize;
  final double? iconRadius;
  final IconData icon;
  final IconData iconSelected;
  final String label;
  final Color? primaryColor;

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
  });

  @override
  _KalmIconButtonState createState() => _KalmIconButtonState();
}

class _KalmIconButtonState extends State<KalmIconButton> {
  bool isSelected = false;

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isSelected = !isSelected;
        setState(() {});
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
                backgroundColor: isSelected ? widget.primaryColor : accentColor,
                child: Icon(
                  isSelected ? widget.iconSelected : widget.icon,
                  size: widget.iconSize ?? 24,
                  color: isSelected ? accentColor : widget.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey[700],
                fontSize: widget.fontSize,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
