import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:kalm/widgets/kalm_button.dart';
import 'package:kalm/widgets/kalm_dialog.dart';
import 'package:kalm/widgets/kalm_journey_field.dart';
import 'package:kalm/widgets/kalm_step_indicator.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'journey_complete_page.dart';

class JourneyChapterPage extends StatefulWidget {
  @override
  _JourneyChapterPageState createState() => _JourneyChapterPageState();
}

class _JourneyChapterPageState extends State<JourneyChapterPage> {
  final journeyTextController = TextEditingController();
  final journeyPageController = PageController();
  final _formKey = GlobalKey<FormState>();
  int currentIndex = 0;
  late SpeechToText _speechToText;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speechToText = SpeechToText();
  }

  @override
  void dispose() {
    super.dispose();
    print('disposed');
    journeyPageController.dispose();
    _speechToText.cancel();
  }

  void listenSpeech() async {
    if (!_isListening) {
      bool available = await _speechToText.initialize(
        onStatus: (status) {
          print('status: $status');
        },
        onError: (error) => print(error),
      );
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speechToText.listen(
          onResult: (result) {
            setState(() {
              journeyTextController.text = result.recognizedWords;
              if (result.hasConfidenceRating && result.confidence > 0) {
                print(result.confidence);
                _isListening = false;
              }
            });
          },
          localeId: 'in_ID',
        );
      }
    } else {
      setState(() {
        _isListening = false;
        _speechToText.stop();
      });
    }
  }

  List<Map<String, dynamic>> journeyData = [
    {'itemIndex': 0, 'title': '1', 'isCompleted': false},
    {'itemIndex': 1, 'title': '2', 'isCompleted': false},
    {'itemIndex': 2, 'title': '3', 'isCompleted': false},
    {'itemIndex': 3, 'title': '4', 'isCompleted': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
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
          'MENGENAL DIRI',
          style:
              kalmOfflineTheme.textTheme.headline1!.apply(color: primaryText),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: journeyData
                    .map(
                      (data) => KalmStepIndicator(
                        title: data['title'],
                        selectedIndex: currentIndex,
                        indicatorIndex: data['itemIndex'],
                        isLast: data['itemIndex'] == 3,
                        isComplete: data['isCompleted'],
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: PageView.builder(
                  itemCount: journeyData.length,
                  physics: NeverScrollableScrollPhysics(),
                  controller: journeyPageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                    print(currentIndex);
                  },
                  pageSnapping: true,
                  itemBuilder: (_, index) => KalmJourneyField(
                    journeyTextController: journeyTextController,
                    title: 'Tuliskan hal-hal yang kamu sukai dari dirimu.',
                    journeyPageController: journeyPageController,
                    currentIndex: currentIndex,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    listenSpeech();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  splashColor: primaryColor.withOpacity(0.5),
                  elevation: 0,
                  tooltip: 'Speech to text',
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.mic,
                    color: tertiaryColor,
                  ),
                ),
                Tooltip(
                  message: 'Selanjutnya',
                  child: KalmButton(
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: 56,
                    borderRadius: 7,
                    primaryColor: primaryColor,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: tertiaryColor,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (currentIndex < 3) {
                          journeyData[currentIndex]['isCompleted'] = true;
                          journeyTextController.clear();
                          journeyPageController.nextPage(
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          );
                        } else
                          showDialog(
                            context: context,
                            builder: (context) => KalmDialog(
                              title:
                                  'Apakah kamu yakin sudah mengisi jurnal dengan baik?',
                              successButtonTitle: 'Selesai',
                              cancelButtonTitle: 'Kembali',
                              onSuccess: () {
                                journeyData[currentIndex]['isCompleted'] = true;
                                journeyTextController.clear();
                                Navigator.of(context).pop(true);
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => JourneyCompletePage(),
                                  ),
                                );
                              },
                              onCancel: () => Navigator.of(context).pop(false),
                            ),
                          );
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
      ),
    );
  }
}
