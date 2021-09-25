import 'package:flutter/cupertino.dart';

class KalmSwitchButton extends StatefulWidget {
  final Color primaryColor;
  final Color accentColor;

  KalmSwitchButton({required this.primaryColor, required this.accentColor});

  @override
  _KalmSwitchButtonState createState() => _KalmSwitchButtonState();
}

class _KalmSwitchButtonState extends State<KalmSwitchButton> {
  bool isEnable = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: isEnable,
      onChanged: (value) {
        setState(() {
          isEnable = value;
        });
        print('is anonymous: $value');
      },
      activeColor: widget.primaryColor,
      trackColor: widget.accentColor,
    );
  }
}
