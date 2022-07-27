import 'package:flutter/material.dart';
import 'package:kalm/presentation/widgets/kalm_button.dart';
import 'package:kalm/styles/kalm_theme.dart';

class KalmLoadingButton extends StatelessWidget {
  final Color loadingColor;
  final Color buttonColor;

  KalmLoadingButton({
    this.buttonColor = primaryColor,
    this.loadingColor = tertiaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return KalmButton(
      width: double.infinity,
      height: 56,
      child: Container(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          backgroundColor: buttonColor,
          color: loadingColor,
        ),
      ),
      borderRadius: 10,
      primaryColor: buttonColor,
      onPressed: () {},
    );
  }
}
