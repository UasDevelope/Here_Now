import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:here_now/app/modules/loading/widget/custom_loading_widget.dart';
import 'package:here_now/app/utils/short_message_utils.dart';
import 'package:intl/intl.dart';
import '../../../utils/api_utils.dart';
import '../../../utils/location_utils.dart';

class PostController extends GetxController {
  // Map to associate categories with their respective news types
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  RxString startDate = ''.obs;
  RxString endDate = ''.obs;
  final RxMap<String, List<String>> categoryToNewsType = <String, List<String>>{
    "Events": [],
    "Institutes": [
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

  final RxString selectedCategory = "Events".obs; // Default selected category
  final RxString selectedNews = "".obs; // Default selected news type

  List<String> get currentNewsTypeOptions =>
      categoryToNewsType[selectedCategory.value] ??
      []; // Get news types for the selected category

  void updateSelectedCategory(String value) {
    selectedCategory.value = value;
    selectedNews.value = ""; // Reset selected news type when category changes
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

  Future<void> createEventPost() async {
    Map<String, dynamic> location = await LocationService.getCurrentLocation();
    var body = {
      "title": titleController.text,
      "description": descriptionController.text,
      "image": "imageUrl",
      "video": "videoUrl",
      "lat": location['lat'],
      "long": location["lng"],
      "location": location['locationName'],
      "contact": contactController.text,
      "price": priceController.text,
      "startDate": startDate.value,
      "endDate": endDate.value, // Ensure date is in ISO format
    };
    try {
      CustomLoadingDialog.showCustomLoadingDialog("Creating post....");
      final response = await ApiClient().post(ApiEndPoints.createEvent, body);
      log("Response is $response");
      ShortMessageUtils.showSuccess("${response["message"]}");
      clearEvents();
    } catch (e) {
      log("Error$e");
    } finally {
      CustomLoadingDialog.closeLoadingDialog();
    }
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
