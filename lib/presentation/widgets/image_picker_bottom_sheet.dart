import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kalm/presentation/widgets/dashed_button.dart';
import 'package:kalm/styles/kalm_theme.dart';
import 'package:kalm/utilities/iconsax_icons.dart';

class ImagePickBottomSheet extends StatefulWidget {
  final Function(File?) pickCallback;

  ImagePickBottomSheet({
    required this.pickCallback,
  });

  @override
  State<StatefulWidget> createState() {
    return _ImagePickBottomSheetState();
  }
}

class _ImagePickBottomSheetState extends State<ImagePickBottomSheet> {
  bool _isPickingImage = false;
  File? pickedImage;

  Future<void> _onPickImage(ImageSource source) async {
    if (_isPickingImage) return;
    _isPickingImage = true;
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: source,
      imageQuality: 50,
    );
    _isPickingImage = false;
    if (null != pickedFile) {
      if (kIsWeb) {
        await pickedFile.readAsBytes();
      } else {
        // Warning:  this will not work on the web platform because pickedFile
        // will instead point to a network resource.
        final imageFile = File(pickedFile.path);
        // assert(null != imageFile);
        pickedImage = imageFile;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 22),
              decoration: BoxDecoration(
                color: Color(0xFFFBFBFB),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(Icons.close, size: 24),
                  ),
                  Text(
                    'Upload Photo',
                    style: kalmOfflineTheme.textTheme.headline1!.apply(
                      color: primaryText,
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashedButtonIcon(
                    text: 'Take a Picture',
                    icon: Iconsax.camera,
                    borderRadius: 16,
                    callback: () async {
                      await _onPickImage(ImageSource.camera);
                      widget.pickCallback(pickedImage);
                      Navigator.of(context).pop();
                    },
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  DashedButtonIcon(
                    text: 'From Gallery',
                    icon: Iconsax.gallery,
                    borderRadius: 16,
                    callback: () async {
                      await _onPickImage(ImageSource.gallery);
                      widget.pickCallback(pickedImage);
                      Navigator.of(context).pop();
                    },
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
