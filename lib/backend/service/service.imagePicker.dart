import 'dart:io';

import 'package:images_picker/images_picker.dart';

extension MediaExt on Media {
  File get file => File(path);
}

mixin MediaMixin on Media {
  bool isVideo = false;
}

class ImagePickerService {
  Future<List<File?>> pickImages() async {
    List<Media>? res = await ImagesPicker.pick(
      count: 5,
      pickType: PickType.image,
      quality: .2,
      cropOpt: CropOption(
        aspectRatio: CropAspectRatio.custom,
        cropType: CropType.rect, // currently for android
      ),
    );
    if (res == null) return [];
    var files = res.map((e) => e.file).toList();
    return files;
  }
}

ImagePickerService _imagePickerService = ImagePickerService();
ImagePickerService get ips => _imagePickerService;
