import 'package:flutter/material.dart';
import 'package:kalm/styles/kalm_theme.dart';

import 'kalm_text_field.dart';

class KalmJourneyField extends StatefulWidget {
  KalmJourneyField({
    Key? key,
    required this.journeyTextController,
    this.title,
    this.currentIndex = 0,
    required this.journeyPageController,
  }) : super(key: key);

  final TextEditingController journeyTextController;
  late final int currentIndex;
  final PageController journeyPageController;
  final String? title;

  @override
  _KalmJourneyTextFieldState createState() => _KalmJourneyTextFieldState();
}

class _KalmJourneyTextFieldState extends State<KalmJourneyField> {
  final journeyFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    journeyFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10),
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            widget.title!,
            textAlign: TextAlign.start,
            style: kalmOfflineTheme.textTheme.bodyText1!
                .apply(color: primaryText, fontSizeFactor: 1.1),
          ),
        ),
        Expanded(
          child: KalmTextField(
            kalmTextFieldController: widget.journeyTextController,
            minLines: 30,
            keyboardType: TextInputType.multiline,
            hintText: 'Tulis apa yang kamu tahu...',
            focusColor: accentColor,
            focusNode: journeyFocusNode,
            primaryColor: tertiaryColor,
            accentColor: primaryText,
            validator: (value) {
              if (value!.isEmpty || value == '') {
                return 'Kolom ini tidak boleh kosong';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
