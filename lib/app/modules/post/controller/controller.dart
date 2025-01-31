import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:here_now/app/modules/loading/widget/custom_loading_widget.dart';
import 'package:here_now/app/utils/appstyle.dart';
import 'package:here_now/app/utils/short_message_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../controllers/controller_locator.dart';
import '../../../routes/routes.dart';
import '../../../utils/api_utils.dart';
import '../../../utils/image_utils.dart';
import '../../../utils/location_utils.dart';

class PostController extends GetxController {
  // Map to associate categories with their respective news types
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  RxString imagePath = "".obs;
  RxString startDate = ''.obs;
  RxString endDate = ''.obs;
  final RxMap<String, List<String>> categoryToNewsType = <String, List<String>>{
    "Events": [],
    // "Institutes": [
    //   "City",
    //   'contiene',
    //   "State",
    //   "Nation",
    //   "World",
    //   "Recent",
    //   "Popular",
    //   "Events",
    //   "Institutions",
    // ],
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

  void showImageSourceDialog() {
    Get.defaultDialog(
      title: 'Pick an image',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text(
              'Use Camera',
              style: AppStyle.openSans(),
            ),
            onTap: () {
              ImageUtils.pickAndUpdateImage(imagePath,
                  source: ImageSource.camera);
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text(
              'Use Gallery',
              style: AppStyle.openSans(),
            ),
            onTap: () {
              ImageUtils.pickAndUpdateImage(imagePath,
                  source: ImageSource.gallery);
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  final RxString selectedCategory = "Events".obs; // Default selected category
  final RxString selectedNews = "".obs; // Default selected news type

  List<String> get currentNewsTypeOptions =>
      categoryToNewsType[selectedCategory.value] ??
      []; // Get news types for the selected category

  void updateSelectedCategory(String value) {
    if (value == "Events") {
      showImageSourceDialog();
    } else if (value == "News") {
      ImageUtils.pickAndUpdateImage(imagePath, source: ImageSource.camera);
    }
    selectedCategory.value = value;
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
      // Format the date before returning it
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      return formattedDate; // Return the formatted date as a string
    }

    return null; // Return null if no date was picked
  }

  Future<void> createNewsPost() async {
    final controller = ControllerLocator.locationController;

    CustomLoadingDialog.showCustomLoadingDialog("Creating News Post....");
    Map<String, dynamic> locationName = controller.selectedLocation;
    if (imagePath.isNotEmpty) {
      imageUrl.value =
          await ImageUtils.uploadToCloudinary(imagePath.value, "HereNow");
    }
    var body = {
      "image": imageUrl.value,
      "title": titleController.text,
      "description": descriptionController.text,
      "lat": controller.latitude.value,
      "long": controller.longitude.value,
      "location": locationName["locationName"],
      "city": locationName["city"],
      "country": locationName["country"],
      "state": locationName["state"],
      "video": "videoUrl",
      "category": selectedCategory.value,
      "typeNews": "selectedNews.value"
    };
    try {
      final response = await ApiClient().post(ApiEndPoints.addNews, body);
      log("Response is $response");
      CustomLoadingDialog.closeLoadingDialog();
      ShortMessageUtils.showSuccess("${response["message"]}");
      clearEvents();
      final bottomNavController = ControllerLocator.bottomNavController;
      bottomNavController.changeIndex(0);
      // Get.offNamed(Routes.bottomNav);
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
      imageUrl.value =
          await ImageUtils.uploadToCloudinary(imagePath.value, "HereNow");
    }
    var body = {
      "title": titleController.text,
      "description": descriptionController.text,
      "image": imageUrl.value,
      "video": "videoUrl",
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
      // CustomLoadingDialog.showCustomLoadingDialog("Creating post....");
      final response = await ApiClient().post(ApiEndPoints.createEvent, body);
      log("Response is $response");
      CustomLoadingDialog.closeLoadingDialog();
      ShortMessageUtils.showSuccess("${response["message"]}");
      clearEvents();
      final bottomNavController = ControllerLocator.bottomNavController;
      bottomNavController.changeIndex(1);
    } catch (e) {
      CustomLoadingDialog.closeLoadingDialog();
      log("Error$e");
    } finally {}
  }
  //
  // Future<void> createInstituteNews() async {
  //   var requestBody={};
  //   try {
  //     var response=await  ApiClient().post(ApiEndPoints.addNews, requestBody)
  //   } catch (e) {
  //
  //   }
  // }

  void clearEvents() {
    titleController.clear();
    startDate.value = "";
    endDate.value = "";
    contactController.clear();
    priceController.clear();
    descriptionController.clear();
  }
}
