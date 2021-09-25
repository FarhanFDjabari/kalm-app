import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:textfield_tags/textfield_tags.dart';

class KalmTextFieldTag extends StatelessWidget {
  final String hintText;
  final Function(String) onTag;
  final Function(String) onDelete;

  const KalmTextFieldTag({
    Key? key,
    required this.hintText,
    required this.onTag,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldTags(
      tagsStyler: TagsStyler(
        tagDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: accentColor,
        ),
        tagCancelIconPadding: const EdgeInsets.symmetric(horizontal: 2.0),
        tagTextPadding: const EdgeInsets.symmetric(horizontal: 3.0),
        tagPadding: const EdgeInsets.all(6.0),
        tagCancelIcon: Icon(
          Icons.close_rounded,
          size: 18.0,
          color: primaryColor,
        ),
      ),
      textFieldStyler: TextFieldStyler(
        textFieldFilled: true,
        contentPadding: const EdgeInsets.all(20),
        textFieldFilledColor: tertiaryColor,
        textFieldEnabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: tertiaryColor),
        ),
        textFieldFocusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor),
        ),
        cursorColor: primaryColor,
        helperText: '',
        hintText: hintText,
      ),
      onTag: onTag,
      onDelete: onDelete,
    );
  }
}
