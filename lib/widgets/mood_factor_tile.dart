import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kalm/utilities/kalm_theme.dart';

class MoodFactorTile extends StatefulWidget {
  const MoodFactorTile({
    Key? key,
  }) : super(key: key);

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
        },
        borderRadius: BorderRadius.circular(10),
        splashColor: accentColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? Iconsax.teacher5 : Iconsax.teacher,
              color: isSelected ? primaryColor : secondaryText,
              size: 28,
            ),
            SizedBox(height: 5),
            Text(
              'Sekolah',
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
