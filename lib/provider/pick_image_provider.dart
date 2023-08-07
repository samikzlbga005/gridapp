import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gridapp/components/amplitude/amplitude.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import '../components/go_to_settings.dart';

class ImagePickerProvider extends ChangeNotifier {
  File? image;
  //bool value true -> resim değiştirildi
  Future<void> pickImage(BuildContext context, bool? value) async {
    //bool value null -> ilk defa resim seçildi

    if (await Permission.storage.request().isGranted) {
      requestGalleryPermission(value);
    } else {
      PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        requestGalleryPermission(value);
      } else {
        showPermissionPermanentlyDeniedDialog(context);
      }
    }
  }

  Future<File> saveImage(List<int> bytes, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/$fileName');

    await file.writeAsBytes(bytes);
    return file;
  }

  void deleteImage() {
    image = null;
    notifyListeners(); // Notify listeners that the image has been deleted
  }

  //asıl resmi burda alıyoruz
  Future<void> requestGalleryPermission(bool? value) async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      if (Platform.isAndroid) {
        final imageTemp = File(pickedImage.path);
        image = imageTemp;
        if (value != null) {
          await AmplitudeConnection.image_changed();
        } else {
          await AmplitudeConnection.image_added();
        }
      } else if (Platform.isIOS) {
        final fileName = pickedImage.path.split('/').last;
        final savedImage =
            await saveImage(await pickedImage.readAsBytes(), fileName);
        image = savedImage;
        if (value != null) {
          await AmplitudeConnection.image_changed();
        } else {
          await AmplitudeConnection.image_added();
        }
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    notifyListeners();
  }
}
