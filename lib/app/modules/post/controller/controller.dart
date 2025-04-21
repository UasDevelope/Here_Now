import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:here_now/app/modules/loading/widget/custom_loading_widget.dart';
import 'package:here_now/app/utils/appstyle.dart';
import 'package:here_now/app/utils/short_message_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../controllers/controller_locator.dart';
import '../../../utils/api_utils.dart';
import '../../../utils/appbutton.dart';
import '../../../utils/colors.dart';
import '../../../utils/image_utils.dart';
import '../../../utils/string.dart';
import '../../../utils/textfiled.dart';

class PostController extends GetxController {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  RxString imagePath = "".obs; // For thumbnail (from image or video)
  RxString videoPath = "".obs; // For video
  RxString startDate = ''.obs;
  RxString endDate = ''.obs;
  final RxMap<String, List<String>> categoryToNewsType = <String, List<String>>{
    "Events": [],
    "News": [
      "City",
      'contiene',
      "State",
      "Nation",
      "World",
      "Recent",
      "Popular",
      "Events",
      "Institutions",
    ],
  }.obs;

  RxString imageUrl = "".obs;

  void showPostBottomSheet(BuildContext context) {
    if (imagePath.isEmpty) {
      ShortMessageUtils.showError("Please select a thumbnail or video first");
      updateSelectedCategory(selectedCategory.value);
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail display
            InkWell(
              onTap: () {
                showImageSourceDialog(); // Allow changing thumbnail or video
              },
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: imagePath.isNotEmpty
                      ? DecorationImage(
                          image: FileImage(File(imagePath.value)),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: imagePath.isEmpty ? Colors.grey[300] : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: imagePath.isEmpty
                    ? Center(child: Text("Tap to select media"))
                    : null,
              ),
            ),
            if (videoPath.isNotEmpty) ...[
              SizedBox(height: 8),
              Text(
                "Video selected",
                style: AppStyle.openSans(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            SizedBox(height: 16),
            // Description field
            Text(
              AppString.description,
              style: AppStyle.openSans(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 8),
            AppTextField(
              obscureText: false,
              maxline: 6,
              width: double.infinity,
              height: 150,
              hintText: AppString.typesomething,
              controller: descriptionController,
            ),
            Spacer(),
            // Submit button
            Center(
              child: AppButton(
                height: 50,
                textWeight: FontWeight.w800,
                textSize: 20,
                width: Get.width * 0.8,
                text: "Submit",
                textColor: AppColors.white,
                borderRadius: 10,
                onTap: () async {
                  if (descriptionController.text.isEmpty) {
                    ShortMessageUtils.showError("Please enter a description");
                    return;
                  }
                  if (selectedCategory.value == "News") {
                    await createNewsPost();
                    Get.back();
                    Get.back();
                  } else {
                    // await createEventPost();
                    Get.back();
                  }
                },
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void showImageSourceDialog() {
    Get.defaultDialog(
      barrierDismissible: false,
      title: 'Select Media',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selectedCategory.value == "News") ...[
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text(
                'Capture Image',
                style: AppStyle.openSans(),
              ),
              onTap: () async {
                await ImageUtils.pickAndUpdateImage(imagePath,
                    source: ImageSource.camera);
                videoPath.value = ""; // Clear video if image is selected
                Get.back();
                if (imagePath.isNotEmpty) {
                  showPostBottomSheet(Get.context!);
                } else {
                  updateSelectedCategory(selectedCategory.value);
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.videocam),
              title: Text(
                'Pick Video',
                style: AppStyle.openSans(),
              ),
              onTap: () async {
                await ImageUtils.pickAndUpdateVideo(videoPath, imagePath,
                    source: ImageSource.camera);
                Get.back();
                if (imagePath.isNotEmpty) {
                  showPostBottomSheet(Get.context!);
                } else {
                  updateSelectedCategory(selectedCategory.value);
                }
              },
            ),
          ] else ...[
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text(
                'Capture Image',
                style: AppStyle.openSans(),
              ),
              onTap: () async {
                await ImageUtils.pickAndUpdateImage(imagePath,
                    source: ImageSource.camera);
                videoPath.value = ""; // Clear video if image is selected
                Get.back();
                if (imagePath.isNotEmpty) {
                  showPostBottomSheet(Get.context!);
                } else {
                  updateSelectedCategory(selectedCategory.value);
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text(
                'Image from Gallery',
                style: AppStyle.openSans(),
              ),
              onTap: () async {
                await ImageUtils.pickAndUpdateImage(imagePath,
                    source: ImageSource.gallery);
                videoPath.value = ""; // Clear video if image is selected
                Get.back();
                if (imagePath.isNotEmpty) {
                  showPostBottomSheet(Get.context!);
                } else {
                  updateSelectedCategory(selectedCategory.value);
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.videocam),
              title: Text(
                'Pick Video',
                style: AppStyle.openSans(),
              ),
              onTap: () async {
                await ImageUtils.pickAndUpdateVideo(videoPath, imagePath,
                    source: ImageSource.gallery);
                Get.back();
                if (imagePath.isNotEmpty) {
                  showPostBottomSheet(Get.context!);
                } else {
                  updateSelectedCategory(selectedCategory.value);
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.videocam),
              title: Text(
                'Capture Video',
                style: AppStyle.openSans(),
              ),
              onTap: () async {
                await ImageUtils.pickAndUpdateVideo(videoPath, imagePath,
                    source: ImageSource.camera);
                Get.back();
                if (imagePath.isNotEmpty) {
                  showPostBottomSheet(Get.context!);
                } else {
                  updateSelectedCategory(selectedCategory.value);
                }
              },
            ),
          ],
        ],
      ),
    );
  }

  final RxString selectedCategory = "Events".obs;
  final RxString selectedNews = "".obs;

  List<String> get currentNewsTypeOptions =>
      categoryToNewsType[selectedCategory.value] ?? [];

  Future<void> updateSelectedCategory(String value) async {
    log("Value is $value");
    selectedCategory.value = value;
    showImageSourceDialog();
  }

  void updateSelectedNews(String value) {
    selectedNews.value = value;
  }

  Future<String?> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      return formattedDate;
    }

    return null;
  }

  Future<void> createNewsPost() async {
    final controller = ControllerLocator.locationController;

    CustomLoadingDialog.showCustomLoadingDialog("Creating News Post....");
    Map<String, dynamic> locationName = controller.selectedLocation;
    if (imagePath.isNotEmpty) {
      imageUrl.value = await ImageUtils.uploadMediaWithThumbnail(
          imagePath.value, videoPath.value, "HereNow");
      log("Image url value is $imageUrl");
    }
    var body = {
      "image": imageUrl.value,
      "title": "djdjjd",
      "description": descriptionController.text,
      "lat": controller.latitude.value,
      "long": controller.longitude.value,
      "location": locationName["locationName"],
      "city": locationName["city"],
      "country": locationName["country"],
      "state": locationName["state"],
      // "video": imageUrl.value, // Use combined URL
      "category": selectedCategory.value,
      "typeNews": "jjd",
    };
    log("Body data is $body");
    try {
      final response = await ApiClient().post(ApiEndPoints.addNews, body);
      log("Response is $response");
      CustomLoadingDialog.closeLoadingDialog();
      ShortMessageUtils.showSuccess("${response["message"]}");
      clearEvents();
      final bottomNavController = ControllerLocator.bottomNavController;
      bottomNavController.changeIndex(0);
    } catch (e) {
      CustomLoadingDialog.closeLoadingDialog();
      ShortMessageUtils.showError("$e");
    }
  }

  Future<void> createEventPost() async {
    final controller = ControllerLocator.locationController;

    CustomLoadingDialog.showCustomLoadingDialog("Creating Event Post....");
    Map<String, dynamic> locationName = controller.selectedLocation;
    if (imagePath.isNotEmpty) {
      imageUrl.value = await ImageUtils.uploadMediaWithThumbnail(
          imagePath.value, videoPath.value, "HereNow");
      log("For event post image url $imageUrl");
    }
    var body = {
      "title": titleController.text,
      "description": descriptionController.text,
      "image": imageUrl.value,
      // "video": imageUrl.value, // Use combined URL
      "lat": controller.latitude.value,
      "long": controller.longitude.value,
      "location": locationName["locationName"],
      "city": locationName["city"],
      "country": locationName["country"],
      "state": locationName["state"],
      "contact": contactController.text,
      "price": priceController.text,
      "startDate": startDate.value,
      "endDate": endDate.value,
    };
    try {
      final response = await ApiClient().post(ApiEndPoints.createEvent, body);
      log("Response is $response");
      CustomLoadingDialog.closeLoadingDialog();
      ShortMessageUtils.showSuccess("${response["message"]}");
      clearEvents();
      final bottomNavController = ControllerLocator.bottomNavController;
      bottomNavController.changeIndex(1);
    } catch (e) {
      CustomLoadingDialog.closeLoadingDialog();
      log("Error is ==> $e");
    }
  }

  void clearEvents() {
    titleController.clear();
    startDate.value = "";
    endDate.value = "";
    contactController.clear();
    priceController.clear();
    descriptionController.clear();
    imagePath.value = "";
    videoPath.value = "";
    imageUrl.value = "";
  }
}
