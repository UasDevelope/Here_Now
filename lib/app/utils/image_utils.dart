import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:here_now/app/utils/api_utils.dart';
import 'package:here_now/app/utils/short_message_utils.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageUtils {
  // Pick an image
  static Future<void> pickAndUpdateImage(RxString pathToUpdate,
      {ImageSource source = ImageSource.camera}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      pathToUpdate.value = image.path;
    } else {
      ShortMessageUtils.showError("Please pick an image");
    }
  }

  // Pick or capture a video
  static Future<void> pickAndUpdateVideo(
      RxString videoPathToUpdate, RxString imagePathToUpdate,
      {ImageSource source = ImageSource.camera}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(
        source: source, maxDuration: Duration(seconds: 10));
    if (video != null) {
      videoPathToUpdate.value = video.path;
      // Generate thumbnail from video using VideoThumbnail.thumbnailFile
      final thumbnailXFile = await VideoThumbnail.thumbnailFile(
        video: video.path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 1280,
        quality: 75,
      );
      if (thumbnailXFile.path != "" &&
          await File(thumbnailXFile.path).exists()) {
        imagePathToUpdate.value = thumbnailXFile.path;
      } else {
        ShortMessageUtils.showError("Failed to generate video thumbnail");
        imagePathToUpdate.value = "";
      }
    } else {
      ShortMessageUtils.showError("Please pick a video");
      videoPathToUpdate.value = "";
    }
  }

  // Upload to Cloudinary (for both image and video)
  static Future<String> uploadToCloudinary(String filePath, String folderName,
      {bool isVideo = false}) async {
    try {
      const cloudName = 'dm9e9oujd';
      const uploadPreset = 'here_now';

      final uri = Uri.parse(
        'https://api.cloudinary.com/v1_1/$cloudName/${isVideo ? 'video' : 'image'}/upload',
      );

      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = uploadPreset
        ..fields['folder'] = folderName
        ..files.add(
          await http.MultipartFile.fromPath('file', filePath),
        );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final decodedData = json.decode(responseBody);
        print('✅ Upload successful: ${decodedData['secure_url']}');
        return decodedData['secure_url'];
      } else {
        print('❌ Upload failed [${response.statusCode}]: $responseBody');
        throw Exception('Cloudinary upload error: $responseBody');
      }
    } catch (e) {
      print('⚠️ Upload exception: $e');
      rethrow;
    }
  }

  // static Future<String> uploadToCloudinary(String filePath, String folderName,
  //     {bool isVideo = false}) async {
  //   try {
  //     const cloudName = 'dm9e9oujd';
  //     const uploadPreset = 'here_now';
  //
  //     final uri = Uri.parse(
  //         'https://api.cloudinary.com/v1_1/$cloudName/${isVideo ? 'video' : 'image'}/upload');
  //     final request = http.MultipartRequest('POST', uri)
  //       ..fields['upload_preset'] = uploadPreset
  //       ..fields['folder'] = folderName
  //       ..files.add(
  //         http.MultipartFile(
  //           'file',
  //           File(filePath).openRead(),
  //           await File(filePath).length(),
  //           filename: isVideo ? 'video.mp4' : 'image.jpg',
  //         ),
  //       );
  //
  //     final response = await request.send();
  //     if (response.statusCode == 200) {
  //       final responseData = await response.stream.bytesToString();
  //       final decodedData = json.decode(responseData);
  //       print('Upload successful: ${decodedData['secure_url']}');
  //
  //       return decodedData['secure_url'];
  //     } else {
  //       print(
  //           'Failed to upload ${isVideo ? 'video' : 'image'}: ${response.statusCode}');
  //       throw Exception('Failed to upload ${isVideo ? 'video' : 'image'}');
  //     }
  //   } catch (error) {
  //     print('Error uploading ${isVideo ? 'video' : 'image'}: $error');
  //     rethrow;
  //   }
  // }

  // Upload thumbnail and video, combine URLs
  static Future<String> uploadMediaWithThumbnail(
      String thumbnailPath, String? videoPath, String folderName) async {
    try {
      // Upload thumbnail
      final thumbnailUrl =
          await uploadToCloudinary(thumbnailPath, folderName, isVideo: false);

      // If no video, return only thumbnail URL
      if (videoPath == null || videoPath.isEmpty) {
        return thumbnailUrl;
      }

      // Upload video
      final videoUrl =
          await uploadToCloudinary(videoPath, folderName, isVideo: true);

      // Combine URLs
      return '$videoUrl&thumbnail=$thumbnailUrl';
    } catch (e) {
      ShortMessageUtils.showError("Error uploading media: $e");
      return "";
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
      return response["secure_url"];
    } catch (e) {
      ShortMessageUtils.showError("$e");
      return "";
    }
  }
}
