import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:kalm/styles/kalm_theme.dart';

class KalmStepIndicator extends StatelessWidget {
  final int selectedIndex;
  final int indicatorIndex;
  final bool isLast;
  final bool isComplete;
  final String title;

  const KalmStepIndicator({
    Key? key,
    this.isLast = false,
    required this.title,
    required this.selectedIndex,
    required this.indicatorIndex,
    this.isComplete = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 550),
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isComplete ? primaryColor : accentColor,
              border: Border.all(
                color: Color(0xFFDBE0FF),
                width: indicatorIndex == selectedIndex && !isComplete ? 4 : 0,
              ),
            ),
            child: Center(
              child: isComplete
                  ? Icon(
                      Icons.check,
                      color: tertiaryColor,
                    )
                  : Text(
                      title,
                      style: kalmOfflineTheme.textTheme.overline!
                          .apply(color: primaryColor, fontSizeFactor: 1.2),
                    ),
            ),
          ),
          if (!isLast)
            DottedLine(
              direction: Axis.horizontal,
              lineLength: MediaQuery.of(context).size.width * 0.15,
              dashLength: 8,
              lineThickness: 3,
              dashColor: isComplete ? primaryColor : Color(0xFFE7EAFF),
            ),
        ],
      ),
    );
  }
}
