import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullScreenImageViewer extends StatelessWidget {
  const FullScreenImageViewer({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the image URL from arguments
    final String imageUrl = Get.arguments;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // PhotoViewGallery for image display
          PhotoViewGallery.builder(
            itemCount: 1,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider:
                    NetworkImage(imageUrl), // Image URL from Get.arguments
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: BouncingScrollPhysics(),
            backgroundDecoration: BoxDecoration(
              color: Colors.black,
            ),
            pageController: PageController(),
          ),
          // Back icon with circular background
          Positioned(
            top: 40.0,
            left: 20.0,
            child: GestureDetector(
              onTap: () => Get.back(), // Go back to previous screen
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 28.0, // Customize icon size
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
