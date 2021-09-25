import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/widgets/kalm_button.dart';
import 'package:kalm/widgets/kalm_dropdown_button.dart';
import 'package:kalm/widgets/kalm_switch_button.dart';
import 'package:kalm/widgets/kalm_text_field.dart';
import 'package:kalm/widgets/kalm_text_field_tag.dart';

class PostCurhatPage extends StatefulWidget {
  @override
  _PostCurhatPageState createState() => _PostCurhatPageState();
}

class _PostCurhatPageState extends State<PostCurhatPage> {
  final _judulCurhatController = TextEditingController();
  final _kontenCurhatController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isAnonymous = false;
  FocusNode _judulFocus = new FocusNode();
  FocusNode _kontenFocus = new FocusNode();

  @override
  void dispose() {
    super.dispose();
    _judulFocus.dispose();
    _kontenFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: primaryText,
          ),
        ),
        title: Text(
          'BUAT CURHATAN',
          style:
              kalmOfflineTheme.textTheme.headline1!.apply(color: primaryText),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: primaryColor,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Maria',
                          style: kalmOfflineTheme.textTheme.button!
                              .apply(color: primaryText, fontSizeFactor: 1.2),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 48,
                      child: KalmDropdownButton(
                        hintText: 'Kategori',
                        primaryColor: tertiaryColor,
                        accentColor: primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        borderColor: primaryColor,
                        width: double.infinity,
                        dropdownItemColor: primaryColor,
                        dropdownData: [
                          {
                            'title': 'Keuangan',
                            'value': 1,
                            'selectedValue': 'Keuangan',
                          },
                          {
                            'title': 'Self-love',
                            'value': 2,
                            'selectedValue': 'Self-love',
                          },
                          {
                            'title': 'Cinta',
                            'value': 3,
                            'selectedValue': 'Cinta',
                          },
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: KalmTextField(
                    kalmTextFieldController: _kontenCurhatController,
                    keyboardType: TextInputType.multiline,
                    minLines: 30,
                    hintText: 'Apa yang ingin kamu sampaikan?',
                    focusColor: accentColor,
                    primaryColor: tertiaryColor,
                    accentColor: primaryColor,
                    focusNode: _kontenFocus,
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return 'Kolom curhat tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 8, top: 10),
                  child: Text('Tag'),
                ),
                KalmTextFieldTag(
                  hintText: 'Tag curhatan...',
                  onTag: (tag) {},
                  onDelete: (tag) {},
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sembunyikan namaku'),
                      KalmSwitchButton(
                        primaryColor: primaryColor,
                        accentColor: accentColor,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: KalmButton(
                    width: double.infinity,
                    height: 56,
                    onPressed: () {},
                    borderRadius: 10,
                    primaryColor: primaryColor,
                    child: Text('Kirim Curhat'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
