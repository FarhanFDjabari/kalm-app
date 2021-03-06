import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';

class KalmDropdownButton extends StatefulWidget {
  final double width;
  final String hintText;
  final Color primaryColor;
  final Color? dropdownColor;
  final Color? dropdownItemColor;
  final Color? borderColor;
  final Color accentColor;
  final EdgeInsets? padding;
  final String? Function(Object?)? validator;
  final List<Map<String, dynamic>> dropdownData;
  final Function(Object?)? onChanged;

  KalmDropdownButton(
      {required this.hintText,
      required this.primaryColor,
      required this.accentColor,
      required this.width,
      required this.dropdownData,
      this.dropdownColor,
      this.dropdownItemColor,
      this.borderColor,
      this.validator,
      this.padding,
      this.onChanged});

  @override
  _KalmDropdownButtonState createState() => _KalmDropdownButtonState();
}

class _KalmDropdownButtonState extends State<KalmDropdownButton> {
  int indexValue = 0;
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
        isExpanded: true,
        icon: Icon(Icons.keyboard_arrow_down_rounded),
        items: widget.dropdownData
            .map(
              (dropdownData) => DropdownMenuItem(
                child: Text(
                  '${dropdownData['title']}',
                  style: TextStyle(
                      color: widget.dropdownItemColor ?? widget.accentColor),
                ),
                value: dropdownData['value'].toString(),
                onTap: () {
                  selectedValue = '${dropdownData['selectedValue']}';
                },
              ),
            )
            .toList(),
        dropdownColor: widget.dropdownColor ?? widget.primaryColor,
        iconEnabledColor: widget.accentColor,
        elevation: 0,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.primaryColor,
          contentPadding: widget.padding ?? const EdgeInsets.all(20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: widget.borderColor ?? widget.primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: widget.accentColor),
          ),
          errorMaxLines: 1,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        style: kalmOfflineTheme.textTheme.subtitle1!
            .apply(color: widget.accentColor),
        onChanged: widget.onChanged,
        hint: Text(
          widget.hintText,
          style: kalmOfflineTheme.textTheme.subtitle1!
              .apply(color: widget.accentColor),
        ),
        validator: widget.validator,
      ),
    );
  }
}
