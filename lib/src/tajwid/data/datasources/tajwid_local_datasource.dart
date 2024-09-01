import 'dart:io';

import 'package:alquran_app/core/errors/exceptions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

abstract class TajwidLocalDataSource {
  Future<File?> pickThumbnailImage();
}

@LazySingleton(as: TajwidLocalDataSource)
class TajwidLocalDataSourceImpl implements TajwidLocalDataSource {
  const TajwidLocalDataSourceImpl({
    required ImagePicker imagePicker,
  }) : _imagePicker = imagePicker;

  final ImagePicker _imagePicker;

  @override
  Future<File?> pickThumbnailImage() async {
    try {
      final image = await _imagePicker.pickImage(source: ImageSource.gallery);

      if (image == null) return null;

      return File(image.path);
    } catch (e) {
      throw ClientException(message: e.toString());
    }
  }
}
