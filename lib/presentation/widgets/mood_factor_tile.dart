import 'package:flutter/material.dart';
import 'package:kalm/styles/kalm_theme.dart';

class MoodFactorTile extends StatefulWidget {
  const MoodFactorTile({
    Key? key,
    required this.icon,
    required this.selectedIcon,
    required this.label,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final Function()? onTap;

  @override
  _MoodFactorTileState createState() => _MoodFactorTileState();
}

class _MoodFactorTileState extends State<MoodFactorTile> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? tertiaryColor : tertiaryColor.withOpacity(0.5),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
          });
          if (widget.onTap != null) widget.onTap!();
        },
        borderRadius: BorderRadius.circular(10),
        splashColor: accentColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? widget.selectedIcon : widget.icon,
              color: isSelected ? primaryColor : secondaryText,
              size: 28,
            ),
            SizedBox(height: 5),
            Text(
              widget.label,
              textAlign: TextAlign.center,
              style: isSelected
                  ? kalmOfflineTheme.textTheme.bodyText2!
                      .apply(color: primaryColor)
                  : kalmOfflineTheme.textTheme.caption!
                      .apply(color: secondaryText),
            ),
          ],
        ),
      ),
    );
  }
}
