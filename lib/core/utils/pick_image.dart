import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  try {
    final xImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (xImage != null) {
      return File(xImage.path);
    }
  } catch (e) {
    return null;
  }
  return null;
}
