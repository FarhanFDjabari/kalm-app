import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/widgets/kalm_curhat_reply_tile.dart';
import 'package:kalm/widgets/kalm_detail_curhat_tile.dart';
import 'package:kalm/widgets/kalm_text_field.dart';

class CurhatDetailPage extends StatefulWidget {
  @override
  _CurhatDetailPageState createState() => _CurhatDetailPageState();
}

class _CurhatDetailPageState extends State<CurhatDetailPage> {
  final _replyController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _replyController.dispose();
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
          'CURHAT',
          style:
              kalmOfflineTheme.textTheme.headline1!.apply(color: primaryText),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 1,
            right: 1,
            child: Image.asset(
              'assets/picture/picture-background_bottom_middle.png',
              scale: 1.5,
            ),
          ),
          SizedBox(height: 10),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: KalmDetailCurhatTile(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 30,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          'Balasan',
                          style: kalmOfflineTheme.textTheme.bodyText2!
                              .apply(color: primaryText, fontSizeFactor: 1.1),
                        ),
                      ),
                      Container(
                        child: Text(
                          ' (3)',
                          style: kalmOfflineTheme.textTheme.bodyText2!
                              .apply(color: primaryText, fontSizeFactor: 1.1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RefreshIndicator(
                    onRefresh: () async {},
                    color: primaryColor,
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (_, index) => KalmCurhatReplyTile(),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.12,
                color: tertiaryColor,
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: KalmTextField(
                        kalmTextFieldController: _replyController,
                        minLines: 1,
                        keyboardType: TextInputType.multiline,
                        hintText: 'Berkomentar sebagai Selene...',
                        focusColor: primaryColor,
                        primaryColor: accentColor,
                        accentColor: secondaryText,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        child: Icon(
                          Iconsax.send_14,
                          size: 28,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
