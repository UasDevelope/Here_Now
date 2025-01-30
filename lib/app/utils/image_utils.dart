import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:here_now/app/utils/api_utils.dart';
import 'package:here_now/app/utils/short_message_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
class ImageUtils {
  static Future<XFile?> compressImage(XFile originalImage) async {
    final directory = path.dirname(originalImage.path);
    final fileName = 'compressed_${path.basename(originalImage.path)}';
    log("File name is ==> $fileName");
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
      log("Original file path is ${originalImage.path} compressed file path is ${compressedImage.path}");
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
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      final XFile? compressImage = await ImageUtils.compressImage(image);
      pathToUpdate.value = compressImage!.path;
    } else {
      ShortMessageUtils.showError("Please pick an image");
    }
  }

  static Future<String> uploadToCloudinary(
      String imagePath, String folderName) async {
    try {
      const cloudName = 'dh61apvbf';
      const uploadPreset = 'wbznzo2g';

      final uri =
          Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/upload');
      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = uploadPreset
        ..fields['folder'] = folderName
        ..files.add(
          http.MultipartFile(
            'file',
            File(imagePath).openRead(),
            await File(imagePath).length(),
            filename: 'image.jpg',
          ),
        );

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final decodedData = json.decode(responseData);
        print('Upload successful: ${decodedData['secure_url']}');

        return decodedData['secure_url'];
      } else {
        print('Failed to upload image: ${response.statusCode}');
        throw Exception('Failed to upload image');
      }
    } catch (error) {
      print('Error uploading image: $error');
      rethrow;
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
