import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:kalm/presentation/cubit/mood_tracker/mood_tracker_cubit.dart';
import 'package:kalm/presentation/views/journey/mood_task/task_mood_factor_page.dart';
import 'package:kalm/presentation/widgets/kalm_snackbar.dart';
import 'package:kalm/styles/kalm_theme.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class MoodCameraTask extends StatefulWidget {
  @override
  _MoodCameraTaskState createState() => _MoodCameraTaskState();
}

class _MoodCameraTaskState extends State<MoodCameraTask> {
  File? _image;
  final picker = ImagePicker();
  Image? _imageWidget;
  bool isLoading = true;

  img.Image? fox;

  Category? _category;

  @override
  void initState() {
    super.initState();
    getImage();
  }

  Future getImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 640);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _imageWidget = Image.file(_image!);
      context.read<MoodTrackerCubit>().postMoodRecognition(_image!);
    } else {
      Navigator.of(context).pop();
    }
    // await _predictFromWeb(imageUrl);
    // setState(() {});
  }

  // Future<String> _getImageUrl(File imageFile) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var postMoodImageUsecase =
  //       PostMoodImage(repository: MoodTrackerRepositoryImpl());
  //   return await postMoodImageUsecase.execute(
  //       image: imageFile, userId: GetStorage().read('user_id'));
  // }

  // void _predict() async {
  //   img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
  //   var prediction = _moodClassifier.predict(imageInput);

  //   setState(() {
  //     this._category = prediction;
  //   });
  // }

  // Future<void> _predictFromWeb(String url) async {
  //   Category? prediction;
  //   var getMoodRecognitionUsecase =
  //       GetMoodRecognition(repository: MoodTrackerRepositoryImpl());

  //   var result = await getMoodRecognitionUsecase.execute(imagePath: url);
  //   result.fold(
  //     (l) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         KalmSnackbar(
  //           message: l,
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //     },
  //     (r) {
  //       prediction = Category(
  //           r['label'].toString(), (r['prediction'] as int).toDouble());
  //     },
  //   );

  //   setState(() {
  //     this._category = prediction;
  //     isLoading = false;
  //   });
  // }

  getImageName(String category) {
    if (category.toLowerCase() == 'buruk') {
      return 'assets/picture/picture-facerecognition_buruk.png';
    } else if (category.toLowerCase() == 'biasa') {
      return 'assets/picture/picture-facerecognition_biasa.png';
    } else if (category.toLowerCase() == 'baik') {
      return 'assets/picture/picture-facerecognition_baik.png';
    } else {
      return 'assets/picture/picture-facerecognition_buruk.png';
    }
  }

  int getMoodPoint(String category) {
    if (category.toLowerCase() == 'buruk') {
      return 0;
    } else if (category.toLowerCase() == 'biasa') {
      return 1;
    } else if (category.toLowerCase() == 'baik') {
      return 2;
    } else {
      return 0;
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image = File(response.file!.path);
        _imageWidget = Image.file(_image!);
      });
    } else {
      print(response.exception!.message);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _image?.deleteSync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<MoodTrackerCubit, MoodTrackerState>(
        listener: (context, state) {
          if (state is MoodTrackerLoading) {
            isLoading = true;
          } else if (state is MoodTrackerPredictionLoaded) {
            _category = state.category;
            isLoading = false;
          } else if (state is MoodTrackerError) {
            isLoading = false;
            _image = null;
            ScaffoldMessenger.of(context).showSnackBar(
              KalmSnackbar(
                message: state.errorMessage,
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: FutureBuilder(
          future: retrieveLostData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return BlocBuilder<MoodTrackerCubit, MoodTrackerState>(
                builder: (builderContext, state) {
                  return Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: _image == null || state is MoodTrackerLoading
                            ? Stack(
                                fit: StackFit.expand,
                                children: [
                                  ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                        primaryColor, BlendMode.overlay),
                                    child: Image.asset(
                                      'assets/picture/camera-bg-placeholder.png',
                                      fit: BoxFit.cover,
                                      scale: 2,
                                    ),
                                  ),
                                  if (isLoading)
                                    Positioned.fill(
                                      child: Center(
                                        child: Container(
                                          width: 65,
                                          height: 65,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                primaryColor.withOpacity(0.5),
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
                                  if (!isLoading)
                                    Positioned.fill(
                                      child: Center(
                                        child: Text(
                                          'Image Url Error',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0),
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
                            if (_category != null && _image != null)
                              Container(
                                width: double.infinity,
                                height: 83,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Perasaanmu saat ini:',
                                            style: kalmOfflineTheme
                                                .textTheme.subtitle1!
                                                .apply(color: primaryText),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            _category!.label,
                                            style: kalmOfflineTheme
                                                .textTheme.headline1!
                                                .apply(color: primaryText),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            if (_category != null && _image != null)
                              SizedBox(height: 15),
                            InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                print(_category!.score);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => TaskMoodFactorPage(
                                      moodPoint: getMoodPoint(_category!.label)
                                          .toDouble(),
                                    ),
                                  ),
                                );
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
                  );
                },
              );
            else if (snapshot.connectionState == ConnectionState.waiting)
              return Stack(
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
              );
            else
              return Center(
                child: Text('No connection'),
              );
          },
        ),
      ),
    );
  }
}
