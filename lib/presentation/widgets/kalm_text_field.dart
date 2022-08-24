import 'package:flutter/material.dart';
import 'package:kalm/styles/kalm_theme.dart';

class KalmTextField extends StatefulWidget {
  final TextEditingController kalmTextFieldController;
  final bool isObscure;
  final int minLines;
  final int? maxLines;
  final TextInputType keyboardType;
  final TextInputAction? inputAction;
  final String hintText;
  final Color primaryColor;
  final Color accentColor;
  final Color focusColor;
  final IconData? suffixIcon;
  final FocusNode? focusNode;
  final Function()? callback;
  final String? Function(String?)? validator;

  KalmTextField(
      {required this.kalmTextFieldController,
      required this.minLines,
      this.keyboardType = TextInputType.text,
      this.inputAction,
      required this.hintText,
      required this.focusColor,
      this.suffixIcon,
      required this.primaryColor,
      required this.accentColor,
      this.callback,
      this.maxLines,
      this.focusNode,
      this.isObscure = false,
      this.validator});

  @override
  _KalmTextFieldState createState() => _KalmTextFieldState();
}

class _KalmTextFieldState extends State<KalmTextField> {
  late bool isObscure;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isObscure;
    if (widget.focusNode != null) widget.focusNode!.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      isFocused = !isFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode ?? null,
      controller: widget.kalmTextFieldController,
      style: TextStyle(
        color: widget.accentColor,
      ),
      obscureText: isObscure,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      cursorColor: widget.accentColor,
      keyboardType: widget.keyboardType,
      textInputAction: widget.inputAction,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.all(20),
        hintStyle: kalmOfflineTheme.textTheme.subtitle1!
            .apply(color: widget.accentColor),
        hintMaxLines: 1,
        focusColor: widget.focusColor,
        filled: true,
        fillColor: isFocused ? widget.focusColor : widget.primaryColor,
        errorMaxLines: 1,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: widget.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: widget.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: widget.accentColor),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        suffixIcon: widget.suffixIcon == null
            ? null
            : Container(
                margin: const EdgeInsets.only(right: 5),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                    if (widget.callback != null) widget.callback!();
                  },
                  icon: Icon(isObscure
                      ? Icons.visibility_off_outlined
                      : widget.suffixIcon!),
                  color: tertiaryColor,
                ),
              ),
      ),
      validator: widget.validator,
    );
  }
}
