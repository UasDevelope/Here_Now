import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:here_now/app/utils/images.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class ShareUtil {
  static Future<void> sharePost({
    required String postImageUrl,
    required String userName,
    required String postDescription,
  }) async {
    try {
      if (postImageUrl.isNotEmpty && postImageUrl.startsWith("http")) {
        // Download the post image
        final response = await http.get(Uri.parse(postImageUrl));
        final Uint8List postBytes = response.bodyBytes;

        // Decode the post image
        img.Image postImageFile = img.decodeImage(postBytes)!;

        // Load the logo from assets
        final ByteData logoData = await rootBundle.load(Images.thumb);
        final Uint8List logoBytes = logoData.buffer.asUint8List();
        img.Image logoImage = img.decodeImage(logoBytes)!;

        // Resize the logo to a height of 30 pixels (auto-adjust width)
        int newLogoHeight = 30;
        int newLogoWidth =
            (logoImage.width * (newLogoHeight / logoImage.height)).toInt();
        img.Image resizedLogo = img.copyResize(logoImage,
            height: newLogoHeight, width: newLogoWidth);

        // Attach logo to the **top-right corner** (no padding)
        int posX = postImageFile.width - newLogoWidth - 20; // 20px padding
        int posY = 20;

        // Overlay the logo onto the post image
        img.compositeImage(postImageFile, resizedLogo, dstX: posX, dstY: posY);

        // Save the modified image to a temporary file
        final Directory tempDir = await getTemporaryDirectory();
        final File file = File('${tempDir.path}/shared_image.png');
        await file.writeAsBytes(img.encodePng(postImageFile));

        // Share the modified image
        await Share.shareXFiles([XFile(file.path)],
            text: "$userName's Post\n\n$postDescription");
      } else {
        await Share.share("$userName's Post\n\n$postDescription");
      }
    } catch (e) {
      print("Error sharing post: $e");
    }
  }
}
