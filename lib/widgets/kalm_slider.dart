import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';

class KalmSlider extends StatefulWidget {
  final double value;
  final double? trackHeight;
  final double max;
  final double min;
  final Color? activeColor;
  final Color? inactiveColor;
  final Function(double) onChanged;

  KalmSlider(
      {required this.value,
      this.max = 5,
      this.min = 0,
      required this.onChanged,
      this.trackHeight,
      this.activeColor,
      this.inactiveColor});

  @override
  _KalmSliderState createState() => _KalmSliderState();
}

class _KalmSliderState extends State<KalmSlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: widget.trackHeight,
      ),
      child: Slider(
        activeColor: widget.activeColor ?? primaryColor,
        inactiveColor: widget.inactiveColor ?? accentColor,
        value: widget.value,
        max: widget.max,
        min: widget.min,
        onChanged: widget.onChanged,
      ),
    );
  }
}
