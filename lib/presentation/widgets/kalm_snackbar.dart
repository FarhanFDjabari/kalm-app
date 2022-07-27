import 'package:flutter/material.dart';
import 'package:kalm/styles/kalm_theme.dart';

class KalmSnackbar extends SnackBar {
  final String message;
  final Duration duration;

  KalmSnackbar({required this.message, required this.duration})
      : super(
          behavior: SnackBarBehavior.floating,
          duration: duration,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          backgroundColor: primaryText.withOpacity(0.75),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Text(
            message,
            style: TextStyle(color: tertiaryColor),
          ),
        );
}
