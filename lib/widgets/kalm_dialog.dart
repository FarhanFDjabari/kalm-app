import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';

import 'kalm_button.dart';
import 'kalm_text_button.dart';

class KalmDialog extends StatelessWidget {
  final String? title;
  final String? successButtonTitle;
  final String? cancelButtonTitle;
  final dynamic Function() onSuccess;
  final dynamic Function() onCancel;
  final double height;

  const KalmDialog({
    Key? key,
    this.title,
    this.height = 200,
    this.successButtonTitle,
    this.cancelButtonTitle,
    required this.onSuccess,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: tertiaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title ?? '',
              style:
                  kalmOfflineTheme.textTheme.button!.apply(color: primaryText),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: KalmTextButton(
                    width: 100,
                    height: 54,
                    borderRadius: 10,
                    primaryColor: tertiaryColor,
                    child: Center(
                      child: Text(
                        cancelButtonTitle ?? '',
                        style: kalmOfflineTheme.textTheme.button!
                            .apply(color: Colors.red),
                      ),
                    ),
                    onPressed: onCancel,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: KalmButton(
                    width: 100,
                    height: 54,
                    child: Text(
                      successButtonTitle ?? '',
                      style: kalmOfflineTheme.textTheme.button!
                          .apply(color: tertiaryColor),
                    ),
                    primaryColor: primaryColor,
                    borderRadius: 10,
                    onPressed: onSuccess,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
