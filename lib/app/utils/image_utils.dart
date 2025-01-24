import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:here_now/app/utils/api_utils.dart';
import 'package:here_now/app/utils/short_message_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ImageUtils {
  static Future<XFile?> compressImage(XFile originalImage) async {
    final directory = path.dirname(originalImage.path);
    final fileName = 'compressed_${path.basename(originalImage.path)}.jpg';
    final compressedPath = path.join(directory, fileName);

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      originalImage.path,
      compressedPath,
      minWidth: 320,
      minHeight: 240,
      quality: 50,
    );

    if (compressedImage != null) {
      final originalSize = await File(originalImage.path).length();
      final compressedSize = await File(compressedImage.path).length();

      print('Original Image Size: ${originalSize ~/ 1024} KB');
      print('Compressed Image Size: ${compressedSize ~/ 1024} KB');

      return XFile(compressedImage.path);
    } else {
      // Compression failed, handle the error
      return null;
    }
  }

  static Future<void> pickAndUpdateImage(RxString pathToUpdate) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final XFile? compressImage = await ImageUtils.compressImage(image);
      pathToUpdate.value = compressImage?.path ?? image.path;
    } else {
      // Show an error message if no image was selected
      ShortMessageUtils.showError("Please pick an image");
    }
  }

  static Future<String> uploadImageToCloudinary(File image) async {
    try {
      final uploadPreset = "Here_now";
      final cloudName = dotenv.env['Cloud_Name']!;
      log("Cloud name is $cloudName and upload preset is $uploadPreset");
      final Map<String, dynamic> data = {
        "folder": "HereNow/Users",
        'upload_preset': uploadPreset,
        'file': image,
      };

      final response = await ApiClient(baseUrl: ApiEndPoints.cloudinaryBaseUrl)
          .postFormData(ApiEndPoints.uploadImage(cloudName), data);
      log("Response is $response and image url is ${response["secure_url"]}");
      return response["secureUrl"];
    } catch (e) {
      ShortMessageUtils.showError("$e");
      return "";
    }
  }
}
