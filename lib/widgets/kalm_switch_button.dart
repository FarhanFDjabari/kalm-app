import 'package:flutter/cupertino.dart';

class KalmSwitchButton extends StatefulWidget {
  final Color primaryColor;
  final Color accentColor;
  final bool value;
  final Function(bool)? onChanged;

  KalmSwitchButton(
      {required this.primaryColor,
      required this.accentColor,
      required this.value,
      this.onChanged});

  @override
  _KalmSwitchButtonState createState() => _KalmSwitchButtonState();
}

class _KalmSwitchButtonState extends State<KalmSwitchButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: widget.value,
      onChanged: widget.onChanged,
      activeColor: widget.primaryColor,
      trackColor: widget.accentColor,
    );
  }
}
