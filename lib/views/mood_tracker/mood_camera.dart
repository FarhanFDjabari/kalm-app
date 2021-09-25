import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:kalm/services/moodtracker/mood_classifier.dart';
import 'package:kalm/services/moodtracker/mood_unquant_classifier.dart';
import 'package:kalm/utilities/kalm_theme.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class MoodCamera extends StatefulWidget {
  @override
  _MoodCameraState createState() => _MoodCameraState();
}

class _MoodCameraState extends State<MoodCamera> {
  late MoodClassifier _moodClassifier;

  File? _image;
  final picker = ImagePicker();
  Image? _imageWidget;

  img.Image? fox;

  Category? _category;

  @override
  void initState() {
    super.initState();
    _moodClassifier = MoodUnquantClassifier();
    getImage();
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile!.path);
      _imageWidget = Image.file(_image!);

      _predict();
    });
  }

  void _predict() async {
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
    var prediction = _moodClassifier.predict(imageInput);

    setState(() {
      this._category = prediction;
    });
  }

  getImageName(String category) {
    if (category == 'Sangat Baik') {
      return 'assets/picture/picture-facerecognition_baik.png';
    } else if (category == 'Buruk') {
      return 'assets/picture/picture-facerecognition_buruk.png';
    } else if (category == 'Biasa') {
      return 'assets/picture/picture-facerecognition_biasa.png';
    } else if (category == 'Baik') {
      return 'assets/picture/picture-facerecognition_sangatbaik.png';
    } else {
      return 'assets/picture/picture-facerecognition_sangatburuk.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: _image == null
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      ColorFiltered(
                        colorFilter:
                            ColorFilter.mode(primaryColor, BlendMode.overlay),
                        child: Image.asset(
                          'assets/picture/camera-bg-placeholder.png',
                          fit: BoxFit.cover,
                          scale: 2,
                        ),
                      ),
                      Positioned.fill(
                        child: Center(
                          child: Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor.withOpacity(0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: CircularProgressIndicator(
                                color: tertiaryColor,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Image.file(
                    _image!,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            top: 55,
            left: 25,
            child: InkWell(
              radius: 35,
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                radius: 28,
                backgroundColor: tertiaryColor,
                child: Icon(
                  Icons.close_rounded,
                  size: 28,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 55,
            right: 5,
            left: 5,
            child: Column(
              children: [
                if (_category != null)
                  Container(
                    width: double.infinity,
                    height: 83,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: tertiaryColor,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 83,
                          height: 63,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            getImageName(_category!.label),
                            scale: 2,
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Perasaanmu saat ini:',
                                style: kalmOfflineTheme.textTheme.subtitle1!
                                    .apply(color: primaryText),
                              ),
                              SizedBox(height: 10),
                              Text(
                                _category!.label,
                                style: kalmOfflineTheme.textTheme.headline1!
                                    .apply(color: primaryText),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                if (_category != null) SizedBox(height: 15),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    print(_category!.score);
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        style: BorderStyle.solid,
                        width: 4,
                        color: tertiaryColor,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 28,
                        color: tertiaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
